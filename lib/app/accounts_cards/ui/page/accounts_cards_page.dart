import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
import 'package:finance_control/app/accounts_cards/ui/show/show_add_accoount.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../show/show_add_card.dart';

class AccountCardsPage extends StatefulWidget {
  const AccountCardsPage({
    super.key,
    required this.controller,
  });

  final AccountCardsController controller;

  @override
  State<AccountCardsPage> createState() => _AccountCardsPageState();
}

class _AccountCardsPageState extends State<AccountCardsPage> {
  int selectedTabIndex = 0;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller.getUsersInHouse();
    widget.controller.getAccountBanks();
    widget.controller.getCards();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FinanceToolBar(
              selectBank: selectedTabIndex == 0,
              selectCard: selectedTabIndex == 1,
              onTapBank: () {
                setState(() {
                  selectedTabIndex = 0;
                });
              },
              onTapCard: () {
                setState(() {
                  selectedTabIndex = 1;
                });
              },
            ),
            const SizedBox(height: 40),
            selectedTabIndex == 0
                ? Padding(
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
                                      'Add Conta',
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
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ValueListenableBuilder(
                      valueListenable: widget.controller.cardList,
                      builder: (context, cardList, child) => ListView.separated(
                        itemCount: cardList.length + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 35),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(25),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ShowAddCard(
                                      controller: widget.controller,
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  height: 200,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add_circle_outline_rounded,
                                        size: 40,
                                        color: AppColors.deepBlue,
                                      ),
                                      const SizedBox(height: 16),
                                      FinanceText.p18(
                                        'Add Cartão',
                                        color: AppColors.deepBlue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            double disponivel = cardList[index - 1].limit! -
                                cardList[index - 1].availableLimit!;
                            return Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(25),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(25),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            cardList[index - 1].flag == 'Visa'
                                                ? 'assets/images/visa.png'
                                                : cardList[index - 1].flag ==
                                                        "MasterCard"
                                                    ? 'assets/images/master.png'
                                                    : cardList[index - 1]
                                                                .flag ==
                                                            "Elo"
                                                        ? 'assets/images/elo.png'
                                                        : cardList[index - 1]
                                                                    .flag ==
                                                                "American Express"
                                                            ? 'assets/images/amex.png'
                                                            : 'assets/images/credit-card.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(width: 16),
                                          FinanceText.h3(
                                            cardList[index - 1].cardName!,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.more_vert_rounded,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FinanceText.p16(
                                            'Parcela do mês',
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                          FinanceText.p16(
                                            formatMoney(cardList[index - 1]
                                                    .availableLimit ??
                                                0),
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FinanceText.p16(
                                            'Fecha em',
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                          FinanceText.p16(
                                            formatDate(
                                                cardList[index - 1].close!),
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          FinanceText.p16(
                                            '${formatMoney(cardList[index - 1].availableLimit!)} de ${formatMoney(cardList[index - 1].limit!)}',
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      LinearProgressIndicator(
                                        value: formatValueProgress(
                                            cardList[index - 1].limit!,
                                            cardList[index - 1]
                                                    .availableLimit ??
                                                0),
                                        minHeight: 20,
                                        borderRadius: BorderRadius.circular(15),
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                          AppColors.cherryRed,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      FinanceText.p16(
                                        'Limite Disponível ${formatMoney(disponivel)}',
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
