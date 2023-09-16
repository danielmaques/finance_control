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
      body: Column(
        children: [
          FinanceHomeTopBar(
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                children: [
                  FinanceSpendingTile(spending: 5400, onTap: () {}),
                  FinanceSpendingTile(spending: 5400, onTap: () {}),
                  FinanceSpendingTile(spending: 5400, onTap: () {}),
                  FinanceSpendingTile(spending: 5400, onTap: () {}),
                  const SizedBox(height: 22),
                  FinanceCredtCardTile(
                    onTap: () {},
                    card: 'card',
                    cardName: 'cardName',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isOpen,
            child: FloatingActionButton(
              mini: true,
              tooltip: 'Histórico',
              onPressed: () {},
              backgroundColor: AppColors.navyBlue,
              child: const Icon(Icons.poll_outlined),
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: isOpen,
            child: FloatingActionButton(
              mini: true,
              tooltip: 'Gasto',
              onPressed: () {
                Modular.to.pushNamed('/transactions/');
                print('Opção 2 clicada');
              },
              backgroundColor: AppColors.navyBlue,
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: isOpen,
            child: FloatingActionButton(
              mini: true,
              tooltip: 'Adicionar',
              onPressed: () {
                widget.controller.addTransaction(
                    DateTime.now(), 1000, 'nome', 'categoria', true);
                print('Opção 2 clicada');
              },
              backgroundColor: AppColors.navyBlue,
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            backgroundColor: AppColors.navyBlue,
            child: Icon(isOpen ? Icons.close : Icons.menu),
          ),
        ],
      ),
    );
  }
}
