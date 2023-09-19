import 'dart:async'; // <-- Required for Timer

import 'package:finance_control/app/home/domain/usecase/home_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
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

  HomeController(this._useCase) {
    _startBalanceRefreshTimer();
  }

  void _startBalanceRefreshTimer() {
    _balanceRefreshTimer?.cancel();
    _balanceRefreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      getBalance();
    });
  }

  Future<void> refreshData() async {
    await getBalance();
    await getTransactions();
    await getGastosEGanhos();
    await getCategoryPercentages();
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
    }
  }

  Future<void> getCategoryPercentages() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      Map<String, double> userGanhos = await _useCase.getGanhos(houseId);
      Map<String, double> categoryTotals =
          await _useCase.getTotalSpentByCategory(houseId);

      String currentMonth = DateTime.now().toString().substring(0, 7);
      double ganhosDoMesAtual = userGanhos[currentMonth] ?? 0.0;

      Map<String, double> percentages = {};

      for (var category in categoryTotals.keys) {
        double percentage =
            (categoryTotals[category]! / ganhosDoMesAtual) * 100;
        percentages[category] = percentage.isNaN ? 0.0 : percentage;
      }

      categoryPercentages.value = percentages;
    }
  }

  void dispose() {
    _balanceRefreshTimer?.cancel();
  }
}
