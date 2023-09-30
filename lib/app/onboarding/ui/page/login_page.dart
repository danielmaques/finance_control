import 'package:finance_control/app/onboarding/ui/controller/login_controller.dart';
import 'package:finance_control_ui/0_core/helper/validator.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
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
    return FutureBuilder<void>(
      future: widget.controller.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ValueListenableBuilder<bool>(
            valueListenable: widget.controller.isLoggedInNotifier,
            builder: (context, isLoggedIn, child) {
              if (isLoggedIn) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Modular.to.pushReplacementNamed('/home/');
                });
                return Container();
              }
              return Scaffold(
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: widget.controller.isBlockedNotifier,
                    builder: (context, button, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              FinanceText.h3(
                                'Olá,',
                                fontWeight: FontWeight.bold,
                              ),
                              FinanceText.h3(
                                ' faça seu login!',
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          FinanceTextField(
                            label: 'Email',
                            controller: widget.controller.email,
                            autocorrect: true,
                            onChanged: (p0) {
                              widget.controller.updateIsBlocked();
                            },
                            validator: (email) {
                              if (email!.isEmpty) {
                                return 'Campo de email não pode estar vazio';
                              } else if (!isEmailValid(email)) {
                                return 'Email inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          FinanceTextField(
                            label: 'Senha',
                            controller: widget.controller.password,
                            onChanged: (p0) {
                              widget.controller.updateIsBlocked();
                            },
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FinanceText.p14('Esqueci minha senha'),
                          ),
                          const SizedBox(height: 40),
                          FinanceButton(
                            title: 'Entrar',
                            disabled: button,
                            onTap: () {
                              widget.controller.login(
                                email: widget.controller.email.text,
                                password: widget.controller.password.text,
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8E8E8),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: FinanceText.p16(
                                  'Ou acesse com',
                                ),
                              ),
                              Container(
                                height: 1,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8E8E8),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          FinanceButton(
                            onTap: () {
                              widget.controller.loginWithGoogle(context);
                            },
                            google: true,
                            color: Colors.transparent,
                          ),
                          const SizedBox(height: 38),
                          GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/createAccount');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FinanceText.p16(
                                  'Não possui uma conta?',
                                ),
                                FinanceText.p16(
                                  ' Criar grátis',
                                  color: AppColors.deepBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
