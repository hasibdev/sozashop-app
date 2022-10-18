part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object> get props => [];
}

class FetchSuppliers extends SupplierEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchSuppliers({this.pageNo, this.perPage, this.searchText});
}

class GoAddSupplierPage extends SupplierEvent {}

class GoAllSuppliersPage extends SupplierEvent {}

class DeleteSupplier extends SupplierEvent {
  int supplierId;
  DeleteSupplier({
    required this.supplierId,
  });
  @override
  List<Object> get props => [supplierId];
}

class GoSupplierDetailPage extends SupplierEvent {
  SupplierModel supplierModel;
  GoSupplierDetailPage({
    required this.supplierModel,
  });
  @override
  List<Object> get props => [supplierModel];
}

class AddSupplier extends SupplierEvent {
  String? fax;
  String? mail;
  String mobile;
  String name;
  String? openingBalance;
  String? status;
  String? telephone;
  String? vatNumber;
  AddSupplier({
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

class GoEditSupplierPage extends SupplierEvent {
  SupplierModel supplierModel;
  GoEditSupplierPage({
    required this.supplierModel,
  });

  @override
  List<Object> get props => [supplierModel];
}

class EditSupplier extends SupplierEvent {
  int supplierId;
  String name;
  String mobile;
  String? fax;
  String? mail;
  String? status;
  String? telephone;
  String? vatNumber;

  EditSupplier({
    required this.supplierId,
    this.fax,
    this.mail,
    required this.mobile,
    required this.name,
    this.status,
    this.telephone,
    this.vatNumber,
  });

  @override
  List<Object> get props => [supplierId];
}
