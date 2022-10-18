import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/bloc/sale_bloc/sale_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_header.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../widgets/k_dropdown.dart';
import '../widgets/k_snackbar.dart';

class AddSalePaymentScreen extends StatelessWidget {
  AddSalePaymentScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  final TextEditingController paymentAmountController = TextEditingController();

  List? methods = [
    {
      'name': 'Cash',
      'value': 'cash',
    },
    {
      'name': 'Bank',
      'value': 'bank',
    },
  ];

  var selectedMethod;

  var paymentableId;
  var invoiceNo;
  var amount;
  var method;
  var grandTotal;
  var totalDue;

  getMethod() {
    method = methods
        ?.firstWhere((element) => element['name'] == selectedMethod)['value'];
    print(method);
  }

  getMethodValue() {
    if (method != null) {
      selectedMethod =
          methods?.firstWhere((element) => element['value'] == method)['name'];
    }
    print(selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SaleBloc>(context).add(FetchSales());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Payment '),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<SaleBloc>(context).add(FetchSales());
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<SaleBloc, SaleState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AddPaymentPageLoading) {
              return const KLoadingIcon();
            }
            if (state is AddPaymentAddingState) {
              paymentableId = state.paymentableId;
              invoiceNo = state.invoiceNo;
              paymentAmountController.text = state.amount ?? '';
              method = state.method;
              grandTotal = state.grandTotal;
              totalDue = state.totalDue;

              getMethodValue();
            }

            return Form(
              key: _formKey,
              child: KPage(
                children: [
                  KPageheader(title: 'Add Payment: $invoiceNo'),
                  KPageMiddle(
                    xPadding: kPaddingX,
                    yPadding: kPaddingY,
                    children: [
                      KTextField(
                        labelText: 'Total Amount',
                        showHintText: true,
                        hintText: grandTotal.toString(),
                        isDisabled: true,
                      ),
                      KTextField(
                        labelText: 'Due Amount',
                        showHintText: true,
                        hintText: totalDue.toString(),
                        isDisabled: true,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => KDropdown(
                          isRequired: true,
                          labelText: 'Payment Method',
                          value: selectedMethod,
                          items: methods
                              ?.map((e) => e['name'].toString())
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMethod = value;
                              getMethod();
                            });
                          },
                        ),
                      ),
                      KTextField(
                        labelText: 'Payment Amount',
                        isRequired: true,
                        textInputType: TextInputType.number,
                        controller: paymentAmountController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Payment Amount is Required';
                          }
                          return null;
                        },
                      ),
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
                            BlocProvider.of<SaleBloc>(context)
                                .add(FetchSales());
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        flex: 2,
                        child: KFilledButton(
                          text: $t('buttons.submit'),
                          onPressed: () {
                            var isValid = _formKey!.currentState!.validate();

                            if (isValid) {
                              BlocProvider.of<SaleBloc>(context).add(
                                AddSalePayment(
                                  paymentableId: paymentableId,
                                  invoiceNo: invoiceNo,
                                  amount: paymentAmountController.text,
                                  method: method,
                                  grandTotal: grandTotal,
                                  totalDue: totalDue,
                                ),
                              );
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
            );
          },
        ),
      ),
    );
  }
}
