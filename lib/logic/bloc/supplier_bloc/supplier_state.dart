part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object> get props => [];
}

class SupplierInitial extends SupplierState {}

class LoadingState extends SupplierState {}

class SuppliersLoading extends SupplierState {}

class SuppliersFetched extends SupplierState {
  List<SupplierModel> suppliers;
  SuppliersFetched({
    required this.suppliers,
  });

  @override
  List<Object> get props => [suppliers];
}

class SupplierAddingState extends SupplierState {}

class SupplierAddedState extends SupplierState {}

class SupplierAddingFailed extends SupplierState {
  final Map error;
  const SupplierAddingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SupplierAddingFailed { error: $error }';
}

class SupplierDeletedState extends SupplierState {}

class SupplierDeletingFailed extends SupplierState {
  final Map error;
  const SupplierDeletingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SupplierDeletingFailed { error: $error }';
}

class SupplierDetailState extends SupplierState {
  SupplierModel supplier;
  SupplierDetailState({
    required this.supplier,
  });
  @override
  List<Object> get props => [supplier];
}

class SupplierEditingState extends SupplierState {
  SupplierModel supplierModel;
  SupplierEditingState({
    required this.supplierModel,
  });

  @override
  List<Object> get props => [supplierModel];
}

class SupplierEditedState extends SupplierState {}

class SupplierEditingFailed extends SupplierState {
  final Map error;
  const SupplierEditingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SupplierEditingFailed { error: $error }';
}
