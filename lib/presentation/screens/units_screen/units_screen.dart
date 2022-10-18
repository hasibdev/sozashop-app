import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/units_screen/units_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_wrapper.dart';

import '../widgets/k_page.dart';
import '../widgets/k_page_header.dart';
import '../widgets/k_search_field.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  UnitsTableLogic unitsTableLogic = UnitsTableLogic();
  List<UnitModel>? units = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, AppRouter.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text($t('units.label')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<UnitBloc, UnitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UnitsFetched) {
              units = state.units;
            }
            return KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  title: $t("units.label"),
                  hasPermission: true,
                  btnText: $t('unit.title.add'),
                  onButtonTap: () {
                    context.read<UnitBloc>().add(GoAddUnitPage());
                  },
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<UnitBloc>(context).add(FetchUnits(
                      searchText: searchController.text,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<UnitBloc>(context).add(const FetchUnits());
                  },
                ),
                BlocBuilder<UnitBloc, UnitState>(
                  builder: (context, state) {
                    if (state is UnitsLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: units,
                        itemTableLogic: unitsTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                          });
                          BlocProvider.of<UnitBloc>(context)
                              .add(FetchUnits(pageNo: currentPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<UnitBloc>(context)
                              .add(FetchUnits(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<UnitBloc>(context)
                              .add(FetchUnits(pageNo: currentPage));
                        },
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
