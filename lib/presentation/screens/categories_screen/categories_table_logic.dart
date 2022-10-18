import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../data/models/category_model.dart';
import '../../../logic/bloc/category_bloc/category_bloc.dart';
import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';

class CategoriesTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      CategoryModel dataItem = datas[indx];

      var item = kDataTableMainItem(
        text: datas[indx].name,
        items: (generateColumns()).map((column) {
          String fieldName = column['field'];

          // get the values form switch cases
          generateValue() {
            switch (fieldName) {
              case 'name':
                return datas[indx].name;
              case 'description':
                return datas[indx].description ?? '-';
              case 'totalProduct':
                return datas[indx].totalProduct;
              case 'totalSaleAmount':
                return datas[indx].totalSaleAmount;
              case 'status':
                return datas[indx].status;
              default:
                '';
            }
          }

          // returned generated item
          return KDataTableDetailItem(
            titleText: column['label'],
            valueText: generateValue().toString(),
            isBadge: column['isBadge'] ?? false,
          );
        }).toList(),
        buttons: [
          KDataTableButton(
            type: ButtonType.delete,
            hasPermission: (Permissions.hasPermission('delete-categories') ||
                Permissions.hasRole('Admin')),
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  BlocProvider.of<CategoryBloc>(context).add(
                    DeleteCategory(categoryId: dataItem.id),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission:
                (Permissions.hasPagePermission('categories.edit-category') &&
                    (Permissions.hasPermission('update-categories') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<CategoryBloc>(context).add(
                GoEditCategoryPage(category: dataItem),
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            hasPermission:
                (Permissions.hasPagePermission('categories.category-detail') &&
                    (Permissions.hasPermission('view-categories') ||
                        Permissions.hasRole('Admin'))),
            onPressed: () {
              BlocProvider.of<CategoryBloc>(context)
                  .add(GetCategoryDetails(category: dataItem));
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
        return item['permission'];
      } else {
        return true;
      }
    }).toList();
  }

  var tableColumns = [
    {
      "field": "name",
      "label": $t('fields.name'),
      "isBadge": false,
      "permission":
          Permissions.hasFieldPermission("categories.manage-categories.name"),
    },
    {
      "field": "description",
      "label": $t('fields.description'),
      // "isBadge": false,
      "permission": Permissions.hasFieldPermission(
          "categories.manage-categories.description"),
    },
    {
      "field": "totalProduct",
      "label": $t('fields.totalProduct'),
      "isBadge": false,
      "permission": Permissions.hasFieldPermission(
          "categories.manage-categories.total-product"),
    },
    {
      "field": "totalSaleAmount",
      "label": $t('fields.totalSale'),
      "isBadge": false,
      "permission": Permissions.hasFieldPermission(
          "categories.manage-categories.total-sale"),
    },
    {
      "field": "status",
      "label": $t('fields.status'),
      "isBadge": true,
      "permission":
          Permissions.hasFieldPermission("categories.manage-categories.status"),
    },
  ];
}
