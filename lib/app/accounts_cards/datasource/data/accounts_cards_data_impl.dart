import 'package:cloud_firestore/cloud_firestore.dart';
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
}
