import 'package:finance_control/app/accounts_cards/ui/page/accounts_cards_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AccountsCardsModule extends Module {
  @override
  void binds(i) {
    // Add your dependencies here
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const AccountCardsPage());
  }
}
