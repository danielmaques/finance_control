import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_datasource.dart';
import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_datasource_impl.dart';
import 'package:finance_control/app/add_transaction/data/repository/add_transaction_repository.dart';
import 'package:finance_control/app/add_transaction/data/repository/add_transaction_repository_impl.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_usecase.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_usecase_impl.dart';
import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_controller.dart';
import 'package:finance_control/app/add_transaction/ui/page/add_transaction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTransactionModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AddTransactionData>(AddTransactionDataImpl.new);
    i.addSingleton<AddTransactionRepository>(AddTransactionRepositoryImpl.new);
    i.addSingleton<AddTransactionUseCase>(AddTransactionUseCaseImpl.new);
    i.addSingleton(AddTransactionController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => AddTransactionPage(
        controller: Modular.get<AddTransactionController>(),
        add: r.args.data?['add'],
      ),
    );
  }
}
