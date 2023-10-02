import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
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
  final ValueNotifier<List<dynamic>> categoriesList =
      ValueNotifier<List<dynamic>>([
    "Conta corrente",
    "Conta poupança",
    "Conta empresarial",
  ]);

  @override
  void initState() {
    super.initState();
    widget.controller.getUsersInHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      appBar: FinanceAppBar(
        title: 'Contas e Cartões',
        icon: true,
        onTap: () => Modular.to.pop(),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 35,
                crossAxisSpacing: 35,
                childAspectRatio: 1.0,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(25),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FinanceText.h4(
                                  'Nova conta',
                                  fontWeight: FontWeight.w500,
                                ),
                                IconButton(
                                  onPressed: () => Modular.to.pop(),
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
                                  textAlign: TextAlign.center,
                                  initialValue: 'R\$ 0,00',
                                  style: const TextStyle(
                                    fontSize: 50,
                                    color: AppColors.deepBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  inputFormatters: [
                                    CurrencyTextInputFormatter(
                                      locale: 'pt-br',
                                      decimalDigits: 2,
                                      symbol: 'R\$',
                                    ),
                                  ],
                                  onChanged: (value) {},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'R\$ 0,00',
                                    hintStyle: TextStyle(
                                      fontSize: 50,
                                      color: AppColors.deepBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 24),
                                const FinanceTextField(
                                  hintText: 'Instituição financeira',
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                                const SizedBox(height: 16),
                                FinanceDropDown(
                                  hint: "Tipo de conta",
                                  categoriesList: categoriesList,
                                  onItemSelected: (String) {},
                                ),
                                FinanceDropDown(
                                  hint: "Selecione o proprietário",
                                  categoriesList: widget.controller.users,
                                  onItemSelected: (p0) {
                                    widget.controller.usersString.value = p0;
                                  },
                                ),
                                const SizedBox(height: 24),
                                const FinanceButton(
                                  title: 'Salvar',
                                ),
                              ],
                            ),
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
                            selectedTabIndex == 0 ? 'Add Conta' : 'Add Cartão',
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
