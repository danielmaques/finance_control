import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';

class FinanceAppBar extends StatelessWidget {
  const FinanceAppBar({
    super.key,
    this.onTap,
    this.icon = false,
  });

  final Function()? onTap;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Visibility(
              visible: icon,
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25,
                color: AppColors.navyBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
