import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/accounts_cards_controller.dart';

class ShowAddAccount extends StatefulWidget {
  const ShowAddAccount({
    super.key,
    required this.controller,
  });

  final AccountCardsController controller;

  @override
  State<ShowAddAccount> createState() => _ShowAddAccountState();
}

class _ShowAddAccountState extends State<ShowAddAccount> {
  final ValueNotifier<List<dynamic>> categoriesList =
      ValueNotifier<List<dynamic>>([
    "Conta corrente",
    "Conta poupança",
    "Conta empresarial",
  ]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FinanceText.h4(
            'Nova conta',
            fontWeight: FontWeight.w500,
          ),
          IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(
              Icons.close_rounded,
              size: 20,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          FinanceTextField(
            hintText: 'Instituição financeira',
            textCapitalization: TextCapitalization.sentences,
            onChanged: (p0) {
              widget.controller.bank.value = p0;
            },
            validator: (p0) {
              if (widget.controller.bank.value.isEmpty) {
                return 'Insira uma instituição financeira';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          FinanceDropDown(
            hint: "Tipo de conta",
            categoriesList: categoriesList,
            onItemSelected: (p0) {
              widget.controller.account.value = p0;
            },
          ),
          const SizedBox(height: 24),
          FinanceDropDown(
            hint: "Selecione o proprietário",
            categoriesList: widget.controller.users,
            onItemSelected: (p0) {
              widget.controller.userSelect.value = p0;
            },
          ),
          const SizedBox(height: 24),
          FinanceButton(
            title: 'Salvar',
            onTap: () {
              setState(() {
                widget.controller.getAccountBanks();
              });
              if (widget.controller.bank.value.isNotEmpty) {
                widget.controller.addBank();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.forestGreen,
                    content: Text('Conta adicionada'),
                  ),
                );
                Modular.to.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
