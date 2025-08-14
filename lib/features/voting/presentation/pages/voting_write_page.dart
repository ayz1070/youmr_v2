import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/widgets/app_button.dart';
import '../../di/voting_module.dart';
import '../widgets/voting_form_section.dart';
import '../providers/states/voting_write_state.dart';
import '../../../auth/di/auth_module.dart';

/// 곡 등록 화면
class VotingWritePage extends ConsumerStatefulWidget {
  const VotingWritePage({super.key});

  @override
  ConsumerState<VotingWritePage> createState() => _VotingWritePageState();
}

class _VotingWritePageState extends ConsumerState<VotingWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  /// 투표 등록 처리
  Future<void> _handleRegisterVote() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authState = ref.read(authProvider);
    
    // 인증 상태 확인
    authState.when(
      data: (authUser) {
        if (authUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('로그인이 필요합니다.')),
          );
          return;
        }
        
        // 투표 등록 실행
        ref.read(votingWriteProvider.notifier).registerVote(
          title: _titleController.text.trim(),
          artist: _artistController.text.trim(),
          youtubeUrl: _youtubeController.text.trim().isEmpty ? null : _youtubeController.text.trim(),
          createdBy: authUser.uid,
        );
      },
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('인증 정보를 확인 중입니다. 잠시만 기다려주세요.')),
        );
      },
      error: (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('인증 오류가 발생했습니다: $error')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final writeState = ref.watch(votingWriteProvider);
    final authState = ref.watch(authProvider);
    
    // 인증 상태별 처리
    return authState.when(
      data: (authUser) {
        if (authUser == null) {
          // 로그인되지 않은 상태
          return Scaffold(
            appBar: AppBar(
              title: const Text('곡 등록'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('로그인이 필요합니다', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('곡을 등록하려면 먼저 로그인해주세요', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        }
        
        // 로그인된 상태 - 기존 로직 실행
        _handleVotingWriteState(writeState);
        return _buildVotingWriteUI();
      },
      loading: () {
        // 인증 정보 로딩 중
        return Scaffold(
          appBar: AppBar(
            title: const Text('곡 등록'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('인증 정보를 확인 중입니다...'),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        // 인증 오류
        return Scaffold(
          appBar: AppBar(
            title: const Text('곡 등록'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('인증 오류가 발생했습니다', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('$error', style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(authProvider),
                  child: const Text('다시 시도'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  /// 투표 작성 상태 처리
  void _handleVotingWriteState(VotingWriteState writeState) {
    writeState.when(
      initial: () {
        // 초기 상태 - 아무것도 하지 않음
      },
      loading: () {
        // 로딩 상태 - 성공 시 자동으로 처리됨
      },
      success: () {
        // 성공 상태 - 자동으로 이전 화면으로 이동
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('곡이 등록되었습니다.')),
          );
          // 상태 초기화
          ref.read(votingWriteProvider.notifier).reset();
        });
      },
      error: (message) {
        // 에러 상태 - 에러 메시지 표시
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('등록 실패: $message')),
          );
        });
      },
    );
  }
  
  /// 투표 작성 UI 구성
  Widget _buildVotingWriteUI() {
    final writeState = ref.watch(votingWriteProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('곡 등록'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: writeState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('등록 중 오류가 발생했습니다'),
              Text(message, style: TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: () => ref.read(votingWriteProvider.notifier).reset(),
                child: Text('다시 시도'),
              ),
            ],
          ),
        ),
        initial: () => _buildForm(),
        success: () => _buildForm(),
      ),
    );
  }

  /// 폼 UI 구성
  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // 폼 섹션
          VotingFormSection(
            formKey: _formKey,
            titleController: _titleController,
            artistController: _artistController,
            youtubeController: _youtubeController,
          ),
          // 등록 버튼
          AppButton(
            text: '등록',
            onPressed: _handleRegisterVote,
          ),
        ],
      ),
    );
  }
} 