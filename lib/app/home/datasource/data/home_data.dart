import 'dart:io';

import 'package:finance_control/core/result_wrapper/result_wrapper.dart';

import '../../../accounts_cards/datasource/model/account_model.dart';
import '../model/balance_model.dart';

abstract class HomeData {
  Future<void> updateBalance(String uid, double valor, bool add);
  Future<String> upload(File imageFile, String uid);
  Future<Result<double>> getBalance(String uid, BalanceModel balance);
  Future<Map<String, double>> getTotalSpentByCategory(String uid);
  Future<List<AccountModel>> getAccountBanks(String houseId);
}
