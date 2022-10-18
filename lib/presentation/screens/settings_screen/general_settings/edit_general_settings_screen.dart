import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../../data/models/client_settings_model.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';

class EditGeneralSettingsScreen extends StatelessWidget {
  EditGeneralSettingsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController invoiceFooterController = TextEditingController();
  var selectedCustomerName;

  CustomerModel? selectedCustomer;
  CustomerModel? defaultCustomer;
  var stateSelectedCustomer;
  var stateDefaultCustomerId;

  ClientSettingsModel? clientSettingsModel;
  List<CustomerModel>? customers;

  getSelectedCustomer() {
    selectedCustomer = customers
        ?.firstWhere((element) => element.name == selectedCustomerName);
  }

  getDefaultCustomer() {
    defaultCustomer = customers
        ?.firstWhere((element) => element.id == stateDefaultCustomerId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<GeneralSettingsBloc>(context)
            .add(GoGeneralSettingsPage());

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            $t('settings.title.edit'),
          ),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<GeneralSettingsBloc>(context)
                  .add(GoGeneralSettingsPage());
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocBuilder<GeneralSettingsBloc, GeneralSettingsState>(
          builder: (context, state) {
            if (state is GeneralSettingsEditingState) {
              clientSettingsModel = state.clientSettingsModel;
              customers = state.customers;

              nameController.text = state.name;
              addressController.text = state.address ?? '';
              websiteController.text = state.website ?? '';
              invoiceFooterController.text = state.invoiceFooter ?? '';
              stateSelectedCustomer = state.clientSettingsModel?.customer;
              stateDefaultCustomerId = state.defaultCustomerId;

              print('type ${state.defaultCustomerId}');
            }
            if (state is GeneralSettingsEditingFailed) {
              stateSelectedCustomer = clientSettingsModel?.customer;
              getSelectedCustomer();
              getDefaultCustomer();
            }

            return KPage(
              children: [
                KPageMiddle(
                  // isExpanded: false,
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    KTextField(
                      labelText: $t('fields.name'),
                      controller: nameController,
                    ),
                    KTextField(
                      labelText: $t('fields.currency'),
                      controller: currencyController,
                    ),
                    KTextField(
                      labelText: $t('fields.address'),
                      controller: addressController,
                    ),
                    KTextField(
                      labelText: $t('fields.website'),
                      controller: websiteController,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => KDropdown(
                        labelText: "Default Customer",
                        value: selectedCustomerName ??
                            defaultCustomer?.name ??
                            stateSelectedCustomer?.name,
                        items: customers?.map((e) => e.name).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCustomerName = value;
                            getSelectedCustomer();
                            // getInvoiceId();
                          });
                        },
                      ),
                    ),
                    KTextField(
                      labelText: $t('fields.invoiceFooter'),
                      controller: invoiceFooterController,
                    ),
                  ],
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Flexible(
                      flex: 1,
                      child: KFilledButton(
                        text: $t("buttons.cancel"),
                        buttonColor: Colors.grey.shade300,
                        textColor: Colors.grey.shade600,
                        onPressed: () {
                          BlocProvider.of<GeneralSettingsBloc>(context)
                              .add(GoGeneralSettingsPage());
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 2,
                      child: KFilledButton(
                        text: $t("buttons.update"),
                        onPressed: () {
                          BlocProvider.of<GeneralSettingsBloc>(context)
                              .add(UpdateClientSettings(
                            name: nameController.text,
                            address: addressController.text,
                            website: websiteController.text,
                            invoiceFooter: invoiceFooterController.text,
                            defaultCustomerId: selectedCustomer?.id ??
                                stateSelectedCustomer?.id,
                          ));

                          print("""
                                Submitting:
                                name: ${nameController.text},
                                selectedCustomer: ${selectedCustomer?.id} ?? ${stateSelectedCustomer?.id},
                                """);
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
