import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/product_model.dart';

import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';

import '../../../data/models/batch_model.dart';

part 'expired_product_event.dart';
part 'expired_product_state.dart';

class ExpiredProductBloc
    extends Bloc<ExpiredProductEvent, ExpiredProductState> {
  ProductRepository productRepository;
  ProductBloc productBloc;
  ExpiredProductBloc({
    required this.productBloc,
    required this.productRepository,
  }) : super(ExpireProductInitial()) {
    on<ExpiredProductEvent>((event, emit) async {
      // fetch expired products
      if (event is FetchExpiredProducts) {
        emit(ExpiredProductsLoading());
        var products = await productRepository.getExpiredProducts(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(ExpiredProductsFetched(expiredProducts: products));
      }

      // go to product details page
      if (event is GoExpiredProductDetailPage) {
        // productBloc.add(FetchProducts());
        emit(ExpiredProductDetailState(
          productModel: event.productModel,
          fromPage: event.fromPage,
        ));
        print('code running');
        productBloc.add(
          GoProductDetailPage(
            productModel: event.productModel,
            referPage: event.fromPage,
          ),
        );
        print('code ran');
      }

      // go to all expired products page
      if (event is GoTOAllExpiredProductsPage) {
        emit(ExpiredProductsLoading());
        var products = await productRepository.getExpiredProducts();
        emit(ExpiredProductsFetched(expiredProducts: products));
      }
    });
  }
}
