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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      FinanceText.h3(
                        'Olá,',
                        fontWeight: FontWeight.bold,
                      ),
                      FinanceText.h3(
                        ' faça seu cadastro!',
                        fontWeight: FontWeight.normal,
                      ),
                    ],
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
                    autocorrect: true,
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
                    autocorrect: true,
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
                    autocorrect: true,
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
                        Modular.to.pushReplacementNamed('/home/');
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: FinanceText.p16(
                          'Ou faça seu cadastro com',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  FinanceButton(
                    onTap: () {
                      widget.controller.createAccountWithGoogleAndJoinHouse(
                          context: context);
                    },
                    google: true,
                    color: Colors.transparent,
                  ),
                  const SizedBox(height: 32),
                  FinanceText.p16(
                    'Ao se cadastrar você está\nautomaticamente aceitando nossos',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  FinanceText.p16(
                    'termos de uso',
                    color: AppColors.deepBlue,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
