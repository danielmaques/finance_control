import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/transactions_usecase.dart';

class TransactionsController {
  final TransactionsUseCase transactionsUseCase;

  final ValueNotifier<Map<String, List<Map<String, dynamic>>>>
      transactionsByMonth =
      ValueNotifier<Map<String, List<Map<String, dynamic>>>>({});

  final ValueNotifier<double> balance = ValueNotifier<double>(0.0);

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  TransactionsController(this.transactionsUseCase);

  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    try {
      if (houseId != null) {
        final transactions = await transactionsUseCase.getTransaction(houseId);

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

        monthMap.forEach((month, transactions) {
          transactions
              .sort((a, b) => b['data'].toDate().compareTo(a['data'].toDate()));
        });

        transactionsByMonth.value = monthMap;

        isLoading.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    if (houseId != null) {
      final currentBalance = await transactionsUseCase.getBalance(houseId);
      balance.value = currentBalance;
    }
  }
}
