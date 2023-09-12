import 'package:finance_control/app/add_transaction/ui/page/add_transaction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTransactionModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const AddTransactionPage(),
    );
  }
}
