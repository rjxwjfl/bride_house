import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerConfig {
  final ImagePicker _imagePicker;

  ImagePickerConfig(this._imagePicker);

  Future<File?> getImage(ImageSource imageSource) async {
    XFile? pickedImage = await _imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      return _cropImage(pickedImage.path);
    }
    return null;
  }

  Future<File?> _cropImage(String path) async {
    const maxWidth = 1920;
    const maxHeight = 1080;

    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: path,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '편집',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        ),
        IOSUiSettings(
          title: '편집',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }
}
