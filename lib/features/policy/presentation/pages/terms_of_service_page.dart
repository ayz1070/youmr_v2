import 'package:flutter/material.dart';

/// 이용약관 페이지
class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이용약관'),
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
              'YouMR 서비스 이용약관',
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
            
            _TermsSection(
              title: '제1조 (목적)',
              content: '이 약관은 YouMR(이하 "회사")가 제공하는 모바일 애플리케이션 서비스(이하 "서비스")의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.',
            ),
            
            _TermsSection(
              title: '제2조 (정의)',
              content: '1. "서비스"란 회사가 제공하는 YouMR 모바일 애플리케이션을 통해 이용할 수 있는 모든 서비스를 의미합니다.\n'
                  '2. "이용자"란 이 약관에 따라 회사가 제공하는 서비스를 받는 자를 의미합니다.\n'
                  '3. "회원"이란 회사에 개인정보를 제공하여 회원등록을 한 자로서, 회사의 서비스를 계속적으로 이용할 수 있는 자를 의미합니다.',
            ),
            
            _TermsSection(
              title: '제3조 (약관의 게시와 개정)',
              content: '1. 회사는 이 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.\n'
                  '2. 회사는 필요하다고 인정되는 경우 이 약관을 개정할 수 있습니다.\n'
                  '3. 회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.',
            ),
            
            _TermsSection(
              title: '제4조 (서비스의 제공 및 변경)',
              content: '1. 회사가 제공하는 서비스는 다음과 같습니다.\n'
                  '   • 출석체크 서비스\n'
                  '   • 커뮤니티 게시판 서비스\n'
                  '   • 기타 회사가 추가 개발하거나 다른 회사와의 제휴계약 등을 통해 이용자에게 제공하는 일체의 서비스\n\n'
                  '2. 회사는 기술적 사양의 변경 등의 경우에는 장래에 제공할 서비스의 내용을 변경할 수 있습니다.',
            ),
            
            _TermsSection(
              title: '제5조 (서비스의 중단)',
              content: '1. 회사는 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.\n'
                  '2. 회사는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상하지 않습니다.',
            ),
            
            _TermsSection(
              title: '제6조 (회원가입)',
              content: '1. 이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.\n'
                  '2. 회사는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.\n'
                  '   • 가입신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우\n'
                  '   • 등록 내용에 허위, 기재누락, 오기가 있는 경우\n'
                  '   • 기타 회원으로 등록하는 것이 회사의 기술상 현저히 지장이 있다고 판단되는 경우',
            ),
            
            _TermsSection(
              title: '제7조 (회원탈퇴 및 자격 상실)',
              content: '1. 회원은 회사에 언제든지 탈퇴를 요청할 수 있으며 회사는 즉시 회원탈퇴를 처리합니다.\n'
                  '2. 회원이 다음 각 호의 사유에 해당하는 경우, 회사는 회원자격을 제한 및 정지시킬 수 있습니다.\n'
                  '   • 가입 신청 시에 허위 내용을 등록한 경우\n'
                  '   • 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우\n'
                  '   • 서비스를 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우',
            ),
            
            _TermsSection(
              title: '제8조 (회원에 대한 통지)',
              content: '1. 회사가 회원에 대한 통지를 하는 경우, 회원이 회사와 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.\n'
                  '2. 회사는 불특정다수 회원에 대한 통지의 경우 1주일이상 서비스 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다.',
            ),
            
            _TermsSection(
              title: '제9조 (개인정보보호)',
              content: '회사는 관계법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법령 및 회사의 개인정보처리방침이 적용됩니다.',
            ),
            
            _TermsSection(
              title: '제10조 (회사의 의무)',
              content: '1. 회사는 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하기 위해서 노력합니다.\n'
                  '2. 회사는 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보보호를 위한 보안 시스템을 구축합니다.\n'
                  '3. 회사는 이용자로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 합니다.',
            ),
            
            _TermsSection(
              title: '제11조 (면책조항)',
              content: '1. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.\n'
                  '2. 회사는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임을 지지 않습니다.\n'
                  '3. 회사는 회원이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않습니다.',
            ),
            
            _TermsSection(
              title: '제12조 (재판권 및 준거법)',
              content: '1. 회사와 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다.\n'
                  '2. 회사와 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.',
            ),
            
            SizedBox(height: 32),
            Text(
              '부칙: 본 약관은 2024년 8월 1일부터 시행됩니다.',
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

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({
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