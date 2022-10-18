import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/repositories/category_repository.dart';
import 'package:sozashop_app/data/services/category_service.dart';
import 'package:sozashop_app/logic/bloc/category_bloc/category_bloc.dart';
import 'package:sozashop_app/presentation/screens/categories_screen/add_category_screen.dart';
import 'package:sozashop_app/presentation/screens/categories_screen/categories_screen.dart';
import 'package:sozashop_app/presentation/screens/categories_screen/edit_category_screen.dart';

import '../../../presentation/screens/categories_screen/categories_detail_screen.dart';
import '../../../presentation/screens/widgets/k_loading_icon.dart';
import '../../../presentation/screens/widgets/k_snackbar.dart';

class CategoryBlocLogic extends StatelessWidget {
  CategoryBlocLogic({Key? key}) : super(key: key);

  final CategoryService categoryService = CategoryService();
  @override
  Widget build(BuildContext context) {
    final CategoryRepository categoryRepository =
        CategoryRepository(categoryService: categoryService);
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            CategoryBloc(categoryRepository: categoryRepository)
              ..add(const FetchCategories()),
        child: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryAddedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: 'Category Added Successfully!',
              );
            }
            if (state is CategoryAddingFailed) {
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: state.error.errorsToString(),
              );
            }
            if (state is CategoryDeleted) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: 'Category Deleted Successfully!',
              );
            }
            if (state is DeleteCategoryFailed) {
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: 'Delete Category Failed!',
              );
            }
            if (state is CategoryEditedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: 'Category Edited Successfully!',
              );
            }
            if (state is CategoryEditingFailed) {
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: state.error.errorsToString(),
              );
            }
          },
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: KLoadingIcon());
            }
            if (state is CategoriesFetched ||
                state is CategoryAddedState ||
                state is NewCategoriesFetched ||
                state is CategoryListLoading) {
              return const CategoriesScreen();
            }
            if (state is CategoryDetailsState) {
              return const CategoryDetailScreen();
            }
            if (state is CategoryAddingState) {
              return AddCategoryScreen();
            }
            if (state is CategoryEditingState) {
              return const EditCategoryScreen();
            }
            if (state is CategoryEditingFailed) {
              return const EditCategoryScreen();
            }
            return const CategoriesScreen();
          },
        ),
      ),
    );
  }
}
