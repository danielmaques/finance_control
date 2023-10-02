import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AccountCardsPage extends StatefulWidget {
  const AccountCardsPage({super.key});

  @override
  _AccountCardsPageState createState() => _AccountCardsPageState();
}

class _AccountCardsPageState extends State<AccountCardsPage> {
  int selectedTabIndex = 0; // Inicialmente, o primeiro item está selecionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      appBar: FinanceAppBar(
        title: 'Contas e Cartões',
        icon: true,
        onTap: () => Modular.to.pop(),
        color: AppColors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FinanceToolBarItem(
                    title: 'Bancos',
                    label: 'Contas Bancárias',
                    icon: Icons.account_balance_outlined,
                    select: selectedTabIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  FinanceToolBarItem(
                    title: 'Cartões',
                    label: 'Cartões de Crédito',
                    icon: Icons.credit_card,
                    select: selectedTabIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
