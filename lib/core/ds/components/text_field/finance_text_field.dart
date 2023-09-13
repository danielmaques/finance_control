import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../style/afinz_text.dart';

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
    this.label,
    this.maxLines = 1,
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
  final String? label;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) FinanceText.p14(label!),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          enableSuggestions: true,
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
            prefixIcon: iconData != null ? Icon(iconData) : null,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: AppColors.midnightBlack,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.midnightBlack,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ],
    );
  }
}
