// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:finance_control/app/onboarding/domain/usecase/login_usecase.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier(true);
  ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);

  ValueNotifier<bool> reset = ValueNotifier(true);

  void updateIsBlocked() {
    isBlockedNotifier.value = email.text.isEmpty || password.text.isEmpty;
  }

  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
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
      return true;
    } catch (e) {
      FinanceAlerts.error(context,
          "Por favor, verifique se os dados estão preenchidos corretamente e tente efetuar o login novamente.");
      return false;
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null && userId.isNotEmpty) {
      isLoggedInNotifier.value = true;
    }
  }

  Future<void> resetPassword({required String email}) async {
    await _loginUseCase.resetPassword(email);
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      final userCredential = await _loginUseCase.loginWithGoogle();
      if (userCredential != null) {
        final user = userCredential.user;
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', user.uid);

          final houseId = await _loginUseCase.findHouseIdByUserId(user.uid);
          if (houseId != null) {
            await prefs.setString('house_id', houseId);
            isLoggedInNotifier.value = true;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.cherryRed,
          content: Text('Conta não existente'),
        ),
      );
    }
  }
}
