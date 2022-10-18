import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_detail_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../../core/core.dart';
import '../../../../logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import '../../widgets/k_data_table.dart/k_data_table_button.dart';

class ExpiredProductsTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      BatchModel? dataItem = datas[indx];

      var item = kDataTableMainItem(
        text: datas[indx].name,
        items: (generateColumns()).map(
          (column) {
            String fieldName = column['field'];

            // get the values form switch cases
            generateValue() {
              switch (fieldName) {
                case 'name':
                  return dataItem?.name;
                case 'productName':
                  return dataItem?.productName;
                case 'categoryName':
                  return dataItem?.categoryName;
                case 'productColor':
                  return dataItem?.productColor;
                case 'productCode':
                  return dataItem?.productCode;
                case 'expDate':
                  return dataItem?.expDate;
                case 'quantity':
                  return dataItem?.quantity;

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
          // delete button
          KDataTableButton(
            type: ButtonType.delete,
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  // BlocProvider.of<ProductBloc>(context).add(
                  //   DeleteProduct(productId: dataItem.id),
                  // );
                  Navigator.pop(context);
                },
              );
            },
          ),

          // details button
          KDataTableButton(
            type: ButtonType.details,
            onPressed: () {
              BlocProvider.of<ExpiredProductBloc>(context).add(
                GoExpiredProductDetailPage(
                  productModel: dataItem!.product,
                  fromPage: 'expiredProducts',
                ),
              );
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
      "field": "name",
      "label": 'fields.batch',
      "permission": "products.expired-products.batch",
    },
    {
      "field": "productName",
      "label": 'fields.product',
      "permission": "products.expired-products.product",
    },
    {
      "field": "categoryName",
      "label": 'fields.category',
      "permission": "products.expired-products.category",
    },
    {
      "field": "productColor",
      "label": 'fields.color',
      "permission": "products.expired-products.color",
    },
    {
      "field": "productCode",
      "label": 'fields.code',
      "permission": "products.expired-products.code",
    },
    {
      "field": "expDate",
      "label": 'fields.expiredDate',
      "permission": "products.expired-products.expired-date",
    },
    {
      "field": "quantity",
      "label": 'fields.quantity',
      "permission": "products.expired-products.quantity",
    },
  ];
}
