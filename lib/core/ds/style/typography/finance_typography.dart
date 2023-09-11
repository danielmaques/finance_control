import 'package:finance_control/core/ds/style/typography/finance_font_weight.dart';
import 'package:finance_control/core/ds/style/typography/finance_fonts.dart';
import 'package:finance_control/core/ds/style/typography/finance_text_style.dart';

abstract class _FinanceTypography {
  const _FinanceTypography();

  FinanceFontFamily get montserrat => FinanceFontFamilies.montserrat;
  FinanceFontFamily get inter => FinanceFontFamilies.inter;

  FinanceFontWeight get bold => FinanceFontWeight.bold;
  FinanceFontWeight get medium => FinanceFontWeight.medium;
  FinanceFontWeight get regular => FinanceFontWeight.regular;
}

class FinanceTitleTypography extends _FinanceTypography {
  FinanceTextStyle get heading1 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: bold,
        fontSize: 52,
        lineHeightInPx: 80,
      );

  FinanceTextStyle get heading2 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: bold,
        fontSize: 38,
        lineHeightInPx: 64,
      );

  FinanceTextStyle get heading3 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: bold,
        fontSize: 24,
        lineHeightInPx: 40,
      );

  FinanceTextStyle get heading4 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: bold,
        fontSize: 20,
        lineHeightInPx: 32,
      );

  FinanceTextStyle get p18 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: medium,
        fontSize: 18,
        lineHeightInPx: 20,
      );

  FinanceTextStyle get p16 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: medium,
        fontSize: 16,
        lineHeightInPx: 20,
      );

  FinanceTextStyle get p14 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: medium,
        fontSize: 16,
        lineHeightInPx: 20,
      );

  FinanceTextStyle get p12 => FinanceTextStyle(
        fontFamily: montserrat,
        fontWeight: medium,
        fontSize: 16,
        lineHeightInPx: 20,
      );
}
