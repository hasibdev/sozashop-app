import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/batch_model.dart';
import 'package:sozashop_app/data/models/purchase_invoice_model.dart';
import 'package:sozashop_app/data/models/supplier_model.dart';
import 'package:sozashop_app/data/models/unit_conversion_model.dart';
import 'package:sozashop_app/data/repositories/barcode_repository.dart';

import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/data/repositories/supplier_repository.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/unit_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  CategoryRepository categoryRepository;
  UnitRepository unitRepository;
  SupplierRepository supplierRepository;
  BarcodeRepository barcodeRepository = BarcodeRepository();
  ProductBloc({
    required this.productRepository,
    required this.categoryRepository,
    required this.unitRepository,
    required this.supplierRepository,
  }) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      // fetch products
      if (event is FetchProducts) {
        emit(ProductsListLoading());
        var products = await productRepository.getProducts(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(ProductsFetched(products: products));
      }

      // delete product
      if (event is DeleteProduct) {
        Response res =
            await productRepository.deleteProduct(id: event.productId);
        if (res.statusCode == 200) {
          emit(ProductDeleted());
          emit(ProductsLoading());
          var products = await productRepository.getProducts();
          emit(ProductsFetched(products: products));
        } else {
          print('bloc del products failed >>>>> $res');
          emit(DeleteProductFailed(error: res.data));
          emit(ProductsLoading());
          var products = await productRepository.getProducts();
          emit(ProductsFetched(products: products));
        }
      }

      // go product detail page
      if (event is GoProductDetailPage) {
        emit(LoadingState());
        var batches = await productRepository.getProductBatches(
          productId: event.productModel!.id,
        );
        emit(ProductBatchesFetched(batches: batches));
        emit(ProductDetailState(
          fromPage: event.referPage,
          product: event.productModel,
          productBatches: batches,
        ));
      }

      // fetch product batches
      if (event is FetchProductBatches) {
        emit(BatchLoading());
        var batches = await productRepository.getProductBatches(
          productId: event.productId,
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(ProductBatchesFetched(batches: batches));
      }

      // delete batch
      if (event is DeleteBatch) {
        Response res = await productRepository.deleteBatch(ids: event.ids);
        if (res.statusCode == 200) {
          emit(BatchDeletedState());
          emit(BatchLoading());
          var product =
              await productRepository.getSingleProduct(id: event.productId);
          var batches = await productRepository.getProductBatches(
              productId: event.productId);
          emit(ProductDetailState().copyWith(
            product: product,
            productBatches: batches,
          ));
        } else {
          emit(BatchDeletingFailed(error: res.data));
          emit(BatchLoading());
          var product =
              await productRepository.getSingleProduct(id: event.productId);
          var batches = await productRepository.getProductBatches(
              productId: event.productId);
          emit(ProductDetailState().copyWith(
            product: product,
            productBatches: batches,
          ));
        }
      }

      // edit batch in product detail page
      if (event is EditBatch) {
        Response res = await productRepository.editBatch(
          batchId: event.batchId,
          productId: event.productId,
          sellingRate: event.sellingRate,
        );
        if (res.statusCode == 200) {
          emit(BatchEditedState());
          emit(BatchLoading());
          var batches = await productRepository.getProductBatches(
              productId: event.productId);
          emit(ProductDetailState().copyWith(
            product: event.productModel,
            productBatches: batches,
          ));
        } else {
          emit(BatchEditingFailed(error: res.data));
        }
      }

      // go add stock page
      if (event is GoAddStockPage) {
        emit(LoadingState());
        emit(StockAddingState(batchModel: event.batchModel));
      }

      // add batch stock
      if (event is AddBatchStock) {
        Response res = await productRepository.addBatchStock(
          batchId: event.batchId,
          productId: event.productId,
          generateInvoice: event.generateInvoice,
          invoiceNo: event.invoiceNo,
          quantity: event.quantity,
          supplierId: event.supplierId,
          date: event.date,
        );

        if (res.statusCode == 200) {
          emit(StockAddedState());
          emit(LoadingState());
          var product =
              await productRepository.getSingleProduct(id: event.productId);
          var batches = await productRepository.getProductBatches(
              productId: event.productId);
          emit(ProductDetailState().copyWith(
            product: product,
            productBatches: batches,
          ));
        } else {
          emit(StockAddingFailed(error: res.data));
          emit(StockAddingState(batchModel: event.batchModel));
        }
      }

      if (event is GoTOAllProductsPage) {
        emit(ProductsLoading());
        var products = await productRepository.getProducts();
        emit(ProductsFetched(products: products));
      }

      if (event is GoAddProductPage) {
        emit(LoadingState());
        var categories = await categoryRepository.getCategories();
        var units = await unitRepository.getUnits();
        emit(ProductAddingState(
          categories: categories,
          units: units,
        ));
      }

      if (event is FetchUnitConversions) {
        var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.baseUnitId);
        emit(UnitConversionsFetched(unitConversions: unitConversions));
      }

      if (event is FetchUnitConversionsOnEditPage) {
        var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.baseUnitId);
        emit(EditPageUnitConversionsFetched(unitConversions: unitConversions));
      }

      if (event is FetchSuppliers) {
        var suppliers = await supplierRepository.getSuppliers();
        emit(SuppliersFetched(suppliers: suppliers));
      }

      if (event is FetchSuppliersForStock) {
        var suppliers = await supplierRepository.getSuppliers();
        emit(SuppliersFetchedForStock(suppliers: suppliers));
      }

      if (event is FetchSupplierInvoices) {
        var invoices =
            await supplierRepository.getSupplierInvoices(event.supplierId);
        emit(SupplierInvoicesFetched(invoices: invoices));
      }

      // add new category
      if (event is AddNewCategory) {
        Response response = await categoryRepository.addCategory(
          categoryName: event.name,
          description: event.description,
        );
        var categories = await categoryRepository.getCategories();
        var units = await unitRepository.getUnits();
        if (response.statusCode == 201) {
          emit(NewCategoryAddedState(categories: categories));
        } else {
          emit(NewCategoryAddingFailed(error: response.data));
          emit(ProductAddingState(
            categories: categories,
            units: units,
          ));
        }
      }

      // add new unit
      if (event is AddNewUnit) {
        Response response = await unitRepository.addUnit(
          unitName: event.unitName,
          unitCode: event.unitName,
        );
        var categories = await categoryRepository.getCategories();
        var units = await unitRepository.getUnits();
        if (response.statusCode == 201) {
          emit(NewUnitAddedState(units: units));
        } else {
          emit(NewUnitAddingFailed(error: response.data));
          emit(ProductAddingState(
            categories: categories,
            units: units,
          ));
        }
      }

      // add supplier
      if (event is AddNewSupplier) {
        var response = await supplierRepository.addSupplier(
          fax: event.fax,
          mail: event.mail,
          mobile: event.mobile,
          name: event.name,
          openingBalance: event.openingBalance,
          status: event.status,
          telephone: event.telephone,
          vatNumber: event.vatNumber,
        );
        var suppliers = await supplierRepository.getSuppliers();
        if (response.statusCode == 201) {
          emit(NewSupplierAddedState(suppliers: suppliers));
        } else {
          var categories = await categoryRepository.getCategories();
          var units = await unitRepository.getUnits();
          emit(NewSupplierAddingFailed(error: response.data));
          emit(ProductAddingState(
            suppliers: suppliers,
            categories: categories,
            units: units,
          ));
        }
      }

      // add product
      if (event is AddProduct) {
        Response resProduct = await productRepository.addProduct(
          name: event.name,
          code: event.code,
          storeIn: event.storeIn,
          size: event.size,
          color: event.color,
          categoryId: event.categoryId,
          batches: event.batches,
          brand: event.brand,
          purchaseRate: event.purchaseRate,
          sellingRate: event.sellingRate,
          openingQuantity: event.openingQuantity,
          alertQuantity: event.alertQuantity,
          unitId: event.unitId,
          purchaseUnits: event.purchaseUnits,
          sellingUnits: event.sellingUnits,
          mfgDate: event.mfgDate?.toIso8601String(),
          expDate: event.expDate?.toIso8601String(),
          generateInvoice: event.generateInvoice,
          invoiceDate: event.invoiceDate?.toIso8601String(),
          supplierId: event.supplierId,
          invoiceNo: event.invoiceNo,
        );
        if (resProduct.statusCode == 201) {
          int? newProductId;
          if (resProduct.data["data"]?.containsKey('id')) {
            newProductId = await resProduct.data['data']?['id'];
          }
          if (event.photo != null && newProductId != null) {
            Response resPhoto = await productRepository.addProductPhoto(
              id: newProductId,
              photo: event.photo,
            );
          }
          emit(ProductAddedState());
          emit(LoadingState());
          var products = await productRepository.getProducts();
          emit(ProductsFetched(products: products));
        } else {
          emit(ProductAddingFailed(error: resProduct.data));
          var categories = await categoryRepository.getCategories();
          var units = await unitRepository.getUnits();
          var suppliers = await supplierRepository.getSuppliers();

          emit(ProductAddingState().copyWith(
            categories: categories,
            units: units,
            suppliers: suppliers,
            name: event.name,
            code: event.code,
            storeIn: event.storeIn,
            size: event.size,
            color: event.color,
            categoryId: event.categoryId,
            batches: event.batches,
            brand: event.brand,
            purchaseRate: event.purchaseRate,
            sellingRate: event.sellingRate,
            openingQuantity: event.openingQuantity,
            alertQuantity: event.alertQuantity,
            unitId: event.unitId,
            purchaseUnits: event.purchaseUnits,
            sellingUnits: event.sellingUnits,
            mfgDate: event.mfgDate,
            expDate: event.expDate,
            generateInvoice: event.generateInvoice,
            invoiceDate: event.invoiceDate,
            supplierId: event.supplierId,
            invoiceNo: event.invoiceNo,
          ));
        }
      }

      if (event is GoEditProductPage) {
        emit(LoadingState());
        var categories = await categoryRepository.getCategories();
        var units = await unitRepository.getUnits();

        var unitConversions = await unitRepository.getUnitConversions(
            baseUnitId: event.productModel.unitId);
        // emit(EditPageUnitConversionsFetched(unitConversions: unitConversions));

        emit(ProductEditingState().copyWith(
          categories: categories,
          units: units,
          unitConversions: unitConversions,
          productId: event.productModel.id,
          name: event.productModel.name,
          code: event.productModel.code,
          storeIn: event.productModel.storeIn,
          size: event.productModel.size,
          color: event.productModel.color,
          categoryId: event.productModel.categoryId,
          brand: event.productModel.brand,
          unitId: event.productModel.unitId,
          purchaseUnits: event.productModel.purchaseUnits,
          sellingUnits: event.productModel.sellingUnits,
          alertQuantity: event.productModel.alertQuantity,
          photo: event.productModel.imageUrl,
          status: event.productModel.status,
        ));
      }

      // add product
      if (event is EditProduct) {
        Response resProduct = await productRepository.editProduct(
          productId: event.productId,
          name: event.name,
          code: event.code,
          storeIn: event.storeIn,
          size: event.size,
          color: event.color,
          categoryId: event.categoryId,
          brand: event.brand,
          unitId: event.unitId,
          purchaseUnits: event.purchaseUnits,
          sellingUnits: event.sellingUnits,
          alertQuantity: event.alertQuantity,
          // photo: event.photo,
          status: event.status,
        );
        print('add product bloc >>>>> ${resProduct.data}');
        // emit(ButtonLoadingState());
        if (resProduct.statusCode == 200) {
          if (event.photo != null) {
            Response resPhoto = await productRepository.addProductPhoto(
              id: event.productId,
              photo: event.photo,
            );

            print('add product image bloc >>>>> ${resPhoto.data}');
          }
          emit(ProductEditedState());
          emit(LoadingState());
          var products = await productRepository.getProducts();
          emit(ProductsFetched(products: products));
        } else {
          print('add product bloc failed >> data >>>>> ${resProduct.data}');
          emit(ProductEditingFailed(error: resProduct.data));
          var categories = await categoryRepository.getCategories();
          var units = await unitRepository.getUnits();
          var unitConversions =
              await unitRepository.getUnitConversions(baseUnitId: event.unitId);

          emit(ProductEditingState().copyWith(
            categories: categories,
            units: units,
            unitConversions: unitConversions,
            productId: event.productId,
            name: event.name,
            code: event.code,
            storeIn: event.storeIn,
            size: event.size,
            color: event.color,
            categoryId: event.categoryId,
            brand: event.brand,
            unitId: event.unitId,
            purchaseUnits: event.purchaseUnits,
            sellingUnits: event.sellingUnits,
            alertQuantity: event.alertQuantity,
            photo: event.photo,
            status: event.status,
          ));
        }
      }

      if (event is GoProductBarcodePage) {
        var batches = await productRepository.getProductBatches(
            productId: event.productId);
        emit(ProductBarcodePageState(batches: batches));
      }

      if (event is GenerateBarcodePdf) {
        final data = await barcodeRepository.generateBarcodePdf(
          totalBarCode: event.totalBarCode,
          batch: event.selectedBatch,
        );

        barcodeRepository.savePdfFile(event.selectedBatch.name, data);

        emit(BarcodePdfGenerated(
            // filePath: barcodeRepository.getPdfFilePath(event.selectedBatch.name),
            ));
        var batches = await productRepository.getProductBatches(
            productId: event.selectedBatch.productId);
        emit(ProductBarcodePageState(batches: batches));
      }

      // open barcode pdf
      if (event is OpenBarcodePdf) {
        await barcodeRepository.openPdfFile();
      }

      // inside
    });
  }
}
