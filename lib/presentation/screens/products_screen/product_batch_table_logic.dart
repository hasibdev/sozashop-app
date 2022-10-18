import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/permissions.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_main_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';
import 'package:toggle_list/toggle_list.dart';

import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_data_table.dart/k_data_table_detail_item.dart';
import '../widgets/k_snackbar.dart';

class ProductBatchTableLogic {
  // data table items
  List<ToggleListItem> kDataTableMainItems(
      {required List<dynamic> datas, required context}) {
    List<ToggleListItem> newListItems = [];

    TextEditingController editSellingRateController = TextEditingController();

    int indx = 0;
    for (indx; indx < datas.length; indx++) {
      BatchModel dataItem = datas[indx];

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
                case 'unitName':
                  return dataItem.unitName;
                case 'quantity':
                  return dataItem.quantity;
                case 'purchaseRate':
                  return dataItem.purchaseRate;
                case 'sellingRate':
                  return dataItem.sellingRate;
                case 'totalSellingRate':
                  return dataItem.totalSellingRate;
                case 'totalSale':
                  return dataItem.totalSale;
                case 'profit':
                  return dataItem.profit;
                case 'mfgDate':
                  return dataItem.mfgDate;
                case 'expDate':
                  return dataItem.expDate ?? '-';
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
            buttonText: $t('buttons.delete'),
            onPressed: () {
              KDialog(
                context: context,
                title: $t('batch.title.delete'),
                yesBtnPressed: () {
                  BlocProvider.of<ProductBloc>(context).add(
                    DeleteBatch(
                      ids: [dataItem.id],
                      productId: dataItem.productId,
                    ),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.edit,
            hasPermission: Permissions.hasActionPermission(
                'products.manage-batch.edit-batch-sellingRate'),
            onPressed: () {
              editSellingRateController.text = dataItem.sellingRate.toString();

              KDialog(
                context: context,
                dialogType: DialogType.form,
                title: $t('batch.title.edit'),
                formContent: [
                  KTextField(
                    labelText: $t('fields.sellingRate'),
                    controller: editSellingRateController,
                    isRequired: true,
                    textInputType: TextInputType.number,
                  ),
                ],
                yesBtnPressed: () {
                  if (editSellingRateController.text
                      .toString()
                      .trim()
                      .isNotEmpty) {
                    BlocProvider.of<ProductBloc>(context).add(EditBatch(
                      batchId: dataItem.id,
                      productId: dataItem.productId,
                      sellingRate: editSellingRateController.text,
                      productModel: dataItem.product,
                    ));
                    Navigator.pop(context);
                  } else {
                    KSnackBar(
                      context: context,
                      type: AlertType.failed,
                      message: 'Selling rate is required!',
                      durationSeconds: 4,
                    );
                  }
                },
              );
            },
          ),
          KDataTableButton(
            type: ButtonType.add,
            buttonText: $t('buttons.addStock'),
            hasPermission: Permissions.hasActionPermission(
                'products.manage-batch.batch-stock-quantity'),
            onPressed: () {
              BlocProvider.of<ProductBloc>(context)
                  .add(GoAddStockPage(batchModel: dataItem));
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
      "permission": "products.manage-batch.name",
    },
    {
      "field": "unitName",
      "label": 'fields.unitName',
      "permission": "products.manage-batch.unitName",
    },
    {
      "field": "quantity",
      "label": 'fields.quantity',
      "permission": "products.manage-batch.quantity",
    },
    {
      "field": "purchaseRate",
      "label": 'fields.purchaseRate',
      "permission": "products.manage-batch.purchaseRate",
    },
    {
      "field": "sellingRate",
      "label": 'fields.sellingRate',
      "permission": "products.manage-batch.sellingRate",
    },
    {
      "field": "totalSellingRate",
      "label": 'fields.totalSellingRate',
      "permission": "products.manage-batch.totalSellingRate",
    },
    {
      "field": "totalSale",
      "label": 'fields.totalSale',
      "permission": "products.manage-batch.totalSale",
    },
    {
      "field": "profit",
      "label": 'fields.profit',
    },
    {
      "field": "mfgDate",
      "label": 'fields.mfgDate',
      "permission": "products.manage-batch.mfgDate",
    },
    {
      "field": "expDate",
      "label": 'fields.expDate',
      "permission": "products.manage-batch.expDate",
    },
  ];
}
