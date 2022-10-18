part of 'sale_bloc.dart';

abstract class SaleEvent extends Equatable {
  const SaleEvent();

  @override
  List<Object> get props => [];
}

class FetchSales extends SaleEvent {
  final int? pageNo;
  final int? perPage;
  final String? searchText;
  const FetchSales({this.pageNo, this.perPage, this.searchText});
}

class GoToSaleDetailPage extends SaleEvent {
  final int saleInvoiceId;
  const GoToSaleDetailPage({required this.saleInvoiceId});
  @override
  List<Object> get props => [saleInvoiceId];
}

// go to all sales page
class GoToAllSalesPage extends SaleEvent {}

// confirm sale
class ConfirmSale extends SaleEvent {
  final List<int> ids;

  const ConfirmSale({
    required this.ids,
  });

  @override
  List<Object> get props => [ids];
}

// delete sale
class DeleteSale extends SaleEvent {
  final int id;

  const DeleteSale({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

// fetch sale payments
class FetchSalePayments extends SaleEvent {
  final int saleInvoiceId;
  final int? pageNo;
  final int? perPage;
  final String? searchText;

  const FetchSalePayments({
    required this.saleInvoiceId,
    this.pageNo,
    this.perPage,
    this.searchText,
  });

  @override
  List<Object> get props => [saleInvoiceId];
}

// add sale payment
class AddSalePayment extends SaleEvent {
  final int paymentableId;
  final dynamic invoiceNo;
  final dynamic amount;
  final String method;
  final dynamic grandTotal;
  final dynamic totalDue;

  const AddSalePayment({
    required this.paymentableId,
    required this.invoiceNo,
    required this.amount,
    required this.method,
    required this.grandTotal,
    required this.totalDue,
  });

  @override
  List<Object> get props => [invoiceNo, paymentableId, amount, method];
}

// go add payment page
class GoToAddPaymentPage extends SaleEvent {
  final SaleModel saleInvoice;

  const GoToAddPaymentPage({
    required this.saleInvoice,
  });

  @override
  List<Object> get props => [saleInvoice];
}

// go to add sale page
class GoToAddSalePage extends SaleEvent {}

// create new customer in sale
class AddNewCustomerInSale extends SaleEvent {
  String name;
  String mobile;
  String? email;
  String? address;
  AddNewCustomerInSale({
    required this.name,
    required this.mobile,
    this.email,
    this.address,
  });

  @override
  List<Object> get props => [name, mobile];
}

// create new sale
class CreateNewSale extends SaleEvent {
  final NewSaleModel newSaleModel;
  const CreateNewSale({
    required this.newSaleModel,
  });

  @override
  List<Object> get props => [newSaleModel];
}

// go to edit sale page
class GoToEditSalePage extends SaleEvent {
  final int saleInvoiceId;
  const GoToEditSalePage({
    required this.saleInvoiceId,
  });

  @override
  List<Object> get props => [saleInvoiceId];
}
