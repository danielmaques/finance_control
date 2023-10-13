import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/core/core.dart';

abstract class IGetAccountBankData {
  Future<Result<List<AccountModel>>> call(String uid);
}

class GetAccountBankData implements IGetAccountBankData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<List<AccountModel>>> call(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('house')
          .doc(uid)
          .collection('accountBanks')
          .get();

      List<AccountModel> accountBanks = [];

      for (var doc in querySnapshot.docs) {
        AccountModel account =
            AccountModel.fromJson(doc.data() as Map<String, dynamic>);
        accountBanks.add(account);
      }

      return ResultSuccess(accountBanks);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
