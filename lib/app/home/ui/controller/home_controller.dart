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

  Timer? _balanceRefreshTimer; // <-- Declare a Timer instance

  HomeController(this._useCase) {
    _startBalanceRefreshTimer(); // <-- Initialize the timer in the constructor
  }

  // Define the timer function
  void _startBalanceRefreshTimer() {
    _balanceRefreshTimer?.cancel(); // Cancel any existing timer just in case
    _balanceRefreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      getBalance();
    });
  }

  Future<void> refreshData() async {
    await getBalance();
    await getTransactions();
    await getGastosEGanhos();
  }

  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final transactions = await _useCase.getTransaction(userId);

      transactions.sort((a, b) => b['data'].compareTo(a['data']));

      transaction.value = transactions;
      await refreshData();
    }
  }

  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final currentBalance = await _useCase.getBalance(userId);
      balance.value = currentBalance;
    }
  }

  Future<void> getGastosEGanhos() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      Map<String, double> userGastos = await _useCase.getGastos(userId);
      Map<String, double> userGanhos = await _useCase.getGanhos(userId);

      String currentMonth = DateTime.now().toString().substring(0, 7);

      double gastosDoMesAtual = userGastos[currentMonth] ?? 0.0;
      double ganhosDoMesAtual = userGanhos[currentMonth] ?? 0.0;

      gastos.value = gastosDoMesAtual;
      ganhos.value = ganhosDoMesAtual;
    }
  }

  // Remember to dispose of the timer when it's no longer needed.
  void dispose() {
    _balanceRefreshTimer?.cancel();
  }
}
