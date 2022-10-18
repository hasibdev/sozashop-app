import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import 'package:sozashop_app/presentation/screens/widgets/k_page_header.dart';

import '../../../core/core.dart';
import '../../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../widgets/k_dialog.dart';

class SupplierDetailScreen extends StatelessWidget {
  SupplierDetailScreen({Key? key}) : super(key: key);

  SupplierModel? supplierDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplierBloc, SupplierState>(
      listener: (context, state) {
        if (state is SupplierDetailState) {
          supplierDetails = state.supplier;
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(child: KLoadingIcon()),
          );
        } else {
          return WillPopScope(
            onWillPop: () async {
              BlocProvider.of<SupplierBloc>(context).add(GoAllSuppliersPage());
              return false;
            },
            child: Scaffold(
              backgroundColor: KColors.greyLight,
              appBar: AppBar(
                title: Text($t('suppliers.title.details')),
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SupplierBloc>(context)
                        .add(GoAllSuppliersPage());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: BlocBuilder<SupplierBloc, SupplierState>(
                builder: (context, state) {
                  if (state is SupplierDetailState) {
                    supplierDetails = state.supplier;
                  }
                  return KPage(
                    isScrollable: true,
                    children: [
                      KPageheader(
                        title: "${supplierDetails?.name}",
                      ),
                      KDetailPageToggle(
                        title: supplierDetails?.name,
                        items: [
                          KDetailPageItem(
                            titleText: $t('fields.name'),
                            valueText: supplierDetails?.name,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.name'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.mobile'),
                            valueText: supplierDetails?.mobile,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.mobile'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.telephone'),
                            valueText: supplierDetails?.telephone,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.telephone'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.email'),
                            valueText: supplierDetails?.email,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.email'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.fax'),
                            valueText: supplierDetails?.fax,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.fax'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.vatNumber'),
                            valueText: supplierDetails?.vatNumber,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.vat-number'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.openingBalance'),
                            valueText:
                                supplierDetails?.openingBalance.toString(),
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.opening-balance'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalInvoice'),
                            valueText: supplierDetails?.totalInvoice.toString(),
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.total-invoice'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalAmount'),
                            valueText: supplierDetails?.totalAmount.toString(),
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.total-amount'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalPaid'),
                            valueText: supplierDetails?.paidAmount.toString(),
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.total-paid'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.totalDue'),
                            valueText: supplierDetails?.totalDue.toString(),
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.total-due'),
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.status'),
                            valueText: supplierDetails?.status,
                            isBadge: true,
                            hasPermission: Permissions.hasFieldPermission(
                                'suppliers.suppliers-details.status'),
                          ),
                        ],
                        buttons: [
                          KDataTableButton(
                            type: ButtonType.delete,
                            hasPermission:
                                Permissions.hasPermission('delete-suppliers') ||
                                    Permissions.hasRole('Admin'),
                            onPressed: () {
                              KDialog(
                                context: context,
                                yesBtnPressed: () {
                                  BlocProvider.of<SupplierBloc>(context).add(
                                      DeleteSupplier(
                                          supplierId: supplierDetails!.id));

                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          KDataTableButton(
                            type: ButtonType.edit,
                            hasPermission: Permissions.hasPagePermission(
                                    'suppliers.edit-suppliers') &&
                                (Permissions.hasPermission(
                                        'update-suppliers') ||
                                    Permissions.hasRole('Admin')),
                            onPressed: () {
                              //
                            },
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
      },
    );
  }
}
