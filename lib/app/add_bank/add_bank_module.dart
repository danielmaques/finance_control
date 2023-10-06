import 'package:finance_control/app/add_bank/datasource/data/add_bank_data.dart';
import 'package:finance_control/app/add_bank/datasource/data/add_bank_data_impl.dart';
import 'package:finance_control/app/add_bank/datasource/repository/add_bank_repository.dart';
import 'package:finance_control/app/add_bank/domain/usecase/add_bank_usecase.dart';
import 'package:finance_control/app/add_bank/ui/controller/add_bank_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/repository/add_bank_repository_impl.dart';
import 'domain/usecase/add_bank_usecase_impl.dart';
import 'ui/page/add_bank_page.dart';

class AddBankModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AddBankData>(AddBankDataImpl.new);
    i.addSingleton<AddBankRepository>(AddBankRepositoryImpl.new);
    i.addSingleton<AddBankUseCase>(AddBankUseCaseImpl.new);
    i.addSingleton(AddBankController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => AddBankPage(
        controller: Modular.get<AddBankController>(),
        isCriate: r.args.data?['isCriate'] ?? false,
      ),
    );
  }
}
