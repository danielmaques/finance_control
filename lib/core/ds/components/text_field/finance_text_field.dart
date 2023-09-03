import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinanceTextField extends StatelessWidget {
  const FinanceTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.iconData,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  final String? hintText;
  final String? labelText;
  final IconData? iconData;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final String Function(String?)? validator;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.midnightBlack,
        fontWeight: FontWeight.w400,
      ),
      textCapitalization: textCapitalization,
      cursorColor: AppColors.slateGray,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.slateGray,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.midnightBlack,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.midnightBlack,
            width: 1,
          ),
        ),
      ),
    );
  }
}
