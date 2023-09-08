import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMM').format(date);
}

String formatMoney(double value) {
  final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  return formatter.format(value);
}
