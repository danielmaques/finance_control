import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter/material.dart';

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
  Future<void> signUp();
}

class CreateAccountControllerImpl extends CreateAccountController {
  final CreateAccountUseCase _createAccountUseCase;
  final Function(BaseState) emit;

  CreateAccountControllerImpl(this._createAccountUseCase, this.emit);

  @override
  Future<void> signUp() async {
    emit(const LoadingState());
    try {
      final user = await _createAccountUseCase.signUp(
        email.value.text,
        password.value.text,
      );
      emit(SuccessState(user));

      await FirebaseFirestore.instance.collection('users').doc(user.id).set({
        'email': user.email,
        'id': user.id,
        'name': name,
      });
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
