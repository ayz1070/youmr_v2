// File generated for test environment Firebase configuration.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Test environment [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_test.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: TestFirebaseOptions.currentPlatform,
/// );
/// ```
class TestFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'TestFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'TestFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'TestFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'TestFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // TODO: 테스트 환경 Firebase 프로젝트 설정으로 업데이트 필요
  // 현재는 프로덕션 설정을 임시로 사용
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCm0wOtl35EvWuPo1jJV_MfKIG8p-DVcqM',
    appId: '1:756931774464:web:7925919cc4cf85b0a4f0e5',
    messagingSenderId: '756931774464',
    projectId: 'youmr-v2', // TODO: youmr-test로 변경
    authDomain: 'youmr-v2.firebaseapp.com', // TODO: youmr-test로 변경
    storageBucket: 'youmr-v2.firebasestorage.app', // TODO: youmr-test로 변경
    measurementId: 'G-BT8XSSB8YC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDepXTG53Am5CoLcBY2CnahH97A3MUwuCU',
    appId: '1:756931774464:android:7d7b1958143f66eaa4f0e5',
    messagingSenderId: '756931774464',
    projectId: 'youmr-v2', // TODO: youmr-test로 변경
    storageBucket: 'youmr-v2.firebasestorage.app', // TODO: youmr-test로 변경
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-nI7gljCxvxyCfoVClce6fS4D7KinnP8',
    appId: '1:756931774464:ios:8be8e4df15799a89a4f0e5',
    messagingSenderId: '756931774464',
    projectId: 'youmr-v2', // TODO: youmr-test로 변경
    storageBucket: 'youmr-v2.firebasestorage.app', // TODO: youmr-test로 변경
    iosBundleId: 'com.youmr.youmrV2',
  );
}
