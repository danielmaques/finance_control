import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FinanceText.h3(
              'Create account',
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 32),
            FinanceTextField(
              label: 'Nome',
              hintText: 'Digite seu nome',
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: 24),
            FinanceTextField(
              label: 'Email',
              hintText: 'Digite seu email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24),
            FinanceTextField(
              label: 'Senha',
              hintText: 'Digite sua senha',
            ),
            SizedBox(height: 24),
            FinanceTextField(
              label: 'Confirme sua senha',
              hintText: 'Digite sua senha',
            ),
            // TODO: Implementar o checkbox
            SizedBox(height: 28),
            ButtonComponet(),
            Spacer(),
            Center(
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
