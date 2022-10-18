import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/category_model.dart';
import 'package:sozashop_app/data/models/purchase_invoice_model.dart';
import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_Icon_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_picker.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_input_tag_field.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_multi_select.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_switch_tile.dart';

import '../../../data/models/unit_model.dart';
import '../widgets/k_button.dart';
import '../widgets/k_date_picker.dart';
import '../widgets/k_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  // add category form datas
  TextEditingController newCatNameController = TextEditingController();
  TextEditingController newCatDescController = TextEditingController();

  // add unit form datas
  TextEditingController newUnitNameController = TextEditingController();

  // add new supplier form datas
  TextEditingController newSupplierNameController = TextEditingController();
  TextEditingController newSupplierMobileController = TextEditingController();
  TextEditingController newSupplierTelephoneController =
      TextEditingController();
  TextEditingController newSupplierEmailController = TextEditingController();
  TextEditingController newSupplierFaxController = TextEditingController();
  TextEditingController newSupplierVatNumberController =
      TextEditingController();
  TextEditingController newSupplierOpeningBalanceController =
      TextEditingController();
  String? newSupplierSelectedStatus;
  List<String> newSupplierAllStatus = ["Active", "Inactive"];

  // form datas
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController storeInController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController purchaseRateController = TextEditingController();
  TextEditingController sellingRateController = TextEditingController();
  TextEditingController openingQuantityController = TextEditingController();
  TextEditingController alertQuantityController = TextEditingController();
  DateTime? mfgDate;
  DateTime? expDate;
  DateTime? invoiceDate;
  var selectedCategoryId;
  var selectedUnitId;
  List<String>? batches = [];
  List<int>? selectedPurchaseUnitIds = [];
  List<int>? selectedSellingUnitIds = [];
  File? selectedPhoto;
  bool? generateInvoice = false;
  var selectedInvoiceNo;
  var selectedSupplierId;

  // supporting datas
  List<CategoryModel>? categories;
  List<UnitModel>? units;
  List<UnitConversionModel>? allPurchaseUnitConversions = [];
  List<UnitConversionModel>? allSellingUnitConversions = [];
  List selectedPurchaseUnits = [];
  List selectedSellingUnits = [];
  var selectedUnit;
  var selectedCategory;
  List<SupplierModel>? allSuppliers;
  var selectedSupplier;
  List<PurchaseInvoiceModel>? allInvoices;
  var selectedInvoice;

  bool? hasBatches;

  getSimpleItems(List<dynamic>? items) {
    return items
        ?.map((e) => SimpleMultiSelectItemModel(id: e.unitId, name: e.unitName))
        .toList();
  }

  getUnitId() {
    selectedUnitId =
        units?.firstWhere((element) => element.name == selectedUnit).id;
    print(selectedUnitId);
  }

  getPurchaseUnitsId() {
    var trimmedList =
        selectedPurchaseUnits.map((e) => e.toString().trim()).toList();

    selectedPurchaseUnitIds = allPurchaseUnitConversions
        ?.where((e) => trimmedList.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();
    print('selectedPurchaseUnitIds $selectedPurchaseUnitIds');
  }

  getSellingUnitsId() {
    var trimmedList =
        selectedSellingUnits.map((e) => e.toString().trim()).toList();

    selectedSellingUnitIds = allSellingUnitConversions
        ?.where((e) => trimmedList.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();

    print('selectedSellingUnitIds $selectedSellingUnitIds');
  }

  getCategoryId() {
    selectedCategoryId = categories
        ?.firstWhere((element) => element.name == selectedCategory)
        .id;
    print(selectedCategoryId);
  }

  getSupplierId() {
    allInvoices?.clear();
    selectedSupplierId = allSuppliers
        ?.firstWhere((element) => element.name == selectedSupplier)
        .id;
    print(selectedSupplierId);
  }

  getInvoiceId() {
    selectedInvoiceNo = allInvoices
        ?.firstWhere((element) => element.invoiceNo == selectedInvoice)
        .id;
    print(selectedInvoiceNo);
  }

  @override
  Widget build(BuildContext context) {
    // formContent of new supplier modal
    List<Widget> newSupplierFormContents = [
      KTextField(
        labelText: $t('fields.name'),
        controller: newSupplierNameController,
        isRequired: true,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return 'Supplier name is required!';
          }
          return null;
        },
      ),
      KTextField(
        labelText: $t('fields.mobile'),
        controller: newSupplierMobileController,
        isRequired: true,
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return 'Mobile is required!';
          }
          return null;
        },
      ),
      KTextField(
        labelText: $t('fields.telephone'),
        controller: newSupplierTelephoneController,
        textInputType: TextInputType.phone,
        hasPermission:
            Permissions.hasFieldPermission('suppliers.add-suppliers.telephone'),
      ),
      KTextField(
        labelText: $t('fields.email'),
        textInputType: TextInputType.emailAddress,
        controller: newSupplierEmailController,
      ),
      KTextField(
        labelText: $t('fields.fax'),
        controller: newSupplierFaxController,
        hasPermission:
            Permissions.hasFieldPermission('suppliers.add-suppliers.fax'),
      ),
      KTextField(
        labelText: $t('fields.vatNumber'),
        controller: newSupplierVatNumberController,
        hasPermission: Permissions.hasFieldPermission(
            'suppliers.add-suppliers.vat-number'),
      ),
      KTextField(
        labelText: $t('fields.openingBalance'),
        controller: newSupplierOpeningBalanceController,
        textInputType: TextInputType.number,
      ),
      StatefulBuilder(
        builder: (context, setState) => KDropdown(
          labelText: $t('fields.status'),
          hasPermission:
              Permissions.hasFieldPermission('suppliers.add-suppliers.status'),
          value: newSupplierSelectedStatus,
          items: newSupplierAllStatus,
          onChanged: (value) {
            setState(() {
              newSupplierSelectedStatus = value as String?;
            });
          },
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ProductBloc>(context)
          ..add(GoTOAllProductsPage())
          ..add(FetchProducts());
        Navigator.pushNamed(context, AppRouter.productsScreen);
        return false;
      },
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is NewCategoryAddedState) {
            newCatNameController.clear();
            newCatDescController.clear();
            Navigator.pop(context);

            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Category Added Successfully!",
            );
          }
          if (state is NewUnitAddedState) {
            newUnitNameController.clear();
            Navigator.pop(context);

            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Unit Added Successfully!",
            );
          }
          if (state is ProductAddedState) {
            Navigator.pushNamed(context, AppRouter.productsScreen);

            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Product Added Successfully!",
            );
          }
          if (state is NewSupplierAddedState) {
            newSupplierMobileController.clear();
            newSupplierFaxController.clear();
            newSupplierEmailController.clear();
            newSupplierNameController.clear();
            newSupplierOpeningBalanceController.clear();
            newSupplierSelectedStatus = null;
            newSupplierTelephoneController.clear();
            newSupplierVatNumberController.clear();

            Navigator.pop(context);

            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Supplier Added Successfully!",
            );
          }
          if (state is SuppliersFetched) {
            allSuppliers = state.suppliers;
          }
          if (state is SupplierInvoicesFetched) {
            allInvoices = state.invoices;
          }
          if (state is ProductAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is NewCategoryAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is NewUnitAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is NewSupplierAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text($t('products.title.add')),
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<ProductBloc>(context)
                    ..add(GoTOAllProductsPage())
                    ..add(FetchProducts());
                  Navigator.pushNamed(context, AppRouter.productsScreen);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductAddingState) {
                categories = state.categories;
                units = state.units;

                // demo data
                // nameController.text = 'textfield_tags: 2.0.0';
                // codeController.text = 'It Works!!';
                // storeInController.text = 'product storeIn';
                // sizeController.text = '54';
                // purchaseRateController.text = '25567';
                // sellingRateController.text = '35567';
                // openingQuantityController.text = '12056';
              }
              if (state is NewCategoryAddedState) {
                categories = state.categories;
              }
              if (state is NewUnitAddedState) {
                units = state.units;
              }
              if (state is NewSupplierAddedState) {
                allSuppliers = state.suppliers;
              }
              if (state is UnitConversionsFetched) {
                allPurchaseUnitConversions = state.unitConversions;
                allSellingUnitConversions = state.unitConversions;
              }
              if (state is LoadingState) {
                return const Center(
                  child: KLoadingIcon(),
                );
              }
              return Form(
                key: _formKey,
                child: KPage(
                  children: [
                    KPageMiddle(
                      controller: _scrollController,
                      xPadding: 15.w,
                      yPadding: 15.h,
                      children: [
                        // const KTagField(),
                        KTextField(
                          labelText: $t('fields.name'),
                          controller: nameController,
                          isRequired: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Product name is required!';
                            }
                            return null;
                          },
                        ),
                        KTextField(
                          labelText: $t('fields.code'),
                          controller: codeController,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.code'),
                        ),

                        KTextField(
                          labelText: $t('fields.storeIn'),
                          controller: storeInController,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.store-in'),
                        ),
                        KTextField(
                          labelText: $t('fields.size'),
                          controller: sizeController,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.size'),
                        ),
                        KTextField(
                          labelText: $t('fields.color'),
                          controller: colorController,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.color'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: KDropdown(
                                  hasMargin: false,
                                  labelText: $t('fields.category'),
                                  isRequired: true,
                                  items:
                                      categories?.map((e) => e.name).toList(),
                                  value: selectedCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                      getCategoryId();
                                      // print(selectedOperator);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 8.w),
                              KIconButton(onPressed: () {
                                KDialog(
                                  context: context,
                                  title: $t('categories.title.add'),
                                  yesButtonText: 'Submit',
                                  yesButtonColor: KColors.primary,
                                  noButtonText: 'Close',
                                  noButtonColor: Colors.grey.shade400,
                                  dialogType: DialogType.form,
                                  formContent: [
                                    KTextField(
                                      labelText: $t('fields.name'),
                                      isRequired: true,
                                      controller: newCatNameController,
                                    ),
                                    KTextField(
                                      labelText: $t('fields.description'),
                                      maxLines: 5,
                                      controller: newCatDescController,
                                      textInputType: TextInputType.multiline,
                                      inputAction: TextInputAction.newline,
                                      hasPermission: Permissions.hasFieldPermission(
                                          'categories.add-category.description'),
                                    ),
                                  ],
                                  yesBtnPressed: () {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(AddNewCategory(
                                      name: newCatNameController.text,
                                      description: newCatDescController.text,
                                    ));
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        KInputTagField(
                          labelText: $t('fields.batchNo'),
                          hintText: 'Enter Your Batch/Serial/IME/SKU',
                          isRequired: true,
                          onTagsChanged: (tags) {
                            batches = tags;
                          },
                        ),
                        KTextField(
                          labelText: $t('fields.brand'),
                          controller: brandController,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.brand'),
                        ),
                        KTextField(
                          labelText: $t('fields.purchaseRate'),
                          controller: purchaseRateController,
                          isRequired: true,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Purchase rate is required!';
                            }
                            return null;
                          },
                        ),
                        KTextField(
                          labelText: $t('fields.sellingRate'),
                          controller: sellingRateController,
                          textInputType: TextInputType.number,
                          isRequired: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Selling rate is required!';
                            }
                            return null;
                          },
                        ),
                        KTextField(
                          labelText: $t('fields.openingQuantity'),
                          controller: openingQuantityController,
                          textInputType: TextInputType.number,
                          isRequired: true,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Opening quantity is required!';
                            }
                            return null;
                          },
                        ),
                        KTextField(
                          labelText: $t('fields.alertQuantity'),
                          controller: alertQuantityController,
                          textInputType: TextInputType.number,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.alert-quantity'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: KDropdown(
                                  hasMargin: false,
                                  labelText: $t('fields.unit'),
                                  isRequired: true,
                                  items: units?.map((e) => e.name).toList(),
                                  value: selectedUnit,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedUnit = value;
                                      getUnitId();
                                      selectedPurchaseUnits.clear();
                                      selectedSellingUnits.clear();
                                      BlocProvider.of<ProductBloc>(context)
                                          .add(FetchUnitConversions(
                                        baseUnitId: selectedUnitId,
                                      ));
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 8.w),
                              KIconButton(onPressed: () {
                                KDialog(
                                  context: context,
                                  title: $t('unit.title.add'),
                                  dialogType: DialogType.form,
                                  formContent: [
                                    KTextField(
                                      labelText: $t('fields.unit'),
                                      isRequired: true,
                                      controller: newUnitNameController,
                                    ),
                                  ],
                                  yesBtnPressed: () {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(AddNewUnit(
                                      unitName: newUnitNameController.text,
                                    ));
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        KMultiSelect(
                          context: context,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.purchase-units'),
                          labelText: $t('fields.purchaseUnits'),
                          // items: getSimpleItems(allPurchaseUnitConversions),
                          items: allPurchaseUnitConversions!
                              .map((e) => '${e.unitName} ')
                              .toList(),
                          selectedItems: selectedPurchaseUnits,
                          onConfirmed: (value) {
                            setState(() {
                              selectedPurchaseUnits = value;
                              getPurchaseUnitsId();
                            });
                          },
                          onItemTap: (value) {
                            setState(() {
                              selectedPurchaseUnits.remove(value);
                              print(selectedPurchaseUnits);
                              getPurchaseUnitsId();
                            });
                          },
                        ),
                        KMultiSelect(
                          context: context,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.selling-units'),
                          labelText: $t('fields.sellingUnits'),
                          items: allSellingUnitConversions!
                              .map((e) => e.unitName)
                              .toList(),
                          selectedItems: selectedSellingUnits,
                          onConfirmed: (value) {
                            setState(() {
                              selectedSellingUnits = value;
                              getSellingUnitsId();
                              print(selectedSellingUnits);
                            });
                          },
                          onItemTap: (value) {
                            setState(() {
                              selectedSellingUnits.remove(value);
                              getSellingUnitsId();
                            });
                          },
                        ),
                        KDatePicker(
                          context: context,
                          labelText: $t('fields.mfgDate'),
                          onDateChange: (value) {
                            mfgDate = value;
                          },
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.manufacture-date'),
                        ),
                        KDatePicker(
                          context: context,
                          labelText: $t('fields.expDate'),
                          onDateChange: (value) {
                            expDate = value;
                          },
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.expire-date'),
                        ),
                        KImagePicker(
                          context: context,
                          labelText: $t('fields.productImage'),
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.product-image'),
                          selectedImage: selectedPhoto,
                          onImageSelect: (value) {
                            setState(() {
                              selectedPhoto = value;
                            });
                          },
                        ),

                        KSwitchTile(
                          label: $t('fields.generateInvoice'),
                          isChecked: generateInvoice!,
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.generate-invoice'),
                          onChanged: (value) {
                            setState(() {
                              generateInvoice = value;

                              if (generateInvoice == true) {
                                BlocProvider.of<ProductBloc>(context)
                                    .add(FetchSuppliers());

                                var maxScrl = _scrollController.offset +
                                    _scrollController.position.maxScrollExtent;
                                print(maxScrl);

                                _scrollController.animateTo(
                                  maxScrl,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.linear,
                                );
                              }
                            });
                          },
                        ),

                        generateInvoice == true
                            ? Column(
                                children: [
                                  // date
                                  KDatePicker(
                                    context: context,
                                    labelText: $t('fields.date'),
                                    onDateChange: (value) {
                                      invoiceDate = value;
                                    },
                                    hasPermission:
                                        Permissions.hasFieldPermission(
                                            'products.add-product.date'),
                                  ),

                                  // supplier
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: KDropdown(
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
                                                BlocProvider.of<ProductBloc>(
                                                        context)
                                                    .add(FetchSupplierInvoices(
                                                        supplierId:
                                                            selectedSupplierId));
                                                // print(selectedOperator);
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        KIconButton(onPressed: () {
                                          KDialog(
                                            context: context,
                                            title: $t('suppliers.title.add'),
                                            yesButtonText: 'Submit',
                                            yesButtonColor: KColors.primary,
                                            noButtonText: 'Close',
                                            noButtonColor: Colors.grey.shade400,
                                            dialogType: DialogType.form,
                                            formContent:
                                                newSupplierFormContents,
                                            yesBtnPressed: () {
                                              BlocProvider.of<ProductBloc>(
                                                      context)
                                                  .add(
                                                AddNewSupplier(
                                                  mobile:
                                                      newSupplierMobileController
                                                          .text,
                                                  fax: newSupplierFaxController
                                                      .text,
                                                  mail:
                                                      newSupplierEmailController
                                                          .text,
                                                  name:
                                                      newSupplierNameController
                                                          .text,
                                                  openingBalance:
                                                      newSupplierOpeningBalanceController
                                                          .text,
                                                  status:
                                                      newSupplierSelectedStatus
                                                          ?.toLowerCase(),
                                                  telephone:
                                                      newSupplierTelephoneController
                                                          .text,
                                                  vatNumber:
                                                      newSupplierVatNumberController
                                                          .text,
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ),

                                  // invoices
                                  KDropdown(
                                    hasMargin: false,
                                    labelText: $t('fields.invoiceNo'),
                                    hasPermission:
                                        Permissions.hasFieldPermission(
                                            'products.add-product.invoice-no'),
                                    items: allInvoices
                                        ?.map((e) => e.invoiceNo)
                                        .toList(),
                                    value: selectedInvoice,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedInvoice = value;
                                        getInvoiceId();
                                      });
                                    },
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    KPageButtonsRow(
                      marginTop: 15.h,
                      buttons: [
                        Expanded(
                          child: (state is ButtonLoadingState)
                              ? KFilledButton.iconText(
                                  leading: const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                  text: 'Loading...',
                                  onPressed: () {})
                              : KFilledButton(
                                  text: $t('buttons.submit'),
                                  onPressed: () async {
                                    var isValid =
                                        _formKey.currentState!.validate();
                                    print(
                                        'invoiceDate ${invoiceDate?.toIso8601String()}');

                                    if (isValid) {
                                      BlocProvider.of<ProductBloc>(context)
                                          .add(AddProduct(
                                        name: nameController.text,
                                        categoryId: selectedCategoryId,
                                        // batches: batchController.text,
                                        batches: batches,
                                        purchaseRate:
                                            purchaseRateController.text,
                                        sellingRate: sellingRateController.text,
                                        openingQuantity:
                                            openingQuantityController.text,
                                        unitId: selectedUnitId,
                                        alertQuantity:
                                            alertQuantityController.text,
                                        brand: brandController.text,
                                        code: codeController.text,
                                        color: codeController.text,
                                        expDate: expDate,
                                        mfgDate: mfgDate,
                                        purchaseUnits: selectedPurchaseUnitIds,
                                        sellingUnits: selectedSellingUnitIds,
                                        size: sizeController.text,
                                        storeIn: storeInController.text,
                                        generateInvoice: generateInvoice,
                                        invoiceDate: invoiceDate,
                                        supplierId: selectedSupplierId,
                                        invoiceNo: selectedInvoiceNo,
                                        photo: selectedPhoto,
                                      ));

                                      print(
                                          'purchaseUnits $selectedPurchaseUnitIds');
                                      print(
                                          'sellingUnits $selectedSellingUnitIds');
                                    } else {
                                      KSnackBar(
                                        context: context,
                                        type: AlertType.failed,
                                        message:
                                            'Please add all the required fields!',
                                      );
                                    }
                                  },
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
