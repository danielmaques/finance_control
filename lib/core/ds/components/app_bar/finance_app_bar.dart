import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FinanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FinanceAppBar({
    Key? key,
    this.icon = false,
    this.title = '',
  }) : super(key: key);

  final bool icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: FinanceText.p16(
        title,
        color: Colors.black,
      ),
      leading: icon
          ? GestureDetector(
              onTap: () => Modular.to.pop(),
              child: const Icon(
                Icons.arrow_back,
                size: 25,
                color: AppColors.navyBlue,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
