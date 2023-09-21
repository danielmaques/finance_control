import 'package:finance_control/app/login/ui/controller/login_controller.dart';
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: widget.controller.isBlockedNotifier,
                    builder: (context, button, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FinanceAppBar(
                            icon: false,
                          ),
                          ValueListenableBuilder(
                            valueListenable: widget.controller.reset,
                            builder: (context, value, child) => Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FinanceText.h3(
                                    'Entrar',
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
                                  Visibility(
                                    visible: value,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24),
                                        FinanceTextField(
                                          label: 'Senha',
                                          hintText: 'Digite sua senha',
                                          controller:
                                              widget.controller.password,
                                          onChanged: (p0) {
                                            widget.controller.updateIsBlocked();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: !value,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24),
                                        FinanceButton(
                                          title: 'Recuperar senha',
                                          disabled: false,
                                          onTap: () {
                                            widget.controller.resetPassword(
                                              email:
                                                  widget.controller.email.text,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: value,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24),
                                        FinanceButton(
                                          title: 'Entrar',
                                          disabled: button,
                                          onTap: () {
                                            widget.controller.login(
                                              email:
                                                  widget.controller.email.text,
                                              password: widget
                                                  .controller.password.text,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      widget.controller.reset.value = !value;
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FinanceText.p16(
                                          value == false
                                              ? 'Lembrei da senha'
                                              : 'Esqueceu a senha?',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed('/createAccount');
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FinanceText.p16(
                                      'Não possui uma conta?',
                                    ),
                                    const SizedBox(width: 5),
                                    FinanceText.p16(
                                      'Criar conta.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
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
