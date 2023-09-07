import 'package:finance_control/app/home/ui/controller/home_controller.dart';
import 'package:finance_control/core/ds/components/transaction_list/finance_transaction_list.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

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
    widget.controller
        .addTransaction(DateTime.now(), 1, 'nome', 'categoria', 'add');
    widget.controller.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FinanceText.p16(
                  'Saldo',
                  fontWeight: FontWeight.w400,
                  color: AppColors.midnightBlack,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.navyBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: widget.controller.balance,
              builder: (context, value, child) => FinanceText.h2(
                'R\$ $value',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      FinanceText.p18(
                        'text',
                        fontWeight: FontWeight.w600,
                        color: AppColors.cherryRed,
                      ),
                      FinanceText.p16('Gastos')
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: AppColors.slateGray,
                  ),
                  const Column(
                    children: [
                      FinanceText.p18(
                        'text',
                        fontWeight: FontWeight.w600,
                        color: AppColors.forestGreen,
                      ),
                      FinanceText.p16('Ganhos')
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FinanceText.h4(
                  'Transações',
                  fontWeight: FontWeight.w500,
                  color: AppColors.midnightBlack,
                ),
                FinanceText.p16('Mais'),
              ],
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: widget.controller.transaction,
              builder: (context, value, child) => FinanceTransactionList(
                transaction: value,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isOpen,
            child: FloatingActionButton(
              mini: true,
              tooltip: 'Histórico',
              onPressed: () {
                print('Opção 1 clicada');
              },
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
