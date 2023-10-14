import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/add_transaction/data/model/add_transaction_model.dart';
import 'package:finance_control/core/core.dart';
import 'package:intl/intl.dart';

abstract class IAddTransactionData {
  Future<Result> call(String uid, AddTransaction addTransaction);
}

class AddTransactionData implements IAddTransactionData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result> call(String uid, AddTransaction addTransaction) async {
    try {
      DocumentSnapshot house =
          await _firestore.collection('house').doc(uid).get();
      Map<String, dynamic> userData = house.data() as Map<String, dynamic>;

      double currentBalance = 0.0;

      // add transaction
      DateTime now = DateTime.now();
      String monthYear = DateFormat('MMM yyyy').format(now);
      await _firestore
          .collection('house')
          .doc(uid)
          .collection(monthYear)
          .add(addTransaction.toJson());

      await _firestore.collection('house').doc(uid).set({
        'subcollections': FieldValue.arrayUnion([monthYear])
      }, SetOptions(merge: true));

      // update category expense
      if (addTransaction.add == false) {
        double currentExpense =
            (userData['categoryExpenses'] ?? {})[addTransaction.category] ??
                0.0;
        currentExpense += addTransaction.value ?? 0;

        await _firestore.collection('house').doc(uid).update({
          'categoryExpenses.${addTransaction.category}': currentExpense,
        });
      }

      // update balance
      currentBalance = house['balance'].toDouble();

      if (addTransaction.add == true) {
        currentBalance += addTransaction.value ?? 0;
      } else if (addTransaction.add == false) {
        currentBalance -= addTransaction.value ?? 0;
      }

      await _firestore.collection('house').doc(uid).update({
        'balance': currentBalance,
      });

      await _firestore
          .collection('house')
          .doc(uid)
          .collection('accountBanks')
          .doc(addTransaction.cardID!)
          .update({'balance': currentBalance});

      String currentMonth = DateTime.now().toString().substring(0, 7);

      if (addTransaction.add == true) {
        double currentGain = (userData['ganhos'] ?? {})[currentMonth] ?? 0.0;
        currentGain += addTransaction.value ?? 0;
        await _firestore.collection('house').doc(uid).update({
          'ganhos.$currentMonth': currentGain,
        });
      } else if (addTransaction.add == false) {
        double currentExpense = (userData['gastos'] ?? {})[currentMonth] ?? 0.0;
        currentExpense += addTransaction.value ?? 0;
        await _firestore.collection('house').doc(uid).update({
          'gastos.$currentMonth': currentExpense,
        });
      }

      return ResultSuccess(addTransaction);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
