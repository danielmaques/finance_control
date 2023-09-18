// ignore_for_file: unnecessary_null_comparison

import 'package:finance_control/app/login/domain/usecase/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier(true);
  ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);

  void updateIsBlocked() {
    isBlockedNotifier.value = email.text.isEmpty || password.text.isEmpty;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final user = await _loginUseCase.login(email, password);
      if (user != null && user.id != null && user.email != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id);

        final houseId = await _loginUseCase.findHouseIdByUserId(user.id);
        if (houseId != null) {
          await prefs.setString('house_id', houseId);
        }

        isLoggedInNotifier.value = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null && userId.isNotEmpty) {
      isLoggedInNotifier.value = true;
    }
  }
}
