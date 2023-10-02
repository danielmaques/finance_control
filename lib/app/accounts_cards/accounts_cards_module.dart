import 'package:finance_control/app/accounts_cards/datasource/data/accounts_cards_data.dart';
import 'package:finance_control/app/accounts_cards/datasource/data/accounts_cards_data_impl.dart';
import 'package:finance_control/app/accounts_cards/datasource/repository/accounts_cards_repository.dart';
import 'package:finance_control/app/accounts_cards/domain/usecase/accounts_cards_usecase.dart';
import 'package:finance_control/app/accounts_cards/domain/usecase/accounts_cards_usecase_impl.dart';
import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
import 'package:finance_control/app/accounts_cards/ui/page/accounts_cards_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/repository/accounts_cards_repository_impl.dart';

class AccountsCardsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AccountCardsData>(AccountCardsDataImpl.new);
    i.addSingleton<AccountCardsRepository>(AccountCardsRepositoryImpl.new);
    i.addSingleton<AccountCardsUseCase>(AccountCardsUseCaseImpl.new);
    i.addSingleton(AccountCardsController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => AccountCardsPage(
        controller: Modular.get<AccountCardsController>(),
      ),
    );
  }
}
