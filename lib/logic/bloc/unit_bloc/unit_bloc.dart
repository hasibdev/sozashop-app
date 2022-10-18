import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';

import 'package:sozashop_app/data/repositories/unit_repository.dart';

import '../../../data/models/unit_model.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitRepository unitRepository;
  UnitBloc({
    required this.unitRepository,
  }) : super(UnitInitial()) {
    on<UnitEvent>((event, emit) async {
      if (event is FetchUnits) {
        emit(UnitsLoading());
        var units = await unitRepository.getUnits(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(UnitsFetched(units: units));
      }

      if (event is GoAddUnitPage) {
        emit(UnitAddingState());
      }

      if (event is GoAllUnitsPage) {
        emit(UnitsLoading());
        var units = await unitRepository.getUnits();
        emit(UnitsFetched(units: units));
      }

      // add unit
      if (event is AddUnit) {
        Response response = await unitRepository.addUnit(
          unitName: event.unitName,
          unitCode: event.unitCode,
        );
        if (response.statusCode == 201) {
          emit(UnitAddedState());
          var units = await unitRepository.getUnits();
          emit(UnitsFetched(units: units));
        } else {
          emit(UnitAddingFailed(error: response.data));
          emit(UnitAddingState());
        }
      }

      // delete unit
      if (event is DeleteUnit) {
        Response res = await unitRepository.deleteUnit(event.unitId);
        if (res.statusCode == 200) {
          emit(UnitDeletedState());
          var units = await unitRepository.getUnits();
          emit(UnitsFetched(units: units));
        } else {
          emit(UnitDeletingFailed(error: res.data));
          var units = await unitRepository.getUnits();
          emit(UnitsFetched(units: units));
        }
      }

      if (event is GoEditUnitPage) {
        emit(UnitEditingState(
          unitId: event.unitModel.id,
          unitName: event.unitModel.name,
          unitCode: event.unitModel.code,
        ));
      }

      // edit unit
      if (event is EditUnit) {
        Response response = await unitRepository.editUnit(
          id: event.unitId,
          name: event.unitName,
          code: event.unitCode,
        );

        if (response.statusCode == 200) {
          emit(UnitEditedState());
          var units = await unitRepository.getUnits();
          emit(UnitsFetched(units: units));
        } else {
          emit(UnitEditingFailed(error: response.data));

          emit(UnitEditingState(
            unitId: event.unitId,
            unitName: event.unitName,
            unitCode: event.unitCode,
          ));
        }
      }

      // unit details
      if (event is GoUnitDetailPage) {
        emit(LoadingState());
        var unitConversions = await unitRepository.getUnitConversions(
          baseUnitId: event.unitModel.id,
        );
        emit(UnitConversionsLoading());
        emit(UnitConversionsFetched(unitConversions: unitConversions));
        emit(UnitDetailState(
          unit: event.unitModel,
          unitConversions: unitConversions,
        ));
      }

      // fetch unit conversions
      if (event is FetchUnitConversions) {
        emit(UnitConversionsLoading());
        var unitConversions = await unitRepository.getUnitConversions(
          baseUnitId: event.baseUnitId,
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(UnitConversionsFetched(unitConversions: unitConversions));
        // emit(UnitDetailState(unitConversions: unitConversions));
      }

      // delete unit conversion
      if (event is DeleteUnitConversion) {
        Response res =
            await unitRepository.deleteUnitConversion(event.unitConversionId);
        if (res.statusCode == 200) {
          emit(UnitConversionDeletedState());
          emit(UnitConversionsLoading());
          var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.baseUnit.id,
          );
          emit(UnitDetailState(
            unit: event.baseUnit,
            unitConversions: unitConversions,
          ));
        } else {
          emit(UnitDeletingFailed(error: res.data));
          emit(UnitConversionsLoading());
          emit(UnitDetailState(
            unit: event.baseUnit,
          ));
        }
      }

      // unit conversion details
      if (event is GoUnitConversionDetailPage) {
        emit(LoadingState());
        emit(UnitConversionDetailState(
          unitConversionModel: event.unitConversionModel,
        ));
      }

      // add unit conversion
      if (event is AddUnitConversion) {
        Response response = await unitRepository.addUnitConversion(
          baseUnitId: event.baseUnitId,
          unitOperator: event.unitOperator,
          unitId: event.unitId,
          value: event.value,
        );
        if (response.statusCode == 201) {
          emit(UnitConversionAddedState());
          var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.baseUnit.id,
          );
          emit(UnitDetailState(
            unit: event.baseUnit,
            unitConversions: unitConversions,
          ));
        } else {
          emit(UnitConversionAddingFailed(error: response.data));
          var units = await unitRepository.getUnits();
          emit(UnitConversionAddingState(
              baseUnit: event.baseUnit, allUnits: units));
        }
      }

      // add unit con page
      if (event is GoAddUnitConversionPage) {
        var units = await unitRepository.getUnits();
        emit(UnitConversionAddingState(
          baseUnit: event.baseUnit,
          allUnits: units,
        ));
      }

      // edit unit con page
      if (event is GoEditUnitConversionPage) {
        var units = await unitRepository.getUnits();
        emit(UnitConversionEditingState(
          allUnits: units,
          baseUnit: event.baseUnit,
          unitConversionModel: event.unitConversionModel,
        ));
      }

      // edit unit conversion
      if (event is EditUnitConversion) {
        var units = await unitRepository.getUnits();

        emit(UnitConversionEditingState(
          unitConversionModel: event.unitConversionItem,
          baseUnit: event.unitConversionItem.baseUnit,
          allUnits: units,
        ));
        Response response = await unitRepository.editUnitConversion(
          conversionId: event.conversionId,
          baseUnitId: event.baseUnitId,
          unitOperator: event.unitOperator,
          unitId: event.unitId.toString(),
          value: event.value,
        );
        if (response.statusCode == 200) {
          emit(UnitConversionEditedState());
          var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.baseUnitId,
          );
          emit(UnitDetailState(
            unit: event.baseUnit,
            unitConversions: unitConversions,
          ));
        } else {
          emit(UnitConversionEditingFailed(error: response.data));
          emit(UnitConversionEditingState(
            unitConversionModel: event.unitConversionItem,
            baseUnit: event.unitConversionItem.baseUnit,
            allUnits: units,
          ));
        }
      }
    });
  }
}
