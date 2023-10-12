import 'package:finance_control/app/home/datasource/data/get_balance_data.dart';
import 'package:finance_control/app/home/domain/usecase/get_balance_usecase.dart';
import 'package:finance_control/app/home/ui/controller/balance_bloc.dart';
import 'package:finance_control/app/transactions/datasource/data/get_transaction_data.dart';
import 'package:finance_control/app/transactions/domain/usecase/get_transaction_usecase.dart';
import 'package:finance_control/app/transactions/ui/bloc/transactions_bloc.dart';
import 'package:finance_control/app/transactions/ui/page/transactions_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TransactionsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<IGetTransactionsData>(GetTransactionsData.new);
    i.addSingleton<IGetTransactionsUseCase>(GetTransactionsUseCase.new);
    i.addSingleton<ITransactionsBloc>(TransactionsBloc.new);

    // Balance
    i.addLazySingleton<IGetBalanceData>(GetBalanceData.new);
    i.addLazySingleton<IGetBalanceUseCase>(GetBalanceUseCase.new);
    i.addLazySingleton<IBalanceBloc>(BalanceBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const TransactionsPage(),
    );
  }
}
