import 'package:finance_control/app/accounts_cards/accounts_cards_module.dart';
import 'package:finance_control/app/add_transaction/add_transaction_module.dart';
import 'package:finance_control/app/transactions/transactions_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/home/home_modular.dart';
import 'app/onboarding/onboarding_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFEEF2F8),
      ),
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
    r.module('/home', module: HomeModule());
    r.module('/addTransaction', module: AddTransactionModule());
    r.module('/transactions', module: TransactionsModule());
    r.module('/accountsCards', module: AccountsCardsModule());
  }
}
