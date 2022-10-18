import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../widgets/k_snackbar.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({Key? key}) : super(key: key);

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  TextEditingController openingBalanceController = TextEditingController();
  String? selectedStatus;

  List<String> allStatus = ["Active", "Inactive"];

  @override
  Widget build(BuildContext context) {
    // demo data
    nameController.text = 'helloo';
    mobileController.text = 'hello';

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SupplierBloc>(context)
          ..add(GoAllSuppliersPage())
          ..add(FetchSuppliers());
        Navigator.pushNamed(context, AppRouter.suppliersScreen);

        return false;
      },
      child: BlocListener<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierAddedState) {
            Navigator.pushNamed(context, AppRouter.suppliersScreen);
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Supplier Added Successfully!",
            );
          }
          if (state is SupplierAddingFailed) {
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
            title: Text($t('suppliers.title.add')),
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<SupplierBloc>(context)
                    ..add(GoAllSuppliersPage())
                    ..add(FetchSuppliers());
                  Navigator.pushNamed(context, AppRouter.suppliersScreen);
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
                    SizedBox(
                      height: 15.h,
                    ),
                    KTextField(
                      labelText: $t('fields.name'),
                      controller: nameController,
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
                      controller: mobileController,
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
                      controller: telephoneController,
                      textInputType: TextInputType.phone,
                      hasPermission: Permissions.hasFieldPermission(
                          'suppliers.add-suppliers.telephone'),
                    ),
                    KTextField(
                      labelText: $t('fields.email'),
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    KTextField(
                      labelText: $t('fields.fax'),
                      controller: faxController,
                      hasPermission: Permissions.hasFieldPermission(
                          'suppliers.add-suppliers.fax'),
                    ),
                    KTextField(
                      labelText: $t('fields.vatNumber'),
                      controller: vatNumberController,
                      hasPermission: Permissions.hasFieldPermission(
                          'suppliers.add-suppliers.vat-number'),
                    ),
                    KTextField(
                      labelText: $t('fields.openingBalance'),
                      controller: openingBalanceController,
                      textInputType: TextInputType.number,
                    ),
                    KDropdown(
                      labelText: $t('fields.status'),
                      hasPermission: Permissions.hasFieldPermission(
                          'suppliers.add-suppliers.status'),
                      value: selectedStatus,
                      items: allStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value as String?;
                        });
                      },
                    ),
                  ],
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Expanded(
                      child: KFilledButton(
                        text: $t('buttons.submit'),
                        onPressed: () async {
                          var isValid = _formKey.currentState!.validate();

                          if (isValid) {
                            BlocProvider.of<SupplierBloc>(context)
                                .add(AddSupplier(
                              fax: faxController.text,
                              mail: emailController.text,
                              mobile: mobileController.text,
                              name: nameController.text,
                              openingBalance: openingBalanceController.text,
                              status: selectedStatus?.toLowerCase(),
                              telephone: telephoneController.text,
                              vatNumber: vatNumberController.text,
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
