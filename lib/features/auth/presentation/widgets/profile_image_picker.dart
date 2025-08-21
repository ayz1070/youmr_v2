import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/image_processing_utils.dart';

/// 프로필 이미지 선택 위젯
/// - 이미지 선택, 미리보기, 카메라/갤러리 선택 기능
class ProfileImagePicker extends StatelessWidget {
  /// 선택된 이미지 파일
  final File? selectedImageFile;
  /// 현재 이미지 URL
  final String? currentImageUrl;
  /// 이미지 선택 콜백
  final Function(File) onImageSelected;
  /// 이미지 선택 에러 콜백
  final Function(String) onError;

  /// [selectedImageFile]: 선택된 이미지 파일
  /// [currentImageUrl]: 현재 이미지 URL
  /// [onImageSelected]: 이미지 선택 시 콜백
  /// [onError]: 에러 발생 시 콜백
  const ProfileImagePicker({
    super.key,
    this.selectedImageFile,
    this.currentImageUrl,
    required this.onImageSelected,
    required this.onError,
  });

  /// 이미지 선택 (카메라 또는 갤러리)
  Future<void> _pickImage({required ImageSource source}) async {
    try {
      // 개선된 이미지 처리 유틸리티 사용
      final File? optimizedImage = await ImageProcessingUtils.pickAndOptimizeImage(
        source: source,
        maxSize: ImageProcessingUtils.profileImageSize,
        quality: ImageProcessingUtils.compressionQuality,
      );

      if (optimizedImage != null) {
        // 이미지 유효성 검사
        final ValidationResult validation = await ImageProcessingUtils.validateImage(optimizedImage);
        
        if (validation.isValid) {
          onImageSelected(optimizedImage);
        } else {
          onError(validation.error ?? '이미지 검증에 실패했습니다.');
        }
      }
    } catch (e) {
      onError('이미지 선택 실패: $e');
    }
  }

  /// 이미지 선택 다이얼로그 표시
  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('프로필 이미지 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 촬영'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(source: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 프로필 이미지
        Center(
          child: GestureDetector(
            onTap: () => _showImagePickerDialog(context),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: selectedImageFile != null
                      ? FileImage(selectedImageFile!)
                      : (currentImageUrl != null
                          ? NetworkImage(currentImageUrl!) as ImageProvider
                          : const AssetImage('assets/images/default_profile.png')),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 이미지 상태 텍스트
        Center(
          child: Text(
            selectedImageFile != null
                ? '선택된 이미지'
                : (currentImageUrl != null ? '현재 프로필 이미지' : '기본 프로필 이미지'),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),

      ],
    );
  }
} 