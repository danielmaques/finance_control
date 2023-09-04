import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

class ButtonComponet extends StatelessWidget {
  const ButtonComponet({
    super.key,
    this.lock = false,
  });

  final bool lock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: lock == true ? AppColors.softGray : AppColors.navyBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: FinanceText.p16(
            'Sign in',
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
