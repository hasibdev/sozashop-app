import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import 'package:sozashop_app/logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc_logic.dart';
import 'package:sozashop_app/presentation/screens/products_screen/product_detail_screen.dart';

import '../../../presentation/screens/widgets/k_loading_icon.dart';
import '../../../presentation/screens/widgets/k_snackbar.dart';

class ProductDetailBlocLogic extends StatelessWidget {
  ProductDetailBlocLogic({Key? key}) : super(key: key);

  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<ProductBloc>(context),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductDeleted) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Product Deleted Successfully!",
              );
            }

            if (state is BatchEditedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Batch Edited Successfully!",
              );
            }
            if (state is StockAddedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Stock Added Successfully!",
              );
            }
            if (state is BarcodePdfGenerated) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                position: FlashPosition.bottom,
                message: "Barcode Generated!",
                durationSeconds: 20,
                showActionButton: true,
                actionButtonText: 'Open',
                onActionButtonTap: () {
                  BlocProvider.of<ProductBloc>(context).add(OpenBarcodePdf());
                },
              );
            }

            if (state is DeleteProductFailed) {
              var errorsAsList = state.error['message'];
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }

            if (state is BatchEditingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is StockAddingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is BatchDeletingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
          },
          builder: (context, state) {
            // if (state is ProductsFetched) {
            //   return ProductsScreen();
            // }
            if (state is ProductDetailState ||
                state is ProductBatchesFetched ||
                state is BatchLoading ||
                state is BatchEditedState ||
                state is BatchDeletedState ||
                state is BatchDeletingFailed ||
                state is BatchDeletingFailed ||
                state is ExpiredProductDetailState ||
                state is ManageStockDetailState) {
              return ProductDetailScreen();
            }

            if (state is ProductAddingState ||
                state is UnitConversionsFetched ||
                state is ProductAddingFailed ||
                state is NewCategoryAddedState ||
                state is NewCategoryAddingFailed ||
                state is NewUnitAddedState ||
                state is NewUnitAddingFailed ||
                state is SuppliersFetched ||
                state is SupplierInvoicesFetched ||
                state is NewSupplierAddedState ||
                state is NewSupplierAddingFailed) {
              return ProductBlocLogic();
            }

            if (state is ProductEditingState ||
                state is StockAddingState ||
                state is ProductAddingState ||
                state is ProductBarcodePageState ||
                state is BarcodePdfGenerated ||
                state is ProductEditingFailed ||
                state is UnitConversionsFetched ||
                state is ProductAddingFailed ||
                state is NewCategoryAddedState ||
                state is NewCategoryAddingFailed ||
                state is NewUnitAddedState ||
                state is NewUnitAddingFailed ||
                state is SuppliersFetched ||
                state is SupplierInvoicesFetched ||
                state is NewSupplierAddedState ||
                state is NewSupplierAddingFailed ||
                state is EditPageUnitConversionsFetched ||
                state is ProductEditingFailed) {
              return ProductBlocLogic();
            }

            {
              // return ProductBlocLogic();
              if (state is ProductsFetched || state is ProductsListLoading) {
                return BlocProvider.value(
                  value: BlocProvider.of<ProductBloc>(context),
                  child: ProductBlocLogic(),
                );
              } else {
                return const Center(child: KLoadingIcon());
              }
            }
          },
        ),
      ),
    );
  }
}
