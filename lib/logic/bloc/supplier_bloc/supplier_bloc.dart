import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/supplier_model.dart';
import '../../../data/repositories/supplier_repository.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierRepository supplierRepository;
  SupplierBloc({
    required this.supplierRepository,
  }) : super(SupplierInitial()) {
    on<SupplierEvent>((event, emit) async {
      if (event is FetchSuppliers) {
        emit(SuppliersLoading());
        var suppliers = await supplierRepository.getSuppliers(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(SuppliersFetched(suppliers: suppliers));
      }

      if (event is GoAddSupplierPage) {
        emit(SupplierAddingState());
      }

      if (event is GoAllSuppliersPage) {
        emit(SuppliersLoading());
        var suppliers = await supplierRepository.getSuppliers();
        emit(SuppliersFetched(suppliers: suppliers));
      }

      // delete supplier
      if (event is DeleteSupplier) {
        Response res =
            await supplierRepository.deleteSupplier(event.supplierId);
        if (res.statusCode == 200) {
          emit(SupplierDeletedState());
          emit(SuppliersLoading());
          var suppliers = await supplierRepository.getSuppliers();
          emit(SuppliersFetched(suppliers: suppliers));
        } else {
          emit(SupplierDeletingFailed(error: res.data));
          emit(SuppliersLoading());
          var suppliers = await supplierRepository.getSuppliers();
          emit(SuppliersFetched(suppliers: suppliers));
        }
      }

      // Supplier details
      if (event is GoSupplierDetailPage) {
        emit(LoadingState());
        emit(SupplierDetailState(supplier: event.supplierModel));
      }

      // add supplier
      if (event is AddSupplier) {
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
        if (response.statusCode == 201) {
          emit(SupplierAddedState());
          emit(SuppliersLoading());
          var suppliers = await supplierRepository.getSuppliers();
          emit(SuppliersFetched(suppliers: suppliers));
        } else {
          emit(SupplierAddingFailed(error: response.data));
          emit(SupplierAddingState());
        }
      }

      if (event is GoEditSupplierPage) {
        emit(SupplierEditingState(supplierModel: event.supplierModel));
      }

      // edit supplier
      if (event is EditSupplier) {
        SupplierModel eventSupplierModel = SupplierModel(
          id: event.supplierId,
          fax: event.fax,
          email: event.mail,
          mobile: event.mobile,
          name: event.name,
          status: event.status,
          telephone: event.telephone,
          vatNumber: event.vatNumber,
        );

        var response = await supplierRepository.editSupplier(
          id: event.supplierId,
          fax: event.fax,
          mail: event.mail,
          mobile: event.mobile,
          name: event.name,
          status: event.status,
          telephone: event.telephone,
          vatNumber: event.vatNumber,
        );
        if (response.statusCode == 200) {
          emit(SupplierEditedState());
          emit(SuppliersLoading());
          var suppliers = await supplierRepository.getSuppliers();
          emit(SuppliersFetched(suppliers: suppliers));
        } else {
          emit(SupplierEditingFailed(error: response.data));
          emit(SupplierEditingState(supplierModel: eventSupplierModel));
        }
      }
    });
  }
}
