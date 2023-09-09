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

  HomeController(this._useCase);

  Future<void> addTransaction(DateTime data, double valor, String nome,
      String categoria, bool add) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      Map<String, dynamic> gastoData = {
        'data': data,
        'valor': valor,
        'nome': nome,
        'categoria': categoria,
        'add': add,
      };

      await _useCase.addTransaction(userId, gastoData, add);
      await _useCase.updateBalance(userId, valor, add);

      // Após atualizar o saldo no Firestore, obtenha o saldo atualizado
      await getBalance();

      getTransactions();
      getGastosEGanhos();
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

      transactions.sort((a, b) => b['data'].compareTo(a['data']));

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

  Future<void> getGastosEGanhos() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      Map<String, double> userGastos = await _useCase.getGastos(userId);
      Map<String, double> userGanhos = await _useCase.getGanhos(userId);

      // Obtenha o mês atual
      String currentMonth =
          DateTime.now().toString().substring(0, 7); // "YYYY-MM"

      double gastosDoMesAtual = userGastos[currentMonth] ?? 0.0;
      double ganhosDoMesAtual = userGanhos[currentMonth] ?? 0.0;

      gastos.value = gastosDoMesAtual;
      ganhos.value = ganhosDoMesAtual;
    }
  }
}
