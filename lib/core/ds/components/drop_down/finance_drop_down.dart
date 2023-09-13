import 'package:flutter/material.dart';

class FinanceDropDown extends StatefulWidget {
  const FinanceDropDown({
    Key? key,
    this.initialItem,
    required this.categoriesList,
    required this.hint,
    this.itemColors,
    required this.onItemSelected,
  }) : super(key: key);

  final String? initialItem;
  final ValueNotifier<List<dynamic>> categoriesList;
  final List<Color>? itemColors;
  final String hint;
  final Function(String) onItemSelected;

  @override
  State<FinanceDropDown> createState() => _FinanceDropDownState();
}

class _FinanceDropDownState extends State<FinanceDropDown> {
  String? selectedItem;
  late List<Color> itemColors;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
    itemColors = widget.itemColors ?? [Colors.transparent];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: widget.categoriesList,
      builder: (context, categories, child) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
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
                  child: Text(
                    selectedItem ?? widget.hint,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
                items: categories.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: itemColors.isNotEmpty
                                ? itemColors[categories.indexOf(value) %
                                    itemColors.length]
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
                  widget.onItemSelected(newValue!);
                },
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 32,
                  color: Colors.grey[500],
                ),
                selectedItemBuilder: (BuildContext context) {
                  return categories.map<Widget>((value) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedItem ?? "Categoria",
                        style: TextStyle(color: Colors.grey[500]),
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
          ),
        );
      },
    );
  }
}
