import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../data/models/sale_model.dart';
import '../../../logic/bloc/sale_bloc/sale_bloc.dart';
import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_snackbar.dart';

class SalesTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      SaleModel dataItem = datas[indx];

      var item = kDataTableMainItem(
        text: datas[indx].invoiceNo + ' - ' + datas[indx].customerName,
        items: (generateColumns()).map(
          (column) {
            String fieldName = column['field'];

            // get the values form switch cases
            generateValue() {
              switch (fieldName) {
                case 'invoiceNo':
                  return dataItem.invoiceNo;
                case 'invoiceDateFormatted':
                  return dataItem.invoiceDateFormatted;
                case 'dueDateFormatted':
                  return dataItem.dueDateFormatted;
                case 'creator':
                  return dataItem.creator;
                case 'customerName':
                  return dataItem.customerName;
                case 'totalAmount':
                  return dataItem.totalAmount;
                case 'totalCharge':
                  return dataItem.totalCharge;
                case 'totalDiscount':
                  return dataItem.totalDiscount;
                case 'totalCost':
                  return dataItem.totalCost;
                case 'paidAmount':
                  return dataItem.paidAmount;
                case 'totalDue':
                  return dataItem.totalDue.toStringAsFixed(2);
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
            hasPermission: (dataItem.status == 'draft') &&
                (Permissions.hasPermission('delete-sale-invoices') ||
                    Permissions.hasRole('Admin')),
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  BlocProvider.of<SaleBloc>(context).add(
                    DeleteSale(id: dataItem.id),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.returns,
            buttonText: 'Return',
            hasPermission:
                Permissions.hasPagePermission('sales.add-return-invoice'),
            onPressed: () {
              // BlocProvider.of<ProductBloc>(context)
              //     .add(GoProductBarcodePage(productId: dataItem.id));
            },
          ),
          KDataTableButton(
            type: ButtonType.share,
            buttonText: 'Share',
            hasPermission: (dataItem.status != 'draft') &&
                Permissions.hasActionPermission(
                    'sales.manage-sales.share-button'),
            onPressed: () {
              // BlocProvider.of<ProductBloc>(context)
              //     .add(GoProductBarcodePage(productId: dataItem.id));
            },
          ),
          KDataTableButton(
            type: ButtonType.invoice,
            buttonText: 'Invoice',
            hasPermission: dataItem.status != 'draft',
            onPressed: () {
              // BlocProvider.of<ProductBloc>(context)
              //     .add(GoProductBarcodePage(productId: dataItem.id));
            },
          ),
          StatefulBuilder(
            builder: (context, setState) => Form(
              child: KDataTableButton(
                type: ButtonType.pay,
                hasPermission: (dataItem.status != 'draft'),
                buttonText: 'Pay Now',
                onPressed: () {
                  BlocProvider.of<SaleBloc>(context)
                      .add(GoToAddPaymentPage(saleInvoice: dataItem));
                },
              ),
            ),
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission: dataItem.status == 'draft' &&
                (Permissions.hasPagePermission('sales.edit-sales') &&
                    (Permissions.hasPermission('update-sale-invoices') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<SaleBloc>(context)
                  .add(GoToEditSalePage(saleInvoiceId: dataItem.id));
            },
          ),
          KDataTableButton(
            type: ButtonType.confirm,
            hasPermission: (dataItem.status == 'draft'),
            onPressed: () {
              KDialog(
                context: context,
                bodyText: 'Are you sure want to confirm?',
                yesBtnPressed: () {
                  BlocProvider.of<SaleBloc>(context).add(
                    ConfirmSale(ids: [dataItem.id]),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            hasPermission:
                (Permissions.hasPagePermission('sales.sales-details') &&
                    (Permissions.hasPermission('view-sale-invoices') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<SaleBloc>(context)
                  .add(GoToSaleDetailPage(saleInvoiceId: dataItem.id));
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
      "field": "invoiceNo",
      "label": 'fields.invoiceNo',
      "permission": "sales.manage-sales.invoice-no",
    },
    {
      "field": "invoiceDateFormatted",
      "label": 'fields.date',
      "permission": "sales.manage-sales.date",
    },
    {
      "field": "dueDateFormatted",
      "label": 'fields.dueDate',
      "permission": "sales.manage-sales.due-date",
    },
    {
      "field": "creator",
      "label": 'fields.creator',
      "permission": "sales.manage-sales.creator",
    },
    {
      "field": "customerName",
      "label": 'fields.customerName',
      "permission": "sales.manage-sales.customer",
    },
    {
      "field": "totalAmount",
      "label": 'fields.totalAmount',
      "permission": "sales.manage-sales.total-amount",
    },
    {
      "field": "totalCharge",
      "label": 'fields.totalCharge',
      "permission": "sales.manage-sales.total-charge",
    },
    {
      "field": "totalDiscount",
      "label": 'fields.totalDiscount',
      "permission": "sales.manage-sales.total-discount",
    },
    {
      "field": "totalCost",
      "label": 'fields.totalCost',
      "permission": "sales.manage-sales.total-cost",
    },
    {
      "field": "paidAmount",
      "label": 'fields.paidAmount',
      "permission": "sales.manage-sales.total-paid",
    },
    {
      "field": "totalDue",
      "label": 'fields.totalDue',
      "permission": "sales.manage-sales.total-due",
    },
    {
      "field": "status",
      "label": 'fields.status',
      "isBadge": true,
      "permission": 'sales.manage-sales.status',
    },
  ];
}
