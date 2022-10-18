import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_checkbox_tile.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_input_tag_field.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../../data/models/supplier_model.dart';
import '../../../../logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import '../../widgets/k_date_picker.dart';
import '../../widgets/k_snackbar.dart';
import '../../widgets/k_text_field.dart';

class ManageStockAddingScreen extends StatefulWidget {
  const ManageStockAddingScreen({Key? key}) : super(key: key);

  @override
  State<ManageStockAddingScreen> createState() =>
      _ManageStockAddingScreenState();
}

class _ManageStockAddingScreenState extends State<ManageStockAddingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();
  TextEditingController purchaseRateController = TextEditingController();
  TextEditingController sellingRateController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();

  bool? generateInvoice = false;
  DateTime? invoiceDate;
  List<SupplierModel>? allSuppliers;
  var selectedSupplier;
  int? selectedSupplierId;
  var product;
  List<UnitModel>? units;
  var selectedUnitId;
  List<String>? batches = [];
  DateTime? mfgDate;
  DateTime? expDate;

  var selectedUnitName;
  var productId;
  var referer;

  getSupplierId() {
    selectedSupplierId = allSuppliers
        ?.firstWhere((element) => element.name == selectedSupplier)
        .id;
    print(selectedSupplierId);
  }

  getUnitId() {
    selectedUnitId =
        units?.firstWhere((element) => element.name == selectedUnitName).id;
    print(selectedUnitId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageStocksBloc, ManageStocksState>(
      listener: (context, state) {
        if (state is ManageStockAddedState) {
          invoiceDate = null;
        }
      },
      builder: (context, state) {
        if (state is ManageStockAddedState) {
          invoiceDate = null;
        }
        if (state is ManageStockAddingState) {
          productId = state.productId;
          units = state.units;
        }
        if (state is SuppliersFetchedForAddingStock) {
          allSuppliers = state.suppliers;
        }
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<ManageStocksBloc>(context)
                .add(GoToManageStocksPage());
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text($t('stock.title.add')),
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<ManageStocksBloc>(context)
                      .add(GoToManageStocksPage());
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            body: KPage(
              children: [
                Form(
                  key: _formKey,
                  child: KPageMiddle(
                    isExpanded: true,
                    xPadding: kPaddingX,
                    yPadding: kPaddingY,
                    children: [
                      KTextField(
                        labelText: $t('fields.quantity'),
                        controller: quantityController,
                        isRequired: true,
                        textInputType: TextInputType.number,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.quantity'),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Quantity is required!';
                          }
                          return null;
                        },
                      ),
                      KInputTagField(
                        labelText: $t('fields.batchNo'),
                        isRequired: true,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.batchNo'),
                        onTagsChanged: (newTags) {
                          batches = newTags;
                        },
                      ),
                      KTextField(
                        labelText: $t('fields.purchaseRate'),
                        controller: purchaseRateController,
                        isRequired: true,
                        textInputType: TextInputType.number,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.purchaseRate'),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Purchase Rate is required!';
                          }
                          return null;
                        },
                      ),
                      KTextField(
                        labelText: $t('fields.sellingRate'),
                        controller: sellingRateController,
                        isRequired: true,
                        textInputType: TextInputType.number,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.sellingRate'),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Selling Rate is required!';
                          }
                          return null;
                        },
                      ),
                      KDropdown(
                        labelText: $t('fields.unit'),
                        isRequired: true,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.unitId'),
                        items: units?.map((e) => e.name).toList(),
                        value: selectedUnitName,
                        onChanged: (value) {
                          setState(() {
                            selectedUnitName = value;
                            getUnitId();
                          });
                        },
                      ),
                      KDatePicker(
                        context: context,
                        labelText: $t('fields.mfgDate'),
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.mfgDate'),
                        onDateChange: (newDate) {
                          mfgDate = newDate;
                        },
                      ),
                      KDatePicker(
                        context: context,
                        labelText: $t('fields.expDate'),
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.expDate'),
                        onDateChange: (newDate) {
                          expDate = newDate;
                        },
                      ),
                      KCheckboxTile(
                        label: $t('fields.generateInvoice'),
                        isChecked: generateInvoice,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.add-stock.generateInvoice'),
                        onChanged: (value) {
                          setState(
                            () {
                              generateInvoice = value;

                              if (generateInvoice == true) {
                                BlocProvider.of<ManageStocksBloc>(context)
                                    .add(FetchSuppliersForAddingStock());
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
                                  controller: invoiceNoController,
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) => KDropdown(
                                    hasMargin: false,
                                    labelText: $t('fields.supplier'),
                                    isRequired: true,
                                    items: allSuppliers
                                        ?.map((e) => e.name)
                                        .toList(),
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
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Flexible(
                      child: KFilledButton(
                        text: $t('buttons.cancel'),
                        buttonColor: Colors.grey.shade400,
                        onPressed: () {
                          BlocProvider.of<ManageStocksBloc>(context)
                              .add(GoToManageStocksPage());
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
                          var isValid = _formKey.currentState?.validate();
                          print('expDate $expDate');
                          if (isValid! &&
                              (generateInvoice == false ||
                                  (generateInvoice == true &&
                                      (invoiceDate != null &&
                                          selectedSupplierId != null)))) {
                            BlocProvider.of<ManageStocksBloc>(context)
                                .add(AddStockOnManageStock(
                              productId: productId,
                              generateInvoice: generateInvoice as bool,
                              invoiceNo: invoiceNoController.text,
                              quantity: quantityController.text,
                              supplierId: selectedSupplierId,
                              date: invoiceDate?.toIso8601String(),
                              batches: batches,
                              expDate: expDate != null
                                  ? expDate?.toIso8601String()
                                  : '',
                              // ignore: prefer_null_aware_operators
                              mfgDate: mfgDate != null
                                  ? mfgDate?.toIso8601String()
                                  : null,
                              purchaseRate: purchaseRateController.text,
                              sellingRate: sellingRateController.text,
                              unitId: selectedUnitId,
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
