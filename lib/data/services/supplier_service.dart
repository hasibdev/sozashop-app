import 'package:dio/dio.dart';

import '../http/dio_client.dart';

class SupplierService {
  final DioClient _dioClient = DioClient();

  Future getSuppliers({
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            "/suppliers?page=$pageNo&search=$searchText&perPage=$perPage&sort=id,desc");
    return response;
  }

  // delete supplier
  Future deleteSupplier(int id) async {
    var response = await _dioClient.delete(endPoint: "/suppliers/$id");
    return response;
  }

  // add Supplier
  Future addSupplier({
    fax,
    mail,
    mobile,
    name,
    openingBalance,
    status,
    telephone,
    vatNumber,
  }) async {
    Response response = await _dioClient.post(
      endPoint: '/suppliers',
      data: {
        "name": name,
        "email": mail,
        "fax": fax,
        "mobile": mobile,
        "openingBalance": openingBalance,
        "status": status,
        "telephone": telephone,
        "vatNumber": vatNumber,
      },
    );
    return response;
  }

  // edit Supplier
  Future editSupplier({
    id,
    fax,
    mail,
    mobile,
    name,
    status,
    telephone,
    vatNumber,
  }) async {
    Response response = await _dioClient.update(
      endPoint: '/suppliers/$id',
      data: {
        "name": name,
        "email": mail,
        "fax": fax,
        "mobile": mobile,
        "status": status,
        "telephone": telephone,
        "vatNumber": vatNumber,
      },
    );
    return response;
  }

  // get supplier purchase invoices
  Future getSupplierInvoices(int id) async {
    var response =
        await _dioClient.get(endPoint: "/purchase-invoices/supplier/$id");
    return response;
  }
}
