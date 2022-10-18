part of 'manage_stocks_bloc.dart';

abstract class ManageStocksState extends Equatable {
  const ManageStocksState();

  @override
  List<Object> get props => [];
}

class ManageStockInitial extends ManageStocksState {}

class PageLoadingState extends ManageStocksState {}

class ManageStocksLoading extends ManageStocksState {}

class ManageStocksFetched extends ManageStocksState {
  List<ProductModel> products;
  ManageStocksFetched({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class DateRangedManageStocksFetched extends ManageStocksState {
  List<ProductModel> products;
  dynamic dateRange;
  DateRangedManageStocksFetched({
    required this.products,
    required this.dateRange,
  });

  @override
  List<Object> get props => [products];
}

class ManageStockDetailState extends ManageStocksState {
  final ProductModel productModel;
  final String? fromPage;
  const ManageStockDetailState({
    required this.productModel,
    this.fromPage,
  });
  @override
  List<Object> get props => [productModel];
}

class ManageStockAddingState extends ManageStocksState {
  int productId;
  List<UnitModel> units;
  ManageStockAddingState({
    required this.productId,
    required this.units,
  });

  @override
  List<Object> get props => [productId, units];
}

class ManageStockAddedState extends ManageStocksState {}

class ManageStockAddingFailed extends ManageStocksState {
  final Map error;
  const ManageStockAddingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class SuppliersFetchedForAddingStock extends ManageStocksState {
  List<SupplierModel> suppliers;
  SuppliersFetchedForAddingStock({
    required this.suppliers,
  });
  @override
  List<Object> get props => [suppliers];
}
