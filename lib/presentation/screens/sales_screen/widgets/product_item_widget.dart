import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/models/new_sale_item_model.dart';
import 'package:sozashop_app/data/repositories/profile_repository.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_Icon_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_box.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';

import '../../../../data/models/config_model.dart';
import '../../widgets/k_text_field.dart';

class ProductItemWidget extends StatefulWidget {
  void Function()? onDelete;
  dynamic widgetIndex;
  List<dynamic>? allProducts;
  List<dynamic>? mainItems;
  NewSaleItemModel? mainItem;
  int? prodId;
  BuildContext? itemContext;
  Function(NewSaleItemModel newSaleItem)? onNewSaleItem;
  ProductItemWidget({
    Key? key,
    this.widgetIndex,
    this.mainItems,
    this.mainItem,
    this.prodId,
    this.onDelete,
    this.onNewSaleItem,
    this.allProducts,
    this.itemContext,
  }) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  ProfileRepository profileRepository = ProfileRepository();

  List<OptionModel>? types;
  var selectedType;
  String? selectedTypeValue;
  var allProducts;
  var selectedProductName;
  var mainItemProductName;
  BatchModel? selectedProduct;
  BatchModel? mainItemProduct;
  List<String>? allProductsName;
  int? selectedProductId;

  dynamic mainItemRate;

  NewSaleItemModel saleItem = NewSaleItemModel();

  getTheFieldsValue() {
    // convert the fields
    int? discount = int.tryParse(_discountController.text);
    int? rate = int.tryParse(_rateController.text);
    num? amount = int.tryParse(_amountController.text);
    int? batchId = selectedProduct?.id;
    int? productId = selectedProduct?.productId;
    int? unitId = selectedProduct?.unitId;
    int? quantity = int.tryParse(_quantityController.text);

    // calculate the total amount
    if (selectedTypeValue == '%') {
      var subTotal = (rate ?? 0) * (quantity ?? 1);
      var subDiscount = subTotal * (discount ?? 0) / 100;
      _amountController.text = (subTotal - subDiscount).toString();
      amount = double.tryParse(_amountController.text);
    } else {
      _amountController.text =
          ((rate ?? 0) * (quantity ?? 1) - (discount ?? 0)).toString();
      amount = int.tryParse(_amountController.text);
    }

    // set the fields
    saleItem.batchId = batchId;
    saleItem.productId = productId;
    saleItem.quantity = quantity ?? 1;
    saleItem.unitId = unitId;
    saleItem.amount = amount;
    saleItem.discount = discount ?? 0;
    saleItem.discountType = selectedTypeValue ?? 'fixed';
    saleItem.rate = rate;
    saleItem.itemKey = widget.key;

    // send the fields to the parent
    widget.onNewSaleItem!(saleItem);
  }

  setTheMainItemFields() {
    if (widget.mainItem == null) {
      return;
    } else {
      getMainItemProductName();
      setMainItemFields();
    }
  }

  getTheMainItemFields() {
    // convert the fields
    int? discount = int.tryParse(_discountController.text);
    int? rate = int.tryParse(_rateController.text);
    num? amount = int.tryParse(_amountController.text);
    int? batchId = selectedProduct?.id;
    int? productId = selectedProduct?.productId;
    int? unitId = selectedProduct?.unitId;
    int? quantity = int.tryParse(_quantityController.text);

    // calculate the total amount
    if (selectedTypeValue == '%') {
      var subTotal = (rate ?? 0) * (quantity ?? 1);
      var subDiscount = subTotal * (discount ?? 0) / 100;
      _amountController.text = (subTotal - subDiscount).toString();
      amount = double.tryParse(_amountController.text);
    } else {
      _amountController.text =
          ((rate ?? 0) * (quantity ?? 1) - (discount ?? 0)).toString();
      amount = int.tryParse(_amountController.text);
    }

    // set the fields
    saleItem.batchId = batchId;
    saleItem.productId = productId;
    saleItem.quantity = quantity ?? 1;
    saleItem.unitId = unitId;
    saleItem.amount = amount;
    saleItem.discount = discount ?? 0;
    saleItem.discountType = selectedTypeValue ?? 'fixed';
    saleItem.rate = rate;
    saleItem.itemKey = widget.key;

    print('saleItem.itemKey: ${saleItem.itemKey}');

    // send the fields to the parent
    widget.onNewSaleItem!(saleItem);
  }

  getAllProductNames() {
    allProductsName = widget.allProducts?.map((item) {
      return '${item?.productName}-${item?.name}';
    }).toList();
  }

  getMainItemProductName() {
    var productName = allProducts
        ?.firstWhere((element) => element.id == widget.mainItem?.batchId)
        .productName;
    var name = allProducts
        ?.firstWhere((element) => element.id == widget.mainItem?.batchId)
        .name;
    mainItemProductName = '$productName-$name';
  }

