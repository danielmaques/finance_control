import 'package:finance_control/app/home/datasource/data/get_balance_data.dart';
import 'package:finance_control/app/home/datasource/data/get_transactions_data.dart';
import 'package:finance_control/app/home/datasource/data/home_data.dart';
import 'package:finance_control/app/home/datasource/data/home_data_impl.dart';
import 'package:finance_control/app/home/domain/usecase/get_balance_usecase.dart';
import 'package:finance_control/app/home/ui/page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecase/get_transactions_usecase.dart';
import 'ui/controller/balance_bloc.dart';
import 'ui/controller/transactions_bloc.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<HomeData>(HomeDataImpl.new);

    // GetBalance
    i.addSingleton<IGetBalanceData>(GetBalanceData.new);
    i.addSingleton<IGetBalanceUseCase>(GetBalanceUseCase.new);
    i.addSingleton<IBalanceBloc>(BalanceBloc.new);

    // GetTransactions
    i.addSingleton<IGetTransactionsData>(GetTransactionsData.new);
    i.addSingleton<IGetTransactionsUseCase>(GetTransactionsUseCase.new);
    i.addSingleton<ITransactionsBloc>(TransactionsBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
