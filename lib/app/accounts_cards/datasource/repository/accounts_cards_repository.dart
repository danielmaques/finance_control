import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';

abstract class AccountCardsRepository {
  Future<List<dynamic>> getUsersInHouse(String houseId);
  Future<void> addBank(String houseId, AccountModel account);
  Future<List<AccountModel>> getAccountBanks(String houseId);
}
