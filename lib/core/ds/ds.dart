import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(const MyDS());
}

class MyDS extends StatelessWidget {
  const MyDS({super.key});

  @override
  Widget build(BuildContext context) {
    return const FinanceTextField();
  }
}
