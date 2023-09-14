import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/transactions_usecase.dart';

class TransactionsController {
  final TransactionsUseCase transactionsUseCase;

  final ValueNotifier<List<Map<String, dynamic>>> transaction =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  final ValueNotifier<Map<String, List<Map<String, dynamic>>>>
      transactionMonths =
      ValueNotifier<Map<String, List<Map<String, dynamic>>>>({});

  final ValueNotifier<Map<String, List<Map<String, dynamic>>>>
      transactionsByMonth =
      ValueNotifier<Map<String, List<Map<String, dynamic>>>>({});

  final ValueNotifier<double> balance = ValueNotifier<double>(0.0);

  TransactionsController(this.transactionsUseCase);

  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    try {
      if (userId != null) {
        final transactions = await transactionsUseCase.getTransaction(userId);

        transactions
            .sort((a, b) => b['data'].toDate().compareTo(a['data'].toDate()));

        Map<String, List<Map<String, dynamic>>> monthMap = {};
        for (var trans in transactions) {
          DateTime date = trans['data'].toDate();
          String month = DateFormat('MMM yyyy').format(date);

          if (!monthMap.containsKey(month)) {
            monthMap[month] = [];
          }
          monthMap[month]!.add(trans);
        }

        transaction.value = transactions;
        transactionsByMonth.value = monthMap;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getTransactionMonths() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final months = await transactionsUseCase.listTransactionMonths(userId);
      transactionMonths.value = months;
    }
  }

  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId != null) {
      final currentBalance = await transactionsUseCase.getBalance(userId);
      balance.value = currentBalance;
    }
  }
}
