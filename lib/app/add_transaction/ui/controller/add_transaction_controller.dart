import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTransactionController {
  final ValueNotifier<XFile?> selectedImageNotifier =
      ValueNotifier<XFile?>(null);
  final ValueNotifier<List<XFile?>> imagesNotifier =
      ValueNotifier<List<XFile?>>([]);

  AddTransactionController();

  Future<void> pickImageFromGallery() async {
    bool hasPermission = await requestGalleryPermission();
    if (!hasPermission) return;

    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagesNotifier.value = [...imagesNotifier.value, image];
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
