import 'package:sozashop_app/data/models/payment_model.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:toggle_list/toggle_list.dart';

import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_snackbar.dart';

class PaymentsTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      //* change the data type
      PaymentModel dataItem = datas[indx];

      var item = kDataTableMainItem(
        text:
            '#${indx + 1} - ${dataItem.amount} (${dataItem.method.toCapitalized()})',
        items: (generateColumns()).map(
          (column) {
            String fieldName = column['field'];

            // get the values form switch cases
            generateValue() {
              switch (fieldName) {
                case 'paymentAt':
                  return dataItem.paymentAt;
                case 'amount':
                  return dataItem.amount;
                case 'method':
                  return dataItem.method.toCapitalized();

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
        buttons: null,
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
      "field": "paymentAt",
      "label": 'fields.paymentAt',
    },
    {
      "field": "amount",
      "label": 'fields.amount',
    },
    {
      "field": "method",
      "label": 'fields.method',
    },
  ];
}
