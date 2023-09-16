import 'package:finance_control/app/home/ui/controller/home_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      appBar: FinanceHomeTopBar(
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
        menuRoute: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                children: [
                  FinanceCredtCardTile(
                    onTap: () {},
                    card: 'card',
                    cardName: 'cardName',
                  ),
                  const SizedBox(height: 22),
                  ValueListenableBuilder(
                    valueListenable: widget.controller.gastos,
                    builder: (context, value, child) => FinanceSpendingTile(
                      spending: value,
                      onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
