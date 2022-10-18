part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class LoadingState extends CategoryState {}

class CategoriesLoading extends CategoryState {}

class CategoryListLoading extends CategoryState {}

class CategoriesFetched extends CategoryState {
  List<CategoryModel> categories;
  CategoriesFetched({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class NewCategoriesFetched extends CategoryState {
  List<CategoryModel> categories;
  NewCategoriesFetched({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class CategoryDetailsState extends CategoryState {
  CategoryModel category;
  CategoryDetailsState({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}

class CategoryAddingState extends CategoryState {}

class CategoryAddingFailed extends CategoryState {
  final Map error;
  const CategoryAddingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CategoryAddingFailed { error: $error }';
}

class CategoryAddedState extends CategoryState {}

class CategoryDeleted extends CategoryState {}

class DeleteCategoryFailed extends CategoryState {}

class CategoryEditingState extends CategoryState {
  int categoryId;
  String? categoryName;
  String? description;
  String? status;
  CategoryEditingState({
    required this.categoryId,
    this.categoryName,
    this.description,
    this.status,
  });

  @override
  List<Object> get props => [categoryId];

  CategoryEditingState copyWith({
    int? categoryId,
    String? categoryName,
    String? description,
    String? status,
  }) {
    return CategoryEditingState(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}

class CategoryEditedState extends CategoryState {
  int categoryId;
  String categoryName;
  String? description;
  String status;
  CategoryEditedState({
    required this.categoryId,
    required this.categoryName,
    this.description,
    required this.status,
  });

  @override
  List<Object> get props => [categoryId, categoryName, status];
}

class CategoryEditingFailed extends CategoryState {
  final Map error;
  const CategoryEditingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
