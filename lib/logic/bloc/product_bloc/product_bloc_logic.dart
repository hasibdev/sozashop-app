import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/presentation/screens/products_screen/add_product_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/add_batch_stock_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/edit_product_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/expired_products/expired_products_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/product_barcode_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/product_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/products_screen/products_screen.dart';

import '../../../data/services/category_service.dart';
import '../../../data/services/unit_service.dart';
import '../../../presentation/screens/widgets/k_loading_icon.dart';
import '../../../presentation/screens/widgets/k_snackbar.dart';

class ProductBlocLogic extends StatelessWidget {
  ProductBlocLogic({Key? key}) : super(key: key);

  final ProductService productService = ProductService();
  final CategoryService categoryService = CategoryService();
  final UnitService unitService = UnitService();
  final SupplierService supplierService = SupplierService();

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
            if (state is ProductEditedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Product Edited Successfully!",
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
            if (state is BatchDeletedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Batch Deleted Successfully!",
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

            if (state is ProductEditingFailed) {
              var errorsAsList = state.error.errorsToString();
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
            if (state is LoadingState) {
              return const Center(child: KLoadingIcon());
            } else if (state is ProductsFetched ||
                state is ProductsListLoading) {
              return const ProductsScreen();
            } else if (state is ProductDetailState ||
                state is ProductBatchesFetched ||
                state is BatchLoading ||
                state is BatchEditedState ||
                state is BatchDeletedState ||
                state is BatchDeletingFailed ||
                state is BatchDeletingFailed) {
              return ProductDetailScreen();
            } else if (state is StockAddingState ||
                state is StockAddingFailed ||
                state is SuppliersFetchedForStock) {
              return const AddBatchStockScreen();
            } else if (state is ProductAddingState ||
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
              return const AddProductScreen();
            } else if (state is ProductEditingState ||
                state is EditPageUnitConversionsFetched ||
                state is ProductEditingFailed) {
              return const EditProductScreen();
            } else if (state is ProductBarcodePageState ||
                state is BarcodePdfGenerated) {
              return const ProductBarcodeScreen();
            }
            if (state is ExpiredProductsFetched) {
              return BlocProvider.value(
                value: BlocProvider.of<ExpiredProductBloc>(context)
                  ..add(GoTOAllExpiredProductsPage()),
                child: ExpiredProductsScreen(),
              );
            } else {
              print(state);

              return BlocProvider.value(
                value: BlocProvider.of<ProductBloc>(context)
                  ..add(FetchProducts()),
                child: const ProductsScreen(),
              );
            }
          },
        ),
      ),
    );
  }
}
