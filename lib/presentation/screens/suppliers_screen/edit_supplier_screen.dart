import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_button.dart';

class EditSupplierScreen extends StatefulWidget {
  const EditSupplierScreen({Key? key}) : super(key: key);

  @override
  State<EditSupplierScreen> createState() => _EditSupplierScreenState();
}

class _EditSupplierScreenState extends State<EditSupplierScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  String? selectedStatus;
  int? supplierId;

  List<String> allStatus = ["active", "inactive"];
  String? stateStatus;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SupplierBloc>(context)
          ..add(GoAllSuppliersPage())
          ..add(FetchSuppliers());
        return false;
      },
      child: BlocConsumer<SupplierBloc, SupplierState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SupplierEditingState) {
            print(state.supplierModel.status);
            supplierId = state.supplierModel.id;
            nameController.text = state.supplierModel.name;
            mobileController.text = state.supplierModel.mobile;
            telephoneController.text = state.supplierModel.telephone as String;
            emailController.text = state.supplierModel.email as String;
            faxController.text = state.supplierModel.fax as String;
            vatNumberController.text = state.supplierModel.vatNumber as String;
            stateStatus = state.supplierModel.status;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text($t('suppliers.title.edit')),
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SupplierBloc>(context)
                      ..add(GoAllSuppliersPage())
                      ..add(FetchSuppliers());
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
                            'suppliers.edit-suppliers.telephone'),
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
                            'suppliers.edit-suppliers.fax'),
                      ),
                      KTextField(
                        labelText: $t('fields.vatNumber'),
                        controller: vatNumberController,
                        hasPermission: Permissions.hasFieldPermission(
                            'suppliers.edit-suppliers.vat-number'),
                      ),
                      KDropdown(
                        labelText: $t('fields.status'),
                        hasPermission: Permissions.hasFieldPermission(
                            'suppliers.edit-suppliers.status'),
                        value: selectedStatus ?? stateStatus,
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
                        child: BlocBuilder<SupplierBloc, SupplierState>(
                          builder: (context, state) {
                            return KFilledButton(
                              text: $t('buttons.update'),
                              onPressed: () async {
                                var isValid = _formKey.currentState!.validate();

                                if (isValid) {
                                  if (state is SupplierEditingState) {
                                    BlocProvider.of<SupplierBloc>(context).add(
                                      EditSupplier(
                                        supplierId: supplierId!,
                                        mobile: mobileController.text,
                                        name: nameController.text,
                                        fax: faxController.text,
                                        mail: emailController.text,
                                        status: selectedStatus ?? stateStatus,
                                        telephone: telephoneController.text,
                                        vatNumber: vatNumberController.text,
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
