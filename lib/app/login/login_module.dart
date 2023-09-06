import 'package:finance_control/app/login/datasource/data/login_data.dart';
import 'package:finance_control/app/login/datasource/data/login_data_impl.dart';
import 'package:finance_control/app/login/datasource/repository/login_repository_impl.dart';
import 'package:finance_control/app/login/domain/usecase/login_usecase.dart';
import 'package:finance_control/app/login/domain/usecase/login_usecaseimpl.dart';
import 'package:finance_control/app/login/ui/controller/login_controller.dart';
import 'package:finance_control/app/login/ui/page/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/repository/login_repository.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<LoginData>(LoginDataImpl.new);
    i.addSingleton<LoginRepository>(LoginRepositoryImpl.new);
    i.addSingleton<LoginUseCase>(LoginUseCaseImpl.new);
    i.addSingleton(LoginController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => LoginPage(
              controller: Modular.get<LoginController>(),
            ));
  }
}
