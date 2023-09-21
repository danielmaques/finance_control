// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/model/user_model.dart';
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
  TextEditingController houseId = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier(true);
  ValueNotifier<bool> isCriate = ValueNotifier(true);

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

        if (houseId.text.length < 10) {
          await createHouse();
        } else {
          await joinExistingHouse();
        }

        isCriate.value = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Map<String, dynamic>?> createHouse() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final List<UserModel> userModel = [
      UserModel(id: userId, name: name.text, email: email.text),
    ];

    final DocumentReference houseRef =
        await _createAccountUseCase.createHouse(userModel);

    await prefs.setString('house_id', houseRef.id);

    final DocumentSnapshot houseSnapshot = await houseRef.get();
    return houseSnapshot.data() as Map<String, dynamic>?;
  }

  Future<void> joinExistingHouse() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final user = UserModel(id: userId, name: name.text, email: email.text);

    await _createAccountUseCase.joinHouse(houseId.text, user);

    await prefs.setString('house_id', houseId.text);
  }
}
