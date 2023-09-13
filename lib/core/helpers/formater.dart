import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMM').format(date);
}

DateTime now = DateTime.now();

// Formato: Jun 28, 2023
String formattedDate1 = DateFormat.yMMMEd().format(now);

// Formato: Tuesday, Jun 28, 2023
String formattedDate2 = DateFormat.yMMMMEEEEd().format(now);

// Formato: 6/28/2023
String formattedDate3 = DateFormat.yMd().format(now);


String formatMoney(double value) {
  final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  return formatter.format(value);
}
