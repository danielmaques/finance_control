import 'package:flutter/material.dart';

class FinanceText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;

  const FinanceText.h1(
    this.text, {
    super.key,
    this.fontFamily = 'Poppins',
    this.fontWeight = FontWeight.w500,
    this.fontSize = 52,
    this.textAlign = TextAlign.left,
  });

  const FinanceText.h2(
    this.text, {
    super.key,
    this.fontFamily = 'Poppins',
    this.fontWeight = FontWeight.w300,
    this.fontSize = 38,
    this.textAlign = TextAlign.left,
  });

  const FinanceText.h3(
    this.text, {
    super.key,
    this.fontFamily = 'Poppins',
    this.fontWeight = FontWeight.normal,
    this.fontSize = 24,
    this.textAlign = TextAlign.left,
  });

  const FinanceText.h4(
    this.text, {
    super.key,
    this.fontFamily = 'Poppins',
    this.fontWeight = FontWeight.normal,
    this.fontSize = 20,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }
}
