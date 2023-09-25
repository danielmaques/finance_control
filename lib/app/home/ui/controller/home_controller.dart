import 'dart:async';

import 'package:finance_control/app/home/domain/usecase/home_usecase.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends Cubit<BaseState> {
  final HomeUseCase _useCase;

  final ValueNotifier<List<Map<String, dynamic>>> transaction =
      ValueNotifier<List<Map<String, dynamic>>>([]);
  final ValueNotifier<double> balance = ValueNotifier<double>(0.0);
  final ValueNotifier<double> gastos = ValueNotifier<double>(0.0);
  final ValueNotifier<double> ganhos = ValueNotifier<double>(0.0);
  final ValueNotifier<Map<String, dynamic>?> house =
      ValueNotifier<Map<String, dynamic>?>(null);
  final ValueNotifier<Map<String, double>> categoryPercentages =
      ValueNotifier<Map<String, double>>({});

  Timer? _balanceRefreshTimer;

  HomeController(this._useCase) : super(const EmptyState()) {
    startBalanceRefreshTimer();
  }

  void startBalanceRefreshTimer() {
    _balanceRefreshTimer?.cancel();
    _balanceRefreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getBalance();
      refreshData();
      updateCategoryPercentages();
    });
  }

  Future<void> refreshData() async {
    await getBalance();
    await getTransactions();
    await getGastosEGanhos();
  }

  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final transactions = await _useCase.getTransaction(houseId);

      transactions.sort((a, b) => b['data'].compareTo(a['data']));

      transaction.value = transactions;
      await refreshData();
    }
  }

  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final currentBalance = await _useCase.getBalance(houseId);
      balance.value = currentBalance;
    }
  }

  Future<void> getGastosEGanhos() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      Map<String, double> userGastos = await _useCase.getGastos(houseId);
      Map<String, double> userGanhos = await _useCase.getGanhos(houseId);

      String currentMonth = DateTime.now().toString().substring(0, 7);

      double gastosDoMesAtual = userGastos[currentMonth] ?? 0.0;
      double ganhosDoMesAtual = userGanhos[currentMonth] ?? 0.0;

      gastos.value = gastosDoMesAtual;
      ganhos.value = ganhosDoMesAtual;

      updateCategoryPercentages();
    }
  }

  double convertToPercentage(double value, double total) {
    if (total == 0) return 0.0;
    return (value / total) * 100;
  }

  Future<void> updateCategoryPercentages() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      Map<String, double> percentages =
          await _useCase.getTotalSpentByCategory(houseId);
      categoryPercentages.value = percentages;
    }
  }

  void dispose() {
    _balanceRefreshTimer?.cancel();
  }
}
