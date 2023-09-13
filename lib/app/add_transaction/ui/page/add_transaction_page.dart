import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_controller.dart';
import 'package:finance_control/core/ds/components/app_bar/finance_add_transaction_app_bar.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/drop_down/finance_drop_down.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/ds/style/afinz_text.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({
    super.key,
    required this.controller,
  });

  final AddTransactionController controller;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  late String price;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    price = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: Column(
        children: [
          const FinanceAddTransactionAppBar(),
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
                    const SizedBox(height: 16),
                    const FinanceDropDown(
                      hint: 'Categoria',
                      items: [
                        'Item 1',
                        'Item 2',
                        'Item 3',
                        'Item 4',
                        'Item 5',
                        'Item 6',
                        'Item 7',
                        'Item 8',
                        'Item 9',
                        'Item 10',
                      ],
                    ),
                    const SizedBox(height: 16),
                    const FinanceDropDown(
                      hint: 'Forma de pagamento',
                      itemColors: [
                        Colors.green,
                        Colors.red,
                        Colors.blue,
                        Colors.yellow
                      ],
                      items: [
                        'Dinheiro',
                        'Pix',
                        'Cartão de crédito',
                        'Cartão de débito',
                      ],
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
                            selectedDate = pickedDate;
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
                          DateFormat('dd/MM/yyyy').format(selectedDate),
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                    const SizedBox(height: 16),
                    const FinanceTextField(
                      hintText: 'Descrição',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<List<XFile?>>(
                      valueListenable: widget.controller
                          .imagesNotifier, // Atualizado para imagesNotifier
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
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.image,
                                                    size: 40,
                                                    color: AppColors.royalBlue,
                                                  ),
                                                  Text('Galeria'),
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
                                                            image); // Remove a imagem da lista
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
        padding: const EdgeInsets.all(20),
        child: FinanceButton(
          title: 'Continuar',
          branded: false,
          disabled: false,
          loading: false,
          onTap: () {},
        ),
      ),
    );
  }
}
