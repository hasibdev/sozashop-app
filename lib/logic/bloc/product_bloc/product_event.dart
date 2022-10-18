part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchProducts({this.pageNo, this.perPage, this.searchText});
}

class DeleteProduct extends ProductEvent {
  int productId;
  DeleteProduct({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class GoProductDetailPage extends ProductEvent {
  final ProductModel? productModel;
  final String? referPage;
  const GoProductDetailPage({
    this.productModel,
    this.referPage,
  });
  @override
  List<Object> get props => [productModel!];

  GoProductDetailPage copyWith({
    ProductModel? productModel,
    String? referPage,
  }) {
    return GoProductDetailPage(
      productModel: productModel ?? this.productModel,
      referPage: referPage ?? this.referPage,
    );
  }
}

class FetchProductBatches extends ProductEvent {
  final int productId;
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchProductBatches({
    required this.productId,
    this.pageNo,
    this.perPage,
    this.searchText,
  });
  @override
  List<Object> get props => [productId];
}

class GoTOAllProductsPage extends ProductEvent {}

class GoAddProductPage extends ProductEvent {}

class FetchUnitConversions extends ProductEvent {
  int baseUnitId;
  FetchUnitConversions({
    required this.baseUnitId,
  });
  @override
  List<Object> get props => [baseUnitId];
}

class FetchUnitConversionsOnEditPage extends ProductEvent {
  int baseUnitId;
  FetchUnitConversionsOnEditPage({
    required this.baseUnitId,
  });
  @override
  List<Object> get props => [baseUnitId];
}

class FetchSuppliers extends ProductEvent {}

class FetchSuppliersForStock extends ProductEvent {}

class FetchSupplierInvoices extends ProductEvent {
  final int supplierId;
  const FetchSupplierInvoices({
    required this.supplierId,
  });
  @override
  List<Object> get props => [supplierId];
}

class AddProduct extends ProductEvent {
  String name;
  String? code;
  var storeIn;
  var size;
  var color;
  var categoryId;
  var batches;
  var brand;
  var purchaseRate;
  var sellingRate;
  var openingQuantity;
  var alertQuantity;
  var unitId;
  var purchaseUnits;
  var sellingUnits;
  var mfgDate;
  var expDate;
  var generateInvoice;
  var invoiceDate;
  var supplierId;
  var invoiceNo;
  File? photo;

  AddProduct({
    required this.name,
    this.code,
    this.storeIn,
    this.size,
    this.color,
    required this.categoryId,
    required this.batches,
    this.brand,
    required this.purchaseRate,
    required this.sellingRate,
    required this.openingQuantity,
    this.alertQuantity,
    required this.unitId,
    this.purchaseUnits,
    this.sellingUnits,
    this.mfgDate,
    this.expDate,
    this.generateInvoice,
    this.invoiceDate,
    this.supplierId,
    this.invoiceNo,
    this.photo,
  });

  @override
  List<Object> get props => [name];
}

class AddNewCategory extends ProductEvent {
  String name;
  String description;
  AddNewCategory({
    required this.name,
    required this.description,
  });

  @override
  List<Object> get props => [name, description];
}

class AddNewUnit extends ProductEvent {
  String unitName;
  AddNewUnit({
    required this.unitName,
  });

  @override
  List<Object> get props => [unitName];
}

class AddNewSupplier extends ProductEvent {
  String? fax;
  String? mail;
  String mobile;
  String name;
  String? openingBalance;
  String? status;
  String? telephone;
  String? vatNumber;
  AddNewSupplier({
    this.fax,
    this.mail,
    required this.mobile,
    required this.name,
    this.openingBalance,
    this.status,
    this.telephone,
    this.vatNumber,
  });

  @override
  List<Object> get props => [mobile, name];
}

class GoEditProductPage extends ProductEvent {
  ProductModel productModel;
  GoEditProductPage({
    required this.productModel,
  });

  @override
  List<Object> get props => [productModel];
}

class EditProduct extends ProductEvent {
  int productId;
  String name;
  String? code;
  dynamic storeIn;
  dynamic size;
  dynamic color;
  dynamic categoryId;
  dynamic brand;
  dynamic unitId;
  dynamic purchaseUnits;
  dynamic sellingUnits;
  dynamic alertQuantity;
  dynamic status;
  dynamic photo;

  EditProduct({
    required this.productId,
    required this.name,
    this.code,
    this.storeIn,
    this.size,
    this.color,
    required this.categoryId,
    this.brand,
    required this.unitId,
    this.purchaseUnits,
    this.sellingUnits,
    this.alertQuantity,
    this.photo,
    this.status,
  });

  @override
  List<Object> get props => [name];
}

class EditBatch extends ProductEvent {
  final int batchId;
  final int productId;
  final dynamic sellingRate;
  final ProductModel productModel;
  const EditBatch({
    required this.batchId,
    required this.productId,
    required this.sellingRate,
    required this.productModel,
  });
}

class GoAddStockPage extends ProductEvent {
  BatchModel batchModel;
  String? referPage;
  GoAddStockPage({
    required this.batchModel,
    this.referPage,
  });

  @override
  List<Object> get props => [batchModel];
}

class AddBatchStock extends ProductEvent {
  final int batchId;
  final int productId;
  final bool generateInvoice;
  final dynamic invoiceNo;
  final dynamic quantity;
  final int? supplierId;
  final dynamic date;
  final BatchModel batchModel;
  const AddBatchStock({
    required this.batchId,
    required this.productId,
    required this.generateInvoice,
    required this.invoiceNo,
    required this.quantity,
    required this.supplierId,
    required this.date,
    required this.batchModel,
  });
}

class DeleteBatch extends ProductEvent {
  final List ids;
  final int productId;
  const DeleteBatch({
    required this.ids,
    required this.productId,
  });
}

class GoProductBarcodePage extends ProductEvent {
  final int productId;
  const GoProductBarcodePage({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class GenerateBarcodePdf extends ProductEvent {
  final int totalBarCode;
  final BatchModel selectedBatch;
  const GenerateBarcodePdf({
    required this.totalBarCode,
    required this.selectedBatch,
  });
}

class OpenBarcodePdf extends ProductEvent {}
