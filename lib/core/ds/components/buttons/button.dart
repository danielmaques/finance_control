// ignore_for_file: library_private_types_in_public_api

import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';

enum CustomButtonType { primary, secondary, basic, basicAlternative }

class FinanceButton extends StatefulWidget {
  final String title;
  final CustomButtonType type;
  final bool disabled;
  final bool loading;
  final void Function()? onTap;
  final IconData? icon;
  final bool small;
  final bool textOnly;
  final bool branded;

  const FinanceButton({
    required this.title,
    Key? key,
    this.type = CustomButtonType.primary,
    this.disabled = false,
    this.loading = false,
    this.onTap,
    this.icon,
    this.small = false,
    this.textOnly = false,
    this.branded = false,
  }) : super(key: key);

  @override
  _FinanceButtonState createState() => _FinanceButtonState();
}

class _FinanceButtonState extends State<FinanceButton> {
  bool _disabled = false;
  late Color _colorBackground;
  late Color _colorDisabled;
  late Color _textIconColor;

  @override
  void initState() {
    super.initState();
    _setButtonAttributes();
  }

  @override
  void didUpdateWidget(covariant FinanceButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setButtonAttributes();
  }

  void _setButtonAttributes() {
    _disabled = widget.disabled || widget.onTap == null;
    _colorBackground = AppColors.navyBlue;
    _colorDisabled = AppColors.softGray;
    _textIconColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.loading || widget.disabled ? null : widget.onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: !_disabled ? _colorBackground : _colorDisabled,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: widget.small ? 36 : 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: _textIconColor,
                  ),
                if (widget.icon != null) const SizedBox(width: 5),
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(color: _textIconColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
