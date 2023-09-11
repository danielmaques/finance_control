import 'package:finance_control/app/create_account/ui/controller/create_account_controller.dart';
import 'package:finance_control/core/ds/components/app_bar/finance_app_bar.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ds/components/checkbox/finance_check_box.dart';
import '../../../../core/ds/style/afinz_text.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CreateAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isBlockedNotifier,
        builder: (context, isBlocked, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FinanceAppBar(
                    onTap: () => Modular.to.pop(),
                    icon: true,
                  ),
                  FinanceText.h3(
                    'Create account',
                  ),
                  const SizedBox(height: 32),
                  FinanceTextField(
                    label: 'Nome',
                    hintText: 'Digite seu nome',
                    controller: controller.name,
                    onChanged: (p0) {
                      controller.name.text = p0;
                      controller.updateIsBlocked();
                    },
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Email',
                    hintText: 'Digite seu email',
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (p0) {
                      controller.updateIsBlocked();
                    },
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Senha',
                    hintText: 'Digite sua senha',
                    controller: controller.password,
                    onChanged: (p0) {
                      controller.updateIsBlocked();
                    },
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Confirme sua senha',
                    hintText: 'Digite sua senha',
                    controller: controller.confirmPassword,
                    onChanged: (p0) {
                      controller.updateIsBlocked();
                    },
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
                    disabled: isBlocked,
                    onTap: () => controller.signUp(
                      email: controller.email.text,
                      password: controller.password.text,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FinanceText.p16(
              'Já possui uma conta?',
            ),
            const SizedBox(width: 5),
            FinanceText.p16(
              'Entrar',
            ),
          ],
        ),
      ),
    );
  }
}
