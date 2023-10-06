import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/add_bank/domain/usecase/add_bank_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBankController {
  final AddBankUseCase _addBankUseCase;

  AddBankController(this._addBankUseCase);

  ValueNotifier<List<dynamic>> users = ValueNotifier<List<dynamic>>([]);
  ValueNotifier<String> userSelect = ValueNotifier<String>('');
  ValueNotifier<String> bank = ValueNotifier<String>('');
  ValueNotifier<String> account = ValueNotifier<String>('');
  ValueNotifier<double> balanceAccount = ValueNotifier<double>(0);

  Future<void> getUsersInHouse() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final userList = await _addBankUseCase.getUsersInHouse(houseId);
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

    final accountId = await _addBankUseCase.addBank(houseId!, accountModel);

    accountModel.id = accountId;
  }
}
