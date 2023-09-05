// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/create_account_usecase.dart';

abstract class CreateAccountController {
  ValueNotifier<TextEditingController> name =
      ValueNotifier(TextEditingController());

  ValueNotifier<TextEditingController> email =
      ValueNotifier(TextEditingController());

  ValueNotifier<TextEditingController> password =
      ValueNotifier(TextEditingController());

  ValueNotifier<TextEditingController> confirmPassword =
      ValueNotifier(TextEditingController());

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier<bool>(false);

  Future<void> signUp({required String email, required String password});
}

class CreateAccountControllerImpl extends CreateAccountController {
  final CreateAccountUseCase _createAccountUseCase;

  CreateAccountControllerImpl(this._createAccountUseCase) {
    // Adding listeners to update the isBlockedNotifier value
    name.addListener(updateIsBlocked);
    email.addListener(updateIsBlocked);
    password.addListener(updateIsBlocked);
    confirmPassword.addListener(updateIsBlocked);
  }

  void updateIsBlocked() {
    // Checking if all fields are not empty
    if (name.value.text.isNotEmpty &&
        email.value.text.isNotEmpty &&
        password.value.text.isNotEmpty &&
        confirmPassword.value.text.isNotEmpty) {
      isBlockedNotifier.value = false;
    } else {
      isBlockedNotifier.value = true;
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      final user = await _createAccountUseCase.signUp(email, password);

      // Null checks for user and its properties
      if (user != null && user.id != null && user.email != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.id).set({
          'email': user.email,
          'id': user.id,
          'name': name.value.text,
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id); // Using null check
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
