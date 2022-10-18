import 'package:dio/dio.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/data/services/unit_service.dart';

import '../../core/constants/strings.dart';

class UnitRepository {
  UnitService unitService;
  UnitRepository({
    required this.unitService,
  });

  // get units
  Future<List<UnitModel>> getUnits({
    int? pageNo,
    int? perPage,
    String? searchText,
  }) async {
    final unitsRaw = await unitService.getUnits(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var units = List<UnitModel>.from(
        unitsRaw['data'].map((x) => UnitModel.fromJson(x)));
    return units;
  }

  // add unit
  Future addUnit({unitName, unitCode}) async {
    Response response =
        await unitService.addUnit(unitName: unitName, unitCode: unitCode);

    return response;
  }

  // delete unit
  Future deleteUnit(int id) async {
    final deleted = await unitService.deleteUnit(id);
    return deleted;
  }

  // edit unit
  Future editUnit({required int id, name, code}) async {
    Response res = await unitService.editUnit(id, name, code);
    return res;
  }

  // get unit conversions
  Future<List<UnitConversionModel>> getUnitConversions({
    int? pageNo,
    int? perPage,
    String? searchText,
    required int baseUnitId,
  }) async {
    final raw = await unitService.getUnitConversions(
      baseUnitId: baseUnitId.toInt(),
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var units = List<UnitConversionModel>.from(
        raw['data'].map((x) => UnitConversionModel.fromJson(x)));
    return units;
  }

  // delete unit conversion
  Future deleteUnitConversion(int id) async {
    final deleted = await unitService.deleteUnitConversion(id);
    return deleted;
  }

  // add unit conversion
  Future addUnitConversion({
    required baseUnitId,
    required unitOperator,
    required unitId,
    required value,
  }) async {
    Response response = await unitService.addUnitConversion(
      baseUnitId: baseUnitId,
      unitOperator: unitOperator,
      unitId: unitId,
      value: value,
    );
    return response;
  }

  // edit unit conversion
  Future editUnitConversion({
    required int conversionId,
    required baseUnitId,
    required unitOperator,
    required unitId,
    required value,
  }) async {
    Response response = await unitService.editUnitConversion(
      conversionId: conversionId,
      baseUnitId: baseUnitId,
      unitOperator: unitOperator,
      unitId: unitId,
      value: value,
    );
    return response;
  }
}
