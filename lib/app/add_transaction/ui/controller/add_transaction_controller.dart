import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTransactionController {
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<XFile?> selectedImageNotifier =
      ValueNotifier<XFile?>(null);
  final ValueNotifier<List<XFile?>> imagesNotifier =
      ValueNotifier<List<XFile?>>([]);

  Future<void> pickImageFromGallery() async {
    bool hasPermission = await requestGalleryPermission();
    if (!hasPermission) return;

    _pickImage(ImageSource.gallery);
  }

  Future<void> pickImageFromCamera() async {
    bool hasPermission = await requestCameraPermission();
    if (!hasPermission) return;

    _pickImage(ImageSource.camera);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        imagesNotifier.value = [...imagesNotifier.value, image];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao selecionar imagem: $e');
      }
    }
  }

  void dispose() {
    selectedImageNotifier.dispose();
  }

  Future<bool> requestGalleryPermission() async {
    return _requestPermission(Permission.photos);
  }

  Future<bool> requestCameraPermission() async {
    return _requestPermission(Permission.camera);
  }

  Future<bool> _requestPermission(Permission permission) async {
    PermissionStatus status = await permission.status;

    if (status.isDenied) {
      status = await permission.request();
    }

    return status.isGranted;
  }
}
