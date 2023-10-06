import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../accounts_cards/datasource/model/account_model.dart';
import 'add_bank_data.dart';

class AddBankDataImpl implements AddBankData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('house').doc(houseId).get();

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null &&
          data.containsKey('membrosNomes') &&
          data['membrosNomes'] is List) {
        return List<dynamic>.from(data['membrosNomes']);
      } else {
        if (kDebugMode) {
          print("Campo 'membrosNomes' não encontrado ou não é uma lista.");
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar: $e");
      }
      return [];
    }
  }

  @override
  Future<String> addBank(String houseId, AccountModel account) async {
    try {
      final transactionRef = _firestore
          .collection('house')
          .doc(houseId)
          .collection('accountBanks')
          .doc();

      final accountId = transactionRef.id;

      Map<String, dynamic> accountData = account.toJson();

      accountData['id'] = accountId;

      await transactionRef.set(accountData);

      return accountId;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao adicionar conta bancária: $e');
      }
      rethrow;
    }
  }
}
