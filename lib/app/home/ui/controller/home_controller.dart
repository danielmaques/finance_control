import 'package:finance_control/app/home/domain/usecase/home_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  final HomeUseCase _useCase;

  final ValueNotifier<List<Map<String, dynamic>>> transaction =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  final ValueNotifier<double> balance = ValueNotifier<double>(0.0);

  HomeController(this._useCase);

  Future<void> addTransaction(DateTime data, double valor, String nome,
      String categoria, String money) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      Map<String, dynamic> gastoData = {
        'data': data,
        'valor': valor,
        'nome': nome,
        'categoria': categoria,
      };

      await _useCase.addTransaction(userId, gastoData, money);
      await _useCase.updateBalance(userId, valor, money);

      // Após atualizar o saldo no Firestore, obtenha o saldo atualizado
      await getBalance();

      getTransactions();
    } else {
      if (kDebugMode) {
        print("Erro: UID do usuário não encontrado.");
      }
    }
  }

  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final transactions = await _useCase.getTransaction(userId);
      transaction.value = transactions;
    }
  }

  // Função para obter o saldo atual do usuário
  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final currentBalance = await _useCase.getBalance(userId);
      balance.value = currentBalance;
    }
  }
}
