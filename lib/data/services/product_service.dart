import 'dart:io';
import 'package:dio/dio.dart';

import '../http/dio_client.dart';

class ProductService {
  final DioClient _dioClient = DioClient();

  // get all products
  Future getProducts({
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            "/products?page=$pageNo&search=$searchText&perPage=$perPage&sort=id,desc");
    return response;
  }

  // get single product
  Future getSingleProduct({required int id}) async {
    var response = await _dioClient.get(endPoint: "/products/$id");
    return response;
  }

  // get products of date ranges
  Future getDateRangedProducts({
    required dynamic dateRange,
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            '/products?page=$pageNo&search=$searchText&perPage=$perPage&dateRange=$dateRange&sort=id,desc');
    return response;
  }

  // delete product
  Future deleteProduct(int id) async {
    Response response = await _dioClient.delete(endPoint: "/products/$id");
    return response;
  }

  // add product
  Future addProduct({
    name,
    code,
    storeIn,
    size,
    color,
    categoryId,
    batches,
    brand,
    purchaseRate,
    sellingRate,
    openingQuantity,
    alertQuantity,
    unitId,
    purchaseUnits,
    sellingUnits,
    mfgDate,
    expDate,
    generateInvoice,
    invoiceDate,
    supplierId,
    invoiceNo,
  }) async {
    Response response = await _dioClient.post(
      endPoint: '/products',
      data: {
        "name": name,
        "code": code,
        "storeIn": storeIn,
        "size": size,
        "color": color,
        "categoryId": categoryId,
        "batches": batches,
        "brand": brand,
        "purchaseRate": purchaseRate,
        "sellingRate": sellingRate,
        "openingQuantity": openingQuantity,
        "alertQuantity": alertQuantity,
        "unitId": unitId,
        "purchaseUnits": purchaseUnits,
        "sellingUnits": sellingUnits,
        "mfgDate": mfgDate,
        "expDate": expDate,
        "generateInvoice": generateInvoice,
        "date": invoiceDate,
        "supplierId": supplierId,
        "invoiceNo": invoiceNo,
      },
    );
    return response;
  }

  // add product photo
  Future addProductPhoto({required int id, File? photo}) async {
    var formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo!.path),
    });

    Response response = await _dioClient.post(
      endPoint: '/products/$id/photo',
      data: formData,
    );
    return response;
  }

  // get product Batches
  Future getProductBatches({
    required int pageNo,
    required int perPage,
    required String searchText,
    required int productId,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            '/batches?page=$pageNo&search=$searchText&perPage=$perPage&product=$productId&sort=id,desc');
    return response;
  }

  // get all Batches
  Future getAllBatches() async {
    var response = await _dioClient.get(
        endPoint: "/batches?page=&search=&product=&sort=id,desc");
    return response;
  }

  // edit product
  Future editProduct({
    required productId,
    required name,
    required code,
    required storeIn,
    required size,
    required color,
    required categoryId,
    required brand,
    required unitId,
    required purchaseUnits,
    required sellingUnits,
    required alertQuantity,
    required photo,
    required status,
  }) async {
    Response response = await _dioClient.update(
      endPoint: '/products/$productId',
      data: {
        "name": name,
        "code": code,
        "storeIn": storeIn,
        "size": size,
        "color": color,
        "categoryId": categoryId,
        "brand": brand,
        "unitId": unitId,
        "purchaseUnits": purchaseUnits,
        "sellingUnits": sellingUnits,
        "alertQuantity": alertQuantity,
        "photo": photo,
        "status": status,
      },
    );
    return response;
  }

  // edit batch
  Future editBatch({
    required batchId,
    required productId,
    required sellingRate,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/purchase-items/edit/batch",
      data: {
        "batchId": batchId,
        "productId": productId,
        "sellingRate": sellingRate,
      },
    );
    return res;
  }

  // add Batch Stock
  Future addBatchStock({
    required batchId,
    required productId,
    required generateInvoice,
    required invoiceNo,
    required quantity,
    required supplierId,
    required date,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/purchase-items/stock/batch",
      data: {
        "batchId": batchId,
        "productId": productId,
        "generateInvoice": generateInvoice,
        "invoiceNo": invoiceNo,
        "quantity": quantity,
        "supplierId": supplierId,
        "date": date,
      },
    );
    return res;
  }

  // delete batch
  Future deleteBatch({
    required ids,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/batches/delete-all",
      data: {
        "ids": ids,
      },
    );
    return res;
  }

  // get all expired products
  Future getExpiredProducts({
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    var response = await _dioClient.get(
        endPoint:
            '/batches/expired?page=$pageNo&search=$searchText&perPage=$perPage&sort=id,desc');
    return response;
  }

  // add stock on manage stock
  Future addStockOnManageStock({
    required date,
    required productId,
    required generateInvoice,
    required invoiceNo,
    required quantity,
    required mfgDate,
    required expDate,
    required purchaseRate,
    required sellingRate,
    required supplierId,
    required unitId,
    required batches,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/purchase-items",
      data: {
        "date": date,
        "productId": productId,
        "generateInvoice": generateInvoice,
        "invoiceNo": invoiceNo,
        "quantity": quantity,
        "mfgDate": mfgDate,
        "expDate": expDate,
        "purchaseRate": purchaseRate,
        "sellingRate": sellingRate,
        "supplierId": supplierId,
        "unitId": unitId,
        "batches": batches,
      },
    );
    return res;
  }
}
