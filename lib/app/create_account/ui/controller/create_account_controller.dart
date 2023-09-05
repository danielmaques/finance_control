// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/create_account_usecase.dart';

class CreateAccountController {
  final CreateAccountUseCase _createAccountUseCase;

  CreateAccountController(this._createAccountUseCase);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier(true);

  void updateIsBlocked() {
    isBlockedNotifier.value = name.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty ||
        password.text != confirmPassword.text;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      final user = await _createAccountUseCase.signUp(email, password);

      if (user != null && user.id != null && user.email != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.id).set({
          'email': user.email,
          'id': user.id,
          'name': name.text,
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
