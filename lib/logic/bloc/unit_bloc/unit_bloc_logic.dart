import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/logic/bloc/unit_bloc/unit_bloc.dart';
import 'package:sozashop_app/presentation/screens/units_screen/add_unit_screen.dart';
import 'package:sozashop_app/presentation/screens/units_screen/edit_unit_screen.dart';
import 'package:sozashop_app/presentation/screens/units_screen/unit_conversions_screen/add_unit_conversion_screen.dart';
import 'package:sozashop_app/presentation/screens/units_screen/unit_conversions_screen/unit_conversion_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/units_screen/unit_detail_screen.dart';
import 'package:sozashop_app/presentation/screens/units_screen/units_screen.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_loading_icon.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

import '../../../presentation/screens/units_screen/unit_conversions_screen/edit_unit_conversion_screen.dart';

class UnitBlocLogic extends StatelessWidget {
  const UnitBlocLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state is UnitAddedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Added Successfully!',
            );
          }
          if (state is UnitDeletedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Deleted Successfully!',
            );
          }
          if (state is UnitEditedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Edited Successfully!',
            );
          }
          if (state is UnitConversionDeletedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Conversion Deleted Successfully!',
            );
          }
          if (state is UnitConversionAddedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Conversion Added Successfully!',
            );
          }
          if (state is UnitConversionEditedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: 'Unit Conversion Edited Successfully!',
            );
          }
          if (state is UnitAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is UnitDeletingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is UnitEditingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is UnitConversionDeletingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is UnitConversionAddingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is UnitConversionEditingFailed) {
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
          if (state is UnitsFetched || state is UnitsLoading) {
            return const UnitsScreen();
          }
          if (state is UnitAddingState) {
            return AddUnitScreen();
          }
          if (state is UnitEditingState) {
            return const EditUnitScreen();
          }
          if (state is UnitEditingFailed) {
            return const EditUnitScreen();
          }
          if (state is UnitDetailState ||
              state is UnitConversionsLoading ||
              state is UnitConversionsFetched) {
            return const UnitDetailScreen();
          }
          if (state is UnitConversionDetailState) {
            return UnitConversionDetailScreen();
          }
          if (state is UnitConversionAddingState) {
            return const AddUnitConversionScreen();
          }
          if (state is UnitConversionEditingState) {
            return const EditUnitConversionScreen();
          } else {
            print(state);
            return const Center(child: KLoadingIcon());
          }
        },
      ),
    );
  }
}
