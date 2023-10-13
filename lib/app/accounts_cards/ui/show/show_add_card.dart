import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class ShowAddCard extends StatefulWidget {
  const ShowAddCard({
    super.key,
    required this.controller,
  });

  final AccountCardsController controller;

  @override
  State<ShowAddCard> createState() => _ShowAddCardState();
}

class _ShowAddCardState extends State<ShowAddCard> {
  final List<dynamic> flagList = [
    "Visa",
    "MasterCard",
    "Elo",
    "American Express",
    "Outros",
  ];

  late String price;

  @override
  void initState() {
    super.initState();
    price = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FinanceText.h4(
            'Novo Cartão',
            fontWeight: FontWeight.w500,
          ),
          IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: Icon(
              Icons.close_rounded,
              size: 20,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      content: Column(
        children: [
          TextFormField(
            autofocus: true,
            textAlign: TextAlign.center,
            initialValue: 'R\$ 0,00',
            style: const TextStyle(
              fontSize: 30,
              color: AppColors.midnightBlack,
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

              String onlyNumbers = value.replaceAll('R\$', '').trim();
              onlyNumbers = onlyNumbers.replaceAll('.', '');
              onlyNumbers = onlyNumbers.replaceAll(',', '.');

              double? priceAsDouble;
              try {
                priceAsDouble = double.parse(onlyNumbers);
              } catch (e) {
                if (kDebugMode) {
                  print("Erro ao converter o valor para double: $e");
                }
                return;
              }

              widget.controller.limit.value = priceAsDouble;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'R\$ 0,00',
              hintStyle: TextStyle(
                fontSize: 30,
                color: AppColors.midnightBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          FinanceText.p16(
            'Limite',
            color: AppColors.midnightBlack,
          ),
          const SizedBox(height: 24),
          FinanceTextField(
            label: 'Nome do Cartão',
            onChanged: (p0) {
              widget.controller.cardName.value = p0;
            },
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: FinanceText.p14('Data de Vencimento'),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDatePickerMode: DatePickerMode.day,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  widget.controller.close.value = pickedDate;
                });
              }
            },
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFDDE2E5),
                ),
              ),
              child: FinanceText.p16(
                widget.controller.close.value == DateTime.now()
                    ? 'Data de Vencimento'
                    : DateFormat('dd/MM/yyyy')
                        .format(widget.controller.close.value),
                color: Colors.grey[500],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FinanceDropDown(
            hint: "Bandeira do Cartão",
            categoriesList: flagList,
            onItemSelected: (p0) {
              widget.controller.flag.value = p0;
            },
          ),
          const SizedBox(height: 24),
          FinanceButton(
            title: 'Salvar',
            onTap: () {
              widget.controller.addCard();
              widget.controller.getCards();
              Modular.to.pop();
            },
          ),
        ],
      ),
    );
  }
}
