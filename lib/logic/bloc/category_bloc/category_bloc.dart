import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/category_model.dart';
import 'package:sozashop_app/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository categoryRepository;
  CategoryBloc({
    required this.categoryRepository,
  }) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is FetchCategories) {
        emit(CategoriesLoading());
        var categories = await categoryRepository.getCategories();
        emit(CategoriesFetched(categories: categories));
      }

      if (event is FetchNewCategories) {
        emit(CategoryListLoading());
        var categories = await categoryRepository.getCategories(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(NewCategoriesFetched(categories: categories));
      }

      if (event is GetCategoryDetails) {
        emit(LoadingState());
        emit(CategoryDetailsState(category: event.category));
      }

      if (event is GoAllCategoriesPage) {
        emit(CategoriesLoading());
        var categories = await categoryRepository.getCategories();
        emit(CategoriesFetched(categories: categories));
      }

      if (event is GoAddCategoryPage) {
        emit(CategoryAddingState());
      }

      if (event is AddCategory) {
        Response response = await categoryRepository.addCategory(
          categoryName: event.name,
          description: event.description,
        );
        if (response.statusCode == 201) {
          emit(CategoriesLoading());
          var categories = await categoryRepository.getCategories();
          emit(CategoryAddedState());
          emit(CategoriesFetched(categories: categories));
        } else if (response.statusCode == 422) {
          emit(
            CategoryAddingFailed(error: response.data),
          );
          emit(CategoryAddingState());
        } else {
          emit(CategoryAddingFailed(error: response.data));
          emit(CategoryAddingState());
        }
      }

      // Delete category
      if (event is DeleteCategory) {
        try {
          await categoryRepository.deleteCategory(event.categoryId);
          emit(CategoryDeleted());
          var categories = await categoryRepository.getCategories();
          emit(CategoriesFetched(categories: categories));
        } catch (e) {
          emit(DeleteCategoryFailed());
          var categories = await categoryRepository.getCategories();
          emit(CategoriesFetched(categories: categories));
        }
      }

      if (event is GoEditCategoryPage) {
        emit(CategoryEditingState(
          categoryId: event.category.id,
        ).copyWith(
          categoryName: event.category.name,
          description: event.category.description,
          status: event.category.status,
        ));
      }

      if (event is EditCategory) {
        Response response = await categoryRepository.editCategory(
          id: event.categoryId,
          name: event.categoryName,
          description: event.description,
          status: event.status,
        );
        if (response.statusCode == 200) {
          emit(
            CategoryEditedState(
              categoryId: event.categoryId,
              categoryName: event.categoryName,
              status: event.status,
              description: event.description,
            ),
          );
          var categories = await categoryRepository.getCategories();
          emit(CategoriesFetched(categories: categories));
        } else {
          emit(CategoryEditingFailed(error: response.data));
          emit(CategoryEditingState(
            categoryId: event.categoryId,
          ).copyWith(
            categoryName: event.categoryName,
            status: event.status,
            description: event.description,
          ));
        }
      }
    });
  }
}
