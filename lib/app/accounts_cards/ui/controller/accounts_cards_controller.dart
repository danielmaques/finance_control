import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../datasource/model/account_model.dart';
import '../../domain/usecase/accounts_cards_usecase.dart';

class AccountCardsController {
  final AccountCardsUseCase _accountCardsUseCase;

  AccountCardsController(this._accountCardsUseCase);

  ValueNotifier<List<dynamic>> users = ValueNotifier<List<dynamic>>([]);
  ValueNotifier<String> userSelect = ValueNotifier<String>('');
  ValueNotifier<String> bank = ValueNotifier<String>('');
  ValueNotifier<String> account = ValueNotifier<String>('');
  ValueNotifier<double> balanceAccount = ValueNotifier<double>(0);
  ValueNotifier<List<AccountModel>> accountList =
      ValueNotifier<List<AccountModel>>([]);

  Future<void> getUsersInHouse() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final userList = await _accountCardsUseCase.getUsersInHouse(houseId);
      users.value = userList;
    }
  }

  Future<void> addBank() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    AccountModel accountModel = AccountModel(
      bank: bank.value,
      accountType: account.value,
      use: userSelect.value,
      balance: balanceAccount.value,
    );

    await _accountCardsUseCase.addBank(houseId!, accountModel);
  }

  Future<void> getAccountBanks() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    final banks = await _accountCardsUseCase.getAccountBanks(houseId!);

    accountList.value = banks;
  }
}
