import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

/// 이미지 처리 유틸리티
/// - 프로필 이미지 최적화, 압축, 포맷 변환 등
class ImageProcessingUtils {
  /// 프로필 이미지 최적화 설정
  static const int profileImageSize = 400;
  static const int thumbnailSize = 100;
  static const int maxFileSizeBytes = 2 * 1024 * 1024; // 2MB
  static const double compressionQuality = 0.7;

  /// 이미지 선택 및 최적화
  /// [source]: 이미지 소스 (카메라/갤러리)
  /// 반환: 최적화된 이미지 파일 또는 null
  static Future<File?> pickAndOptimizeImage({
    required ImageSource source,
    int maxSize = profileImageSize,
    double quality = compressionQuality,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: maxSize.toDouble(),
        maxHeight: maxSize.toDouble(),
        imageQuality: (quality * 100).round(),
      );

      if (image == null) return null;

      final File imageFile = File(image.path);
      
      // 파일 크기 검증
      if (!await _validateFileSize(imageFile)) {
        throw Exception('이미지 파일이 너무 큽니다. (최대 2MB)');
      }

      // 추가 최적화 (필요시)
      return await _furtherOptimizeImage(imageFile, quality);
    } catch (e) {
      rethrow;
    }
  }

  /// 파일 크기 검증
  /// [file]: 검증할 파일
  /// 반환: 크기 제한 통과 여부
  static Future<bool> _validateFileSize(File file) async {
    try {
      final int fileSize = await file.length();
      return fileSize <= maxFileSizeBytes;
    } catch (e) {
      return false;
    }
  }

  /// 추가 이미지 최적화
  /// [file]: 원본 이미지 파일
  /// [quality]: 압축 품질
  /// 반환: 최적화된 이미지 파일
  static Future<File> _furtherOptimizeImage(File file, double quality) async {
    // 현재는 기본 압축만 적용
    // flutter_image_compress 패키지 사용 시 더 고급 최적화 가능
    return file;
  }

  /// 이미지 메타데이터 추출
  /// [file]: 이미지 파일
  /// 반환: 이미지 정보
  static Future<CustomImageInfo> getImageInfo(File file) async {
    try {
      final int fileSize = await file.length();
      final Uint8List bytes = await file.readAsBytes();
      
      return CustomImageInfo(
        fileSize: fileSize,
        width: 0, // 실제 구현에서는 이미지 디코딩 필요
        height: 0,
        format: _detectImageFormat(bytes),
      );
    } catch (e) {
      throw Exception('이미지 정보 추출 실패: $e');
    }
  }

  /// 이미지 포맷 감지
  /// [bytes]: 이미지 바이트 데이터
  /// 반환: 이미지 포맷
  static String _detectImageFormat(Uint8List bytes) {
    if (bytes.length < 4) return 'unknown';
    
    // JPEG 시그니처 확인
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) return 'JPEG';
    
    // PNG 시그니처 확인
    if (bytes[0] == 0x89 && bytes[1] == 0x50 && 
        bytes[2] == 0x4E && bytes[3] == 0x47) return 'PNG';
    
    // WebP 시그니처 확인
    if (bytes.length >= 12 &&
        bytes[0] == 0x52 && bytes[1] == 0x49 && 
        bytes[2] == 0x46 && bytes[3] == 0x46 &&
        bytes[8] == 0x57 && bytes[9] == 0x45 && 
        bytes[10] == 0x42 && bytes[11] == 0x50) return 'WebP';
    
    return 'unknown';
  }

  /// 이미지 유효성 검사
  /// [file]: 검사할 이미지 파일
  /// 반환: 유효성 검사 결과
  static Future<ValidationResult> validateImage(File file) async {
    try {
      // 파일 존재 확인
      if (!await file.exists()) {
        return ValidationResult(
          isValid: false,
          error: '파일이 존재하지 않습니다.',
        );
      }

      // 파일 크기 확인
      final int fileSize = await file.length();
      if (fileSize > maxFileSizeBytes) {
        return ValidationResult(
          isValid: false,
          error: '파일 크기가 너무 큽니다. (최대 2MB)',
        );
      }

      // 이미지 포맷 확인
      final Uint8List bytes = await file.readAsBytes();
      final String format = _detectImageFormat(bytes);
      if (format == 'unknown') {
        return ValidationResult(
          isValid: false,
          error: '지원하지 않는 이미지 포맷입니다.',
        );
      }

      return ValidationResult(
        isValid: true,
        fileSize: fileSize,
        format: format,
      );
    } catch (e) {
      return ValidationResult(
        isValid: false,
        error: '이미지 검증 실패: $e',
      );
    }
  }

  /// 이미지 크기 조정 (필요시)
  /// [file]: 원본 이미지 파일
  /// [targetSize]: 목표 크기
  /// 반환: 크기 조정된 이미지 파일
  static Future<File> resizeImage(File file, int targetSize) async {
    // image 패키지를 사용한 크기 조정 구현
    // 현재는 기본 반환
    return file;
  }
}

/// 이미지 정보 클래스 (Flutter의 ImageInfo와 충돌 방지)
class CustomImageInfo {
  final int fileSize;
  final int width;
  final int height;
  final String format;

  const CustomImageInfo({
    required this.fileSize,
    required this.width,
    required this.height,
    required this.format,
  });

  /// 파일 크기를 읽기 쉬운 형태로 변환
  String get fileSizeFormatted {
    if (fileSize < 1024) return '${fileSize}B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)}KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

/// 이미지 검증 결과 클래스
class ValidationResult {
  final bool isValid;
  final String? error;
  final int? fileSize;
  final String? format;

  const ValidationResult({
    required this.isValid,
    this.error,
    this.fileSize,
    this.format,
  });
} 