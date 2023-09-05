import 'package:finance_control/app/login/ui/page/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';


class LoginModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginPage());
  }
}