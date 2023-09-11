import 'finance_font_weight.dart';

/// Font families for Finance Design System
class FinanceFontFamilies {
  const FinanceFontFamilies();

  static const FinanceFontFamily montserrat = _FinanceMontserratFontFamily();
  static const FinanceFontFamily inter = _FinanceInterFontFamily();
}

/// Font names for Finance Design System
abstract class FinanceFontFamily {
  abstract final String name;
  abstract final List<FinanceFontWeight> weights;

  const FinanceFontFamily();
}

class _FinanceMontserratFontFamily implements FinanceFontFamily {
  const _FinanceMontserratFontFamily();

  @override
  String get name => "Montserrat";

  @override
  List<FinanceFontWeight> get weights => [
        FinanceFontWeight.light,
        FinanceFontWeight.regular,
        FinanceFontWeight.medium,
        FinanceFontWeight.bold,
        FinanceFontWeight.extraBold,
        FinanceFontWeight.black,
      ];
}

class _FinanceInterFontFamily implements FinanceFontFamily {
  const _FinanceInterFontFamily();

  @override
  String get name => "Inter";

  @override
  List<FinanceFontWeight> get weights => FinanceFontWeight.values;
}
