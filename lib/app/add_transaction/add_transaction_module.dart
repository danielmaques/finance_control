import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_controller.dart';
import 'package:finance_control/app/add_transaction/ui/page/add_transaction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTransactionModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(AddTransactionController.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => AddTransactionPage(
        controller: Modular.get<AddTransactionController>(),
      ),
    );
  }
}
