import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';

import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/products_screen/expired_products/expired_products_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';

import '../../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../../widgets/k_page_header.dart';
import '../../widgets/k_search_field.dart';

class ExpiredProductsScreen extends StatefulWidget {
  const ExpiredProductsScreen({Key? key}) : super(key: key);

  @override
  State<ExpiredProductsScreen> createState() => _ExpiredProductsScreenState();
}

class _ExpiredProductsScreenState extends State<ExpiredProductsScreen> {
  ExpiredProductsTableLogic expiredProductsTableLogic =
      ExpiredProductsTableLogic();
  List<BatchModel>? products = [];
  TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpiredProductBloc, ExpiredProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ExpiredProductsFetched) {
          products = state.expiredProducts;
        }
        return WillPopScope(
          onWillPop: () async {
            Navigator.popAndPushNamed(context, AppRouter.home);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text($t('headings.expiredProducts')),
              actions: [
                const KAppbarAvatar(),
                SizedBox(width: kPaddingX),
              ],
            ),
            drawer: MainSidebar(),
            drawerEdgeDragWidth: 30.w,
            body: KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  title: $t("headings.expiredProducts"),
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<ExpiredProductBloc>(context)
                        .add(FetchExpiredProducts(
                      searchText: searchController.text,
                      pageNo: currentPage,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<ExpiredProductBloc>(context)
                        .add(const FetchExpiredProducts());
                  },
                ),
                BlocBuilder<ExpiredProductBloc, ExpiredProductState>(
                  builder: (context, state) {
                    if (state is ExpiredProductsLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: products ?? [],
                        itemTableLogic: expiredProductsTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                          });
                          BlocProvider.of<ExpiredProductBloc>(context)
                              .add(FetchExpiredProducts(pageNo: currentPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<ExpiredProductBloc>(context)
                              .add(FetchExpiredProducts(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<ExpiredProductBloc>(context)
                              .add(FetchExpiredProducts(pageNo: currentPage));
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Navigator.pushNamed(context, AppRouter.productsScreen);
