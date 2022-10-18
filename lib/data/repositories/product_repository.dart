import 'package:dio/dio.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/data/models/batch_model.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  ProductService productService;
  ProductRepository({
    required this.productService,
  });

  Future<List<ProductModel>> getProducts(
      {int? pageNo, int? perPage, String? searchText}) async {
    final productsRaw = await productService.getProducts(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var products = Product.fromJson(productsRaw);
    return products.data;
  }

  Future<ProductModel> getSingleProduct({required int id}) async {
    final productRaw = await productService.getSingleProduct(id: id);
    var product = ProductModel.fromJson(productRaw['data']);
    return product;
  }

  // get products of date range
  Future<List<ProductModel>> getDateRangedProducts({
    required dynamic dateRange,
    int? pageNo,
    int? perPage,
    String? searchText,
  }) async {
    final raw = await productService.getDateRangedProducts(
      dateRange: dateRange,
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var products = Product.fromJson(raw);
    return products.data;
  }

  Future deleteProduct({required int id}) async {
    Response deleted = await productService.deleteProduct(id);
    return deleted;
  }

  Future addProduct({
    required name,
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
    Response res = await productService.addProduct(
      name: name,
      code: code,
      storeIn: storeIn,
      size: size,
      color: color,
      categoryId: categoryId,
      batches: batches,
      brand: brand,
      purchaseRate: purchaseRate,
      sellingRate: sellingRate,
      openingQuantity: openingQuantity,
      alertQuantity: alertQuantity,
      unitId: unitId,
      purchaseUnits: purchaseUnits,
      sellingUnits: sellingUnits,
      mfgDate: mfgDate,
      expDate: expDate,
      generateInvoice: generateInvoice,
      invoiceDate: invoiceDate,
      invoiceNo: invoiceNo,
      supplierId: supplierId,
    );
    return res;
  }

  Future addProductPhoto({
    required int id,
    required photo,
  }) async {
    Response res = await productService.addProductPhoto(id: id, photo: photo);
    return res;
  }

  // get product batches
  Future<List<BatchModel>> getProductBatches({
    int? pageNo,
    int? perPage,
    String? searchText,
    required int productId,
  }) async {
    final raw = await productService.getProductBatches(
      productId: productId,
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var batches = Batch.fromJson(raw);
    print(batches);
    return batches.data;
  }

  // get product batches
  Future<List<BatchModel>> getAllBatches() async {
    final raw = await productService.getAllBatches();
    var batches = Batch.fromJson(raw);
    print(batches);
    return batches.data;
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
    photo,
    required status,
  }) async {
    Response res = await productService.editProduct(
      productId: productId,
      name: name,
      code: code,
      storeIn: storeIn,
      size: size,
      color: color,
      categoryId: categoryId,
      brand: brand,
      unitId: unitId,
      purchaseUnits: purchaseUnits,
      sellingUnits: sellingUnits,
      alertQuantity: alertQuantity,
      photo: photo,
      status: status,
    );
    return res;
  }

  // edit batch
  Future editBatch({
    required batchId,
    required productId,
    required sellingRate,
  }) async {
    var res = await productService.editBatch(
      batchId: batchId,
      productId: productId,
      sellingRate: sellingRate,
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
    var res = await productService.addBatchStock(
      batchId: batchId,
      productId: productId,
      generateInvoice: generateInvoice,
      invoiceNo: invoiceNo,
      quantity: quantity,
      supplierId: supplierId,
      date: date,
    );
    return res;
  }

  // delete Batch
  Future deleteBatch({
    required ids,
  }) async {
    var res = await productService.deleteBatch(ids: ids);
    return res;
  }

  // get expired products
  Future<List<BatchModel>> getExpiredProducts({
    int? pageNo,
    int? perPage,
    String? searchText,
  }) async {
    final raw = await productService.getExpiredProducts(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var products = Batch.fromJson(raw);
    return products.data;
  }

  // add Batch Stock
  Future addStockOnManageStock({
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
    required date,
  }) async {
    var res = await productService.addStockOnManageStock(
      productId: productId,
      generateInvoice: generateInvoice,
      invoiceNo: invoiceNo,
      quantity: quantity,
      mfgDate: mfgDate,
      expDate: expDate,
      purchaseRate: purchaseRate,
      sellingRate: sellingRate,
      supplierId: supplierId,
      unitId: unitId,
      batches: batches,
      date: date,
    );
    return res;
  }
}
