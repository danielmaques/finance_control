import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

class ButtonComponet extends StatelessWidget {
  const ButtonComponet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: FinanceText.p16(
          'Sign in',
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