  getSelectedTypeValue() {
    selectedTypeValue =
        types?.firstWhere((element) => element.name == selectedType).value;
  }

  setProductFields() {
    if (widget.allProducts != null && selectedProductName != null) {
      selectedProduct = widget.allProducts!.firstWhere((element) =>
          element.name == selectedProductName.toString().split('-')[1]);

      if (selectedProduct != null) {
        _rateController.text = selectedProduct?.sellingRate ?? mainItemRate;
        _unitController.text = selectedProduct!.unitName.toString();
        selectedType = types?.first.name;
      }
    }
  }

  setMainItemFields() {
    if (widget.allProducts != null && mainItemProductName != null) {
      mainItemProduct = widget.allProducts!.firstWhere((element) =>
          element.name == mainItemProductName.toString().split('-')[1]);

      if (mainItemProduct != null) {
        _rateController.text = mainItemProduct!.sellingRate.toString();
        // mainItemRate = mainItemProduct!.sellingRate.toString();
        _unitController.text = mainItemProduct!.unitName.toString();
        _amountController.text = widget.mainItem?.amount?.toString() ?? '';
        _discountController.text = widget.mainItem?.discount?.toString() ?? '';
        selectedType = types?.first.name;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.widgetIndex = widget.key;
    allProducts = widget.allProducts;
    print('Created with key: ${widget.key}');
    setTheMainItemFields();

    // getMainItemProductName();
  }

  @override
  void didChangeDependencies() {
    types = profileRepository.getConfigEnums(type: EnumType.discountType);
    getAllProductNames();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    print('Disposed key: ${widget.key}');
    selectedProductName = null;
    selectedProduct = null;
    selectedType = null;
    _discountController.dispose();
    _rateController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext itemContext) {
    setTheMainItemFields();

    return Form(
      // key: widget.key,
      child: KDetailPageBox(
        bgColor: Colors.white,
        borderColor: KColors.primary,
        padding: 15.w,
        children: [
          Row(
            children: [
              Flexible(
                flex: 7,
                child: KDropdown(
                  labelText: $t('fields.product'),
                  isRequired: true,
                  value: selectedProductName ?? mainItemProductName,
                  items: allProductsName,
                  onChanged: (value) {
                    setState(() {
                      selectedProductName = value;
                      setProductFields();
                      getTheFieldsValue();
                      getTheMainItemFields();
                    });
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 2,
                child: KTextField(
                  labelText: $t('fields.quantity'),
                  textInputType: TextInputType.number,
                  hintText: 1.toString(),
                  showHintText: true,
                  controller: _quantityController,
                  isDisabled: (selectedProductName == null &&
                          mainItemProductName == null)
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      getTheFieldsValue();
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: KTextField(
                  labelText: $t('fields.rate'),
                  controller: _rateController,
                  textInputType: TextInputType.number,
                  isDisabled: (selectedProductName == null &&
                          mainItemProductName == null)
                      ? true
                      : false,
                  onChanged: (value) {
                    setState(() {
                      getTheFieldsValue();
                    });
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: KTextField(
                  labelText: $t('fields.unit'),
                  isDisabled: true,
                  controller: _unitController,
                ),
              ),
            ],
          ),
          Permissions.hasFieldPermission('sales.new-sales.discount')
              ? Row(
                  children: [
                    Flexible(
                      child: KTextField(
                        labelText: $t('fields.discount'),
                        controller: _discountController,
                        textInputType: TextInputType.number,
                        isDisabled: (selectedProductName == null &&
                                mainItemProductName == null)
                            ? true
                            : false,
                        hintText: 0.toString(),
                        showHintText: true,
                        onChanged: (value) {
                          setState(() {
                            _amountController.text = value;
                            // widget.onNewSaleItem(saleItem.copyWith(
                            //   amount: int.tryParse(value),
                            // ));
                            getTheFieldsValue();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      child: KDropdown(
                        isDisabled: (selectedProductName == null &&
                                mainItemProductName == null)
                            ? true
                            : false,
                        labelText: $t('fields.type'),
                        items: types?.map((e) => e.name).toList(),
                        value: selectedType ?? types?.first.name,
                        onChanged: (value) {
                          setState(() {
                            selectedType = value;
                            getSelectedTypeValue();
                            getTheFieldsValue();
                          });
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: KTextField(
                  labelText: $t('fields.amount'),
                  hasMargin: false,
                  isDisabled: true,
                  controller: _amountController,
                  onChanged: (value) {
                    setState(() {
                      getTheFieldsValue();
                    });
                  },
                ),
              ),
              SizedBox(width: 10.w),
              KIconButton(
                icon: Icons.delete,
                iconColor: KColors.danger,
                onPressed: widget.onDelete!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
