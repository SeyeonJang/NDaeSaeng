import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtil {
  static Future<File> compressImage(File imageFile, {int quality = 30, int maxSize = 1024, fileSizeKb = 100}) async {
    try {
      // 원본 이미지 높이, 너비 가져오기
      final originalImage = img.decodeImage(imageFile.readAsBytesSync());
      if (originalImage == null) throw Error();
      final int originalWidth = originalImage.width;
      final int originalHeight = originalImage.height;

      // 원본 이미지 비율 유지로 단축될 높이와 너비 계산
      int targetWidth = originalWidth;
      int targetHeight = originalHeight;

      if (originalWidth > maxSize || originalHeight > maxSize) {
        if (originalWidth >= originalHeight) {
          targetWidth = maxSize;
          targetHeight = (maxSize * originalHeight) ~/ originalWidth;
        } else {
          targetHeight = maxSize;
          targetWidth = (maxSize * originalWidth) ~/ originalHeight;
        }
      }

      int currentQuality = quality;
      File compressedImageFile = imageFile;
      do {
        final bytes = await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minWidth: targetWidth,
          minHeight: targetHeight,
          quality: currentQuality,
        );

        final newPath = '${imageFile.path}_compressed.jpeg';
        compressedImageFile = File(newPath);
        await compressedImageFile.writeAsBytes(bytes as List<int>);

        // 품질을 낮추며 크기가 100KB 이하가 될 때까지 반복
        currentQuality -= 5;
        print("compressedImage Size: ${getImageSize(compressedImageFile)}");
      } while (getImageSize(compressedImageFile) > fileSizeKb * 1024 && currentQuality > 0);

      return compressedImageFile;
    } catch (e) {
      print('Error compressing image: $e');
      // 실패한 경우 원래 이미지 파일 반환
      return imageFile;
    }
  }

  // 이미지 파일 크기(byte)를 반환하는 함수
  static int getImageSize(File imageFile) {
    return imageFile.lengthSync();
  }
}
