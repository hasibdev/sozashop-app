import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import '../../../../core/core.dart';
import '../../../../data/models/unit_model.dart';
import '../../../../logic/bloc/unit_bloc/unit_bloc.dart';
import '../../widgets/k_dialog.dart';

class UnitConversionDetailScreen extends StatelessWidget {
  UnitConversionDetailScreen({Key? key}) : super(key: key);

  UnitConversionModel? unitConversionDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitBloc, UnitState>(
      listener: (context, state) {
        if (state is UnitConversionDetailState) {
          unitConversionDetails = state.unitConversionModel;
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
              BlocProvider.of<UnitBloc>(context).add(GoUnitDetailPage(
                unitModel: unitConversionDetails?.baseUnit as UnitModel,
              ));
              return false;
            },
            child: Scaffold(
              // backgroundColor: const Color(0xffF8F8FA),
              appBar: AppBar(
                title: Text($t('conversions.title.details')),
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<UnitBloc>(context).add(GoUnitDetailPage(
                      unitModel: unitConversionDetails?.baseUnit as UnitModel,
                    ));
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),

              body: BlocBuilder<UnitBloc, UnitState>(
                builder: (context, state) {
                  if (state is UnitConversionDetailState) {
                    unitConversionDetails = state.unitConversionModel;
                  }
                  return KPage(
                    children: [
                      KDetailPageToggle(
                        title: '${unitConversionDetails?.baseUnit.name}',
                        items: [
                          KDetailPageItem(
                            titleText: $t('fields.baseUnit'),
                            valueText: unitConversionDetails?.baseUnitName,
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.unit'),
                            valueText: unitConversionDetails?.unitName,
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.operator'),
                            valueText: unitConversionDetails?.unitOperator,
                          ),
                          KDetailPageItem(
                            titleText: $t('fields.value'),
                            valueText: unitConversionDetails?.value,
                          ),
                        ],
                        buttons: [
                          KDataTableButton(
                            type: ButtonType.delete,
                            onPressed: () {
                              KDialog(
                                context: context,
                                yesBtnPressed: () {
                                  BlocProvider.of<UnitBloc>(context)
                                      .add(DeleteUnitConversion(
                                    baseUnit: unitConversionDetails!.baseUnit,
                                    unitConversionId: unitConversionDetails!.id,
                                  ));

                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          KDataTableButton(
                            type: ButtonType.edit,
                            onPressed: () {
                              BlocProvider.of<UnitBloc>(context)
                                  .add(GoEditUnitConversionPage(
                                baseUnit: unitConversionDetails!.baseUnit,
                                unitConversionModel: unitConversionDetails!,
                              ));
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
