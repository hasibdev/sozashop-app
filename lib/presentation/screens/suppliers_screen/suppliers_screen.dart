import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/suppliers_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';

import '../../../data/models/supplier_model.dart';
import '../../../logic/bloc/supplier_bloc/supplier_bloc.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_page.dart';
import '../widgets/k_page_header.dart';
import '../widgets/k_search_field.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({Key? key}) : super(key: key);

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  SuppliersTableLogic suppliersTableLogic = SuppliersTableLogic();
  List<SupplierModel>? suppliers = [];
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
          title: Text($t('suppliers.label')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<SupplierBloc, SupplierState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SuppliersFetched) {
              suppliers = state.suppliers;
            }
            return KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  title: $t("suppliers.label"),
                  hasPermission: true,
                  btnText: $t('suppliers.title.add'),
                  onButtonTap: () {
                    BlocProvider.of<SupplierBloc>(context)
                        .add(GoAddSupplierPage());
                  },
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<SupplierBloc>(context).add(FetchSuppliers(
                      searchText: searchController.text,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<SupplierBloc>(context)
                        .add(const FetchSuppliers());
                  },
                ),
                BlocBuilder<SupplierBloc, SupplierState>(
                  builder: (context, state) {
                    if (state is SuppliersLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: suppliers,
                        itemTableLogic: suppliersTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                          });
                          BlocProvider.of<SupplierBloc>(context)
                              .add(FetchSuppliers(pageNo: currentPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<SupplierBloc>(context)
                              .add(FetchSuppliers(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<SupplierBloc>(context)
                              .add(FetchSuppliers(pageNo: currentPage));
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
