import 'dart:io';

import 'package:finance_control/app/home/datasource/data/home_data.dart';
import 'package:finance_control/app/home/datasource/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeData _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<void> addTransaction(
          String uid, Map<String, dynamic> transactionData, String money) =>
      _dataSource.addTransaction(uid, transactionData, money);
  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) =>
      _dataSource.getTransaction(uid);
  @override
  Future<String> upload(File imageFile, String uid) =>
      _dataSource.upload(imageFile, uid);

  @override
  Future<void> updateBalance(String uid, double valor, String money) {
    return _dataSource.updateBalance(uid, valor, money);
  }

  @override
  Future<double> getBalance(String uid) {
    return _dataSource.getBalance(uid);
  }

  @override
  Future<Map<String, double>> getGanhos(String uid) {
    return _dataSource.getGanhos(uid);
  }

  @override
  Future<Map<String, double>> getGastos(String uid) {
    return _dataSource.getGastos(uid);
  }
}
