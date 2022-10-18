import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/logic/bloc/manage_stocks_bloc/manage_stocks_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_detail_bloc_logic.dart';
import 'package:sozashop_app/presentation/screens/products_screen/manage_stocks/manage_stock_adding_screen.dart';

import '../../../data/services/category_service.dart';
import '../../../data/services/unit_service.dart';
import '../../../presentation/screens/products_screen/manage_stocks/manage_stocks_screen.dart';
import '../../../presentation/screens/widgets/k_snackbar.dart';

class ManageStocksBlocLogic extends StatelessWidget {
  ManageStocksBlocLogic({Key? key}) : super(key: key);

  final ProductService productService = ProductService();
  final CategoryService categoryService = CategoryService();
  final UnitService unitService = UnitService();
  final SupplierService supplierService = SupplierService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<ManageStocksBloc>(context),
        child: BlocConsumer<ManageStocksBloc, ManageStocksState>(
          listener: (context, state) {
            if (state is ManageStockAddedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Stock Added Successfully!",
              );
            }
            if (state is ManageStockAddingFailed) {
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
            print(state);

            if (state is ManageStocksFetched ||
                state is DateRangedManageStocksFetched ||
                state is ManageStocksLoading) {
              return const ManageStocksScreen();
            }

            if (state is ManageStockDetailState) {
              return BlocProvider.value(
                value: BlocProvider.of<ProductBloc>(context)
                  ..add(GoProductDetailPage(
                    productModel: state.productModel,
                    referPage: state.fromPage,
                  )),
                child: ProductDetailBlocLogic(),
              );
            }

            if (state is ManageStockAddingState ||
                state is SuppliersFetchedForAddingStock ||
                state is ManageStockAddingFailed) {
              return const ManageStockAddingScreen();
            } else {
              print(state);
              return BlocProvider.value(
                value: BlocProvider.of<ManageStocksBloc>(context)
                  ..add(const FetchManageStocks()),
                child: const ManageStocksScreen(),
              );
            }
          },
        ),
      ),
    );
  }
}
