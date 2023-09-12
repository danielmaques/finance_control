import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:flutter/material.dart';

class FinanceDropDown extends StatefulWidget {
  const FinanceDropDown({
    Key? key,
    this.initialItem,
    required this.items,
    required this.hint,
    this.itemColors,
  }) : super(key: key);

  final String? initialItem;
  final List<String> items;
  final List<Color>? itemColors;
  final String hint;

  @override
  State<FinanceDropDown> createState() => _FinanceDropDownState();
}

class _FinanceDropDownState extends State<FinanceDropDown> {
  String? selectedItem;
  late List<String> items;
  late List<Color> itemColors;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
    items = widget.items;
    itemColors = widget.itemColors ?? [Colors.transparent]; // Valor padrão
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedItem,
          hint: Align(
            alignment: Alignment.centerLeft,
            child: FinanceText.p16(
              selectedItem ?? widget.hint,
              color: Colors.grey[500],
            ),
          ),
          items: items.asMap().entries.map((entry) {
            int idx = entry.key;
            String value = entry.value;
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: itemColors.isNotEmpty
                          ? itemColors[idx % itemColors.length]
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedItem = newValue;
            });
          },
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 32,
            color: Colors.grey[500],
          ),
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String value) {
              return Align(
                alignment: Alignment.centerLeft,
                child: FinanceText.p16(
                  selectedItem ?? "Categoria",
                  color: Colors.grey[500],
                ),
              );
            }).toList();
          },
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
          style: TextStyle(color: Colors.grey[500]),
          iconSize: 32,
          elevation: 16,
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}
