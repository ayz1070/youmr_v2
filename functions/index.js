/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const { onRequest } = require('firebase-functions/v2/https');
const { onSchedule } = require('firebase-functions/v2/scheduler');
const admin = require('firebase-admin');

// Firebase Admin SDK 초기화
admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

/**
 * 푸시 알림 전송 Cloud Function
 * Firestore의 push_notifications 컬렉션에 새 문서가 생성되면 자동으로 실행됩니다.
 */
exports.sendPushNotification = onDocumentCreated('push_notifications/{notificationId}', async (event) => {
  try {
    const notificationData = event.data.data();
    const notificationId = event.params.notificationId;

    console.log(`푸시 알림 전송 시작: ${notificationId}`);

    // 알림 데이터 추출
    const {
      title,
      body,
      type,
      data,
      imageUrl,
      userIds,
    } = notificationData;

    // 대상 사용자들의 FCM 토큰 조회
    let tokens = [];
    
    if (userIds && userIds.length > 0) {
      // 특정 사용자들에게 전송
      const tokenDocs = await db
        .collection('fcm_tokens')
        .where(admin.firestore.FieldPath.documentId, 'in', userIds)
        .get();
      
      tokens = tokenDocs.docs.map(doc => doc.data().token);
    } else {
      // 모든 사용자에게 전송
      const tokenDocs = await db.collection('fcm_tokens').get();
      tokens = tokenDocs.docs.map(doc => doc.data().token);
    }

    if (tokens.length === 0) {
      console.log('전송할 FCM 토큰이 없습니다.');
      return null;
    }

    // FCM 메시지 구성
    const message = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        type: type,
        ...data,
        timestamp: Date.now().toString(),
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    // 이미지가 있는 경우 추가
    if (imageUrl) {
      message.notification.imageUrl = imageUrl;
    }

    // FCM 전송 (최대 500개씩 배치로 전송)
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    let successCount = 0;
    let failureCount = 0;

    for (const batch of batches) {
      try {
        // 개별 토큰으로 전송 (sendMulticast 대신 send 사용)
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 결과를 Firestore에 업데이트
    await event.data.ref.update({
      status: 'completed',
      successCount: successCount,
      failureCount: failureCount,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`푸시 알림 전송 완료: ${notificationId}`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    return { successCount, failureCount };
  } catch (error) {
    console.error(`푸시 알림 전송 실패: ${error}`);
    
    // 에러 상태로 업데이트
    await event.data.ref.update({
      status: 'failed',
      error: error.message,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    throw error;
  }
});

/**
 * 조건부 푸시 알림 전송 Cloud Function
 * Firestore의 conditional_notifications 컬렉션에 새 문서가 생성되면 자동으로 실행됩니다.
 */
exports.sendConditionalPushNotification = onDocumentCreated('conditional_notifications/{notificationId}', async (event) => {
  try {
    const notificationData = event.data.data();
    const notificationId = event.params.notificationId;

    console.log(`조건부 푸시 알림 전송 시작: ${notificationId}`);

    const {
      title,
      body,
      type,
      data,
      imageUrl,
      conditions,
    } = notificationData;

    // 조건에 맞는 사용자 ID 조회
    let userQuery = db.collection('users');
    
    if (conditions.dayOfWeek !== undefined) {
      userQuery = userQuery.where('attendanceDayOfWeek', '==', conditions.dayOfWeek);
    }
    
    if (conditions.userType) {
      userQuery = userQuery.where('userType', '==', conditions.userType);
    }
    
    const userSnapshot = await userQuery.get();
    const userIds = userSnapshot.docs.map(doc => doc.id);

    if (userIds.length === 0) {
      console.log('조건에 맞는 사용자가 없습니다.');
      await event.data.ref.update({
        status: 'no_recipients',
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // 해당 사용자들의 FCM 토큰 조회
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where(admin.firestore.FieldPath.documentId(), 'in', userIds)
      .get();

    const tokens = tokenDocs.docs.map(doc => doc.data().token);

    if (tokens.length === 0) {
      console.log('조건에 맞는 사용자의 FCM 토큰이 없습니다.');
      await event.data.ref.update({
        status: 'no_tokens',
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return null;
    }

    // FCM 메시지 구성
    const message = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        type: type,
        ...data,
        timestamp: Date.now().toString(),
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    if (imageUrl) {
      message.notification.imageUrl = imageUrl;
    }

    // FCM 전송
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    let successCount = 0;
    let failureCount = 0;

    for (const batch of batches) {
      try {
        // 개별 토큰으로 전송 (sendMulticast 대신 send 사용)
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 결과 업데이트
    await event.data.ref.update({
      status: 'completed',
      successCount: successCount,
      failureCount: failureCount,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`조건부 푸시 알림 전송 완료: ${notificationId}`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    return { successCount, failureCount };
  } catch (error) {
    console.error(`조건부 푸시 알림 전송 실패: ${error}`);
    
    await event.data.ref.update({
      status: 'failed',
      error: error.message,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    throw error;
  }
});

/**
 * 매월 1일 회비 알림 전송 Cloud Function
 * 매월 1일 오후 12시에 자동으로 실행됩니다.
 */
exports.sendMonthlyFeeNotification = onSchedule({
  schedule: '0 12 1 * *', // 매월 1일 오후 12시
  timeZone: 'Asia/Seoul',
}, async (event) => {
  try {
    console.log('매월 회비 알림 전송 시작');

    // admin과 offline_member 타입의 모든 사용자 조회
    const userSnapshot = await db
      .collection('users')
      .where('userType', 'in', ['admin', 'offline_member'])
      .get();

    if (userSnapshot.empty) {
      console.log('admin과 offline_member가 없습니다.');
      return null;
    }

    const userIds = userSnapshot.docs.map(doc => doc.id);
    console.log(`admin과 offline_member 수: ${userIds.length}`);

    // 해당 사용자들의 FCM 토큰 조회
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where(admin.firestore.FieldPath.documentId(), 'in', userIds)
      .get();

    const tokens = tokenDocs.docs.map(doc => doc.data().token);

    if (tokens.length === 0) {
      console.log('admin과 offline_member의 FCM 토큰이 없습니다.');
      return null;
    }

    // 회비 알림 메시지 구성
    const message = {
      notification: {
        title: '회비 안내',
        body: '1일 입니다. 이번 달 회비를 납부해 주세요.',
      },
      data: {
        type: 'monthly_fee',
        timestamp: Date.now().toString(),
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    // FCM 전송 (최대 500개씩 배치로 전송)
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    let successCount = 0;
    let failureCount = 0;

    for (const batch of batches) {
      try {
        // 개별 토큰으로 전송
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 결과를 로그로 기록
    console.log(`매월 회비 알림 전송 완료`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    // 전송 기록을 Firestore에 저장
    await db.collection('notification_logs').add({
      type: 'monthly_fee',
      title: '회비 안내',
      body: '1일 입니다. 이번 달 회비를 납부해 주세요.',
      targetUserType: 'offline_member',
      successCount: successCount,
      failureCount: failureCount,
      sentAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { successCount, failureCount };
  } catch (error) {
    console.error(`매월 회비 알림 전송 실패: ${error}`);
    throw error;
  }
});

/**
 * 관리자가 수동으로 회비 알림을 보낼 수 있는 HTTP Cloud Function
 */
exports.sendManualFeeNotification = onRequest(async (req, res) => {
  try {
    // CORS 설정
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Access-Control-Allow-Methods', 'POST');
    res.set('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
      res.status(204).send('');
      return;
    }

    if (req.method !== 'POST') {
      res.status(405).send('Method Not Allowed');
      return;
    }

    const { adminUserId, customMessage, testMode } = req.body;

    console.log('요청 데이터:', { adminUserId, customMessage, testMode });

    if (!adminUserId) {
      console.log('필수 파라미터 누락:', { adminUserId });
      res.status(400).send('adminUserId is required');
      return;
    }

    // 관리자 권한 확인
    const adminUserDoc = await db.collection('users').doc(adminUserId).get();
    if (!adminUserDoc.exists) {
      console.log('관리자 사용자를 찾을 수 없음:', adminUserId);
      res.status(403).send('Admin user not found');
      return;
    }

    const adminUserData = adminUserDoc.data();
    console.log('관리자 사용자 데이터:', { userType: adminUserData.userType });
    
    if (adminUserData.userType !== 'admin' && adminUserData.userType !== 'developer') {
      console.log('권한 부족:', adminUserData.userType);
      res.status(403).send('Insufficient permissions');
      return;
    }

    console.log('수동 회비 알림 전송 시작');

    let userSnapshot;
    
    if (testMode) {
      // 테스트 모드: 모든 사용자에게 전송
      console.log('테스트 모드: 모든 사용자에게 전송');
      userSnapshot = await db.collection('users').get();
    } else {
      // admin과 offline_member 타입의 모든 사용자 조회
      userSnapshot = await db
        .collection('users')
        .where('userType', 'in', ['admin', 'offline_member'])
        .get();
    }

    console.log(`admin과 offline_member 사용자 수: ${userSnapshot.size}`);

    if (userSnapshot.empty) {
      console.log('admin과 offline_member가 없습니다.');
      res.status(200).json({ 
        message: 'admin과 offline_member가 없습니다. 테스트 모드를 사용하거나 사용자 데이터에 userType을 설정해주세요.', 
        successCount: 0, 
        failureCount: 0,
        suggestion: 'testMode: true를 추가하여 모든 사용자에게 테스트 전송을 시도해보세요.'
      });
      return;
    }

    const userIds = userSnapshot.docs.map(doc => doc.id);
    console.log(`사용자 ID 목록:`, userIds);

    // 해당 사용자들의 FCM 토큰 조회
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where(admin.firestore.FieldPath.documentId(), 'in', userIds)
      .get();

    console.log(`FCM 토큰 문서 수: ${tokenDocs.size}`);

    const tokens = tokenDocs.docs.map(doc => doc.data().token);
    console.log(`FCM 토큰 수: ${tokens.length}`);

    if (tokens.length === 0) {
      console.log('admin과 offline_member의 FCM 토큰이 없습니다.');
      res.status(200).json({ 
        message: 'admin과 offline_member의 FCM 토큰이 없습니다. 사용자가 앱에서 FCM 토큰을 등록했는지 확인해주세요.', 
        successCount: 0, 
        failureCount: 0 
      });
      return;
    }

    // 회비 알림 메시지 구성
    const messageBody = customMessage || '1일 입니다. 이번 달 회비를 납부해 주세요.';
    
    const message = {
      notification: {
        title: '회비 안내',
        body: messageBody,
      },
      data: {
        type: 'monthly_fee',
        timestamp: Date.now().toString(),
        sentBy: adminUserId,
        testMode: testMode ? 'true' : 'false',
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    console.log('FCM 메시지 구성 완료:', message);

    // FCM 전송 (최대 500개씩 배치로 전송)
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    console.log(`배치 수: ${batches.length}`);

    let successCount = 0;
    let failureCount = 0;

    for (let batchIndex = 0; batchIndex < batches.length; batchIndex++) {
      const batch = batches[batchIndex];
      console.log(`배치 ${batchIndex + 1}/${batches.length} 처리 중 (${batch.length}개 토큰)`);
      
      try {
        // 개별 토큰으로 전송
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 기록을 Firestore에 저장
    await db.collection('notification_logs').add({
      type: 'monthly_fee_manual',
      title: '회비 안내',
      body: messageBody,
      targetUserType: 'offline_member',
      successCount: successCount,
      failureCount: failureCount,
      sentBy: adminUserId,
      testMode: testMode || false,
      sentAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`수동 회비 알림 전송 완료`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    res.status(200).json({
      message: '회비 알림 전송 완료',
      successCount: successCount,
      failureCount: failureCount,
      totalRecipients: userIds.length,
      testMode: testMode || false,
    });

  } catch (error) {
    console.error(`수동 회비 알림 전송 실패: ${error}`);
    res.status(500).json({ error: error.message });
  }
});

/**
 * dayOfWeek별 출석 체크 알림 전송 Cloud Function
 * 매주 해당 요일 전날 오후 6시에 자동으로 실행됩니다.
 */
exports.sendAttendanceReminderNotification = onSchedule({
  schedule: '0 18 * * 4,5,6,0,1,2,3', // 매주 목~수요일 오후 6시 (다음날 출석 체크 알림)
  timeZone: 'Asia/Seoul',
}, async (event) => {
  try {
    const now = new Date();
    const tomorrow = new Date(now);
    tomorrow.setDate(now.getDate() + 1);
    
    // 내일이 무슨 요일인지 확인
    const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
    const tomorrowDayName = dayNames[tomorrow.getDay()];
    
    console.log(`출석 체크 알림 전송 시작: ${tomorrowDayName}요일 출석 체크`);

    // 해당 요일에 맞는 사용자들 조회 (dayOfWeek 필드 기준)
    console.log(`${tomorrowDayName}요일 사용자 조회 (dayOfWeek 필드 기준)`);
    
    // 해당 요일에 맞는 사용자들 조회
    const dayOfWeekUsers = await db
      .collection('users')
      .where('dayOfWeek', '==', tomorrowDayName)
      .get();
    
    // dayOfWeek 필드가 없는 admin과 offline_member 사용자들도 조회
    const usersWithoutDayOfWeek = await db
      .collection('users')
      .where('userType', 'in', ['admin', 'offline_member'])
      .get();
    
    // 두 결과를 합치고 중복 제거
    const allUsers = new Map();
    
    // dayOfWeek가 설정된 사용자들 추가
    dayOfWeekUsers.docs.forEach(doc => {
      allUsers.set(doc.id, doc);
    });
    
    // dayOfWeek가 없는 admin/offline_member 사용자들 추가
    usersWithoutDayOfWeek.docs.forEach(doc => {
      const userData = doc.data();
      if (!userData.dayOfWeek) {
        allUsers.set(doc.id, doc);
      }
    });
    
    // Map의 값들을 배열로 변환
    const userSnapshot = {
      docs: Array.from(allUsers.values()),
      size: allUsers.size,
      empty: allUsers.size === 0
    };

    if (userSnapshot.empty) {
      console.log(`${tomorrowDayName}요일 출석 사용자가 없습니다.`);
      return null;
    }

    const userIds = userSnapshot.docs.map(doc => doc.id);
    console.log(`${tomorrowDayName}요일 사용자 수: ${userIds.length}`);

    // 사용자 타입별 통계 로깅
    const userTypeStats = {};
    userSnapshot.docs.forEach(doc => {
      const userData = doc.data();
      const userType = userData.userType || 'unknown';
      userTypeStats[userType] = (userTypeStats[userType] || 0) + 1;
    });
    console.log(`사용자 타입별 통계:`, userTypeStats);

    // 해당 사용자들의 FCM 토큰 조회
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where(admin.firestore.FieldPath.documentId(), 'in', userIds)
      .get();

    const tokens = tokenDocs.docs.map(doc => doc.data().token);

    if (tokens.length === 0) {
      console.log(`${tomorrowDayName}요일 사용자의 FCM 토큰이 없습니다.`);
      return null;
    }

    // 출석 체크 알림 메시지 구성
    const message = {
      notification: {
        title: '출석 체크 합시다',
        body: `(${tomorrowDayName}요일) 출석 체크를 해주세요!`,
      },
      data: {
        type: 'attendance_reminder',
        dayOfWeek: tomorrowDayName,
        timestamp: Date.now().toString(),
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    // FCM 전송 (최대 500개씩 배치로 전송)
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    let successCount = 0;
    let failureCount = 0;

    for (const batch of batches) {
      try {
        // 개별 토큰으로 전송
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 결과를 로그로 기록
    console.log(`${tomorrowDayName}요일 출석 체크 알림 전송 완료`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    // 전송 기록을 Firestore에 저장
    await db.collection('notification_logs').add({
      type: 'attendance_reminder',
      title: '출석 알림',
      body: `(${tomorrowDayName}요일) 출석 체크를 해주세요!`,
      targetDayOfWeek: tomorrowDayName,
      successCount: successCount,
      failureCount: failureCount,
      userTypeStats: userTypeStats,
      sentAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return { successCount, failureCount };
  } catch (error) {
    console.error(`출석 체크 알림 전송 실패: ${error}`);
    throw error;
  }
});

/**
 * 관리자가 수동으로 dayOfWeek별 출석 체크 알림을 보낼 수 있는 HTTP Cloud Function
 */
exports.sendManualAttendanceNotification = onRequest(async (req, res) => {
  try {
    // CORS 설정
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Access-Control-Allow-Methods', 'POST');
    res.set('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
      res.status(204).send('');
      return;
    }

    if (req.method !== 'POST') {
      res.status(405).send('Method Not Allowed');
      return;
    }

    const { adminUserId, dayOfWeek, customMessage, testMode } = req.body;

    console.log('요청 데이터:', { adminUserId, dayOfWeek, customMessage, testMode });

    if (!adminUserId || !dayOfWeek) {
      console.log('필수 파라미터 누락:', { adminUserId, dayOfWeek });
      res.status(400).send('adminUserId and dayOfWeek are required');
      return;
    }

    // 관리자 권한 확인
    const adminUserDoc = await db.collection('users').doc(adminUserId).get();
    if (!adminUserDoc.exists) {
      console.log('관리자 사용자를 찾을 수 없음:', adminUserId);
      res.status(403).send('Admin user not found');
      return;
    }

    const adminUserData = adminUserDoc.data();
    console.log('관리자 사용자 데이터:', { userType: adminUserData.userType });
    
    if (adminUserData.userType !== 'admin' && adminUserData.userType !== 'developer') {
      console.log('권한 부족:', adminUserData.userType);
      res.status(403).send('Insufficient permissions');
      return;
    }

    console.log(`수동 출석 체크 알림 전송 시작: ${dayOfWeek}요일`);

    let userSnapshot;
    
    if (testMode) {
      // 테스트 모드: 모든 사용자에게 전송
      console.log('테스트 모드: 모든 사용자에게 전송');
      userSnapshot = await db.collection('users').get();
    } else {
      // 해당 요일에 맞는 사용자들 조회 (dayOfWeek 필드 기준)
      console.log(`${dayOfWeek}요일 사용자 조회 (dayOfWeek 필드 기준)`);
      
      // 해당 요일에 맞는 사용자들 조회
      const dayOfWeekUsers = await db
        .collection('users')
        .where('dayOfWeek', '==', dayOfWeek)
        .get();
      
      // dayOfWeek 필드가 없는 admin과 offline_member 사용자들도 조회
      const usersWithoutDayOfWeek = await db
        .collection('users')
        .where('userType', 'in', ['admin', 'offline_member'])
        .get();
      
      // 두 결과를 합치고 중복 제거
      const allUsers = new Map();
      
      // dayOfWeek가 설정된 사용자들 추가
      dayOfWeekUsers.docs.forEach(doc => {
        allUsers.set(doc.id, doc);
      });
      
      // dayOfWeek가 없는 admin/offline_member 사용자들 추가
      usersWithoutDayOfWeek.docs.forEach(doc => {
        const userData = doc.data();
        if (!userData.dayOfWeek) {
          allUsers.set(doc.id, doc);
        }
      });
      
      // Map의 값들을 배열로 변환
      userSnapshot = {
        docs: Array.from(allUsers.values()),
        size: allUsers.size,
        empty: allUsers.size === 0
      };
    }

    console.log(`${dayOfWeek}요일 사용자 수: ${userSnapshot.size}`);

    // 사용자 타입별 통계 로깅
    const userTypeStats = {};
    userSnapshot.docs.forEach(doc => {
      const userData = doc.data();
      const userType = userData.userType || 'unknown';
      userTypeStats[userType] = (userTypeStats[userType] || 0) + 1;
    });
    console.log(`사용자 타입별 통계:`, userTypeStats);

    if (userSnapshot.empty) {
      console.log(`${dayOfWeek}요일 사용자가 없습니다.`);
      res.status(200).json({ 
        message: `${dayOfWeek}요일 사용자가 없습니다. 테스트 모드를 사용하거나 사용자 데이터에 dayOfWeek 필드를 추가해주세요.`, 
        successCount: 0, 
        failureCount: 0,
        suggestion: 'testMode: true를 추가하여 모든 사용자에게 테스트 전송을 시도해보세요.'
      });
      return;
    }

    const userIds = userSnapshot.docs.map(doc => doc.id);
    console.log(`사용자 ID 목록:`, userIds);

    // 해당 사용자들의 FCM 토큰 조회
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where(admin.firestore.FieldPath.documentId(), 'in', userIds)
      .get();

    console.log(`FCM 토큰 문서 수: ${tokenDocs.size}`);

    const tokens = tokenDocs.docs.map(doc => doc.data().token);
    console.log(`FCM 토큰 수: ${tokens.length}`);

    if (tokens.length === 0) {
      console.log(`${dayOfWeek}요일 사용자의 FCM 토큰이 없습니다.`);
      res.status(200).json({ 
        message: `${dayOfWeek}요일 사용자의 FCM 토큰이 없습니다. 사용자가 앱에서 FCM 토큰을 등록했는지 확인해주세요.`, 
        successCount: 0, 
        failureCount: 0 
      });
      return;
    }

    // 출석 체크 알림 메시지 구성
    const messageBody = customMessage || `${dayOfWeek}요일 오후 6시에 출석 체크를 해주세요!`;
    
    const message = {
      notification: {
        title: '출석 체크 알림',
        body: messageBody,
      },
      data: {
        type: 'attendance_reminder',
        dayOfWeek: dayOfWeek,
        timestamp: Date.now().toString(),
        sentBy: adminUserId,
        testMode: testMode ? 'true' : 'false',
      },
      android: {
        notification: {
          channelId: 'fcm_default_channel',
          priority: 'high',
          defaultSound: true,
          defaultVibrateTimings: true,
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
    };

    console.log('FCM 메시지 구성 완료:', message);

    // FCM 전송 (최대 500개씩 배치로 전송)
    const batchSize = 500;
    const batches = [];
    
    for (let i = 0; i < tokens.length; i += batchSize) {
      const batch = tokens.slice(i, i + batchSize);
      batches.push(batch);
    }

    console.log(`배치 수: ${batches.length}`);

    let successCount = 0;
    let failureCount = 0;

    for (let batchIndex = 0; batchIndex < batches.length; batchIndex++) {
      const batch = batches[batchIndex];
      console.log(`배치 ${batchIndex + 1}/${batches.length} 처리 중 (${batch.length}개 토큰)`);
      
      try {
        // 개별 토큰으로 전송
        const sendPromises = batch.map(async (token) => {
          try {
            await messaging.send({
              token: token,
              ...message,
            });
            return { success: true, token: token };
          } catch (error) {
            console.log(`토큰 전송 실패: ${token}, 에러: ${error.message}`);
            return { success: false, token: token, error: error.message };
          }
        });

        const results = await Promise.all(sendPromises);
        
        results.forEach(result => {
          if (result.success) {
            successCount++;
          } else {
            failureCount++;
            // 실패한 토큰들을 수집
            if (result.error && result.error.includes('NotRegistered')) {
              console.log(`유효하지 않은 토큰 삭제: ${result.token}`);
            }
          }
        });

        // 실패한 토큰들 정리 (NotRegistered 에러인 경우)
        const failedTokens = results
          .filter(result => !result.success && result.error && result.error.includes('NotRegistered'))
          .map(result => result.token);

        if (failedTokens.length > 0) {
          await cleanupFailedTokens(failedTokens);
        }
      } catch (error) {
        console.error(`배치 전송 실패: ${error}`);
        failureCount += batch.length;
      }
    }

    // 전송 기록을 Firestore에 저장
    await db.collection('notification_logs').add({
      type: 'attendance_reminder_manual',
      title: '출석 알림',
      body: messageBody,
      targetDayOfWeek: dayOfWeek,
      successCount: successCount,
      failureCount: failureCount,
      sentBy: adminUserId,
      testMode: testMode || false,
      sentAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`수동 출석 체크 알림 전송 완료: ${dayOfWeek}요일`);
    console.log(`성공: ${successCount}, 실패: ${failureCount}`);

    res.status(200).json({
      message: `${dayOfWeek}요일 출석 체크 알림 전송 완료`,
      successCount: successCount,
      failureCount: failureCount,
      totalRecipients: userIds.length,
      userTypeStats: userTypeStats,
      testMode: testMode || false,
    });

  } catch (error) {
    console.error(`수동 출석 체크 알림 전송 실패: ${error}`);
    res.status(500).json({ error: error.message });
  }
});

/**
 * 실패한 FCM 토큰들을 정리하는 함수
 */
async function cleanupFailedTokens(failedTokens) {
  try {
    const tokenDocs = await db
      .collection('fcm_tokens')
      .where('token', 'in', failedTokens)
      .get();

    const batch = db.batch();
    tokenDocs.docs.forEach(doc => {
      batch.delete(doc.ref);
    });

    await batch.commit();
    console.log(`${failedTokens.length}개의 실패한 토큰을 삭제했습니다.`);
  } catch (error) {
    console.error(`실패한 토큰 정리 중 오류: ${error}`);
  }
}
