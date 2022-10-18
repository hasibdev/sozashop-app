import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/categories_screen/categories_table_logic.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_appbar_avatar.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_search_field.dart';

import '../../../data/models/category_model.dart';
import '../../../logic/bloc/category_bloc/category_bloc.dart';
import '../../router/app_router.dart';
import '../widgets/k_data_table.dart/k_data_table_wrapper.dart';
import '../widgets/k_page_header.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesTableLogic categoriesTableLogic = CategoriesTableLogic();
  List<CategoryModel>? categories = [];
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
          title: Text($t('categories.label')),
          actions: [
            const KAppbarAvatar(),
            SizedBox(width: kPaddingX),
          ],
        ),
        drawer: MainSidebar(),
        drawerEdgeDragWidth: 30.w,
        body: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CategoriesFetched) {
              categories = state.categories;
            }
            if (state is NewCategoriesFetched) {
              categories = state.categories;
            }
            return KPage(
              children: [
                KPageheader(
                  title: $t("categories.label"),
                  hasPermission: true,
                  bottomPadding: 10.h,
                  btnText: $t('categories.title.add'),
                  onButtonTap: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(GoAddCategoryPage());
                  },
                ),
                KSearchField(
                  controller: searchController,
                  onSearchTap: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(FetchNewCategories(
                      searchText: searchController.text,
                    ));
                  },
                  onClearSearch: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(const FetchNewCategories());
                  },
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading ||
                        state is CategoryListLoading) {
                      return const Expanded(
                        child: Center(child: KLoadingIcon()),
                      );
                    } else {
                      return KDataTableWrapper(
                        itemList: categories ?? [],
                        itemTableLogic: categoriesTableLogic,
                        onRefresh: () {
                          setState(() {
                            currentPage = 1;
                            searchController.clear();
                          });
                          BlocProvider.of<CategoryBloc>(context)
                              .add(FetchNewCategories(
                            pageNo: currentPage,
                          ));
                        },
                        currentPage: currentPage,
                        onNextPage: () {
                          setState(() {
                            currentPage++;
                          });
                          BlocProvider.of<CategoryBloc>(context)
                              .add(FetchNewCategories(pageNo: currentPage));
                        },
                        onPreviousPage: () {
                          setState(() {
                            currentPage--;
                            if (currentPage == 0) {
                              currentPage = 1;
                            }
                          });
                          BlocProvider.of<CategoryBloc>(context)
                              .add(FetchNewCategories(pageNo: currentPage));
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
