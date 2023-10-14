import 'package:finance_control/app/home/datasource/model/balance_model.dart';
import 'package:finance_control/app/home/ui/controller/balance_bloc.dart';
import 'package:finance_control/app/transactions/datasource/model/transaction_model.dart';
import 'package:finance_control/app/transactions/ui/bloc/transactions_bloc.dart';
import 'package:finance_control/app/transactions/ui/shimmer/transaction_page_shimmer.dart';
import 'package:finance_control/core/core.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({
    super.key,
  });

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late ITransactionsBloc bloc;
  late IBalanceBloc balanceBloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get();
    balanceBloc = Modular.get();
    bloc.getTransactions();
    balanceBloc.getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinanceAppBar(
        title: 'Transactions',
        icon: true,
        color: const Color(0xFFEEF2F8),
        onTap: () => Modular.to.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FinanceText.l12('Saldo', color: AppColors.slateGray),
              BlocBuilder(
                bloc: balanceBloc,
                builder: (context, state) {
                  if (state is SuccessState<BalanceModel>) {
                    var balance = state.data;
                    return FinanceText.h3(
                      formatMoney(balance.balance ?? 0.0),
                    );
                  } else {
                    return FinanceText.h3(
                      formatMoney(0.0),
                    );
                  }
                },
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
                    BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is SuccessState<List<TransactionModel>>) {
                          var transactions = state.data;
                          return FinanceTransactionList(
                            transactionsByMonth: transactions,
                          );
                        } else {
                          return const FinanceTransactionListShimmer(
                              isLoading: true);
                        }
                      },
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
