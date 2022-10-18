import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';
import 'package:sozashop_app/data/repositories/unit_repository.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';

import '../../../data/models/supplier_model.dart';

part 'manage_stocks_event.dart';
part 'manage_stocks_state.dart';

class ManageStocksBloc extends Bloc<ManageStocksEvent, ManageStocksState> {
  ProductRepository productRepository;
  UnitRepository unitRepository;
  SupplierRepository supplierRepository;
  ProductBloc productBloc;
  ManageStocksBloc({
    required this.productRepository,
    required this.unitRepository,
    required this.supplierRepository,
    required this.productBloc,
  }) : super(ManageStockInitial()) {
    on<ManageStocksEvent>((event, emit) async {
      // fetch manage stocks
      if (event is FetchManageStocks) {
        emit(ManageStocksLoading());
        var products = await productRepository.getProducts(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(ManageStocksFetched(products: products));
      }

      // fetch manage stocks
      if (event is FetchDateRangedProducts) {
        emit(ManageStocksLoading());
        var products = await productRepository.getDateRangedProducts(
          dateRange: event.dateRange,
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );

        emit(DateRangedManageStocksFetched(
          products: products,
          dateRange: event.dateRange,
        ));
      }

      // go to manage stock page
      if (event is GoToManageStocksPage) {
        emit(ManageStocksLoading());
        var products = await productRepository.getProducts();
        emit(ManageStocksFetched(products: products));
      }

      // go to manage stock detail page
      if (event is GoManageStockDetailPage) {
        emit(ManageStockDetailState(
          productModel: event.productModel,
          fromPage: event.fromPage,
        ));

        productBloc.add(
          GoProductDetailPage(
            productModel: event.productModel,
            referPage: event.fromPage,
          ),
        );
      }

      // go to manage stock adding page
      if (event is GoManageStockAddingPage) {
        emit(PageLoadingState());
        var units = await unitRepository.getUnits();
        emit(ManageStockAddingState(productId: event.productId, units: units));
      }

      // fetch suppliers for adding stock
      if (event is FetchSuppliersForAddingStock) {
        var suppliers = await supplierRepository.getSuppliers();
        emit(SuppliersFetchedForAddingStock(suppliers: suppliers));
      }

      // add stock on manage stock
      if (event is AddStockOnManageStock) {
        Response res = await productRepository.addStockOnManageStock(
          productId: event.productId,
          generateInvoice: event.generateInvoice,
          invoiceNo: event.invoiceNo,
          quantity: event.quantity,
          mfgDate: event.mfgDate,
          expDate: event.expDate,
          purchaseRate: event.purchaseRate,
          sellingRate: event.sellingRate,
          supplierId: event.supplierId,
          unitId: event.unitId,
          batches: event.batches,
          date: event.date,
        );

        if (res.statusCode == 200) {
          emit(ManageStockAddedState());
          emit(ManageStocksLoading());
          var products = await productRepository.getProducts();
          emit(ManageStocksFetched(products: products));
        } else {
          emit(ManageStockAddingFailed(error: res.data));
          var units = await unitRepository.getUnits();
          emit(
              ManageStockAddingState(productId: event.productId, units: units));
        }
      }
    });
  }
}
