import 'package:clipboard/clipboard.dart';
import 'package:finance_control/app/home/ui/controller/home_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    widget.controller.getTransactions();
    widget.controller.getBalance();
    widget.controller.getGastosEGanhos();
    widget.controller.startBalanceRefreshTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      body: CustomScrollView(
        slivers: [
          FinanceHomeTopBarSliver(
            money: widget.controller.balance,
            addRoute: () {
              Modular.to.pushNamed('/addTransaction/', arguments: {
                'add': true,
              });
            },
            removeRoute: () {
              Modular.to.pushNamed('/addTransaction/', arguments: {
                'add': false,
              });
            },
            transactionRoute: () {
              Modular.to.pushNamed('/transactions/');
            },
            menuRoute: () async {
              final prefs = await SharedPreferences.getInstance();
              final userId = prefs.getString('house_id');
              if (userId != null) {
                await FlutterClipboard.copy(userId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.forestGreen,
                    content: Text('Convite copiado!'),
                  ),
                );
              }
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // FinanceCredtCardTile(
                  //   onTap: () {},
                  //   card: 'card',
                  //   cardName: 'cardName',
                  // ),
                  const SizedBox(height: 22),
                  ValueListenableBuilder<Map<String, double>>(
                    valueListenable: widget.controller.categoryPercentages,
                    builder: (context, value, child) => FinanceSpendingTile(
                      spending: widget.controller.gastos.value,
                      onTap: () {},
                      categoryPercentages: value,
                    ),
                  ),
                  const SizedBox(height: 22),
                  ValueListenableBuilder(
                    valueListenable: widget.controller.transaction,
                    builder: (context, value, child) => FinanceListTile(
                      transactions: value,
                      onTap: () {
                        Modular.to.pushNamed('/transactions/');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
