import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:toggle_list/toggle_list.dart';

import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_dialog.dart';

class UnitsTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      UnitModel dataItem = datas[indx];

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
                case 'code':
                  return dataItem.code;
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
            onPressed: () {
              KDialog(
                context: context,
                yesBtnPressed: () {
                  BlocProvider.of<UnitBloc>(context)
                      .add(DeleteUnit(unitId: dataItem.id));

                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission: Permissions.hasPagePermission('settings.edit-unit'),
            onPressed: () {
              BlocProvider.of<UnitBloc>(context)
                  .add(GoEditUnitPage(unitModel: dataItem));
            },
          ),
          KDataTableButton(
            type: ButtonType.details,
            hasPermission:
                Permissions.hasPagePermission('settings.unit-details'),
            onPressed: () {
              BlocProvider.of<UnitBloc>(context)
                  .add(GoUnitDetailPage(unitModel: dataItem));
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
      "permission": "settings.manage-units.name",
    },
    {
      "field": "code",
      "label": 'fields.code',
      "permission": "settings.manage-units.code",
    },
  ];
}
