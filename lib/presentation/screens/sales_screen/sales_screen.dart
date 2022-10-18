import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/sale_model.dart';
import 'package:sozashop_app/logic/bloc/sale_bloc/sale_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/sales_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_search_field.dart';

import '../../../logic/permissions.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_page.dart';
import '../widgets/k_page_header.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  SalesTableLogic salesTableLogic = SalesTableLogic();
  List<SaleModel>? saleInvoices = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int perPage = 25;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, AppRouter.home);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text($t('sales.title.manage')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<SaleBloc, SaleState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SalesFetched) {
              saleInvoices = state.sales;
            }

            return KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  bottomPadding: 10.h,
                  title: $t("sales.title.manage"),
                  hasPermission:
                      Permissions.hasPagePermission('sales.new-sales') &&
                          (Permissions.hasPermission('create-sale-invoices') ||
                              Permissions.hasRole('Admin')),
                  btnText: $t('sales.title.add'),
                  onButtonTap: () {
                    BlocProvider.of<SaleBloc>(context).add(GoToAddSalePage());
                  },
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<SaleBloc>(context)
                        .add(FetchSales(searchText: searchController.text));
                  },
                  onClearSearch: () {
                    BlocProvider.of<SaleBloc>(context).add(const FetchSales());
                  },
                ),
                BlocBuilder<SaleBloc, SaleState>(
                  builder: (context, state) {
                    if (state is SalesLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: saleInvoices,
                        itemTableLogic: salesTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                          });
                          BlocProvider.of<SaleBloc>(context).add(FetchSales(
                              pageNo: currentPage, perPage: perPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<SaleBloc>(context).add(FetchSales(
                              pageNo: currentPage, perPage: perPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<SaleBloc>(context).add(FetchSales(
                              pageNo: currentPage, perPage: perPage));
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
