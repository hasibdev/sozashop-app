import 'package:dio/dio.dart';
import 'package:sozashop_app/data/models/category_model.dart';
import 'package:sozashop_app/data/services/category_service.dart';

import '../../core/constants/strings.dart';

class CategoryRepository {
  CategoryService categoryService;
  CategoryRepository({
    required this.categoryService,
  });

  Future<List<CategoryModel>> getCategories(
      {int? pageNo, int? perPage, String? searchText}) async {
    final categoriesRaw = await categoryService.getCategories(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var categories = Category.fromJson(categoriesRaw);
    return categories.data;
  }

  Future addCategory({categoryName, description}) async {
    Response newCategoryRes =
        await categoryService.addCategory(categoryName, description);
    return newCategoryRes;
  }

  Future deleteCategory(int id) async {
    final deletedCategory = await categoryService.deleteCategory(id);
    print(deletedCategory);
    return deletedCategory;
  }

  Future editCategory({required int id, name, description, status}) async {
    Response editCategoryRes =
        await categoryService.editCategory(id, name, description, status);
    print('editCategory >>>>>>> $editCategoryRes');
    return editCategoryRes;
  }
}
