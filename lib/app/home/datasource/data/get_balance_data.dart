import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';
import '../model/balance_model.dart';

abstract class IGetBalanceData {
  Future<Result<BalanceModel>> call(String uid);
}

class GetBalanceData implements IGetBalanceData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<BalanceModel>> call(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();

    try {
      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

      if (userData.containsKey('balance')) {
        final double currentBalance =
            (userData['balance'] as num?)?.toDouble() ?? 0.0;

        final BalanceModel balance = BalanceModel(
          balance: currentBalance,
        );

        return ResultSuccess(balance);
      } else {
        return ResultSuccess(BalanceModel());
      }
    } catch (e) {
      return ResultError(BaseError('Error: $e'));
    }
  }
}
