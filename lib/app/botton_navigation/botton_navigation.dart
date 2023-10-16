// ignore_for_file: deprecated_member_use

import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  bool _isExpanded = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Modular.to.navigate(_getRoute(index));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const RouterOutlet(),
            if (_isExpanded)
              Positioned(
                bottom: 100,
                left: 150,
                child: Row(
                  children: [
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.forestGreen,
                      onPressed: () {
                        Modular.to.pushNamed('/addTransaction/',
                            arguments: {'add': true});

                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/wallet-add.svg',
                        height: 18,
                        width: 18,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.cherryRed,
                      onPressed: () {
                        Modular.to.pushNamed('/addTransaction/',
                            arguments: {'add': false});
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/wallet-remove.svg',
                        height: 18,
                        width: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          elevation: 2,
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item(icon: 'assets/icons/home.svg', index: 0),
                item(icon: 'assets/icons/receipt.svg', index: 1),
                FloatingActionButton(
                  mini: true,
                  backgroundColor:
                      _isExpanded ? AppColors.lighterBlue : AppColors.deepBlue,
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: _isExpanded
                      ? const Icon(Icons.close)
                      : const Icon(Icons.add),
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
    final selectedColor = Theme.of(context).primaryColor;
    final unselectedColor = Theme.of(context).colorScheme.background;

    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: SvgPicture.asset(
        icon,
        height: 24,
        width: 24,
        color: _selectedIndex == index ? selectedColor : unselectedColor,
      ),
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/bottomNavigation/homeBottom';
      case 1:
        return '/bottomNavigation/transactionsBottom';
      case 2:
        return '/bottomNavigation/accountsCardsBottom';
      case 3:
        return '/homeBottom';
      default:
        return '/bottomNavigation/homeBottom';
    }
  }
}
