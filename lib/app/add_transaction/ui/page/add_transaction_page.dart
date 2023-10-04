import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({
    super.key,
    required this.controller,
    required this.add,
  });

  final AddTransactionController controller;
  final bool add;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  late String price;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.controller.fetchCategories();
    widget.controller.fetchPayments();
    widget.controller.getAccountBanks();
    price = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: Column(
        children: [
          FinanceAddTransactionAppBar(
            onChanged: (p0) {
              widget.controller.pay.value = double.parse(p0.toString());
            },
            onPressed: () {
              Modular.to.pop();
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FinanceTextField(
                      hintText: 'Descrição',
                      maxLines: 1,
                      controller: widget.controller.description.value,
                      onChanged: (p0) {
                        widget.controller.description.value.text = p0;
                      },
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    FinanceDropDown(
                      hint: 'Conta',
                      categoriesList: widget.controller.accountList,
                      onItemSelected: (p0) {
                        widget.controller.bank.value = p0;
                      },
                    ),
                    Visibility(
                      visible: !widget.add,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          FinanceDropDown(
                            hint: "Selecione uma categoria",
                            categoriesList: widget.controller.categoriesList,
                            onItemSelected: (p0) {
                              widget.controller.categoriesValue.value = p0;
                            },
                          ),
                          const SizedBox(height: 16),
                          FinanceDropDown(
                              hint: 'Forma de pagamento',
                              categoriesList: widget.controller.paymentsList,
                              onItemSelected: (p0) {
                                widget.controller.paymentsValue.value = p0;
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
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
                            widget.controller.date.value = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey[200]!,
                          ),
                        ),
                        child: FinanceText.p16(
                          DateFormat('dd/MM/yyyy')
                              .format(widget.controller.date.value),
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<List<XFile?>>(
                      valueListenable: widget.controller.imagesNotifier,
                      builder: (context, images, child) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(32),
                                ),
                              ),
                              builder: (context) {
                                return Container(
                                  height: 180,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 24),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 4,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.slateGray,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final XFile? file =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (file != null) {
                                                widget.controller.imagesNotifier
                                                    .value = [
                                                  ...widget.controller
                                                      .imagesNotifier.value,
                                                  file
                                                ];
                                              }
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: AppColors.lighterBlue
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.camera_alt,
                                                    size: 40,
                                                    color: AppColors.royalBlue,
                                                  ),
                                                  FinanceText.p14('Camera'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              widget.controller
                                                  .pickImageFromGallery();
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: AppColors.lighterBlue
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.image,
                                                    size: 40,
                                                    color: AppColors.royalBlue,
                                                  ),
                                                  FinanceText.p14('Galeria'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: DottedBorder(
                            color: const Color(0xFFF1F1FA),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(12),
                            child: images.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.attachment_outlined,
                                        color: AppColors.slateGray,
                                      ),
                                      const SizedBox(width: 10),
                                      FinanceText.p16(
                                        'Comprovante',
                                        color: AppColors.slateGray,
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ...images.take(3).map(
                                            (image) => Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    File(image!.path),
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 80,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return const Text(
                                                          'Erro ao carregar a imagem');
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        images.remove(
                                                          image,
                                                        );
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 30,
                                                      color:
                                                          AppColors.cherryRed,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      if (images.length < 3)
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: AppColors.lighterBlue
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            size: 40,
                                            color: AppColors.royalBlue,
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: FinanceButton(
          title: 'Continuar',
          branded: false,
          disabled: false,
          loading: false,
          onTap: () {
            widget.controller.addTransaction(
              add: widget.add,
              categoria: widget.controller.categoriesValue.value,
              payments: widget.controller.paymentsValue.value,
              data: widget.controller.date.value,
              descricao: widget.controller.description.value.text,
              valor: widget.controller.pay.value,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.forestGreen,
                content: Text('Lançamento adicionado'),
              ),
            );
            // Modular.to.pushReplacementNamed('/home/');
          },
        ),
      ),
    );
  }
}
