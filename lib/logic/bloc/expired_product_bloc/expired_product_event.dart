part of 'expired_product_bloc.dart';

abstract class ExpiredProductEvent extends Equatable {
  const ExpiredProductEvent();

  @override
  List<Object> get props => [];
}

//* Expired products are actually expired batches. I had to name it as expired products because of the naming of the web version.

class FetchExpiredProducts extends ExpiredProductEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchExpiredProducts({
    this.pageNo,
    this.perPage,
    this.searchText,
  });
}

class GoExpiredProductDetailPage extends ExpiredProductEvent {
  final ProductModel productModel;
  final String? fromPage;
  const GoExpiredProductDetailPage({
    required this.productModel,
    this.fromPage,
  });
  @override
  List<Object> get props => [productModel];
}

class GoTOAllExpiredProductsPage extends ExpiredProductEvent {}
