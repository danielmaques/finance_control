import 'package:finance_control/app/onboarding/ui/controller/create_account_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CreateAccountController controller;

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: widget.controller.isBlockedNotifier,
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
                    controller: widget.controller.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (p0) {
                      widget.controller.name.text = p0;
                      widget.controller.updateIsBlocked();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome e sobrenome';
                      }

                      final regex = RegExp(r'^\w+\s+\w+$');

                      if (!regex.hasMatch(value)) {
                        return 'Por favor, insira um nome e sobrenome válidos';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Email',
                    hintText: 'Digite seu email',
                    controller: widget.controller.email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (p0) {
                      widget.controller.updateIsBlocked();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um endereço de e-mail';
                      }

                      final emailRegex =
                          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                      if (!emailRegex.hasMatch(value)) {
                        return 'Por favor, insira um e-mail válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FinanceTextField(
                    label: 'Senha',
                    hintText: 'Digite sua senha',
                    controller: widget.controller.password,
                    onChanged: (p0) {
                      widget.controller.updateIsBlocked();
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
                    controller: widget.controller.confirmPassword,
                    onChanged: (p0) {
                      widget.controller.updateIsBlocked();
                    },
                    validator: (p0) {
                      if (widget.controller.confirmPassword.text !=
                              widget.controller.password.text ||
                          p0 != null) {
                        return 'Senhas diferentes';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ValueListenableBuilder(
                    valueListenable: widget.controller.invitation,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          FinanceCheckBox(
                            label: 'Tenho convite de conta compartilhada!',
                            isChecked: value,
                            onChanged: (newValue) {
                              widget.controller.invitation.value = newValue;
                            },
                          ),
                          Visibility(
                            visible: value,
                            child: Column(
                              children: [
                                const SizedBox(height: 24),
                                FinanceTextField(
                                  label: 'Codigo de convite',
                                  hintText:
                                      'fbe2t948-83e4-4098-a185-e811ce254505',
                                  controller: widget.controller.houseId,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: widget.controller.terms,
                    builder: (context, value, child) {
                      return FinanceCheckBox(
                        label:
                            'Ao criar uma conta, você concorda com nossos Termos e Condições.',
                        isChecked: value,
                        onChanged: (newValue) {
                          widget.controller.terms.value = newValue;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  FinanceButton(
                    title: 'Criar conta',
                    disabled: isBlocked,
                    onTap: () async {
                      widget.controller.signUp(
                        email: widget.controller.email.text,
                        password: widget.controller.password.text,
                      );

                      if (widget.controller.isCriate.value == true) {
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
      bottomNavigationBar: GestureDetector(
        onTap: () => Modular.to.pop(),
        child: Container(
          color: Colors.transparent,
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
      ),
    );
  }
}
