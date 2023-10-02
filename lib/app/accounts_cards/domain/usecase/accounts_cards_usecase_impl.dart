import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';

import '../../datasource/repository/accounts_cards_repository.dart';
import 'accounts_cards_usecase.dart';

class AccountCardsUseCaseImpl implements AccountCardsUseCase {
  final AccountCardsRepository _accountCardsRepository;

  AccountCardsUseCaseImpl(this._accountCardsRepository);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await _accountCardsRepository.getUsersInHouse(houseId);
  }

  @override
  Future<void> addBank(String houseId, AccountModel account) {
    return _accountCardsRepository.addBank(houseId, account);
  }
  
  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) {
    return _accountCardsRepository.getAccountBanks(houseId);
  }
}
