import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sozashop_app/logic/bloc/sale_bloc/sale_bloc.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/add_sale_payment_screen.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/edit_sale_screen.dart';
import 'package:sozashop_app/presentation/screens/sales_screen/sales_detail_screen.dart';

import '../../../presentation/screens/sales_screen/add_sale_screen.dart';
import '../../../presentation/screens/sales_screen/sales_screen.dart';
import '../../../presentation/screens/widgets/k_snackbar.dart';

class SaleBlocLogic extends StatelessWidget {
  const SaleBlocLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: BlocProvider.of<SaleBloc>(context),
        // ! test this later
        // ..add(FetchSales()),
        child: BlocConsumer<SaleBloc, SaleState>(
          listener: (context, state) {
            if (state is SaleConfirmed) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Sale Confirmed!",
              );
            }
            if (state is SalePaymentAdded) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Payment Added Successfully!",
              );
            }
            if (state is SaleDeleted) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Sale Deleted Successfully!",
              );
            }
            if (state is NewCustomerAdded) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Customer Created Successfully!",
              );
            }
            if (state is NewSaleAdded) {
              KSnackBar(
                context: context,
                type: AlertType.success,
                message: "Sale Created Successfully!",
              );
            }

            if (state is SaleConfirmFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is SalePaymentAddingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is SaleDeleteFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is NewCustomerAddingFailed) {
              var errorsAsList = state.error.errorsToString();
              KSnackBar(
                context: context,
                type: AlertType.failed,
                message: errorsAsList,
                durationSeconds: 4,
              );
            }
            if (state is NewSaleAddingFailed) {
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
            // if (state is SalesLoading) {
            //   return const Center(child: KLoadingIcon());
            // }
            if (state is SaleDetailState ||
                state is SaleDetailPageLoading ||
                state is SalePaymentsLoading ||
                state is SalePaymentsFetched) {
              return const SalesDetailScreen();
            }
            // add payment page
            if (state is AddPaymentAddingState ||
                state is AddPaymentPageLoading ||
                state is SalePaymentAdded ||
                state is SalePaymentAddingFailed) {
              return AddSalePaymentScreen();
            }

            // add sale page
            if (state is SaleAddingState ||
                state is NewCustomerAdded ||
                state is NewCustomerAddingFailed ||
                state is NewSaleAddingFailed) {
              return const AddSaleScreen();
            }

            // add sale page
            if (state is SaleEditPageLoading || state is SaleEditingState) {
              return const EditSaleScreen();
            }

            if (state is SalesFetched ||
                state is SaleDeleted ||
                state is SalesLoading) {
              return const SalesScreen();
            } else {
              print(state);
              return BlocProvider.value(
                value: BlocProvider.of<SaleBloc>(context)
                  ..add(const FetchSales()),
                child: const SalesScreen(),
              );
            }
          },
        ),
      ),
    );
  }
}
