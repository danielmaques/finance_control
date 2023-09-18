import 'package:finance_control/app/transactions/ui/controller/transactions_controller.dart';
import 'package:finance_control/app/transactions/ui/shimmer/transaction_page_shimmer.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({
    super.key,
    required this.controller,
  });

  final TransactionsController controller;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.getTransactions();
    widget.controller.getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinanceAppBar(
        title: 'Transactions',
        icon: true,
        onTap: () => Modular.to.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FinanceText.p14('Saldo', color: AppColors.slateGray),
              ValueListenableBuilder(
                valueListenable: widget.controller.balance,
                builder: (context, value, child) => FinanceText.h3(
                  formatMoney(value),
                ),
              ),
              const SizedBox(height: 26),
              const Divider(
                height: 1,
                color: Colors.black45,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: widget.controller.isLoading,
                      builder: (context, value, child) => value == true
                          ? const FinanceTransactionListShimmer(isLoading: true)
                          : ValueListenableBuilder(
                              valueListenable:
                                  widget.controller.transactionsByMonth,
                              builder: (context, value, child) =>
                                  FinanceTransactionList(
                                transactionsByMonth: value,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}