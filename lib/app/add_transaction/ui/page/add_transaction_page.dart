import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:finance_control/app/add_transaction/ui/controller/add_transaction_controller.dart';
import 'package:finance_control/core/ds/components/app_bar/finance_add_transaction_app_bar.dart';
import 'package:finance_control/core/ds/components/buttons/button.dart';
import 'package:finance_control/core/ds/components/drop_down/finance_drop_down.dart';
import 'package:finance_control/core/ds/components/text_field/finance_text_field.dart';
import 'package:finance_control/core/ds/style/afinz_text.dart';
import 'package:finance_control/core/ds/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
                    FinanceTextField(
                      hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
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
                    GestureDetector(
                      onTap: () {
                        widget.controller.requestGalleryPermission();
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
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
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
                                      ValueListenableBuilder<XFile?>(
                                        valueListenable: widget
                                            .controller.selectedImageNotifier,
                                        builder: (context, image, child) {
                                          return GestureDetector(
                                            onTap: widget.controller
                                                .pickImageFromGallery,
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
                                                  if (image == null)
                                                    const Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color:
                                                          AppColors.royalBlue,
                                                    )
                                                  else
                                                    Image.file(File(image.path),
                                                        fit: BoxFit.cover),
                                                  if (image == null)
                                                    const Text('Galeria'),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ),
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
