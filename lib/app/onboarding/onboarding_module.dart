import 'package:finance_control/app/onboarding/datasource/data/create_account_data_impl.dart';
import 'package:finance_control/app/onboarding/datasource/data/login_data.dart';
import 'package:finance_control/app/onboarding/datasource/repository/create_account_repository.dart';
import 'package:finance_control/app/onboarding/datasource/repository/create_account_repository_impl.dart';
import 'package:finance_control/app/onboarding/datasource/repository/login_repository.dart';
import 'package:finance_control/app/onboarding/domain/usecase/create_account_usecase.dart';
import 'package:finance_control/app/onboarding/domain/usecase/create_account_usecase_impl.dart';
import 'package:finance_control/app/onboarding/domain/usecase/login_usecase.dart';
import 'package:finance_control/app/onboarding/ui/controller/create_account_controller.dart';
import 'package:finance_control/app/onboarding/ui/controller/login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/data/create_account_data.dart';
import 'datasource/data/login_data_impl.dart';
import 'datasource/repository/login_repository_impl.dart';
import 'domain/usecase/login_usecase_impl.dart';
import 'ui/page/create_account_page.dart';
import 'ui/page/login_page.dart';

class OnboardingModule extends Module {
  @override
  void binds(i) {
    // Login
    i.addLazySingleton<LoginData>(LoginDataImpl.new);
    i.addLazySingleton<LoginRepository>(LoginRepositoryImpl.new);
    i.addLazySingleton<LoginUseCase>(LoginUseCaseImpl.new);
    i.addLazySingleton(LoginController.new);

    // CreateAccount
    i.addSingleton<CreateAccountData>(CreateAccountDataImpl.new);
    i.addSingleton<CreateAccountRepository>(CreateAccountRepositoryImpl.new);
    i.addSingleton<CreateAccountUseCase>(CreateAccountUseCaseImpl.new);
    i.addSingleton<CreateAccountController>(CreateAccountController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) =>
            LoginPage(controller: Modular.get<LoginController>()));
    r.child('/createAccount',
        child: (context) => CreateAccountPage(
            controller: Modular.get<CreateAccountController>()));
  }
}
