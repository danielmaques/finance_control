import 'dart:io';

import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/home/datasource/repository/home_repository.dart';
import 'package:finance_control/app/home/domain/usecase/home_usecase.dart';

class HomeUseCaseImpl implements HomeUseCase {
  final HomeRepository _repository;

  HomeUseCaseImpl(this._repository);

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) =>
      _repository.getTransaction(uid);
  @override
  Future<String> upload(File imageFile, String uid) =>
      _repository.upload(imageFile, uid);

  @override
  Future<void> updateBalance(String uid, double valor, bool add) {
    return _repository.updateBalance(uid, valor, add);
  }

  @override
  Future<double> getBalance(String uid) {
    return _repository.getBalance(uid);
  }

  @override
  Future<Map<String, double>> getGanhos(String uid) {
    return _repository.getGanhos(uid);
  }

  @override
  Future<Map<String, double>> getGastos(String uid) {
    return _repository.getGastos(uid);
  }

  @override
  Future<Map<String, double>> getTotalSpentByCategory(String uid) {
    return _repository.getTotalSpentByCategory(uid);
  }

  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) {
    return _repository.getAccountBanks(houseId);
  }
}
