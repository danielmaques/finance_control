import 'package:finance_control/app/accounts_cards/accounts_cards_module.dart';
import 'package:finance_control/app/add_transaction/add_transaction_module.dart';
import 'package:finance_control/app/botton_navigation/botton_navigation.dart';
import 'package:finance_control/app/transactions/transactions_module.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/add_bank/add_bank_module.dart';
import 'app/home/home_modular.dart';
import 'app/onboarding/onboarding_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // MobileAds.instance.initialize();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));

  final bool hasHouseId = await checkIfYouHaveHouseId();

  if (hasHouseId) {
    Modular.setInitialRoute('/bottomNavigation/homeBottom');
  } else {
    Modular.setInitialRoute('/');
  }

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: OnboardingModule());
    r.child('/bottomNavigation',
        child: (context) => const BottomNavigation(),
        children: [
          ModuleRoute('/homeBottom', module: HomeModule()),
          ModuleRoute('/transactionsBottom', module: TransactionsModule()),
          ModuleRoute('/accountsCardsBottom', module: AccountsCardsModule()),
        ]);
    r.module('/home', module: HomeModule());
    r.module('/addTransaction', module: AddTransactionModule());
    r.module('/transactions', module: TransactionsModule());
    r.module('/accountsCards', module: AccountsCardsModule());
    r.module('/addBank', module: AddBankModule());
  }
}

Future<bool> checkIfYouHaveHouseId() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('user_id');
  return userId != null && userId.isNotEmpty;
}
