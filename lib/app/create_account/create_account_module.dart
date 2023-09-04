import 'package:flutter_modular/flutter_modular.dart';

import 'ui/page/create_account_page.dart';

class CreateAccountModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const CreateAccountPage());
  }
}
