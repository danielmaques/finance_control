import 'package:finance_control/core/ds/components/menu/finance_meu.dart';
import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FinanceHomeAppBar extends StatelessWidget {
  const FinanceHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.deepBlue,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            child: SvgPicture.asset('assets/icons/lines.svg'),
          ),
          Positioned(
            left: 20,
            bottom: 147,
            child: FinanceText.h3(
              'Saldo',
              color: AppColors.white,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 127,
            child: FinanceText.p14(
              'Saldo',
              color: AppColors.white.withOpacity(0.5),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FinanceMenu(
                  label: 'Adicionar',
                  icon: Icons.add_rounded,
                  onTap: () {},
                ),
                FinanceMenu(
                  label: 'Remover',
                  icon: Icons.remove_rounded,
                  onTap: () {},
                ),
                FinanceMenu(
                  label: 'Transações',
                  icon: Icons.receipt_outlined,
                  onTap: () {},
                ),
                FinanceMenu(
                  label: 'Menu',
                  icon: Icons.dehaze_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
