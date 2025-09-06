import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {
  File? _image;

  Future<void> pickAndCropImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      _image = await _cropImage(imageFile: img);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  File? get getImage => _image;
}
