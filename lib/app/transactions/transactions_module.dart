import 'package:finance_control/app/transactions/datasource/data/transactions_data_impl.dart';
import 'package:finance_control/app/transactions/domain/usecase/transactions_usecase.dart';
import 'package:finance_control/app/transactions/ui/page/transactions_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/data/transactions_data.dart';
import 'datasource/repository/transactions_repository.dart';
import 'datasource/repository/transactions_repository_impl.dart';
import 'domain/usecase/transactions_usecase_impl.dart';
import 'ui/controller/transactions_controller.dart';

class TransactionsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<TransactionsData>(TransactionsDataImpl.new);
    i.addSingleton<TransactionsRepository>(TransactionsRepositoryImpl.new);
    i.addSingleton<TransactionsUseCase>(TransactionsUseCaseImpl.new);
    i.addSingleton(TransactionsController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => TransactionsPage(
        controller: Modular.get<TransactionsController>(),
      ),
    );
  }
}
