import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/repositories/barcode_repository.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

class ProductBarcodeScreen extends StatefulWidget {
  const ProductBarcodeScreen({Key? key}) : super(key: key);

  @override
  State<ProductBarcodeScreen> createState() => _ProductBarcodeScreenState();
}

class _ProductBarcodeScreenState extends State<ProductBarcodeScreen> {
  BarcodeRepository barcodeRepository = BarcodeRepository();

  TextEditingController totalBarcodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<BatchModel>? batches;
  var selectedBatchName;
  BatchModel? selectedBatch;

  int? totalBarcode;

  getSelectedBatch() {
    selectedBatch =
        batches?.firstWhere((element) => element.name == selectedBatchName);
    print(selectedBatch?.name);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ProductBloc>(context).add(GoTOAllProductsPage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text($t("barcode.title.details")),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<ProductBloc>(context).add(GoTOAllProductsPage());
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductBarcodePageState) {
              batches = state.batches;
            }
            return KPage(
              children: [
                Form(
                  key: _formKey,
                  child: KPageMiddle(
                    xPadding: kPaddingX,
                    yPadding: kPaddingY,
                    dismissKeyboard: true,
                    children: [
                      KDropdown(
                        labelText: $t('fields.batch'),
                        isRequired: true,
                        items: batches?.map((e) => e.name).toList(),
                        value: selectedBatchName,
                        onChanged: (value) {
                          setState(() {
                            selectedBatchName = value;
                            getSelectedBatch();
                          });
                        },
                      ),
                      KTextField(
                        labelText: 'Total Barcode',
                        textInputType: TextInputType.number,
                        isRequired: true,
                        controller: totalBarcodeController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              totalBarcode = int.parse(value);
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Total number of barcode is required';
                          }
                          return null;
                        },
                      ),
                      selectedBatchName != null
                          ? Card(
                              elevation: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: 300.w,
                                ),
                                // color: Colors.amber,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectedBatch!.product.name,
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      selectedBatch!.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                    BarcodeWidget(
                                      barcode: Barcode.code128(),
                                      data: 'Hello world',
                                      drawText: false,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 20.h,
                                        horizontal: 40.w,
                                      ),
                                      width: 180.w,
                                    ),
                                    Text(
                                      'Price: ${selectedBatch!.sellingRate}',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 250.h,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Lottie.asset(
                                          'assets/animations/barcode_scan.json'),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        'Select a batch to generate the barcode',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Flexible(
                      child: KFilledButton(
                        text: $t("buttons.back"),
                        buttonColor: Colors.grey.shade300,
                        textColor: Colors.grey.shade600,
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(GoTOAllProductsPage());
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 2,
                      child: KFilledButton(
                        text: 'Generate Pdf',
                        onPressed: () async {
                          var isValid = _formKey.currentState!.validate();

                          if (isValid && selectedBatchName != null) {
                            BlocProvider.of<ProductBloc>(context).add(
                              GenerateBarcodePdf(
                                totalBarCode: totalBarcode!,
                                selectedBatch: selectedBatch!,
                              ),
                            );
                          } else {
                            KSnackBar(
                              context: context,
                              type: AlertType.failed,
                              message: 'Please add all the required fields',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
