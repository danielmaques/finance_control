import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:finance_control/core/ds/style/finance_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const FinanceText.p16(
              'Saldo',
              fontWeight: FontWeight.w400,
              color: AppColors.midnightBlack,
            ),
            const FinanceText.h2(
              'R\$ text',
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5FA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.arrow_circle_down_rounded,
                        color: AppColors.cherryRed,
                        size: 48,
                      ),
                      SizedBox(height: 8),
                      FinanceText.p18(
                        'text',
                        fontWeight: FontWeight.w600,
                        color: AppColors.midnightBlack,
                      ),
                      FinanceText.p16('Gastos')
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 90,
                    color: AppColors.slateGray,
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.arrow_circle_up_rounded,
                        color: AppColors.forestGreen,
                        size: 48,
                      ),
                      SizedBox(height: 8),
                      FinanceText.p18(
                        'text',
                        fontWeight: FontWeight.w600,
                        color: AppColors.midnightBlack,
                      ),
                      FinanceText.p16('Gastos')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
