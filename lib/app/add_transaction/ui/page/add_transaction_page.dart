import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/add_transaction/data/model/add_transaction_model.dart';
import 'package:finance_control/app/add_transaction/ui/bloc/account_bank_bloc.dart';
import 'package:finance_control/app/add_transaction/ui/bloc/add_transaction_bloc.dart';
import 'package:finance_control/app/add_transaction/ui/bloc/card_bloc.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({
    super.key,
    this.add = true,
  });

  final bool add;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  DateTime selectedDate = DateTime.now();

  late ICardBloc cardBloc;
  late IAccountBankBloc accountBankBloc;
  late IAddTransactionBloc transactionsBloc;

  late String category;
  late String paymentMethod;
  late String selectAccount;
  late String selectedCard;
  late String selectedCardId;
  late String user;
  late double value;
  late double installment;

  late TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    cardBloc = Modular.get();
    accountBankBloc = Modular.get();
    transactionsBloc = Modular.get();
    cardBloc.getAccountBank();
    accountBankBloc.getAccountBank();

    category = '';
    paymentMethod = '';
    selectAccount = '';
    selectedCard = '';
    selectedCardId = '';
    user = '';
    value = 0.00;
    installment = 1;
  }

  @override
  void dispose() {
    super.dispose();

    category = '';
    paymentMethod = '';
    selectAccount = '';
    selectedCard = '';
    selectedCardId = '';
    user = '';
    value = 0.00;
    installment = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightSkyBlue,
      appBar: FinanceAppBar(
        title: widget.add == true ? 'Adicionar Receita' : 'Adicionar Despesa',
        color: AppColors.white,
        icon: true,
        onTap: () => Modular.to.pop(),
      ),
      body: Column(
        children: [
          FinanceAddTransactionAppBar(
            onChanged: (p0) {
              setState(() {
                value = p0;
              });
            },
            onPressed: () {},
            color: widget.add == true
                ? AppColors.forestGreen
                : AppColors.cherryRed,
          ),
          Expanded(
            child: Material(
              elevation: 1,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    FinanceTextField(
                      hintText: 'Descrição',
                      controller: description,
                      onChanged: (value) {
                        description.text = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    FinanceDropDown(
                      hint: 'Usuário',
                      svg: 'assets/icons/user.svg',
                      categoriesList: const [],
                      onItemSelected: (userSelect) {
                        setState(() {
                          user = userSelect;
                        });
                      },
                      border: true,
                      elevation: 0,
                    ),
                    if (widget.add) const SizedBox(height: 16),
                    if (widget.add)
                      BlocBuilder(
                        bloc: accountBankBloc,
                        builder: (context, state) {
                          if (state is SuccessState<List<AccountModel>>) {
                            var accounts = state.data;
                            var accountNames =
                                accounts.map((e) => e.bank).toList();

                            return FinanceDropDown(
                              hint: 'Conta',
                              svg: 'assets/icons/bank.svg',
                              categoriesList: accountNames,
                              onItemSelected: (bank) {
                                setState(() {
                                  final bankID = accounts.firstWhere(
                                      (element) => element.bank == bank);
                                  selectedCardId = bankID.id;
                                  selectAccount = bank;
                                });
                              },
                              border: true,
                              elevation: 0,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),

                    const SizedBox(height: 16),
                    FinanceDropDown(
                      hint: 'Categoria',
                      svg: 'assets/icons/category.svg',
                      categoriesList: widget.add == true
                          ? [
                              'Salário',
                              'Renda extra',
                              'Outros',
                            ]
                          : [
                              'Moradia',
                              'Alimentação',
                              'Transporte',
                              'Saúde',
                              'Educação',
                              'Lazer e Entretenimento',
                              'Roupas e Calçados',
                              'Dívidas',
                              'Assinaturas e Serviços',
                              'Impostos',
                              'Cuidados Pessoais',
                              'Despesas de Família',
                              'Outros',
                            ],
                      onItemSelected: (cat) {
                        setState(() {
                          category = cat;
                        });
                      },
                      border: true,
                      elevation: 0,
                    ),
                    const SizedBox(height: 16),
                    if (!widget.add) ...{
                      FinanceDropDown(
                        hint: 'Metodo de pagamento',
                        svg: 'assets/icons/moneys.svg',
                        categoriesList: const [
                          'Dinheiro',
                          'Boleto',
                          'Pix',
                          'Transferencia',
                          'Cartão de debito',
                        ],
                        onItemSelected: (value) {
                          setState(() {
                            paymentMethod = value;
                          });
                        },
                        border: true,
                        elevation: 0,
                      ),
                      const SizedBox(height: 16),
                      if (paymentMethod == 'Cartão de debito' ||
                          paymentMethod == 'Pix' ||
                          paymentMethod == 'Transferencia') ...{
                        BlocBuilder(
                          bloc: accountBankBloc,
                          builder: (context, state) {
                            if (state is SuccessState<List<AccountModel>>) {
                              var accounts = state.data;
                              var accountNames = accounts
                                  .map((account) => account.bank)
                                  .toList();

                              return FinanceDropDown(
                                hint: 'Selecione a conta',
                                svg: 'assets/icons/bank.svg',
                                categoriesList: accountNames,
                                onItemSelected: (bank) {
                                  setState(() {
                                    final bankID = accounts.firstWhere(
                                        (element) => element.bank == bank);
                                    selectedCardId = bankID.id;
                                    selectAccount = bank;
                                  });
                                },
                                border: true,
                                elevation: 0,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      }
                    },
                    const SizedBox(height: 16),
                    // ValueListenableBuilder<List<XFile?>>(
                    //   valueListenable: widget.controller.imagesNotifier,
                    //   builder: (context, images, child) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return AlertDialog(
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(15),
                    //               ),
                    //               actions: [
                    //                 Container(
                    //                   height: 180,
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 20, vertical: 24),
                    //                   child: Column(
                    //                     children: [
                    //                       const Spacer(),
                    //                       Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.spaceAround,
                    //                         children: [
                    //                           GestureDetector(
                    //                             onTap: () async {
                    //                               final XFile? file =
                    //                                   await ImagePicker()
                    //                                       .pickImage(
                    //                                           source:
                    //                                               ImageSource
                    //                                                   .camera);
                    //                               if (file != null) {
                    //                                 widget
                    //                                     .controller
                    //                                     .imagesNotifier
                    //                                     .value = [
                    //                                   ...widget.controller
                    //                                       .imagesNotifier.value,
                    //                                   file
                    //                                 ];
                    //                               }
                    //                             },
                    //                             child: Container(
                    //                               height: 100,
                    //                               width: 100,
                    //                               decoration: BoxDecoration(
                    //                                 color: AppColors.lighterBlue
                    //                                     .withOpacity(0.3),
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         10),
                    //                               ),
                    //                               child: Column(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .center,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .center,
                    //                                 children: [
                    //                                   const Icon(
                    //                                     Icons.camera_alt,
                    //                                     size: 40,
                    //                                     color:
                    //                                         AppColors.royalBlue,
                    //                                   ),
                    //                                   FinanceText.p14('Camera'),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                               widget.controller
                    //                                   .pickImageFromGallery();
                    //                             },
                    //                             child: Container(
                    //                               height: 100,
                    //                               width: 100,
                    //                               decoration: BoxDecoration(
                    //                                 color: AppColors.lighterBlue
                    //                                     .withOpacity(0.3),
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         10),
                    //                               ),
                    //                               child: Column(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .center,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment
                    //                                         .center,
                    //                                 children: [
                    //                                   const Icon(
                    //                                     Icons.image,
                    //                                     size: 40,
                    //                                     color:
                    //                                         AppColors.royalBlue,
                    //                                   ),
                    //                                   FinanceText.p14(
                    //                                       'Galeria'),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       const Spacer(),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             );
                    //           },
                    //         );
                    //       },
                    //       child: DottedBorder(
                    //         color: Colors.grey[300]!,
                    //         borderType: BorderType.RRect,
                    //         radius: const Radius.circular(12),
                    //         padding: const EdgeInsets.all(12),
                    //         child: images.isEmpty
                    //             ? Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 children: [
                    //                   const Icon(
                    //                     Icons.attachment_outlined,
                    //                     color: AppColors.midnightBlack,
                    //                   ),
                    //                   const SizedBox(width: 10),
                    //                   FinanceText.p16(
                    //                     'Comprovante',
                    //                     color: AppColors.midnightBlack,
                    //                   ),
                    //                 ],
                    //               )
                    //             : Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceAround,
                    //                 children: [
                    //                   ...images.take(3).map(
                    //                         (image) => Stack(
                    //                           children: [
                    //                             ClipRRect(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(10),
                    //                               child: Image.file(
                    //                                 File(image!.path),
                    //                                 fit: BoxFit.cover,
                    //                                 width: 80,
                    //                                 height: 80,
                    //                                 errorBuilder:
                    //                                     (BuildContext context,
                    //                                         Object exception,
                    //                                         StackTrace?
                    //                                             stackTrace) {
                    //                                   return const Text(
                    //                                       'Erro ao carregar a imagem');
                    //                                 },
                    //                               ),
                    //                             ),
                    //                             Positioned(
                    //                               top: 0,
                    //                               right: 0,
                    //                               child: GestureDetector(
                    //                                 onTap: () {
                    //                                   setState(() {
                    //                                     images.remove(
                    //                                       image,
                    //                                     );
                    //                                   });
                    //                                 },
                    //                                 child: const Icon(
                    //                                   Icons.delete,
                    //                                   size: 30,
                    //                                   color:
                    //                                       AppColors.cherryRed,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                   if (images.length < 3)
                    //                     Container(
                    //                       height: 80,
                    //                       width: 80,
                    //                       decoration: BoxDecoration(
                    //                         color: AppColors.lighterBlue
                    //                             .withOpacity(0.3),
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       child: const Icon(
                    //                         Icons.add,
                    //                         size: 40,
                    //                         color: AppColors.royalBlue,
                    //                       ),
                    //                     ),
                    //                 ],
                    //               ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: transactionsBloc,
        builder: (context, state) {
          return Container(
            color: AppColors.white,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: FinanceButton(
              title: 'Continuar',
              branded: false,
              disabled: false,
              loading: false,
              onTap: () {
                transactionsBloc.addTransaction(
                  AddTransaction(
                    category: category,
                    add: widget.add,
                    description: description.text,
                    method: paymentMethod,
                    creditCard: selectedCard,
                    cardID: selectedCardId,
                    time: DateTime.now(),
                    value: value,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
