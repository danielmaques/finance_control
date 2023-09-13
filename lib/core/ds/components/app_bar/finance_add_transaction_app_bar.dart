import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class FinanceAddTransactionAppBar extends StatefulWidget {
  const FinanceAddTransactionAppBar({
    super.key,
    required this.onChanged,
  });

  final Function(double) onChanged;

  @override
  State<FinanceAddTransactionAppBar> createState() =>
      _FinanceAddTransactionAppBarState();
}

class _FinanceAddTransactionAppBarState
    extends State<FinanceAddTransactionAppBar> {
  late String price;

  @override
  void initState() {
    super.initState();
    price = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: AppColors.deepBlue,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                'assets/icons/lines.svg',
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: FinanceText.p16(
                  'Adicionar transação',
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: 'R\$ 0,00',
                style: const TextStyle(
                  fontSize: 50,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'pt-br',
                    decimalDigits: 2,
                    symbol: 'R\$',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    price = value;
                  });

                  // Remova o "R\$" e espaços em branco
                  String onlyNumbers = value.replaceAll('R\$', '').trim();

                  // Substitua o ponto (separador de milhar) por nada
                  onlyNumbers = onlyNumbers.replaceAll('.', '');

                  // Substitua a vírgula (separador decimal) por um ponto
                  onlyNumbers = onlyNumbers.replaceAll(',', '.');

                  // Converta a string para double
                  double? priceAsDouble;
                  try {
                    priceAsDouble = double.parse(onlyNumbers);
                  } catch (e) {
                    if (kDebugMode) {
                      print("Erro ao converter o valor para double: $e");
                    }
                    return;
                  }

                  widget.onChanged(priceAsDouble);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'R\$ 0,00',
                  hintStyle: TextStyle(
                    fontSize: 50,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
