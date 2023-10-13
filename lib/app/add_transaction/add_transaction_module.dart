import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_data.dart';
import 'package:finance_control/app/add_transaction/data/datasource/get_account_bank_data.dart';
import 'package:finance_control/app/add_transaction/data/datasource/get_card_data.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_usecase.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/get_account_bank_usecase.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/get_card_usecase.dart';
import 'package:finance_control/app/add_transaction/ui/controller/account_bank_bloc.dart';
import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_bloc.dart';
import 'package:finance_control/app/add_transaction/ui/controller/card_bloc.dart';
import 'package:finance_control/app/add_transaction/ui/page/add_transaction_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTransactionModule extends Module {
  @override
  void binds(i) {
    // AddTransaction
    i.addSingleton<IAddTransactionData>(AddTransactionData.new);
    i.addSingleton<IAddTransactionUseCase>(AddTransactionUseCase.new);
    i.addSingleton<IAddTransactionBloc>(AddTransactionBloc.new);

    // GetAccountBank
    i.addSingleton<IGetAccountBankData>(GetAccountBankData.new);
    i.addSingleton<IGetAccountBankUseCase>(GetAccountBankUseCase.new);
    i.addSingleton<IAccountBankBloc>(AccountBankBloc.new);

    // GetCard
    i.addSingleton<IGetCardData>(GetCardData.new);
    i.addSingleton<IGetCardUseCase>(GetCardUseCase.new);
    i.addSingleton<ICardBloc>(CardBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => AddTransactionPage(
        add: r.args.data['add'],
      ),
    );
  }
}
