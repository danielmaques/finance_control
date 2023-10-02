import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:flutter/foundation.dart';

import 'accounts_cards_data.dart';

class AccountCardsDataImpl implements AccountCardsData {
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
  Future<void> addBank(String houseId, AccountModel account) async {
    try {
      final transactionRef = _firestore
          .collection('house')
          .doc(houseId)
          .collection('accountBanks')
          .doc();

      Map<String, dynamic> accountData = account.toJson();

      await transactionRef.set(accountData);
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao adicionar conta bancária: $e');
      }
    }
  }

  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('house')
          .doc(houseId)
          .collection('accountBanks')
          .get();

      List<AccountModel> accountBanks = [];

      for (var doc in querySnapshot.docs) {
        AccountModel account =
            AccountModel.fromJson(doc.data() as Map<String, dynamic>);
        accountBanks.add(account);
      }

      return accountBanks;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar os bancos: $e");
      }
      return [];
    }
  }
}
