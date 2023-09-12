import 'package:flutter/material.dart';

import 'typography/finance_text_style.dart';
import 'typography/finance_typography.dart';

class FinanceText extends StatelessWidget {
  final String text;
  final bool underline;
  final Color? color;
  final TextAlign? textAlign;
  final FinanceTextStyle style;
  final int? maxLines;
  final TextOverflow? textOverflow;

  FinanceText.h1(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().heading1;

  FinanceText.h2(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().heading2;

  FinanceText.h3(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().heading3;

  FinanceText.h4(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().heading4;

  FinanceText.p18(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().p18;

  FinanceText.p16(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().p16;

  FinanceText.p14(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().p14;

  FinanceText.p12(
    this.text, {
    super.key,
    this.underline = false,
    this.color,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
  }) : style = FinanceTitleTypography().p12;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: style.fontFamily.name,
        fontWeight: style.fontWeight,
        fontSize: style.fontSize,
        height: style.lineHeight,
        color: color,
        decoration: underline ? TextDecoration.underline : null,
      ),
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
