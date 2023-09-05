import 'package:finance_control/app/create_account/datasource/data/create_account_data.dart';
import 'package:finance_control/app/create_account/datasource/data/create_account_data_impl.dart';
import 'package:finance_control/app/create_account/datasource/repository/create_account_repository.dart';
import 'package:finance_control/app/create_account/domain/usecase/create_account_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/repository/create_account_repository_impl.dart';
import 'domain/usecase/create_account_usecase_impl.dart';
import 'ui/controller/create_account_controller.dart';
import 'ui/page/create_account_page.dart';

class CreateAccountModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<CreateAccountData>(CreateAccountDataImpl.new);
    i.addSingleton<CreateAccountRepository>(CreateAccountRepositoryImpl.new);
    i.addSingleton<CreateAccountUseCase>(CreateAccountUseCaseImpl.new);
    i.addSingleton<CreateAccountController>(CreateAccountControllerImpl.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) =>
          CreateAccountPage(controller: Modular.get<CreateAccountController>()),
    );
  }
}
