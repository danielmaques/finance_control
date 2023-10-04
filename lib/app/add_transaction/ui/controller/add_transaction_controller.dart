import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactionController {
  final AddTransactionUseCase _useCase;

  final ValueNotifier<TextEditingController> value =
      ValueNotifier(TextEditingController());
  final ValueNotifier<double> pay = ValueNotifier(0);
  ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
  final ValueNotifier<TextEditingController> description =
      ValueNotifier(TextEditingController());
  final ValueNotifier<List<dynamic>> categoriesList = ValueNotifier([]);
  final ValueNotifier<String> categoriesValue = ValueNotifier('');
  final ValueNotifier<List<dynamic>> paymentsList = ValueNotifier([]);
  final ValueNotifier<String> paymentsValue = ValueNotifier('');
  final ValueNotifier<XFile?> selectedImageNotifier =
      ValueNotifier<XFile?>(null);
  final ValueNotifier<List<XFile?>> imagesNotifier =
      ValueNotifier<List<XFile?>>([]);
  ValueNotifier<List<String>> accountList = ValueNotifier<List<String>>([]);
  ValueNotifier<String> bank = ValueNotifier('');

  AddTransactionController(
    this._useCase,
  );

  Future<void> addTransaction({
    required DateTime data,
    required double valor,
    required String categoria,
    required String payments,
    required String descricao,
    required bool add,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      Map<String, dynamic> gastoData = {
        'data': data,
        'valor': valor,
        'categoria': categoria,
        'pagamento': payments,
        'descricao': descricao,
        'add': add,
      };

      await _useCase.addTransaction(houseId, gastoData, add);
      await _useCase.updateBalance(houseId, valor, add);
      await _useCase.updateAccountBalance(houseId, bank.value, pay.value, add);
    } else {
      if (kDebugMode) {
        print("Erro: UID do usuário não encontrado.");
      }
    }
  }

  Future<void> fetchCategories() async {
    try {
      final List<dynamic> categories = await _useCase.getCategories();
      categoriesList.value = categories;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar categorias: $e");
      }
    }
  }

  Future<void> fetchPayments() async {
    try {
      final List<dynamic> payments = await _useCase.getPayments();
      paymentsList.value = payments;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar categorias: $e");
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

  Future<void> getAccountBanks() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    final banks = await _useCase.getAccountBanks(houseId!);

    accountList.value = banks;
  }
}
