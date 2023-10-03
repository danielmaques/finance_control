import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';

abstract class AccountCardsData {
  Future<List<dynamic>> getUsersInHouse(String houseId);
  Future<String> addBank(String houseId, AccountModel account);
  Future<List<AccountModel>> getAccountBanks(String houseId);
  Future<void> deleteBank(String houseId, String accountId);
}
