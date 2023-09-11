
import 'finance_font_weight.dart';
import 'finance_fonts.dart';

class FinanceTextStyle {
  final FinanceFontFamily fontFamily;
  final double fontSize;

  /// [fontWeight] should be included in the [fontFamily] weights list values.
  final FinanceFontWeight fontWeight;
  final double lineHeight;

  FinanceTextStyle({
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    required double lineHeightInPx,
  })  : lineHeight = lineHeightInPx / fontSize,
        assert(fontFamily.weights.contains(fontWeight));
}
