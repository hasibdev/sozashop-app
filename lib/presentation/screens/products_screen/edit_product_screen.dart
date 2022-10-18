import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_multi_select.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/purchase_invoice_model.dart';
import '../../../data/models/supplier_model.dart';
import '../../../data/models/unit_model.dart';
import '../../../logic/bloc/product_bloc/product_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_button.dart';
import '../widgets/k_image_picker.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // form datas
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController storeInController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  var selectedCategoryId;
  var selectedUnitId;
  List batches = [];

  List<int>? selectedPurchaseUnitIds = [];
  List<int>? selectedSellingUnitIds = [];
  File? selectedPhoto;
  bool? generateInvoice = false;
  var selectedInvoiceNo;
  var selectedSupplierId;
  int? productId;

  // supporting datas
  List<CategoryModel>? categories;
  List<UnitModel>? units;
  List<UnitConversionModel>? allPurchaseUnitConversions = [];
  List<UnitConversionModel>? allSellingUnitConversions = [];
  List? selectedPurchaseUnits = [];
  List? selectedSellingUnits = [];
  var selectedUnit;
  var selectedCategory;
  List<SupplierModel>? allSuppliers;
  var selectedSupplier;
  List<PurchaseInvoiceModel>? allInvoices;
  var selectedInvoice;

  var selectedStatus;
  List<String> allStatus = ["active", "inactive"];
  String? stateStatus;
  var stateCategoryId;
  var stateCategoryName;
  var stateUnitId;
  var stateUnitName;
  List? statePurchaseUnits;
  List? stateSelectedPurchaseUnits;
  List? stateSellingUnits;
  List? stateSelectedSellingUnits;
  List<int>? statePurchaseUnitIds = [];
  List<int>? stateSellingUnitIds = [];
  var statePhoto;
  var stateAlertQuantity;

  getUnitId() {
    selectedUnitId =
        units?.firstWhere((element) => element.name == selectedUnit).id;
    print(selectedUnitId);
  }

  getCategoryId() {
    selectedCategoryId = categories
        ?.firstWhere((element) => element.name == selectedCategory)
        .id;
    print(selectedCategoryId);
  }

  getUnitName() {
    stateUnitName =
        units?.firstWhere((element) => element.id == stateUnitId).name;
    print(selectedUnit);
  }

  getCategoryName() {
    stateCategoryName =
        categories?.firstWhere((element) => element.id == stateCategoryId).name;
    print(selectedCategory);
  }

  getStatePurchaseUnitsId() {
    statePurchaseUnitIds = allPurchaseUnitConversions
        ?.where((e) => stateSelectedPurchaseUnits!.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();
    print('statePurchaseUnitIds $statePurchaseUnitIds');
  }

  getStateSellingUnitsId() {
    stateSellingUnitIds = allSellingUnitConversions
        ?.where((e) => stateSelectedSellingUnits!.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();
    print('stateSellingUnitIds $stateSellingUnitIds');
  }

  getPurchaseUnitsId() {
    var trimmedList =
        selectedPurchaseUnits?.map((e) => e.toString().trim()).toList();

    selectedPurchaseUnitIds = allPurchaseUnitConversions
        ?.where((e) => trimmedList!.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();
    print('selectedPurchaseUnitIds $selectedPurchaseUnitIds');
  }

  getSellingUnitsId() {
    var trimmedList =
        selectedSellingUnits?.map((e) => e.toString().trim()).toList();

    selectedSellingUnitIds = allSellingUnitConversions
        ?.where((e) => trimmedList!.contains(e.unitName))
        .map((obj) => obj.unitId)
        .toSet()
        .toList();

    print('selectedSellingUnitIds $selectedSellingUnitIds');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ProductBloc>(context)
          ..add(GoTOAllProductsPage())
          ..add(FetchProducts());
        return false;
      },
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductEditingState) {
            categories = state.categories;
            units = state.units;
            allPurchaseUnitConversions = state.unitConversions;
            allSellingUnitConversions = state.unitConversions;

            productId = state.productId;
            nameController.text = state.name;
            codeController.text = state.code;
            storeInController.text = state.storeIn;
            sizeController.text = state.size;
            colorController.text = state.color;
            brandController.text = state.brand;
            stateCategoryId = state.categoryId;
            stateUnitId = state.unitId;
            stateStatus = state.status;
            statePhoto = state.photo;
            stateAlertQuantity = state.alertQuantity;

            // set units from state
            statePurchaseUnits = state.purchaseUnits;
            stateSellingUnits = state.purchaseUnits;
            stateSelectedPurchaseUnits =
                statePurchaseUnits?.map((e) => e.name).toList();
            stateSelectedSellingUnits =
                stateSellingUnits?.map((e) => e.name).toList();

            getCategoryName();
            getUnitName();
            getStatePurchaseUnitsId();
            getStateSellingUnitsId();

            print(
                'selectedPurchaseUnits ${selectedPurchaseUnits?.map((e) => e)}');
            print('selectedPurchaseUnitIds $selectedPurchaseUnitIds');
            print('stateSelectedPurchaseUnits $stateSelectedPurchaseUnits');
            print(
                'allSellingUnitConversions ${allSellingUnitConversions?.map((e) => e)}');
          }
          if (state is EditPageUnitConversionsFetched) {
            allPurchaseUnitConversions = state.unitConversions;
            allSellingUnitConversions = state.unitConversions;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text($t('products.title.edit')),
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                      ..add(GoTOAllProductsPage())
                      ..add(FetchProducts());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            body: Form(
              key: _formKey,
              child: KPage(
                children: [
                  KPageMiddle(
                    xPadding: kPaddingX,
                    yPadding: 5.h,
                    children: [
                      SizedBox(height: 15.h),
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
                            'products.edit-product.code'),
                      ),
                      KTextField(
                        labelText: $t('fields.storeIn'),
                        controller: storeInController,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.store-in'),
                      ),
                      KTextField(
                        labelText: $t('fields.size'),
                        controller: sizeController,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.size'),
                      ),
                      KTextField(
                        labelText: $t('fields.color'),
                        controller: colorController,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.color'),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => KDropdown(
                          labelText: $t('fields.category'),
                          isRequired: true,
                          items: categories?.map((e) => e.name).toList(),
                          value: selectedCategory ?? stateCategoryName,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                              getCategoryId();
                              // print(selectedOperator);
                            });
                          },
                        ),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => KDropdown(
                          labelText: $t('fields.unit'),
                          isRequired: true,
                          items: units?.map((e) => e.name).toList(),
                          value: selectedUnit ?? stateUnitName,
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                              getUnitId();
                              selectedPurchaseUnits?.clear();
                              selectedSellingUnits?.clear();
                              BlocProvider.of<ProductBloc>(context)
                                  .add(FetchUnitConversionsOnEditPage(
                                baseUnitId: selectedUnitId,
                              ));
                            });
                          },
                        ),
                      ),
                      KTextField(
                        labelText: $t('fields.brand'),
                        controller: brandController,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.brand'),
                      ),
                      KMultiSelect(
                        context: context,
                        showItems: true,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.purchase-units'),
                        labelText: $t('fields.purchaseUnits'),
                        items: allPurchaseUnitConversions!
                            .map((e) => '${e.unitName} ')
                            .toList(),
                        selectedItems:
                            selectedPurchaseUnits ?? stateSelectedPurchaseUnits,
                        onConfirmed: (value) {
                          setState(() {
                            selectedPurchaseUnits = value;
                            getPurchaseUnitsId();
                            print(
                                'selectedPurchaseUnits ${selectedPurchaseUnits?.map((e) => e)}');
                            print(
                                'stateSelectedPurchaseUnits ${stateSelectedPurchaseUnits?.map((e) => e)}');
                          });
                        },
                        onItemTap: (value) {
                          setState(() {
                            selectedPurchaseUnits?.remove(value);
                            getPurchaseUnitsId();
                            print(selectedPurchaseUnits);
                          });
                        },
                      ),
                      KMultiSelect(
                        context: context,
                        showItems: true,
                        hasPermission: Permissions.hasFieldPermission(
                            'products.edit-product.selling-units'),
                        labelText: $t('fields.sellingUnits'),
                        items: allSellingUnitConversions!
                            .map((e) => e.unitName)
                            .toList(),
                        selectedItems:
                            selectedSellingUnits ?? stateSelectedSellingUnits,
                        onConfirmed: (value) {
                          setState(() {
                            selectedSellingUnits = value;
                            getSellingUnitsId();

                            print(selectedSellingUnits);
                          });
                        },
                        onItemTap: (value) {
                          setState(() {
                            selectedSellingUnits?.remove(value);
                            getSellingUnitsId();

                            print(selectedSellingUnits);
                          });
                        },
                      ),
                      // SizedBox(
                      //   height: 150,
                      //   child: selectedPhoto != null
                      //       ? Image.file(selectedPhoto!)
                      //       : Image.network(statePhoto),
                      // ),
                      StatefulBuilder(
                        builder: (context, setState) => KImagePicker(
                          context: context,
                          labelText: $t('fields.productImage'),
                          hasPermission: Permissions.hasFieldPermission(
                              'products.add-product.product-image'),
                          selectedImage: selectedPhoto,
                          onImageSelect: (value) {
                            setState(() {
                              selectedPhoto = value;
                            });
                            print("photo >>>>>$selectedPhoto");
                            print("photo path >>>>> ${selectedPhoto?.path}");
                          },
                        ),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => KDropdown(
                          labelText: $t('fields.status'),
                          hasPermission: Permissions.hasFieldPermission(
                              'suppliers.add-suppliers.status'),
                          value: selectedStatus ?? stateStatus,
                          items: allStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value as String?;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  KPageButtonsRow(
                    marginTop: 15.h,
                    buttons: [
                      Expanded(
                        child: BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            return KFilledButton(
                              text: $t('buttons.update'),
                              onPressed: () async {
                                var isValid = _formKey.currentState!.validate();

                                if (isValid) {
                                  if (state is ProductEditingState ||
                                      state is ProductEditingFailed) {
                                    BlocProvider.of<ProductBloc>(context).add(
                                      EditProduct(
                                        productId: productId!,
                                        name: nameController.text,
                                        categoryId: selectedCategoryId ??
                                            stateCategoryId,
                                        unitId: selectedUnitId ?? stateUnitId,
                                        brand: brandController.text,
                                        code: codeController.text,
                                        color: colorController.text,
                                        size: sizeController.text,
                                        storeIn: storeInController.text,
                                        purchaseUnits:
                                            selectedPurchaseUnitIds ??
                                                statePurchaseUnitIds,
                                        sellingUnits: selectedSellingUnitIds ??
                                            stateSellingUnitIds,
                                        photo: selectedPhoto,
                                        status: selectedStatus ?? stateStatus,
                                        alertQuantity: stateAlertQuantity,
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
