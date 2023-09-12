import 'package:flutter/material.dart';

@protected
class FinanceFontWeight implements FontWeight {
  const FinanceFontWeight._(this.index);

  /// The encoded integer value of this font weight.
  @override
  final int index;

  /// Thin, the least thick
  static const FinanceFontWeight _w100 = FinanceFontWeight._(0);
  static const FinanceFontWeight thin = _w100;

  /// Extra-light
  static const FinanceFontWeight _w200 = FinanceFontWeight._(1);
  static const FinanceFontWeight extraLight = _w200;

  /// Light
  static const FinanceFontWeight _w300 = FinanceFontWeight._(2);
  static const FinanceFontWeight light = _w300;

  /// Normal / regular / plain
  static const FinanceFontWeight _w400 = FinanceFontWeight._(3);
  static const FinanceFontWeight regular = _w400;

  /// Medium
  static const FinanceFontWeight _w500 = FinanceFontWeight._(4);
  static const FinanceFontWeight medium = _w500;

  /// Semi-bold
  static const FinanceFontWeight _w600 = FinanceFontWeight._(5);
  static const FinanceFontWeight semiBold = _w600;

  /// Bold
  static const FinanceFontWeight _w700 = FinanceFontWeight._(6);
  static const FinanceFontWeight bold = _w700;

  /// Extra-bold
  static const FinanceFontWeight _w800 = FinanceFontWeight._(7);
  static const FinanceFontWeight extraBold = _w800;

  /// Black, the most thick
  static const FinanceFontWeight _w900 = FinanceFontWeight._(8);
  static const FinanceFontWeight black = _w900;

  /// A list of all the font weights.
  static const List<FinanceFontWeight> values = <FinanceFontWeight>[
    thin,
    extraLight,
    light,
    regular,
    medium,
    semiBold,
    bold,
    extraBold,
    black
  ];
  
  @override
  // TODO: implement value
  int get value => throw UnimplementedError();
}
