part of 'sale_bloc.dart';

abstract class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

class SaleInitial extends SaleState {}

class SalesLoading extends SaleState {}

class SalesFetched extends SaleState {
  List<SaleModel> sales;
  SalesFetched({
    required this.sales,
  });

  @override
  List<Object> get props => [sales];
}

class SaleDetailPageLoading extends SaleState {}

class SaleDetailState extends SaleState {
  final SaleModel sale;
  final List<PaymentModel>? salePayments;

  const SaleDetailState({
    required this.sale,
    this.salePayments,
  });

  @override
  List<Object> get props => [sale];
}

// sale confirmed
class SaleConfirmed extends SaleState {}

// sale confirm failed
class SaleConfirmFailed extends SaleState {
  final Map error;

  const SaleConfirmFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// sale deleted
class SaleDeleted extends SaleState {}

// sale delete failed
class SaleDeleteFailed extends SaleState {
  final Map error;

  const SaleDeleteFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// sale payments loading
class SalePaymentsLoading extends SaleState {}

// sale payment fetched
class SalePaymentsFetched extends SaleState {
  List<PaymentModel> salePayments;
  SalePaymentsFetched({
    required this.salePayments,
  });

  @override
  List<Object> get props => [salePayments];
}

// add payment page loading
class AddPaymentPageLoading extends SaleState {}

// add payment state
class AddPaymentAddingState extends SaleState {
  final int? paymentableId;
  final dynamic invoiceNo;
  final dynamic amount;
  final dynamic method;
  final dynamic grandTotal;
  dynamic totalDue;

  AddPaymentAddingState({
    this.paymentableId,
    this.invoiceNo,
    this.amount,
    this.method,
    this.grandTotal,
    this.totalDue,
  });

  // @override
  // List<Object> get props => [amount, method, grandTotal, totalDue];

  AddPaymentAddingState copyWith({
    int? paymentableId,
    dynamic invoiceNo,
    dynamic amount,
    dynamic method,
    dynamic grandTotal,
    dynamic totalDue,
  }) {
    return AddPaymentAddingState(
      paymentableId: paymentableId ?? this.paymentableId,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      grandTotal: grandTotal ?? this.grandTotal,
      totalDue: totalDue ?? this.totalDue,
    );
  }
}

// add sale payment
class SalePaymentAdded extends SaleState {}

// add sale payment failed
class SalePaymentAddingFailed extends SaleState {
  final Map error;

  const SalePaymentAddingFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// go to add sale page
class SaleAddingState extends SaleState {
  List? customers;
  List? paymentMethods;
  List? batches;
  List? charges;
  List? discountTypes;
  SaleAddingState({
    this.customers,
    this.paymentMethods,
    this.batches,
    this.charges,
    this.discountTypes,
  });

  SaleAddingState copyWith({
    List<dynamic>? customers,
    List<dynamic>? paymentMethods,
    List<dynamic>? batches,
    List<dynamic>? charges,
    List<dynamic>? discountTypes,
  }) {
    return SaleAddingState(
      customers: customers ?? this.customers,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      batches: batches ?? this.batches,
      charges: charges ?? this.charges,
      discountTypes: discountTypes ?? this.discountTypes,
    );
  }

  @override
  List<Object> get props => [];
}

// new customer added
class NewCustomerAdded extends SaleState {
  List? customers;
  List? paymentMethods;
  List? batches;
  List? charges;
  List? discountTypes;
  NewCustomerAdded({
    this.customers,
    this.paymentMethods,
    this.batches,
    this.charges,
    this.discountTypes,
  });
}

// new customer adding failed
class NewCustomerAddingFailed extends SaleState {
  final Map error;

  const NewCustomerAddingFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// new sale added
class NewSaleAdded extends SaleState {}

// new sale adding failed
class NewSaleAddingFailed extends SaleState {
  final Map error;

  const NewSaleAddingFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

// sale edit page loading
class SaleEditPageLoading extends SaleState {}

// sale editing state
class SaleEditingState extends SaleState {
  final SaleModel? saleModel;
  final List? customers;
  final List? paymentMethods;
  final List? batches;
  final List? discountTypes;
  const SaleEditingState({
    this.saleModel,
    this.customers,
    this.paymentMethods,
    this.batches,
    this.discountTypes,
  });

  SaleEditingState copyWith({
    SaleModel? saleModel,
    List? customers,
    List? paymentMethods,
    List? batches,
    List? discountTypes,
  }) {
    return SaleEditingState(
      saleModel: saleModel ?? this.saleModel,
      customers: customers ?? this.customers,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      batches: batches ?? this.batches,
      discountTypes: discountTypes ?? this.discountTypes,
    );
  }

  @override
  List<Object> get props => [];
}
