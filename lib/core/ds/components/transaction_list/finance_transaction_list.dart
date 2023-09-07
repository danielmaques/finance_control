import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const FinanceText.p14(
          'text',
          fontWeight: FontWeight.w500,
          color: AppColors.slateGray,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount ?? transaction.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final currentTransaction = transaction[index];
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
                        fontWeight: FontWeight.w500,
                        color: AppColors.midnightBlack,
                      ),
                      FinanceText.p16(
                        currentTransaction['data'].toString(),
                        fontWeight: FontWeight.w500,
                        color: AppColors.slateGray,
                      ),
                    ],
                  ),
                ),
                FinanceText.p18(
                  currentTransaction['valor'].toString(),
                  fontWeight: FontWeight.w500,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
