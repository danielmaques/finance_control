import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
import 'package:finance_control/app/accounts_cards/ui/show/show_add_accoount.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AccountCardsPage extends StatefulWidget {
  const AccountCardsPage({
    super.key,
    required this.controller,
  });

  final AccountCardsController controller;

  @override
  _AccountCardsPageState createState() => _AccountCardsPageState();
}

class _AccountCardsPageState extends State<AccountCardsPage> {
  int selectedTabIndex = 0;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller.getUsersInHouse();
    widget.controller.getAccountBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      appBar: FinanceAppBar(
        title: 'Contas e Cartões',
        icon: true,
        onTap: () {
          Modular.to.pop();
        },
        color: AppColors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FinanceToolBarItem(
                    title: 'Bancos',
                    label: 'Contas Bancárias',
                    icon: Icons.account_balance_outlined,
                    select: selectedTabIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  FinanceToolBarItem(
                    title: 'Cartões',
                    label: 'Cartões de Crédito',
                    icon: Icons.credit_card,
                    select: selectedTabIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedTabIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          selectedTabIndex == 0
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ValueListenableBuilder(
                      valueListenable: widget.controller.accountList,
                      builder: (context, accountList, child) =>
                          GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 35,
                          crossAxisSpacing: 35,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: accountList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(25),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ShowAddAccount(
                                      controller: widget.controller,
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 40,
                                      color: AppColors.deepBlue,
                                    ),
                                    const SizedBox(height: 16),
                                    FinanceText.p18(
                                      selectedTabIndex == 0
                                          ? 'Add Conta'
                                          : 'Add Cartão',
                                      color: AppColors.deepBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return FinanceAccountCardItem(
                              selectedTabIndex: selectedTabIndex,
                              gasto: accountList[index - 1].balance!,
                              name: accountList[index - 1].bank!,
                              saldo: accountList[index - 1].balance!,
                              accountType: accountList[index - 1].accountType!,
                              delete: () {
                                widget.controller.deleteBank(
                                  accountList[index - 1].id!,
                                );
                                Modular.to.pop();
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
        ],
      ),
    );
  }
}
