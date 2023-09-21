import 'package:finance_control/app/create_account/ui/controller/create_account_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                    icon: true,
                    onTap: () => Modular.to.pop(),
                  ),
                  FinanceText.h3(
                    'Criar conta',
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
                    validator: (p0) {
                      if (p0 == null) {
                        return 'Digite uma senha';
                      } else if (p0.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
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
                    validator: (p0) {
                      if (controller.confirmPassword.text !=
                              controller.password.text ||
                          p0 != null) {
                        return 'Senhas diferentes';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Codigo de convite',
                    hintText: 'fbe2t948-83e4-4098-a185-e811ce254505',
                    controller: controller.houseId,
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
                    onTap: () async {
                      controller.signUp(
                        email: controller.email.text,
                        password: controller.password.text,
                      );

                      if (controller.isCriate.value == true) {
                        Modular.to.pushNamed('/home/');
                      }
                    },
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
