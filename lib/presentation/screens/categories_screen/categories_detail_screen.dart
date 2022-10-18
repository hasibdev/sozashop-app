import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';

import 'package:sozashop_app/logic/bloc/category_bloc/category_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_detail_page_toggle.dart';

import '../../../logic/permissions.dart';
import '../widgets/k_data_table.dart/k_data_table_button.dart';
import '../widgets/k_detail_page_item.dart';
import '../widgets/k_dialog.dart';
import '../widgets/k_page.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryDetailsState) {
          return WillPopScope(
            onWillPop: () async {
              BlocProvider.of<CategoryBloc>(context).add(GoAllCategoriesPage());
              return false;
            },
            child: Scaffold(
              backgroundColor: KColors.greyLight,
              appBar: AppBar(
                title: Text($t('categories.title.details')),
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(GoAllCategoriesPage());
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: KPage(
                children: [
                  KDetailPageToggle(
                    title: state.category.name,
                    items: [
                      KDetailPageItem(
                        titleText: $t('fields.name'),
                        valueText: state.category.name.toString(),
                        hasPermission: Permissions.hasFieldPermission(
                            'categories.category-detail.name'),
                      ),
                      KDetailPageItem(
                        titleText: $t('fields.description'),
                        valueText: state.category.description ?? '',
                        hasPermission: Permissions.hasFieldPermission(
                            "categories.category-detail.description"),
                      ),
                      KDetailPageItem(
                        titleText: $t('fields.totalProduct'),
                        valueText: state.category.productsCount.toString(),
                        hasPermission: Permissions.hasFieldPermission(
                            "categories.category-detail.total-product"),
                      ),
                      KDetailPageItem(
                        titleText: $t('fields.totalSale'),
                        valueText: state.category.totalSaleAmount.toString(),
                        hasPermission: Permissions.hasFieldPermission(
                            "categories.category-detail.total-sale"),
                      ),
                      KDetailPageItem(
                        titleText: $t('fields.status'),
                        valueText: state.category.status.toString(),
                        isBadge: true,
                        hasPermission: Permissions.hasFieldPermission(
                            "categories.category-detail.status"),
                      ),
                    ],
                    buttons: [
                      KDataTableButton(
                        type: ButtonType.delete,
                        hasPermission:
                            (Permissions.hasPermission('delete-categories') ||
                                Permissions.hasRole('Admin')),
                        onPressed: () {
                          KDialog(
                            context: context,
                            yesBtnPressed: () {
                              BlocProvider.of<CategoryBloc>(context).add(
                                DeleteCategory(categoryId: state.category.id),
                              );
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      KDataTableButton(
                        type: ButtonType.edit,
                        hasPermission: Permissions.hasPagePermission(
                                'categories.edit-category') &&
                            (Permissions.hasPermission('update-categories') ||
                                Permissions.hasRole('Admin')),
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context).add(
                            GoEditCategoryPage(category: state.category),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: KLoadingIcon()),
          );
        }
      },
    );
  }
}
