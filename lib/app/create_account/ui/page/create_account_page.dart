import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FinanceText.h3(
              'Create account',
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 32),
            const FinanceTextField(
              label: 'Nome',
              hintText: 'Digite seu nome',
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            const FinanceTextField(
              label: 'Email',
              hintText: 'Digite seu email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            const FinanceTextField(
              label: 'Senha',
              hintText: 'Digite sua senha',
            ),
            const SizedBox(height: 24),
            const FinanceTextField(
              label: 'Confirme sua senha',
              hintText: 'Digite sua senha',
            ),
            // TODO: Implementar o checkbox
            const SizedBox(height: 28),
            const ButtonComponet(),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Modular.to.pushNamed('/login/');
                },
                child: const Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
