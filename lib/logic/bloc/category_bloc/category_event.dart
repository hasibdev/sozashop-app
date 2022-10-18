part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends CategoryEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchCategories({this.pageNo, this.perPage, this.searchText});
}

class FetchNewCategories extends CategoryEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchNewCategories({this.pageNo, this.perPage, this.searchText});
}

class GetCategoryDetails extends CategoryEvent {
  CategoryModel category;
  GetCategoryDetails({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class GoAllCategoriesPage extends CategoryEvent {}

class GoAddCategoryPage extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  String name;
  String description;
  AddCategory({
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [name, description];
}

class DeleteCategory extends CategoryEvent {
  int categoryId;
  DeleteCategory({
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryId];
}

class GoEditCategoryPage extends CategoryEvent {
  CategoryModel category;
  GoEditCategoryPage({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class EditCategory extends CategoryEvent {
  int categoryId;
  String categoryName;
  String? description;
  String status;
  EditCategory({
    required this.categoryId,
    required this.categoryName,
    this.description,
    required this.status,
  });

  @override
  List<Object> get props => [categoryId, categoryName, status];
}
