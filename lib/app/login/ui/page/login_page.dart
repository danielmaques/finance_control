import 'package:finance_control/app/login/ui/controller/login_controller.dart';
import 'package:finance_control/core/ds/components/app_bar/finance_app_bar.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.controller});

  final LoginController controller;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.controller.isBlockedNotifier,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FinanceAppBar(
                  icon: false,
                ),
                const FinanceText.h3(
                  'Entrar',
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 31),
                FinanceTextField(
                  label: 'Email',
                  hintText: 'Digite seu email',
                  controller: widget.controller.email,
                  onChanged: (p0) {
                    widget.controller.updateIsBlocked();
                  },
                ),
                const SizedBox(height: 24),
                FinanceTextField(
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  controller: widget.controller.password,
                  obscureText: true,
                  onChanged: (p0) {
                    widget.controller.updateIsBlocked();
                  },
                ),
                const SizedBox(height: 24),
                FinanceButton(
                  title: 'Entrar',
                  disabled: value,
                  onTap: () {
                    widget.controller.login(
                      email: widget.controller.email.text,
                      password: widget.controller.password.text,
                    );
                  },
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
                      Modular.to.pushNamed('/createAccount');
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
                          'Criar conta.',
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
