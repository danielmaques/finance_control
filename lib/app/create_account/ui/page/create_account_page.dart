import 'package:finance_control/app/create_account/ui/controller/create_account_controller.dart';
import 'package:finance_control/core/ds/components/app_bar/finance_app_bar.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ds/components/checkbox/finance_check_box.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    super.key,
    required this.controller,
  });

  final CreateAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FinanceAppBar(
              onTap: () => Modular.to.pop(),
            ),
            const FinanceText.h3(
              'Create account',
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 32),
            FinanceTextField(
              label: 'Nome',
              hintText: 'Digite seu nome',
              controller: controller.name,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FinanceTextField(
              label: 'Email',
              hintText: 'Digite seu email',
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            FinanceTextField(
              label: 'Senha',
              hintText: 'Digite sua senha',
              controller: controller.password,
            ),
            const SizedBox(height: 24),
            FinanceTextField(
              label: 'Confirme sua senha',
              hintText: 'Digite sua senha',
              controller: controller.confirmPassword,
            ),
            const SizedBox(height: 20),
            const FinanceCheckBox(
              label:
                  'Ao criar uma conta, você concorda com nossos Termos e Condições.',
              isChecked: false,
            ),
            const SizedBox(height: 28),
            FinanceButton(
              title: 'Criar conta',
              disabled: controller.name.value.text.isEmpty ||
                      controller.email.value.text.isEmpty ||
                      controller.password.value.text.isEmpty ||
                      controller.confirmPassword.value.text.isEmpty ||
                      controller.password.value.text !=
                          controller.confirmPassword.value.text
                  ? true
                  : false,
              onTap: () => controller.signUp(
                email: controller.email.value.text,
                password: controller.password.value.text,
              ),
            ),
            const Spacer(),
            const Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FinanceText.p16(
                    'Já possui uma conta?',
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 5),
                  FinanceText.p16(
                    'Entrar',
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
