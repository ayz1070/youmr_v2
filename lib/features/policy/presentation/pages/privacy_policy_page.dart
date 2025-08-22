import 'package:flutter/material.dart';

/// 개인정보처리방침 페이지
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인정보처리방침'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YouMR 개인정보처리방침',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '시행일자: 2024년 8월 1일',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            
            _PolicySection(
              title: '1. 개인정보의 처리목적',
              content: 'YouMR(이하 "회사")는 다음의 목적을 위하여 개인정보를 처리합니다.\n\n'
                  '• 회원가입 및 서비스 이용에 따른 본인확인\n'
                  '• 서비스 제공 및 운영\n'
                  '• 출석체크 및 활동 관리\n'
                  '• 공지사항 전달 및 고객상담\n'
                  '• 서비스 개선 및 신규 서비스 개발',
            ),
            
            _PolicySection(
              title: '2. 개인정보의 처리 및 보유기간',
              content: '회사는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.\n\n'
                  '• 회원정보: 회원탈퇴 시까지\n'
                  '• 출석 기록: 서비스 이용 종료 후 1년\n'
                  '• 서비스 이용 기록: 3개월',
            ),
            
            _PolicySection(
              title: '3. 개인정보의 제3자 제공',
              content: '회사는 원칙적으로 정보주체의 개인정보를 수집·이용 목적으로 명시한 범위 내에서 처리하며, 정보주체의 동의, 법률의 특별한 규정 등이 없는 한 개인정보를 제3자에게 제공하지 않습니다.',
            ),
            
            _PolicySection(
              title: '4. 개인정보처리의 위탁',
              content: '회사는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.\n\n'
                  '• 수탁업체: Google Firebase\n'
                  '• 위탁업무 내용: 클라우드 서비스 및 데이터 저장\n'
                  '• 보유 및 이용기간: 위탁계약 종료시까지',
            ),
            
            _PolicySection(
              title: '5. 정보주체의 권리·의무 및 행사방법',
              content: '정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.\n\n'
                  '• 개인정보 처리현황 통지요구\n'
                  '• 개인정보 열람요구\n'
                  '• 개인정보 정정·삭제요구\n'
                  '• 개인정보 처리정지요구\n\n'
                  '상기 권리 행사는 개인정보보호법 시행규칙 별지 제8호 서식에 따라 작성하여 서면, 전자우편 등을 통하여 하실 수 있으며, 회사는 이에 대해 지체없이 조치하겠습니다.',
            ),
            
            _PolicySection(
              title: '6. 개인정보의 안전성 확보조치',
              content: '회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n\n'
                  '• 관리적 조치: 개인정보 취급 직원의 최소화 및 교육\n'
                  '• 기술적 조치: 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치\n'
                  '• 물리적 조치: 전산실, 자료보관실 등의 접근통제',
            ),
            
            _PolicySection(
              title: '7. 개인정보보호책임자',
              content: '회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보보호책임자를 지정하고 있습니다.\n\n'
                  '개인정보보호책임자\n'
                  '• 성명: YouMR 개발팀\n'
                  '• 연락처: youmr.contact@gmail.com',
            ),
            
            _PolicySection(
              title: '8. 개인정보처리방침의 변경',
              content: '이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.',
            ),
            
            SizedBox(height: 32),
            Text(
              '본 방침은 2024년 8월 1일부터 시행됩니다.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const _PolicySection({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}