import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:toggle_list/toggle_list.dart';

import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_snackbar.dart';

class ProductsTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      ProductModel dataItem = datas[indx];

      var item = kDataTableMainItem(
        text: datas[indx].name,
        items: (generateColumns()).map(
          (column) {
            String fieldName = column['field'];

            // get the values form switch cases
            generateValue() {
              switch (fieldName) {
                case 'name':
                  return dataItem.name;
                case 'categoryName':
                  return dataItem.categoryName;
                case 'code':
                  return dataItem.code;
                case 'storeIn':
                  return dataItem.storeIn;
                case 'size':
                  return dataItem.size;
                case 'color':
                  return dataItem.color;
                case 'brand':
                  return dataItem.brand;
                case 'unitName':
                  return dataItem.unitName;
                case 'purchaseUnits':
                  return dataItem.purchaseUnits?.length;
                case 'sellingUnits':
                  return dataItem.sellingUnits?.length;
                case 'totalQuantity':
                  return dataItem.totalQuantity;
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
            hasPermission: (Permissions.hasPermission('delete-products') ||
                Permissions.hasRole('Admin')),
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  BlocProvider.of<ProductBloc>(context).add(
                    DeleteProduct(productId: dataItem.id),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission:
                (Permissions.hasPagePermission('products.edit-product') &&
                    (Permissions.hasPermission('update-products') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<ProductBloc>(context)
                  .add(GoEditProductPage(productModel: dataItem));
            },
          ),
          KDataTableButton(
            type: ButtonType.barcode,
            hasPermission:
                (Permissions.hasPagePermission('categories.edit-category') &&
                    (Permissions.hasPermission('update-categories') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<ProductBloc>(context)
                  .add(GoProductBarcodePage(productId: dataItem.id));
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            hasPermission:
                (Permissions.hasPagePermission('products.product-detail') &&
                    (Permissions.hasPermission('view-products') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<ProductBloc>(context).add(
                GoProductDetailPage(
                  productModel: dataItem,
                  referPage: 'products',
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
      "label": 'fields.name',
      "permission": "products.manage-products.name",
    },
    {
      "field": "categoryName",
      "label": 'fields.categoryName',
      "permission": "products.manage-products.category",
    },
    {
      "field": "code",
      "label": 'fields.code',
      "permission": "products.manage-products.code",
    },
    {
      "field": "storeIn",
      "label": 'fields.storeIn',
      "permission": "products.manage-products.store-in",
    },
    {
      "field": "size",
      "label": 'fields.size',
      "permission": "products.manage-products.size",
    },
    {
      "field": "color",
      "label": 'fields.color',
      "permission": "products.manage-products.color",
    },
    {
      "field": "brand",
      "label": 'fields.brand',
      "permission": "products.manage-products.brand",
    },
    {
      "field": "unitName",
      "label": 'fields.unitName',
      "permission": "products.manage-products.unit",
    },
    {
      "field": "purchaseUnits",
      "label": 'fields.purchaseUnits',
      "permission": "products.manage-products.purchase-units",
    },
    {
      "field": "sellingUnits",
      "label": 'fields.sellingUnits',
      "permission": "products.manage-products.selling-units",
    },
    {
      "field": "totalQuantity",
      "label": 'fields.totalQuantity',
      "permission": "products.manage-products.total-quantity",
    },
    {
      "field": "status",
      "label": 'fields.status',
      "isBadge": true,
      "permission": true,
    },
  ];
}
