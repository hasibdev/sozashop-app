import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';
import 'package:sozashop_app/logic/bloc/supplier_bloc/supplier_bloc.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/add_supplier_screen.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/edit_supplier_screen.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/supplier_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/suppliers_screen/suppliers_screen.dart';

import '../../../presentation/screens/widgets/k_snackbar.dart';

class SupplierBlocLogic extends StatelessWidget {
  SupplierBlocLogic({Key? key}) : super(key: key);

  SupplierService supplierService = SupplierService();
  @override
  Widget build(BuildContext context) {
    SupplierRepository supplierRepository =
        SupplierRepository(supplierService: supplierService);

    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            SupplierBloc(supplierRepository: supplierRepository)
              ..add(const FetchSuppliers()),
        child: BlocConsumer<SupplierBloc, SupplierState>(
          listener: (context, state) {
            if (state is SupplierDeletedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Supplier Deleted Successfully!",
              );
            }
            if (state is SupplierAddedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Supplier Added Successfully!",
              );
            }
            if (state is SupplierEditedState) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Supplier Edited Successfully!",
              );
            }

            if (state is SupplierDeletingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is SupplierAddingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is SupplierEditingFailed) {
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
            if (state is SuppliersFetched) {
              return SuppliersScreen();
            }
            if (state is SupplierDetailState) {
              return SupplierDetailScreen();
            }
            if (state is SupplierAddingState || state is SupplierAddingFailed) {
              return const AddSupplierScreen();
            }
            if (state is SupplierEditingState ||
                state is SupplierEditingFailed) {
              return const EditSupplierScreen();
            }
            return SuppliersScreen();
          },
        ),
      ),
    );
  }
}
