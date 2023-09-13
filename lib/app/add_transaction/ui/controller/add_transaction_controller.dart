import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddTransactionController {
  CameraController? cameraController;
  final ValueNotifier<XFile?> selectedImageNotifier =
      ValueNotifier<XFile?>(null);
  final ValueNotifier<List<XFile?>> imagesNotifier =
      ValueNotifier<List<XFile?>>([]);

  AddTransactionController() {
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final firstCamera = cameras.first;

        cameraController = CameraController(
          firstCamera,
          ResolutionPreset.medium,
        );

        await cameraController!.initialize();
      } else {
        if (kDebugMode) {
          print('No cameras available');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }
  }

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
    if (cameraController != null && cameraController!.value.isInitialized) {
      cameraController!.dispose();
    }
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
