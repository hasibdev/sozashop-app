import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_checkbox_tile.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../data/models/supplier_model.dart';
import '../widgets/k_date_picker.dart';
import '../widgets/k_snackbar.dart';
import '../widgets/k_text_field.dart';

class AddBatchStockScreen extends StatefulWidget {
  const AddBatchStockScreen({Key? key}) : super(key: key);

  @override
  State<AddBatchStockScreen> createState() => _AddBatchStockScreenState();
}

class _AddBatchStockScreenState extends State<AddBatchStockScreen> {
  TextEditingController addQuantityController = TextEditingController();

  TextEditingController invoiceController = TextEditingController();

  bool? generateInvoice = false;
  DateTime? invoiceDate;
  List<SupplierModel>? allSuppliers;
  var selectedSupplier;
  int? selectedSupplierId;
  var product;
  BatchModel? batch;
  var referer;

  getSupplierId() {
    selectedSupplierId = allSuppliers
        ?.firstWhere((element) => element.name == selectedSupplier)
        .id;
    print(selectedSupplierId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is StockAddedState) {
          invoiceDate = null;
        }
      },
      builder: (context, state) {
        if (state is StockAddedState) {
          invoiceDate = null;
        }
        if (state is StockAddingState) {
          product = state.batchModel.product;
          batch = state.batchModel;
        }
        if (state is SuppliersFetchedForStock) {
          allSuppliers = state.suppliers;
        }
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<ProductBloc>(context)
                .add(GoProductDetailPage(productModel: product));
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text($t('stock.title.add')),
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(GoProductDetailPage(productModel: product));
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            body: KPage(
              children: [
                KPageMiddle(
                  isExpanded: true,
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    KTextField(
                      labelText: $t('fields.quantity'),
                      controller: addQuantityController,
                      isRequired: true,
                      textInputType: TextInputType.number,
                    ),
                    KCheckboxTile(
                      label: $t('fields.generateInvoice'),
                      isChecked: generateInvoice,
                      onChanged: (value) {
                        setState(
                          () {
                            generateInvoice = value;

                            if (generateInvoice == true) {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(FetchSuppliersForStock());
                            }
                          },
                        );
                      },
                    ),
                    generateInvoice == true
                        ? Column(
                            children: [
                              KDatePicker(
                                context: context,
                                labelText: $t('fields.date'),
                                isRequired: true,
                                onDateChange: (value) {
                                  invoiceDate = value;
                                },
                              ),
                              KTextField(
                                labelText: $t('fields.invoiceNo'),
                                controller: invoiceController,
                              ),
                              StatefulBuilder(
                                builder: (context, setState) => KDropdown(
                                  hasMargin: false,
                                  labelText: $t('fields.supplier'),
                                  isRequired: true,
                                  items:
                                      allSuppliers?.map((e) => e.name).toList(),
                                  value: selectedSupplier,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSupplier = value;
                                      getSupplierId();
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Flexible(
                      child: KFilledButton(
                        text: $t('buttons.cancel'),
                        buttonColor: Colors.grey.shade400,
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context).add(
                              const GoProductDetailPage()
                                  .copyWith(productModel: product));
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 2,
                      child: KFilledButton(
                        text: $t('buttons.submit'),
                        onPressed: () {
                          print(invoiceDate);

                          if (generateInvoice == false ||
                              (generateInvoice == true &&
                                  (invoiceDate != null &&
                                      selectedSupplierId != null))) {
                            BlocProvider.of<ProductBloc>(context)
                                .add(AddBatchStock(
                              batchId: batch!.id,
                              productId: product.id,
                              generateInvoice: generateInvoice as bool,
                              invoiceNo: invoiceController.text,
                              quantity: addQuantityController.text,
                              supplierId: selectedSupplierId,
                              date: invoiceDate?.toIso8601String(),
                              batchModel: batch!,
                            ));
                          } else {
                            KSnackBar(
                              context: context,
                              type: AlertType.failed,
                              message: 'Please add the required fields!',
                              durationSeconds: 4,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
