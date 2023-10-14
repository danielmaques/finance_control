import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/add_transaction/data/model/add_transaction_card_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';

abstract class IAddTransactionCardData {
  Future<Result<void>> call(String uid, AddTransactionCard addTransaction);
}

class AddTransactionCardData implements IAddTransactionCardData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<void>> call(
      String uid, AddTransactionCard addTransaction) async {
    try {
      String selectedCardId = addTransaction.cardID!;

      if (addTransaction.isInstallment == true) {
        int numberOfInstallments =
            addTransaction.installmentMonths?.toInt() ?? 0;
        double monthlyValue = addTransaction.value! / numberOfInstallments;
        DateTime currentDate = DateTime.now();

        DocumentReference cardRef = _firestore
            .collection('house')
            .doc(uid)
            .collection('cards')
            .doc(selectedCardId);

        DocumentSnapshot cardSnapshot = await cardRef.get();

        if (cardSnapshot.exists) {
          Map<String, dynamic>? cardData =
              cardSnapshot.data() as Map<String, dynamic>?;

          if (cardData != null) {
            double currentAvailableLimit =
                cardData['availableLimit'].toDouble();
            currentAvailableLimit = addTransaction.value ?? 0;

            await cardRef.update({
              'availableLimit': currentAvailableLimit,
            });
          }
        }

        for (int month = 1; month <= numberOfInstallments; month++) {
          final transactionTime = currentDate.add(Duration(days: 30 * month));
          final monthYear = DateFormat('MMM yyyy').format(transactionTime);

          DocumentReference monthRef = cardRef.collection(monthYear).doc();

          final AddTransactionCard transaction = AddTransactionCard(
            description: '${addTransaction.description} - Parcela $month',
            value: monthlyValue,
            time: transactionTime,
          );

          await monthRef.set(transaction.toJson());
        }
      }

      return ResultSuccess(AddTransactionCard());
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
