import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/models/charge_model.dart';
import 'package:sozashop_app/data/models/config_model.dart';
import 'package:sozashop_app/data/models/customer_model.dart';
import 'package:sozashop_app/data/models/new_sale_charge_model.dart';
import 'package:sozashop_app/data/models/new_sale_item_model.dart';
import 'package:sozashop_app/data/models/new_sale_model.dart';
import 'package:sozashop_app/data/models/sale_model.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/widgets/product_item_widget.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

import '../../../data/models/sale_item_model.dart';
import '../../../logic/bloc/sale_bloc/sale_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_button.dart';
import '../widgets/k_date_picker.dart';
import '../widgets/k_detail_page_box.dart';
import '../widgets/k_dialog.dart';
import '../widgets/k_dropdown.dart';
import '../widgets/k_keep_alive_wrapper.dart';
import '../widgets/k_text_field.dart';

class EditSaleScreen extends StatefulWidget {
  const EditSaleScreen({Key? key}) : super(key: key);

  @override
  State<EditSaleScreen> createState() => _EditSaleScreenState();
}

class _EditSaleScreenState extends State<EditSaleScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _addButtonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  TabController? _tabController;

  // text fields controllers
  final TextEditingController discountController = TextEditingController();
  final TextEditingController totalDiscountController = TextEditingController();
  final TextEditingController grandTotalController = TextEditingController();
  final TextEditingController totalPaidController = TextEditingController();
  final TextEditingController totalDueController = TextEditingController();
  final TextEditingController receivedAmountController =
      TextEditingController();
  final TextEditingController exchangeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // charge fields controllers
  TextEditingController? chargeDiscountController;
  TextEditingController? chargeAmountController;

  SaleModel? saleModel;

  List<OptionModel>? paymentMethods;
  List<CustomerModel>? customers;
  List<BatchModel>? batches;
  List<dynamic> charges = [];
  List<OptionModel>? discountTypes;
  var selectedPaymentMethod;
  var selectedPaymentMethodValue;
  var selectedDiscountType;
  var selectedCustomer;
  var selectedCustomerId;
  DateTime? date;
  DateTime? dueDate;
  final nowDate = DateTime.now();

  NewSaleItemModel newSaleItemModal = NewSaleItemModel();
  List<NewSaleItemModel> saleItems = [];
  List<SaleItemModel> stateSaleItems = [];
  List<ProductItemWidget> saleItemWidgets = [];

  // state variables
  var stateSelectedPaymentMethod;
  var stateSelectedPaymentMethodValue;
  var stateSelectedDiscountType;
  var stateSelectedCustomer;
  var stateSelectedCustomerId;

  // calculation variables
  num saleItemsTotal = 0;
  double subTotal = 0;
  double totalCharge = 0;
  int discount = 0;
  num totalDiscountAmount = 0;
  num totalPaidAmount = 0;
  var selectedTypeValue;

  bool? isKeyboardOpen;

  scrollToAddButton() {
    var cntxt = _addButtonKey.currentContext;

    var maxScrl = _scrollController.offset +
        _scrollController.position.maxScrollExtent +
        400;
    _scrollController.animateTo(
      maxScrl,
      duration: const Duration(milliseconds: 700),
      curve: Curves.linear,
    );
  }

  getSelectedTypeValue() {
    selectedTypeValue = discountTypes
        ?.firstWhere((element) => element.name == selectedDiscountType)
        .value;
  }

  // calculate sub total
  getSubTotal() {
    if (saleItems.isEmpty) {
      subTotal = 0;
    } else {
      subTotal = saleItems
          .map((e) => e.amount?.toDouble() ?? 0)
          .toList()
          .reduce((total, current) => (total += current));
    }
    calculateGrandTotal();
    calculateTotalDiscount();
  }

  // calculate single type of charges
  calculateCharge(charge) {
    num total = 0;
    if (charge.chargeType == '%') {
      total = (subTotal * charge.chargeAmount) / 100;
    } else {
      total += charge.chargeAmount;
    }

    chargeAmountController?.text = total.toString();
    return total.toDouble();
  }

  // calculate total charges
  calculateTotalCharge() {
    totalCharge = charges
        .map((e) => calculateCharge(e))
        .toList()
        .reduce((total, current) => (total += current));
    return totalCharge;
  }

  // calculate total discount
  calculateTotalDiscount() {
    num total = 0;
    if (discountController.text.isNotEmpty && selectedTypeValue != null) {
      if (selectedTypeValue == '%') {
        total = 0;
        total = (double.parse(discountController.text) *
                double.tryParse(grandTotalController.text)!) /
            100;
      } else {
        total = 0;
        total = double.parse(discountController.text);
      }
    } else {
      total = 0;
    }

    totalDiscountController.text = total.toStringAsFixed(2);
    totalDiscountAmount = total;

    return total;
  }

  // calculate grand total
  calculateGrandTotal() {
    if (hasProducts()) {
      grandTotalController.text =
          (subTotal + calculateTotalCharge() - totalDiscountAmount)
              .toStringAsFixed(2);
    } else {
      grandTotalController.text = '0.0';
    }

    calculateTotalDue();
  }

  // calculate total due
  calculateTotalDue() {
    num totalDue = 0;
    num totalPaid = 0;
    if (totalPaidController.text.isEmpty) {
      totalPaid = 0;
    } else {
      totalPaid = double.parse(totalPaidController.text);
    }

    totalDue = (double.parse(grandTotalController.text) - totalPaid);

    totalPaidAmount = totalPaid;
    totalDueController.text = totalDue.toStringAsFixed(2);
    return totalDueController.text;
  }

  // check if saleItems has products
  bool hasProducts() {
    return saleItems.any((element) => element.batchId != null);
  }

  // get exchange amount
  getExchangeAmount() {
    num change = 0;
    if (receivedAmountController.text.isNotEmpty) {
      change = (double.parse(receivedAmountController.text) -
          double.parse(totalPaidController.text));
    } else {
      change = 0;
    }

    if (change > 0) {
      exchangeController.text = change.toStringAsFixed(2);
      return change;
    } else {
      exchangeController.text = '0';
      return '0';
    }
  }

  makeNewChargesList() {
    List<NewSaleChargeModel> newCharges = [];
    if (charges.isNotEmpty) {
      for (var charge in charges) {
        newCharges.add(NewSaleChargeModel(
          chargeAmount: charge.chargeAmount,
          chargeId: charge.id,
        ));
      }
    }
    return newCharges;
  }

  // check if saleItem has any null values
  hasNullItem() {
    var widgetKeys = saleItemWidgets.map((e) => e.key).toList();
    var saleItemKeys = saleItems.map((e) => e.itemKey).toList();
    print("widgetKeys $widgetKeys");
    print("saleItemKeys $saleItemKeys");

    var allMatched = saleItemKeys.equals(widgetKeys);
    print("allMatched $allMatched");

    if (allMatched) {
      // make button enabled
      return false;
    } else {
      // make button disabled
      return true;
    }
  }

  // remove saleItem from list
  removeSaleItem(item) {
    saleItems.removeWhere((e) => e.productId == item.productId);
  }

  // getStateSaleItems() {
  //   stateSaleItems.clear();

  //   if (saleModel != null && saleModel?.saleItems != null) {
  //     for (var mainSaleItem in saleModel!.saleItems!) {
  //       newSaleItemModal = NewSaleItemModel(
  //         amount: mainSaleItem.amount,
  //         batchId: mainSaleItem.batchId,
  //         discount: mainSaleItem.discount,
  //         discountType: mainSaleItem.discountType,
  //         productId: mainSaleItem.productId,
  //         quantity: mainSaleItem.quantity,
  //         rate: mainSaleItem.rate,
  //         unitId: mainSaleItem.unitId,
  //       );

  //       stateSaleItems.add(newSaleItemModal);
  //     }
  //   } else {
  //     return;
  //   }
  // }

  setSaleItemsIfNotEmpty() {
    if (saleItems.isEmpty) {
      getSaleItemsFromSaleModel();
      print('sale items empty >>>>>>>>>>>>');
    } else {
      print('sale items not empty >>>>>>>>>>>>');
      return;
    }
  }

  getSaleItemsFromSaleModel() {
    saleItems.clear();

    if (stateSaleItems.isNotEmpty) {
      for (var mainSaleItem in stateSaleItems) {
        newSaleItemModal = NewSaleItemModel(
          amount: mainSaleItem.amount,
          batchId: mainSaleItem.batchId,
          discount: mainSaleItem.discount,
          discountType: mainSaleItem.discountType,
          productId: mainSaleItem.productId,
          quantity: mainSaleItem.quantity,
          rate: mainSaleItem.rate,
          unitId: mainSaleItem.unitId,
        );

        saleItems.add(newSaleItemModal);
      }
    } else {
      return;
    }

    setSaleItemsToSaleWidget();
  }

  setSaleItemsToSaleWidget() {
    saleItemWidgets.clear();
    saleItemWidgets.addAll(saleItems.map((e) {
      return ProductItemWidget(
        key: GlobalKey(),
      );
    }).toList());

    print("saleItems.map((e) => e.batchId) ${saleItems.map((e) => e.batchId)}");
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController?.addListener(() {
      setState(() {});
    });

    KeyboardVisibilityController().onChange.listen((isVisible) {
      isKeyboardOpen = isVisible ? true : false;
    });

    getSubTotal();
    calculateGrandTotal();
    calculateTotalDiscount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    saleItemsTotal = saleItems.map((e) => e.amount).toList().fold<num>(
        0, (previousValue, element) => previousValue + (element ?? 0));

    print('saleItemsTotal: $saleItemsTotal');

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SaleBloc>(context).add(GoToAllSalesPage());
        return false;
      },
      child: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SaleEditingState) {
            saleModel = state.saleModel;
            paymentMethods = state.paymentMethods?.cast<OptionModel>() ?? [];
            customers = state.customers?.cast<CustomerModel>() ?? [];
            batches = state.batches?.cast<BatchModel>() ?? [];
            discountTypes = state.discountTypes?.cast<OptionModel>() ?? [];
            charges = state.saleModel?.charges?.cast<ChargeModel>() ?? [];

            stateSaleItems =
                state.saleModel?.saleItems?.cast<SaleItemModel>() ?? [];

            setSaleItemsIfNotEmpty();

            //  getStateSaleItems();
            print('saleEditingState >>>>>>>>>>>>>>>>>>>>>>>>>>');

            makeNewChargesList();

            date = saleModel?.date;
            stateSelectedCustomer = saleModel?.customerName;

            print('saleItems: $saleItems');
          }

          if (state is SaleEditPageLoading) {
            return const KLoadingIcon();
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text($t('sales.title.edit')),
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SaleBloc>(context).add(GoToAllSalesPage());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: $t('Information'),
                  ),
                  Tab(
                    text: $t('Sale items'),
                  ),
                  Tab(
                    text: $t('Details'),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                // tab 1
                firstTabContent(context),

                // tab 2 contents
                secondTabContent(context),

                // tab 3 contents
                thirdTabContent(context),
              ],
            ),
          );
        },
      ),
    );
  }

  firstTabContent(BuildContext context) {
    return KKeepAliveWrapper(
      child: Form(
        key: _formKey,
        child: KPage(
          dismissKeyboard: true,
          children: [
            KPageMiddle(
              xPadding: kPaddingX,
              yPadding: kPaddingY,
              children: [
                KDatePicker(
                  context: context,
                  labelText: $t('fields.date'),
                  isRequired: true,
                  initialDate: nowDate, //! fix initial date
                  onDateChange: (newDate) {
                    setState(() {
                      date = newDate;
                    });
                  },
                ),
                KDropdown(
                  labelText: $t('fields.paymentMethod'),
                  items: paymentMethods?.map((e) => e.name).toList(),
                  value: selectedPaymentMethod ?? paymentMethods?.first.name,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                      selectedPaymentMethodValue =
                          getSelectedValueFromName(paymentMethods ?? [], value);
                    });
                  },
                ),
                KDropdown(
                  hasMargin: false,
                  labelText: $t('fields.customer'),
                  isRequired: true,
                  items: customers?.map((e) => e.name.toString()).toList(),
                  value: selectedCustomer ?? stateSelectedCustomer,
                  onChanged: (value) {
                    setState(() {
                      selectedCustomer = value;
                      selectedCustomerId =
                          getSelectedIdFromName(customers!, selectedCustomer);
                      print('selectedCustomerId: $selectedCustomerId');
                    });
                  },
                ),
              ],
            ),
            KPageButtonsRow(
              marginTop: 15.h,
              buttons: [
                Flexible(
                  child: KFilledButton(
                    buttonColor: Colors.grey.shade300,
                    text: 'Cancel',
                    onPressed: () {
                      BlocProvider.of<SaleBloc>(context)
                          .add(GoToAllSalesPage());
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: KFilledButton.iconText(
                    buttonColor: KColors.grey,
                    icon: Icons.arrow_forward_ios_rounded,
                    // text: 'Next',
                    onPressed: () {
                      _tabController?.animateTo(1);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  secondTabContent(BuildContext context) {
    return KKeepAliveWrapper(
      child: KPage(
        dismissKeyboard: true,
        children: [
          KPageMiddle(
            controller: _scrollController,

            dismissKeyboard: true,
            xPadding: kPaddingX,
            yPadding: kPaddingY,
            // isExpanded: saleItems.isEmpty ? false : true,
            children: [
              SizedBox(
                // height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: saleItemWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = saleItemWidgets[index];
                    var saleItem = saleItems[index];
                    return StatefulBuilder(
                      builder: (context, setState) => ProductItemWidget(
                        key: item.key,
                        itemContext: context,
                        allProducts: batches,
                        mainItem: saleItem,
                        onDelete: () {
                          setState(() {
                            saleItemWidgets
                                .removeWhere((e) => e.key == item.key);
                            saleItems.removeWhere((e) => e.itemKey == item.key);

                            print('saleItemWidgets: $saleItemWidgets');
                            print('saleItems: $saleItems');
                            print(
                                'saleItems: >>>>>>>>>>> ${saleItems.map((e) => e.itemKey)}');

                            getSubTotal();
                            calculateGrandTotal();
                            calculateTotalDiscount();

                            hasNullItem();
                          });
                          print('saleItemWidgets: $saleItemWidgets');
                          print('saleItems: $saleItems');
                        },
                        onNewSaleItem: (newItem) {
                          Future.delayed(Duration.zero, () async {
                            setState(() {
                              getSaleItems() {
                                var hasNullItem = saleItems.any(
                                    (element) => element.productId == null);

                                if (saleItems.isEmpty) {
                                  print('isEmpty <<<<<<<<<<<<<<<<<<<<');
                                  saleItems.add(newItem);
                                } else if (saleItems.any((element) =>
                                    element.itemKey == newItem.itemKey)) {
                                  print('matchedItem  <<<<<<<<<<<<<<<<<<<<');

                                  var matchedItem = saleItems.firstWhere(
                                    (e) => e.itemKey == newItem.itemKey,
                                  );

                                  matchedItem.copyWith(
                                    productId: newItem.productId,
                                    amount: newItem.amount,
                                    discount: newItem.discount,
                                    discountType: newItem.discountType,
                                    batchId: newItem.batchId,
                                    quantity: newItem.quantity,
                                    rate: newItem.rate,
                                    unitId: newItem.unitId,
                                    itemKey: newItem.itemKey,
                                  );
                                } else if (saleItemWidgets.any((element) =>
                                    element.key == newItem.itemKey)) {
                                  print(
                                      'matched edit Item  <<<<<<<<<<<<<<<<<<<<');

                                  var matchedEditItem =
                                      saleItemWidgets.firstWhere(
                                    (e) => e.key == newItem.itemKey,
                                  );
                                  // Future.delayed(Duration.zero, () async {
                                  // setState(() {
                                  // saleItem.copyWith(
                                  //   productId: newItem.productId,
                                  //   amount: newItem.amount,
                                  //   discount: newItem.discount,
                                  //   discountType: newItem.discountType,
                                  //   batchId: newItem.batchId,
                                  //   quantity: newItem.quantity,
                                  //   rate: newItem.rate,
                                  //   unitId: newItem.unitId,
                                  //   itemKey: newItem.itemKey,
                                  // );
                                  // saleItems.removeAt(index);
                                  saleItems.clear();
                                  saleItems.map((e) => e == newItem).toList();
                                  print('inserted item: $newItem');

                                  print("newItem.itemKey: ${newItem.itemKey}");
                                  print(
                                      'saleItem itemKeys: >>>>> ${saleItems.map((e) => e.itemKey)}');
                                  // });
                                  // });
                                } else {
                                  print('newItem  <<<<<<<<<<<<<<<<<<<<');
                                  saleItems.add(newItem);
                                }
                              }

                              getSaleItems();
                            });
                          });
                          print('saleItemWidgets >>>>> $saleItemWidgets');
                          print('saleItems >>>>> $saleItems');
                          print(
                              'saleItem itemKeys: >>>>> ${saleItems.map((e) => e.itemKey)}');
                          hasNullItem();
                          getSubTotal();
                          calculateGrandTotal();
                          calculateTotalDiscount();
                        },
                      ),
                    );
                  },
                ),
              ),
              // Column(
              //   children: [
              //     for (var item in saleItemWidgets)
              //       ProductItemWidget(
              //         key: item.key,
              //         itemContext: context,
              //         allProducts: batches,
              //         onDelete: () {
              //           setState(() {
              //             saleItemWidgets.removeWhere((e) => e.key == item.key);
              //             saleItems.removeWhere((e) => e.itemKey == item.key);

              //             print('saleItemWidgets: $saleItemWidgets');
              //             print('saleItems: $saleItems');
              //             print(
              //                 'saleItems: >>>>>>>>>>> ${saleItems.map((e) => e.itemKey)}');

              //             getSubTotal();
              //             calculateGrandTotal();
              //             calculateTotalDiscount();

              //             hasNullItem();
              //           });
              //           print('saleItemWidgets: $saleItemWidgets');
              //           print('saleItems: $saleItems');
              //         },
              //         onNewSaleItem: (newItem) {
              //           setState(() {
              //             getSaleItems() {
              //               var hasNullItem = saleItems
              //                   .any((element) => element.productId == null);

              //               if (saleItems.isEmpty) {
              //                 print('isEmpty <<<<<<<<<<<<<<<<<<<<');
              //                 saleItems.add(newItem);
              //               } else if (saleItems.any((element) =>
              //                   element.itemKey == newItem.itemKey)) {
              //                 print('matchedItem  <<<<<<<<<<<<<<<<<<<<');

              //                 var matchedItem = saleItems.firstWhere(
              //                   (e) => e.itemKey == newItem.itemKey,
              //                 );

              //                 matchedItem.copyWith(
              //                   productId: newItem.productId,
              //                   amount: newItem.amount,
              //                   discount: newItem.discount,
              //                   discountType: newItem.discountType,
              //                   batchId: newItem.batchId,
              //                   quantity: newItem.quantity,
              //                   rate: newItem.rate,
              //                   unitId: newItem.unitId,
              //                   itemKey: newItem.itemKey,
              //                 );
              //               } else {
              //                 print('newItem  <<<<<<<<<<<<<<<<<<<<');
              //                 saleItems.add(newItem);
              //               }
              //             }

              //             getSaleItems();
              //           });
              //           print('saleItemWidgets >>>>> $saleItemWidgets');
              //           print('saleItems >>>>> $saleItems');
              //           print(
              //               'saleItem itemKeys: >>>>> ${saleItems.map((e) => e.itemKey)}');
              //           hasNullItem();
              //           getSubTotal();
              //           calculateGrandTotal();
              //           calculateTotalDiscount();
              //         },
              //       ),
              //   ],
              // ),
              saleItems.isEmpty
                  ? SizedBox(
                      height: 450.h,
                      // height: MediaQuery.of(context).viewInsets.bottom,
                      child: const Center(
                        child: Text(
                          'No sale item added yet!',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          KPageButtonsRow(
            marginTop: 15.h,
            buttons: [
              Flexible(
                key: _addButtonKey,
                child: KFilledButton(
                  isDisabled: hasNullItem(),
                  text: 'Add Sale Item',
                  onPressed: () {
                    setState(() {
                      saleItemWidgets.add(ProductItemWidget(
                        key: GlobalKey(),
                      ));
                      print(saleItemWidgets);
                      print(saleItems);
                      getSubTotal();
                    });
                    scrollToAddButton();
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: (isKeyboardOpen == true) ? false : true,
            child: KPageButtonsRow(
              marginTop: 10.h,
              buttons: [
                Flexible(
                  child: KFilledButton.iconText(
                    buttonColor: KColors.grey,
                    icon: Icons.arrow_back_ios_rounded,
                    // text: 'Back',
                    onPressed: () {
                      _tabController?.animateTo(0);
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: KFilledButton.iconText(
                    buttonColor: KColors.grey,
                    icon: Icons.arrow_forward_ios_rounded,
                    // text: 'Next',
                    onPressed: () {
                      _tabController?.animateTo(2);
                      print('saleItems: $saleItems');

                      getSubTotal();
                      calculateGrandTotal();
                      calculateTotalDiscount();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  thirdTabContent(BuildContext context) {
    return KKeepAliveWrapper(
      child: KPage(
        children: [
          KPageMiddle(
            xPadding: kPaddingX,
            yPadding: kPaddingY,
            children: [
              // Charge items
              charges.isEmpty
                  ? Container(
                      height: 20.h,
                    )
                  : KDetailPageBox(
                      yMargin: 0,
                      bgColor: Colors.white,
                      borderColor: Colors.grey.shade400,
                      padding: 15.w,
                      bottomPadding: 0.w,
                      children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: charges.length,
                          itemBuilder: (BuildContext context, int index) {
                            chargeDiscountController = TextEditingController();

                            chargeAmountController = TextEditingController();

                            chargeDiscountController?.text =
                                '${charges[index].chargeAmount} ${charges[index].chargeType.toString().toCapitalized()}';
                            chargeAmountController?.text =
                                calculateCharge(charges[index]).toString();

                            return Row(
                              children: [
                                Flexible(
                                  child: KTextField(
                                    labelText: charges[index].chargeName,
                                    isDisabled: true,
                                    controller: chargeDiscountController,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Flexible(
                                  child: StatefulBuilder(
                                    builder: (context, setState) => KTextField(
                                      labelText: 'Amount ',
                                      showLabel: false,
                                      isDisabled: true,
                                      controller: chargeAmountController,
                                      onChanged: (value) {
                                        setState(() {
                                          chargeAmountController?.text =
                                              calculateCharge(charges[index])
                                                  .toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),

              SizedBox(height: 20.h),

              // discount
              Row(
                children: [
                  Flexible(
                    child: KTextField(
                      labelText: $t('fields.discount'),
                      hintText: '0',
                      showHintText: true,
                      controller: discountController,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        calculateTotalDiscount();
                        calculateGrandTotal();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: KDropdown(
                      labelText: $t('fields.type'),
                      value: selectedDiscountType,
                      items: discountTypes?.map((e) => e.name).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDiscountType = value;
                          getSelectedTypeValue();
                          calculateTotalDiscount();
                          calculateGrandTotal();
                        });
                      },
                    ),
                  ),
                ],
              ),

              // total discount
              Row(
                children: [
                  Flexible(
                    child: KTextField(
                      labelText: $t('fields.totalDiscount'),
                      isDisabled: true,
                      hasPermission: Permissions.hasFieldPermission(
                          'sales.new-sales.discount'),
                      controller: totalDiscountController,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: KTextField(
                      labelText: $t('fields.grandTotal'),
                      isDisabled: true,
                      controller: grandTotalController,
                      onChanged: (value) {
                        calculateTotalDue();
                      },
                    ),
                  ),
                ],
              ),

              // total due
              Row(
                children: [
                  Flexible(
                    child: KTextField(
                      labelText: $t('fields.totalPaid'),
                      hasPermission: Permissions.hasFieldPermission(
                          'sales.new-sales.discount'),
                      hasMargin: false,
                      hintText: '0',
                      showHintText: true,
                      controller: totalPaidController,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        calculateTotalDue();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: KTextField(
                      labelText: $t('fields.totalDue'),
                      isDisabled: true,
                      hasPermission: Permissions.hasFieldPermission(
                          'sales.new-sales.discount'),
                      hasMargin: false,
                      controller: totalDueController,
                    ),
                  ),
                ],
              ),
            ],
          ),
          KPageButtonsRow(
            marginTop: 15.h,
            buttons: [
              Flexible(
                child: KFilledButton.iconText(
                  buttonColor: KColors.grey,
                  icon: Icons.arrow_back_ios_rounded,
                  // text: 'Back',
                  onPressed: () {
                    _tabController?.animateTo(1);
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 2,
                child: KFilledButton(
                  text: $t('buttons.submit'),
                  onPressed: () async {
                    var isValid = _formKey.currentState!.validate();

                    if (isValid &&
                        selectedCustomerId != null &&
                        date != null &&
                        dueDate != null &&
                        saleItems.isNotEmpty &&
                        saleItems.first.productId != null) {
                      exchangeController.text = getExchangeAmount().toString();

                      // modal
                      KDialog(
                        context: context,
                        dialogType: DialogType.form,
                        formContent: [
                          KTextField(
                            labelText: $t('fields.grandTotal'),
                            isDisabled: true,
                            controller: grandTotalController,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: KTextField(
                                  labelText: $t('fields.totalDue'),
                                  isDisabled: true,
                                  controller: totalDueController,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: KTextField(
                                  labelText: $t('fields.totalPaid'),
                                  hintText: '0',
                                  showHintText: true,
                                  isDisabled: true,
                                  controller: totalPaidController,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: KTextField(
                                  labelText: $t('fields.receivedAmount'),
                                  controller: receivedAmountController,
                                  textInputType: TextInputType.number,
                                  onChanged: (value) {
                                    getExchangeAmount();
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: KTextField(
                                  labelText: $t('fields.exchange'),
                                  hintText: '0',
                                  showHintText: true,
                                  isDisabled: true,
                                  controller: exchangeController,
                                ),
                              ),
                            ],
                          ),
                          KTextField(
                            labelText: $t('fields.note'),
                            hasPermission: Permissions.hasFieldPermission(
                                'sales.new-sales.note'),
                            controller: noteController,
                            maxLines: 3,
                            inputAction: TextInputAction.newline,
                          ),
                        ],
                        yesBtnPressed: () {
                          NewSaleModel newSaleModel = NewSaleModel(
                            charges: makeNewChargesList(),
                            customerId: selectedCustomerId,
                            saleItems: saleItems,
                            date: date,
                            dueDate: dueDate,
                            discountType: selectedTypeValue,
                            paidAmount: totalPaidAmount.toString(),
                            paymentMethod: selectedPaymentMethodValue ??
                                paymentMethods?.first.value,
                            totalDiscount: totalDiscountAmount,
                            note: noteController.text,
                          );

                          BlocProvider.of<SaleBloc>(context)
                              .add(CreateNewSale(newSaleModel: newSaleModel));
                        },
                      );
                    } else {
                      KSnackBar(
                        context: context,
                        type: AlertType.failed,
                        message: 'Please add all the required fields!',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
