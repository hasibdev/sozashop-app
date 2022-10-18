part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class LoadingState extends ProductState {}

class ButtonLoadingState extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsListLoading extends ProductState {}

class ProductsFetched extends ProductState {
  List<ProductModel> products;
  ProductsFetched({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}

class ProductDeleted extends ProductState {}

class DeleteProductFailed extends ProductState {
  final Map error;
  const DeleteProductFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DeleteProductFailed { error: $error }';
}

class ProductDetailState extends ProductState {
  ProductModel? product;
  List<BatchModel>? productBatches;
  String? fromPage;

  ProductDetailState({
    this.product,
    this.productBatches,
    this.fromPage,
  });

  @override
  List<Object> get props => [product!, productBatches!];

  ProductDetailState copyWith({
    ProductModel? product,
    List<BatchModel>? productBatches,
    String? fromPage,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      productBatches: productBatches ?? this.productBatches,
      fromPage: fromPage ?? this.fromPage,
    );
  }
}

class ProductBatchesFetched extends ProductState {
  final List<BatchModel> batches;
  const ProductBatchesFetched({
    required this.batches,
  });

  @override
  List<Object> get props => [batches];
}

class UnitConversionsFetched extends ProductState {
  List<UnitConversionModel> unitConversions;
  UnitConversionsFetched({
    required this.unitConversions,
  });

  @override
  List<Object> get props => [unitConversions];
}

class EditPageUnitConversionsFetched extends ProductState {
  List<UnitConversionModel> unitConversions;
  EditPageUnitConversionsFetched({
    required this.unitConversions,
  });

  @override
  List<Object> get props => [unitConversions];
}

class SuppliersFetchedForStock extends ProductState {
  List<SupplierModel> suppliers;
  SuppliersFetchedForStock({
    required this.suppliers,
  });
  @override
  List<Object> get props => [suppliers];
}

class SuppliersFetched extends ProductState {
  List<SupplierModel> suppliers;
  SuppliersFetched({
    required this.suppliers,
  });
  @override
  List<Object> get props => [suppliers];
}

class SupplierInvoicesFetched extends ProductState {
  List<PurchaseInvoiceModel> invoices;
  SupplierInvoicesFetched({
    required this.invoices,
  });
  @override
  List<Object> get props => [invoices];
}

class ProductAddingState extends ProductState {
  List<CategoryModel>? categories;
  List<UnitModel>? units;
  List<SupplierModel>? suppliers;

  dynamic name;
  dynamic code;
  dynamic storeIn;
  dynamic size;
  dynamic color;
  dynamic categoryId;
  dynamic batches;
  dynamic brand;
  dynamic purchaseRate;
  dynamic sellingRate;
  dynamic openingQuantity;
  dynamic alertQuantity;
  dynamic unitId;
  dynamic purchaseUnits;
  dynamic sellingUnits;
  dynamic mfgDate;
  dynamic expDate;
  dynamic generateInvoice;
  dynamic invoiceDate;
  dynamic supplierId;
  dynamic invoiceNo;
  dynamic photo;
  ProductAddingState({
    this.categories,
    this.units,
    this.suppliers,
    this.name,
    this.code,
    this.storeIn,
    this.size,
    this.color,
    this.categoryId,
    this.batches,
    this.brand,
    this.purchaseRate,
    this.sellingRate,
    this.openingQuantity,
    this.alertQuantity,
    this.unitId,
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
  List<Object> get props => [categories!, units!];

  ProductAddingState copyWith({
    List<CategoryModel>? categories,
    List<UnitModel>? units,
    List<SupplierModel>? suppliers,
    dynamic name,
    dynamic code,
    dynamic storeIn,
    dynamic size,
    dynamic color,
    dynamic categoryId,
    dynamic batches,
    dynamic brand,
    dynamic purchaseRate,
    dynamic sellingRate,
    dynamic openingQuantity,
    dynamic alertQuantity,
    dynamic unitId,
    dynamic purchaseUnits,
    dynamic sellingUnits,
    dynamic mfgDate,
    dynamic expDate,
    dynamic generateInvoice,
    dynamic invoiceDate,
    dynamic supplierId,
    dynamic invoiceNo,
    dynamic photo,
  }) {
    return ProductAddingState(
      categories: categories ?? this.categories,
      units: units ?? this.units,
      suppliers: suppliers ?? this.suppliers,
      name: name ?? this.name,
      code: code ?? this.code,
      storeIn: storeIn ?? this.storeIn,
      size: size ?? this.size,
      color: color ?? this.color,
      categoryId: categoryId ?? this.categoryId,
      batches: batches ?? this.batches,
      brand: brand ?? this.brand,
      purchaseRate: purchaseRate ?? this.purchaseRate,
      sellingRate: sellingRate ?? this.sellingRate,
      openingQuantity: openingQuantity ?? this.openingQuantity,
      alertQuantity: alertQuantity ?? this.alertQuantity,
      unitId: unitId ?? this.unitId,
      purchaseUnits: purchaseUnits ?? this.purchaseUnits,
      sellingUnits: sellingUnits ?? this.sellingUnits,
      mfgDate: mfgDate ?? this.mfgDate,
      expDate: expDate ?? this.expDate,
      generateInvoice: generateInvoice ?? this.generateInvoice,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      supplierId: supplierId ?? this.supplierId,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      photo: photo ?? this.photo,
    );
  }
}

class ProductAddedState extends ProductState {}

class ProductAddingFailed extends ProductState {
  final Map error;
  const ProductAddingFailed({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'ProductAddingFailed { error: $error }';
}

class NewCategoryAddedState extends ProductState {
  List<CategoryModel> categories;
  NewCategoryAddedState({
    required this.categories,
  });
  @override
  List<Object> get props => [categories];
}

class NewCategoryAddingFailed extends ProductState {
  final Map error;
  const NewCategoryAddingFailed({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'NewCategoryAddingFailed { error: $error }';
}

class NewUnitAddedState extends ProductState {
  List<UnitModel> units;
  NewUnitAddedState({
    required this.units,
  });
  @override
  List<Object> get props => [units];
}

class NewUnitAddingFailed extends ProductState {
  final Map error;
  const NewUnitAddingFailed({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'NewUnitAddingFailed { error: $error }';
}

class NewSupplierAddedState extends ProductState {
  List<SupplierModel> suppliers;
  NewSupplierAddedState({
    required this.suppliers,
  });
  @override
  List<Object> get props => [suppliers];
}

class NewSupplierAddingFailed extends ProductState {
  final Map error;
  const NewSupplierAddingFailed({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'NewSupplierAddingFailed { error: $error }';
}

class ProductEditingState extends ProductState {
  List<CategoryModel>? categories;
  List<UnitModel>? units;
  List<UnitConversionModel>? unitConversions;

  int? productId;
  dynamic name;
  dynamic code;
  dynamic storeIn;
  dynamic size;
  dynamic color;
  dynamic categoryId;
  dynamic brand;
  dynamic unitId;
  dynamic purchaseUnits;
  dynamic sellingUnits;
  dynamic alertQuantity;
  dynamic photo;
  dynamic status;

  ProductEditingState({
    this.categories,
    this.units,
    this.unitConversions,
    this.productId,
    this.name,
    this.code,
    this.storeIn,
    this.size,
    this.color,
    this.categoryId,
    this.brand,
    this.unitId,
    this.purchaseUnits,
    this.sellingUnits,
    this.alertQuantity,
    this.photo,
    this.status,
  });

  ProductEditingState copyWith({
    List<CategoryModel>? categories,
    List<UnitModel>? units,
    List<UnitConversionModel>? unitConversions,
    int? productId,
    dynamic name,
    dynamic code,
    dynamic storeIn,
    dynamic size,
    dynamic color,
    dynamic categoryId,
    dynamic brand,
    dynamic unitId,
    dynamic purchaseUnits,
    dynamic sellingUnits,
    dynamic alertQuantity,
    dynamic photo,
    dynamic status,
  }) {
    return ProductEditingState(
      categories: categories ?? this.categories,
      units: units ?? this.units,
      unitConversions: unitConversions ?? this.unitConversions,
      name: name ?? this.name,
      productId: productId ?? this.productId,
      code: code ?? this.code,
      storeIn: storeIn ?? this.storeIn,
      size: size ?? this.size,
      color: color ?? this.color,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      unitId: unitId ?? this.unitId,
      purchaseUnits: purchaseUnits ?? this.purchaseUnits,
      sellingUnits: sellingUnits ?? this.sellingUnits,
      alertQuantity: alertQuantity ?? this.alertQuantity,
      photo: photo ?? this.photo,
      status: status ?? this.status,
    );
  }
}

class ProductEditedState extends ProductState {}

class ProductEditingFailed extends ProductState {
  final Map error;
  const ProductEditingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class BatchLoading extends ProductState {}

class BatchEditingState extends ProductState {}

class BatchEditedState extends ProductState {}

class BatchEditingFailed extends ProductState {
  final Map error;
  const BatchEditingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class StockAddingState extends ProductState {
  final BatchModel batchModel;
  String? referPage;
  StockAddingState({
    required this.batchModel,
    this.referPage,
  });

  @override
  List<Object> get props => [batchModel];
}

class StockAddedState extends ProductState {}

class StockAddingFailed extends ProductState {
  final Map error;
  const StockAddingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class BatchDeletedState extends ProductState {}

class BatchDeletingFailed extends ProductState {
  final Map error;
  const BatchDeletingFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductBarcodePageState extends ProductState {
  List<BatchModel> batches;
  ProductBarcodePageState({
    required this.batches,
  });

  @override
  List<Object> get props => [batches];
}

class BarcodePdfGenerated extends ProductState {}

class BarcodePdfGeneratedFailed extends ProductState {
  final Map error;
  const BarcodePdfGeneratedFailed({required this.error});

  @override
  List<Object> get props => [error];
}
