import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../../logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import '../../widgets/k_data_table.dart/k_data_table_button.dart';
import '../../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../../widgets/k_snackbar.dart';

class ManageStocksTableLogic {
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
                case 'alertQuantity':
                  return dataItem.alertQuantity;
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
            type: ButtonType.add,
            buttonText: $t('buttons.addStock'),
            btnColor: KColors.blue,
            hasPermission: (Permissions.hasActionPermission(
                'products.manage-stocks.add-stock')),
            onPressed: () {
              BlocProvider.of<ManageStocksBloc>(context)
                  .add(GoManageStockAddingPage(productId: dataItem.id));
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            onPressed: () {
              BlocProvider.of<ManageStocksBloc>(context).add(
                GoManageStockDetailPage(
                  productModel: dataItem,
                  fromPage: 'manageStocks',
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
      "permission": "products.manage-stocks.name",
    },
    {
      "field": "categoryName",
      "label": 'fields.categoryName',
      "permission": "products.manage-stocks.category",
    },
    {
      "field": "code",
      "label": 'fields.code',
      "permission": "products.manage-stocks.code",
    },
    {
      "field": "storeIn",
      "label": 'fields.storeIn',
      "permission": "products.manage-stocks.store-in",
    },
    {
      "field": "size",
      "label": 'fields.size',
      "permission": "products.manage-stocks.size",
    },
    {
      "field": "color",
      "label": 'fields.color',
      "permission": "products.manage-stocks.color",
    },
    {
      "field": "brand",
      "label": 'fields.brand',
      "permission": "products.manage-stocks.brand",
    },
    {
      "field": "purchaseUnits",
      "label": 'fields.purchaseUnits',
      "permission": "products.manage-stocks.purchase-units",
    },
    {
      "field": "sellingUnits",
      "label": 'fields.sellingUnits',
      "permission": "products.manage-stocks.selling-units",
    },
    {
      "field": "totalQuantity",
      "label": 'fields.totalQuantity',
      "permission": "products.manage-stocks.total-quantity",
    },
    {
      "field": "alertQuantity",
      "label": 'fields.alertQuantity',
      "permission": "products.manage-stocks.alert-quantity",
    },
  ];
}
