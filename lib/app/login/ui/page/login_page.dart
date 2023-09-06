import 'package:finance_control/app/login/ui/controller/login_controller.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const FinanceText.h3(
              'Entrar',
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 31),
            const FinanceTextField(
              label: 'Email',
              hintText: 'Digite seu email',
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            const FinanceTextField(
              label: 'Senha',
              hintText: 'Digite sua senha',
              obscureText: true,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            const FinanceButton(
              title: 'Entrar',
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Modular.to.pushNamed('');
                  // TODO: Implementar modulo de esqueceu a senha
                },
                child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FinanceText.p16(
                        'Esqueceu a senha?',
                        fontWeight: FontWeight.w400,
                      ),
                    ]),
              ),
            ),
            const Spacer(flex: 2),
            Center(
              child: GestureDetector(
                onTap: () {
                  Modular.to.pushNamed('/');
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FinanceText.p16(
                      'Não possui uma conta?',
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(width: 5),
                    FinanceText.p16(
                      'Registrar.',
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
