import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/helpers/formater.dart';
import 'package:flutter/material.dart';

import '../../style/afinz_text.dart';

class FinanceTransactionList extends StatelessWidget {
  const FinanceTransactionList({
    super.key,
    this.itemCount,
    required this.transaction,
  });

  final int? itemCount;
  final List<Map<String, dynamic>> transaction;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount ?? transaction.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final currentTransaction = transaction[index];
        Timestamp timestamp = currentTransaction['data'];
        DateTime dateTime = timestamp.toDate();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.softGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.battery_charging_full_rounded,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FinanceText.p16(
                    currentTransaction['nome'],
                    color: AppColors.midnightBlack,
                  ),
                  FinanceText.p16(
                    formatDate(dateTime),
                    color: AppColors.slateGray,
                  ),
                ],
              ),
            ),
            FinanceText.p18(
              formatMoney(currentTransaction['valor']),
              color: currentTransaction['add'] == true
                  ? AppColors.forestGreen
                  : AppColors.cherryRed,
            ),
          ],
        );
      },
    );
  }
}
