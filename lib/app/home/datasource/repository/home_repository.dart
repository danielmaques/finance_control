import 'dart:io';

import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';

abstract class HomeRepository {
  Future<void> updateBalance(String uid, double valor, bool add);
  Future<List<Map<String, dynamic>>> getTransaction(String uid);
  Future<String> upload(File imageFile, String uid);
  Future<double> getBalance(String uid);
  Future<Map<String, double>> getGastos(String uid);
  Future<Map<String, double>> getGanhos(String uid);
  Future<Map<String, double>> getTotalSpentByCategory(String uid);
  Future<List<AccountModel>> getAccountBanks(String houseId);
}
