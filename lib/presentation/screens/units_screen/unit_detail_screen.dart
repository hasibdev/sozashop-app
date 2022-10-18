import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/presentation/screens/units_screen/unit_conversions_screen/unit_conversions_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import 'package:sozashop_app/presentation/screens/widgets/k_page_header.dart';

import '../../../core/core.dart';
import '../../../logic/bloc/unit_bloc/unit_bloc.dart';
import '../../../logic/permissions.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_dialog.dart';
import '../widgets/k_search_field.dart';

class UnitDetailScreen extends StatefulWidget {
  const UnitDetailScreen({Key? key}) : super(key: key);

  @override
  State<UnitDetailScreen> createState() => _UnitDetailScreenState();
}

class _UnitDetailScreenState extends State<UnitDetailScreen> {
  UnitModel? unitDetails;
  UnitConversionsTableLogic unitConversionsTableLogic =
      UnitConversionsTableLogic();
  List<UnitConversionModel>? unitConversions = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitBloc, UnitState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UnitDetailState) {
          unitDetails = state.unit;
          unitConversions = state.unitConversions;
        }
        if (state is UnitConversionsFetched) {
          unitConversions = state.unitConversions;
        }

        if (state is LoadingState) {
          return const Scaffold(
            body: Center(child: KLoadingIcon()),
          );
        } else {
          return WillPopScope(
            onWillPop: () async {
              BlocProvider.of<UnitBloc>(context).add(GoAllUnitsPage());
              return false;
            },
            child: Scaffold(
              backgroundColor: KColors.greyLight,
              appBar: AppBar(
                title: Text($t('unit.title.details')),
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<UnitBloc>(context).add(GoAllUnitsPage());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: KPage(
                bottomPadding: 0,
                isScrollable: true,
                children: [
                  KDetailPageToggle(
                    title: unitDetails?.name,
                    items: [
                      KDetailPageItem(
                        titleText: $t('fields.name'),
                        valueText: unitDetails?.name,
                        hasPermission: Permissions.hasFieldPermission(
                            'settings.unit-details.name'),
                      ),
                      KDetailPageItem(
                        titleText: $t('fields.code'),
                        valueText: unitDetails?.code,
                        hasPermission: Permissions.hasFieldPermission(
                            'settings.unit-details.code'),
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
                                  .add(DeleteUnit(unitId: unitDetails!.id));

                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      KDataTableButton(
                        type: ButtonType.edit,
                        hasPermission:
                            Permissions.hasPagePermission('settings.edit-unit'),
                        onPressed: () {
                          BlocProvider.of<UnitBloc>(context)
                              .add(GoEditUnitPage(unitModel: unitDetails!));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  KPageheader(
                    title: '${$t("unit.label")} ${$t("conversions.label")}',
                    topPadding: 20.h,
                    hasPermission: true,
                    btnText: $t('conversions.title.add'),
                    onButtonTap: () {
                      BlocProvider.of<UnitBloc>(context)
                          .add(GoAddUnitConversionPage(baseUnit: unitDetails!));
                    },
                  ),
                  KSearchField(
                    controller: searchController,
                    onSearchTap: () {
                      BlocProvider.of<UnitBloc>(context)
                          .add(FetchUnitConversions(
                        baseUnitId: unitDetails!.id,
                        searchText: searchController.text,
                      ));
                    },
                    onClearSearch: () {
                      BlocProvider.of<UnitBloc>(context)
                          .add(FetchUnitConversions(
                        baseUnitId: unitDetails!.id,
                      ));
                    },
                  ),
                  BlocBuilder<UnitBloc, UnitState>(
                    builder: (context, state) {
                      if (state is UnitConversionsLoading) {
                        return SizedBox(
                          height: 500.h,
                          child: const Center(
                            child: KLoadingIcon(),
                          ),
                        );
                      } else {
                        return KDataTableWrapper(
                          height: 500.h,
                          itemList: unitConversions,
                          itemTableLogic: unitConversionsTableLogic,
                          onRefresh: () {
                            setState(() {
                              currentPage = 1;
                              searchController.clear();
                            });
                            BlocProvider.of<UnitBloc>(context)
                                .add(FetchUnitConversions(
                              baseUnitId: unitDetails!.id,
                              pageNo: currentPage,
                            ));
                          },
                          currentPage: currentPage,
                          onNextPage: () {
                            setState(() {
                              currentPage++;
                            });
                            BlocProvider.of<UnitBloc>(context)
                                .add(FetchUnitConversions(
                              baseUnitId: unitDetails!.id,
                              pageNo: currentPage,
                            ));
                          },
                          onPreviousPage: () {
                            setState(() {
                              currentPage--;
                              if (currentPage == 0) {
                                currentPage = 1;
                              }
                            });
                            BlocProvider.of<UnitBloc>(context)
                                .add(FetchUnitConversions(
                              baseUnitId: unitDetails!.id,
                              pageNo: currentPage,
                            ));
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
