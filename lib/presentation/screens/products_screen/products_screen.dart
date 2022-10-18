import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/products_screen/products_table_logic.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';

import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_page.dart';
import '../widgets/k_page_header.dart';
import '../widgets/k_search_field.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductsTableLogic productsTableLogic = ProductsTableLogic();
  List<ProductModel>? products = [];
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
          title: Text($t('products.label')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsFetched) {
              products = state.products;
            }
            return KPage(
              bottomPadding: 0,
              children: [
                KPageheader(
                  title: $t("products.label"),
                  hasPermission: true,
                  btnText: $t('products.title.add'),
                  onButtonTap: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(GoAddProductPage());
                  },
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<ProductBloc>(context).add(FetchProducts(
                      searchText: searchController.text,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(const FetchProducts());
                  },
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductsLoading ||
                        state is ProductsListLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: products ?? [],
                        itemTableLogic: productsTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                          });
                          BlocProvider.of<ProductBloc>(context)
                              .add(FetchProducts(pageNo: currentPage));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<ProductBloc>(context)
                              .add(FetchProducts(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<ProductBloc>(context)
                              .add(FetchProducts(pageNo: currentPage));
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
