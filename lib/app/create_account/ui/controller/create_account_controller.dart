// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/create_account_usecase.dart';

abstract class CreateAccountController extends Cubit<BaseState> {
  CreateAccountController(BaseState initialState) : super(initialState);

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  ValueNotifier<bool> isBlockedNotifier = ValueNotifier<bool>(true);

  Future<void> signUp({required String email, required String password});
}

class CreateAccountControllerImpl extends CreateAccountController {
  final CreateAccountUseCase _createAccountUseCase;

  CreateAccountControllerImpl(this._createAccountUseCase)
      : super(const EmptyState()) {
    name.addListener(updateIsBlocked);
    email.addListener(updateIsBlocked);
    password.addListener(updateIsBlocked);
    confirmPassword.addListener(updateIsBlocked);
  }

  void updateIsBlocked() {
    isBlockedNotifier.value = name.value.text.isEmpty ||
        email.value.text.isEmpty ||
        password.value.text.isEmpty ||
        confirmPassword.value.text.isEmpty ||
        password.value.text != confirmPassword.value.text;
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      emit(const LoadingState());
      final user = await _createAccountUseCase.signUp(email, password);

      if (user != null && user.id != null && user.email != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.id).set({
          'email': user.email,
          'id': user.id,
          'name': name.value.text,
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.id);
        emit(SuccessState(user));
      }
    } catch (e) {
      emit(const ErrorState(''));
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
