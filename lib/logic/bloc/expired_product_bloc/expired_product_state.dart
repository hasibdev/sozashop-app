part of 'expired_product_bloc.dart';

abstract class ExpiredProductState extends Equatable {
  const ExpiredProductState();

  @override
  List<Object> get props => [];
}

class ExpireProductInitial extends ExpiredProductState {}

class ExpiredProductsLoading extends ExpiredProductState {}

class ExpiredProductsFetched extends ExpiredProductState {
  final List<BatchModel> expiredProducts;
  const ExpiredProductsFetched({
    required this.expiredProducts,
  });
  @override
  List<Object> get props => [expiredProducts];
}

class ExpiredProductDetailState extends ExpiredProductState {
  final ProductModel productModel;
  final String? fromPage;
  const ExpiredProductDetailState({
    required this.productModel,
    this.fromPage,
  });
  @override
  List<Object> get props => [productModel];
}
