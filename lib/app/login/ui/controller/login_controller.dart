import 'package:finance_control/app/login/domain/usecase/login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginController {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier(true);

  void updateIsBlocked() {
    isBlockedNotifier.value = email.text.isEmpty || password.text.isEmpty;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final user = await _loginUseCase.login(email, password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
