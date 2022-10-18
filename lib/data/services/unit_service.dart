import 'package:dio/dio.dart';

import '../http/dio_client.dart';

class UnitService {
  final DioClient _dioClient = DioClient();

  Future getUnits({
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            "/units?page=$pageNo&search=$searchText&perPage=$perPage&sort=id,desc");
    return response;
  }

  // add unit
  Future addUnit({unitName, unitCode}) async {
    Response response = await _dioClient.post(
      endPoint: '/units',
      data: {
        "name": unitName,
        "code": unitCode,
      },
    );
    return response;
  }

  // delete unit
  Future deleteUnit(int id) async {
    var response = await _dioClient.delete(endPoint: "/units/$id");
    return response;
  }

  // edit unit
  Future editUnit(int id, name, code) async {
    Response response = await _dioClient.update(
      endPoint: '/units/$id',
      data: {
        "name": name,
        "code": code,
      },
    );
    return response;
  }

  // get unit conversions
  Future getUnitConversions({
    required int baseUnitId,
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            "/unit-conversions?page=$pageNo&search=$searchText&perPage=$perPage&baseUnit=$baseUnitId&sort=id,desc");
    return response;
  }

  // delete unit conversion
  Future deleteUnitConversion(int id) async {
    var response = await _dioClient.delete(endPoint: "/unit-conversions/$id");
    return response;
  }

  // add unit conversion
  Future addUnitConversion(
      {required baseUnitId,
      required unitOperator,
      required unitId,
      required value}) async {
    Response response = await _dioClient.post(
      endPoint: '/unit-conversions',
      data: {
        "baseUnitId": baseUnitId,
        "operator": unitOperator,
        "unitId": unitId,
        "value": value,
      },
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
    Response response = await _dioClient.update(
      endPoint: '/unit-conversions/$conversionId',
      data: {
        "baseUnitId": baseUnitId,
        "operator": unitOperator,
        "unitId": unitId,
        "value": value,
      },
    );
    return response;
  }
}
