import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';
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

  ValueNotifier<List<CardModel>> cardList = ValueNotifier<List<CardModel>>([]);
  ValueNotifier<double> limit = ValueNotifier<double>(0);
  ValueNotifier<double> availableLimit = ValueNotifier<double>(0);
  ValueNotifier<String> cardName = ValueNotifier<String>('');
  ValueNotifier<String> flag = ValueNotifier<String>('');
  ValueNotifier<DateTime> close = ValueNotifier<DateTime>(DateTime.now());

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

    final accountId =
        await _accountCardsUseCase.addBank(houseId!, accountModel);

    accountModel.id = accountId;
  }

  Future<void> deleteBank(String accountId) async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    await _accountCardsUseCase.deleteBank(houseId!, accountId);

    await getAccountBanks();
  }

  Future<void> getAccountBanks() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    final banks = await _accountCardsUseCase.getAccountBanks(houseId!);

    accountList.value = banks;
  }

  Future<void> addCard() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    CardModel cardModel = CardModel(
      limit: limit.value,
      cardName: cardName.value,
      flag: flag.value,
      close: close.value,
      availableLimit: 0,
    );

    final cardId = await _accountCardsUseCase.addCard(houseId!, cardModel);

    cardModel.id = cardId;
  }

  Future<void> getCards() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    final cards = await _accountCardsUseCase.getCards(houseId!);

    cardList.value = cards;
  }
}
