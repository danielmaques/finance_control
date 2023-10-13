import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';

import '../../../../core/core.dart';

abstract class IGetCardData {
  Future<Result<List<CardModel>>> call(String uid);
}

class GetCardData implements IGetCardData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<Result<List<CardModel>>> call(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('house')
          .doc(uid)
          .collection('cards')
          .get();

      List<CardModel> cards = [];

      for (var doc in querySnapshot.docs) {
        CardModel cardsList =
            CardModel.fromJson(doc.data() as Map<String, dynamic>);
        cards.add(cardsList);
      }

      return ResultSuccess(cards);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
