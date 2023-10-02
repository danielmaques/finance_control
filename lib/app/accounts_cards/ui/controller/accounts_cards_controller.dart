import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/accounts_cards_usecase.dart';

class AccountCardsController {
  final AccountCardsUseCase _accountCardsUseCase;

  AccountCardsController(this._accountCardsUseCase);

  ValueNotifier<List<dynamic>> users = ValueNotifier<List<dynamic>>([]);
  ValueNotifier<String> usersString = ValueNotifier<String>('');

  Future<void> getUsersInHouse() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final userList = await _accountCardsUseCase.getUsersInHouse(houseId);
      users.value = userList;
    }
  }
}
