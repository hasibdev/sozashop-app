import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';
import 'package:sozashop_app/data/services/product_service.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/logic/bloc/expired_product_bloc/expired_product_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_bloc.dart';
import 'package:sozashop_app/logic/bloc/product_bloc/product_detail_bloc_logic.dart';

import 'package:sozashop_app/presentation/screens/products_screen/expired_products/expired_products_screen.dart';

import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/unit_repository.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/unit_service.dart';
import '../../../presentation/screens/widgets/k_loading_icon.dart';

class ExpiredProductBlocLogic extends StatelessWidget {
  ExpiredProductBlocLogic({Key? key}) : super(key: key);

  final ProductService productService = ProductService();
  final CategoryService categoryService = CategoryService();
  final UnitService unitService = UnitService();
  final SupplierService supplierService = SupplierService();

  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository =
        ProductRepository(productService: productService);
    final CategoryRepository categoryRepository =
        CategoryRepository(categoryService: categoryService);
    final UnitRepository unitRepository =
        UnitRepository(unitService: unitService);
    final SupplierRepository supplierRepository =
        SupplierRepository(supplierService: supplierService);

    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<ExpiredProductBloc>(context)
          ..add(const FetchExpiredProducts()),
        child: BlocConsumer<ExpiredProductBloc, ExpiredProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state);
            
            if (state is ExpiredProductsFetched) {
              return const ExpiredProductsScreen();
            }

            if (state is ExpiredProductDetailState) {
              return BlocProvider.value(
                value: BlocProvider.of<ProductBloc>(context)
                  // ..add(FetchProducts())
                  ..add(GoProductDetailPage(
                    productModel: state.productModel,
                    referPage: state.fromPage,
                  )),
                child: ProductDetailBlocLogic(),
              );
            }

            // if (state is StockAddingState ||
            //     state is StockAddingFailed ||
            //     state is SuppliersFetchedForStock) {
            //     return BlocProvider.value(
            //     value: BlocProvider.of<ProductBloc>(context)
            //       ..add(GoAddStockPage(batchModel: dataItem)),
            //     child: const AddProductStockScreen(),
            //   );
            //   // return const AddProductStockScreen();

            // }

            print(state);
            return const ExpiredProductsScreen();
          },
        ),
      ),
    );
  }
}
