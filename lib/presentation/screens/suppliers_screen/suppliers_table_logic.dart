import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_dialog.dart';

class SuppliersTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      SupplierModel dataItem = datas[indx];

      var item = kDataTableMainItem(
        text: datas[indx].name,
        items: (generateColumns()).map(
          (column) {
            String fieldName = column['field'];

            // get the values form switch cases
            generateValue() {
              switch (fieldName) {
                case 'id':
                  return dataItem.id;
                case 'name':
                  return dataItem.name;
                case 'mobile':
                  return dataItem.mobile;
                case 'telephone':
                  return dataItem.telephone;
                case 'fax':
                  return dataItem.fax;
                case 'email':
                  return dataItem.email;
                case 'vatNumber':
                  return dataItem.vatNumber;
                case 'openingBalance':
                  return dataItem.openingBalance;
                case 'totalInvoice':
                  return dataItem.totalInvoice;
                case 'totalAmount':
                  return dataItem.totalAmount;
                case 'totalDue':
                  return dataItem.totalDue;
                case 'status':
                  return dataItem.status;
                default:
                  '';
              }
            }

            // returned generated item
            return KDataTableDetailItem(
              titleText: $t(column['label']),
              valueText: generateValue().toString(),
              isBadge: column['isBadge'] ?? false,
            );
          },
        ).toList(),
        buttons: [
          KDataTableButton(
            type: ButtonType.delete,
            hasPermission: Permissions.hasPermission('delete-suppliers') ||
                Permissions.hasRole('Admin'),
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  BlocProvider.of<SupplierBloc>(context)
                      .add(DeleteSupplier(supplierId: dataItem.id));

                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission:
                Permissions.hasPagePermission('suppliers.edit-suppliers') &&
                    (Permissions.hasPermission('update-suppliers') ||
                        Permissions.hasRole('Admin')),
            onPressed: () {
              BlocProvider.of<SupplierBloc>(context)
                  .add(GoEditSupplierPage(supplierModel: dataItem));
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            hasPermission:
                Permissions.hasPagePermission('suppliers.suppliers-details') &&
                    (Permissions.hasPermission('view-suppliers') ||
                        Permissions.hasRole('Admin')),
            onPressed: () {
              BlocProvider.of<SupplierBloc>(context)
                  .add(GoSupplierDetailPage(supplierModel: dataItem));
            },
          ),
        ],
      );
      newListItems.add(item);
    }
    return newListItems;
  }

  // generated columns
  List<dynamic> generateColumns() {
    // ignore: unnecessary_cast
    return (tableColumns as List).where((item) {
      if (item.containsKey('permission')) {
        return Permissions.hasFieldPermission(item['permission']);
      } else {
        return true;
      }
    }).toList();
  }

  var tableColumns = [
    {
      "field": "id",
      "label": 'fields.id',
      "permission": "suppliers.manage-suppliers.id",
    },
    {
      "field": "name",
      "label": 'fields.name',
      "permission": "suppliers.manage-suppliers.name",
    },
    {
      "field": "mobile",
      "label": 'fields.mobile',
      "permission": "suppliers.manage-suppliers.mobile",
    },
    {
      "field": "telephone",
      "label": 'fields.telephone',
      "permission": "suppliers.manage-suppliers.telephone",
    },
    {
      "field": "fax",
      "label": 'fields.fax',
      "permission": "suppliers.manage-suppliers.fax",
    },
    {
      "field": "email",
      "label": 'fields.email',
      "permission": "suppliers.manage-suppliers.email",
    },
    {
      "field": "vatNumber",
      "label": 'fields.vatNumber',
      "permission": "suppliers.manage-suppliers.vat-number",
    },
    {
      "field": "openingBalance",
      "label": 'fields.openingBalance',
      "permission": "suppliers.manage-suppliers.opening-balance",
    },
    {
      "field": "totalInvoice",
      "label": 'fields.totalInvoice',
      "permission": "suppliers.manage-suppliers.total-invoice",
    },
    {
      "field": "totalAmount",
      "label": 'fields.totalAmount',
      "permission": "suppliers.manage-suppliers.total-amount",
    },
    {
      "field": "paidAmount",
      "label": 'fields.paidAmount',
      "permission": "suppliers.manage-suppliers.total-paid",
    },
    {
      "field": "totalDue",
      "label": 'fields.totalDue',
      "permission": "suppliers.manage-suppliers.total-due",
    },
    {
      "field": "status",
      "label": 'fields.status',
      "isBadge": true,
      "permission": "suppliers.manage-suppliers.status",
    },
  ];
}
