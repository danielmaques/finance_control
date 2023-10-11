import 'package:finance_control/app/home/ui/page/home_page.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('Página 1'),
    Text('Página 2'),
    Text('Página 3'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item(icon: 'assets/icons/home.svg', index: 0),
                item(icon: 'assets/icons/receipt.svg', index: 1),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.deepBlue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                item(icon: 'assets/icons/bank.svg', index: 2),
                item(icon: 'assets/icons/user.svg', index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item({required String icon, required int index}) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: SvgPicture.asset(
        icon,
        height: 24,
        width: 24,
        color: _selectedIndex == index ? Colors.blue : Colors.black,
      ),
    );
  }
}
