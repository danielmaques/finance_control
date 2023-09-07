import 'package:finance_control/app/home/datasource/data/home_data.dart';
import 'package:finance_control/app/home/datasource/data/home_data_impl.dart';
import 'package:finance_control/app/home/datasource/repository/home_repository.dart';
import 'package:finance_control/app/home/datasource/repository/home_repository_impl.dart';
import 'package:finance_control/app/home/domain/usecase/home_usecase.dart';
import 'package:finance_control/app/home/domain/usecase/home_usecase_impl.dart';
import 'package:finance_control/app/home/ui/controller/home_controller.dart';
import 'package:finance_control/app/home/ui/page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<HomeData>(HomeDataImpl.new);
    i.addSingleton<HomeUseCase>(HomeUseCaseImpl.new);
    i.addSingleton<HomeRepository>(HomeRepositoryImpl.new);
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) =>
            HomePage(controller: Modular.get<HomeController>()));
  }
}
