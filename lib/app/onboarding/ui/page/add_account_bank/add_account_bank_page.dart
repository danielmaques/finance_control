import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddAccountBankPage extends StatelessWidget {
  const AddAccountBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinanceAppBar(
        title: 'Adicionar Conta',
        icon: true,
        onTap: () {
          Modular.to.pop();
        },
        color: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            SizedBox(
              height: 155,
              width: double.infinity,
              child: FinanceAccountCardItem(
                selectedTabIndex: 0,
                gasto: 0,
                saldo: 0,
                name: 'name',
                accountType: 'accountType',
                delete: () {},
              ),
            ),
            const FinanceSelectBank(),
          ],
        ),
      ),
    );
  }
}
