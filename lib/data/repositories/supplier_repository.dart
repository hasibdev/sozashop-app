import 'package:dio/dio.dart';
import 'package:sozashop_app/data/models/purchase_invoice_model.dart';
import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/data/services/supplier_service.dart';

import '../../core/constants/strings.dart';

class SupplierRepository {
  SupplierService supplierService;
  SupplierRepository({
    required this.supplierService,
  });

  // getSuppliers
  Future<List<SupplierModel>> getSuppliers({
    int? pageNo,
    int? perPage,
    String? searchText,
  }) async {
    final rawData = await supplierService.getSuppliers(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var suppliers = List<SupplierModel>.from(
        rawData['data'].map((x) => SupplierModel.fromJson(x)));
    return suppliers;
  }

  // delete supplier
  Future deleteSupplier(int id) async {
    final deleted = await supplierService.deleteSupplier(id);
    return deleted;
  }

  // add Supplier
  Future addSupplier({
    required fax,
    required mail,
    required mobile,
    required name,
    required openingBalance,
    required status,
    required telephone,
    required vatNumber,
  }) async {
    Response response = await supplierService.addSupplier(
      name: name,
      mail: mail,
      fax: fax,
      mobile: mobile,
      openingBalance: openingBalance,
      status: status,
      telephone: telephone,
      vatNumber: vatNumber,
    );

    return response;
  }

  // edit Supplier
  Future editSupplier({
    required id,
    required fax,
    required mail,
    required mobile,
    required name,
    required status,
    required telephone,
    required vatNumber,
  }) async {
    Response response = await supplierService.editSupplier(
      id: id,
      name: name,
      mail: mail,
      fax: fax,
      mobile: mobile,
      status: status,
      telephone: telephone,
      vatNumber: vatNumber,
    );

    return response;
  }

  // get supplier purchase invoices
  Future<List<PurchaseInvoiceModel>> getSupplierInvoices(int id) async {
    final rawData = await supplierService.getSupplierInvoices(id);
    var invoices = List<PurchaseInvoiceModel>.from(
        rawData['data'].map((x) => PurchaseInvoiceModel.fromJson(x)));
    return invoices;
  }
}
