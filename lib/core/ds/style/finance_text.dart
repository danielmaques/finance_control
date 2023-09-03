import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  const FinanceText.h1(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 52,
    this.color = Colors.black,
  });

  const FinanceText.h2(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 38,
    this.color = Colors.black,
  });

  const FinanceText.h3(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 24,
    this.color = Colors.black,
  });

  const FinanceText.h4(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 20,
    this.color = Colors.black,
  });

  const FinanceText.p18(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.color = Colors.black,
  });

  const FinanceText.p16(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16,
    this.color = Colors.black,
  });

  const FinanceText.p14(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.color = Colors.black,
  });

  const FinanceText.p12(
    this.text, {
    super.key,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
