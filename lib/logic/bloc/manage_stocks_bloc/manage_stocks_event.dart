part of 'manage_stocks_bloc.dart';

abstract class ManageStocksEvent extends Equatable {
  const ManageStocksEvent();

  @override
  List<Object> get props => [];
}

class FetchManageStocks extends ManageStocksEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchManageStocks({
    this.pageNo,
    this.perPage,
    this.searchText,
  });
}

class GoToManageStocksPage extends ManageStocksEvent {}

class GoManageStockDetailPage extends ManageStocksEvent {
  final ProductModel productModel;
  final String? fromPage;
  const GoManageStockDetailPage({
    required this.productModel,
    this.fromPage,
  });
  @override
  List<Object> get props => [productModel];
}

class GoManageStockAddingPage extends ManageStocksEvent {
  int productId;
  GoManageStockAddingPage({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class FetchSuppliersForAddingStock extends ManageStocksEvent {}

class AddStockOnManageStock extends ManageStocksEvent {
  final int productId;
  final bool generateInvoice;
  final dynamic invoiceNo;
  final dynamic quantity;
  final dynamic mfgDate;
  final dynamic expDate;
  final dynamic date;
  final dynamic purchaseRate;
  final dynamic sellingRate;
  final int? supplierId;
  final int? unitId;
  final List? batches;
  const AddStockOnManageStock({
    required this.productId,
    required this.generateInvoice,
    required this.invoiceNo,
    required this.quantity,
    required this.mfgDate,
    required this.expDate,
    required this.purchaseRate,
    required this.sellingRate,
    required this.supplierId,
    required this.unitId,
    required this.batches,
    required this.date,
  });
}

class FetchDateRangedProducts extends ManageStocksEvent {
  final dynamic dateRange;
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchDateRangedProducts({
    required this.dateRange,
    this.pageNo,
    this.perPage,
    this.searchText,
  });

  @override
  List<Object> get props => [dateRange];
}
