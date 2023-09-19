// ignore_for_file: use_build_context_synchronously

import 'package:clipboard/clipboard.dart';
import 'package:finance_control/app/home/ui/controller/home_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:fl_chart/fl_chart.dart';
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
    widget.controller.getCategoryPercentages();
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
                        sections: [
                          PieChartSectionData(
                            color: Colors.red,
                            value: widget.controller.categoryPercentages
                                .value['Alimentação'],
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.amber,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.grey,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.pink,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.purple,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.tealAccent,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.amber,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                          PieChartSectionData(
                            color: Colors.black,
                            value: 10,
                            radius: 20,
                            title: '',
                          ),
                        ]),
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
