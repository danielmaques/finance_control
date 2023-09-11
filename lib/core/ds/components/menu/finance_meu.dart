import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';

class FinanceMenu extends StatelessWidget {
  const FinanceMenu({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lighterBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.white,
            ),
          ),
          FinanceText.p12(
            label,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
