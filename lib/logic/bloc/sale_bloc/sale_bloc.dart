import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/new_sale_model.dart';

import 'package:sozashop_app/data/models/payment_model.dart';
import 'package:sozashop_app/data/repositories/product_repository.dart';
import 'package:sozashop_app/data/repositories/profile_repository.dart';
import 'package:sozashop_app/data/repositories/sale_repository.dart';
import 'package:sozashop_app/data/repositories/settings_repository.dart';

import '../../../data/models/sale_model.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  SaleRepository saleRepository = SaleRepository();
  SettingsRepository settingsRepository = SettingsRepository();
  ProfileRepository profileRepository = ProfileRepository();
  ProductRepository productRepository;

  SaleBloc({
    required this.productRepository,
  }) : super(SaleInitial()) {
    on<SaleEvent>((event, emit) async {
      // fetch sales
      if (event is FetchSales) {
        emit(SalesLoading());
        var sales = await saleRepository.getSales(
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(SalesFetched(sales: sales));
      }

      // go to sale detail page
      if (event is GoToSaleDetailPage) {
        emit(SaleDetailPageLoading());
        // emit(SalePaymentsLoading());
        var sale = await saleRepository.getSingleSale(id: event.saleInvoiceId);
        var payments = await saleRepository.getSalePayments(
            paymentableId: event.saleInvoiceId);
        // emit(SalePaymentsFetched(salePayments: payments));
        emit(SaleDetailState(sale: sale, salePayments: payments));
      }

      // go to all sales page
      if (event is GoToAllSalesPage) {
        emit(SalesLoading());
        var sales = await saleRepository.getSales();
        emit(SalesFetched(sales: sales));
      }

      // confirm sale
      if (event is ConfirmSale) {
        Response res = await saleRepository.confirmSale(ids: event.ids);
        if (res.statusCode == 200) {
          emit(SalesLoading());
          var sales = await saleRepository.getSales();
          emit(SaleConfirmed());
          emit(SalesFetched(sales: sales));
        } else {
          emit(SaleConfirmFailed(error: res.data));
          var sales = await saleRepository.getSales();
          emit(SalesFetched(sales: sales));
        }
      }

      // delete sale
      if (event is DeleteSale) {
        Response res = await saleRepository.deleteSale(id: event.id);
        if (res.statusCode == 200) {
          emit(SaleDeleted());
          emit(SalesLoading());
          var sales = await saleRepository.getSales();
          emit(SalesFetched(sales: sales));
        } else {
          emit(SaleDeleteFailed(error: res.data));
          var sales = await saleRepository.getSales();
          emit(SalesFetched(sales: sales));
        }
      }

      // fetch sale payments
      if (event is FetchSalePayments) {
        emit(SalePaymentsLoading());
        var res = await saleRepository.getSalePayments(
          paymentableId: event.saleInvoiceId,
          pageNo: event.pageNo,
          perPage: event.perPage,
          searchText: event.searchText,
        );
        emit(SalePaymentsFetched(salePayments: res));
      }

      // go add payment page
      if (event is GoToAddPaymentPage) {
        emit(AddPaymentPageLoading());
        emit(AddPaymentAddingState().copyWith(
          paymentableId: event.saleInvoice.id,
          grandTotal: event.saleInvoice.grandTotal,
          totalDue: event.saleInvoice.totalDue,
          invoiceNo: event.saleInvoice.invoiceNo,
        ));
      }

      // add sale payment
      if (event is AddSalePayment) {
        Response res = await saleRepository.addPayment(
          paymentableId: event.paymentableId,
          amount: event.amount,
          method: event.method,
        );
        if (res.statusCode == 201) {
          emit(SalePaymentAdded());
          emit(AddPaymentPageLoading());
          var sales = await saleRepository.getSales();
          emit(SalesFetched(sales: sales));
        } else {
          emit(SalePaymentAddingFailed(error: res.data));
          emit(AddPaymentAddingState().copyWith(
            paymentableId: event.paymentableId,
            amount: event.amount,
            method: event.method,
            grandTotal: event.grandTotal,
            totalDue: event.totalDue,
            invoiceNo: event.invoiceNo,
          ));
        }
      }

      // go to add sale page
      if (event is GoToAddSalePage) {
        var customers = await settingsRepository.getCustomers();
        var allBatches = await productRepository.getAllBatches();
        var charges = await saleRepository.getCharges();
        var paymentMethods =
            profileRepository.getConfigEnums(type: EnumType.paymentMethod);
        var discountTypes =
            profileRepository.getConfigEnums(type: EnumType.discountType);

        emit(SaleAddingState().copyWith(
          customers: customers,
          paymentMethods: paymentMethods,
          batches: allBatches,
          charges: charges,
          discountTypes: discountTypes,
        ));
        print('SaleAddingState() emitted');
      }

      // add new customer
      if (event is AddNewCustomerInSale) {
        Response res = await saleRepository.createNewCustomerInSale(
          name: event.name,
          mobile: event.mobile,
          email: event.email ?? '',
          address: event.address ?? '',
        );
        var allBatches = await productRepository.getAllBatches();
        var charges = await saleRepository.getCharges();
        var paymentMethods =
            profileRepository.getConfigEnums(type: EnumType.paymentMethod);
        var discountTypes =
            profileRepository.getConfigEnums(type: EnumType.discountType);
        if (res.statusCode == 201) {
          var customers = await settingsRepository.getCustomers();
          emit(NewCustomerAdded(
            customers: customers,
            paymentMethods: paymentMethods,
            batches: allBatches,
            charges: charges,
            discountTypes: discountTypes,
          ));
          emit(SaleAddingState().copyWith(
            customers: customers,
            paymentMethods: paymentMethods,
            batches: allBatches,
            charges: charges,
            discountTypes: discountTypes,
          ));
        } else {
          emit(NewCustomerAddingFailed(error: res.data));
          var customers = await settingsRepository.getCustomers();
          emit(SaleAddingState().copyWith(
            customers: customers,
            paymentMethods: paymentMethods,
            batches: allBatches,
            charges: charges,
            discountTypes: discountTypes,
          ));
        }
      }

      // add new sale
      if (event is CreateNewSale) {
        Response res = await saleRepository.createNewSale(
          newSaleModel: event.newSaleModel,
        );
        if (res.statusCode == 201) {
          emit(NewSaleAdded());
          var sales = await saleRepository.getSales();
          emit(SalesFetched(sales: sales));
        } else {
          emit(NewSaleAddingFailed(error: res.data));
          var customers = await settingsRepository.getCustomers();
          var allBatches = await productRepository.getAllBatches();
          var charges = await saleRepository.getCharges();
          var paymentMethods =
              profileRepository.getConfigEnums(type: EnumType.paymentMethod);
          var discountTypes =
              profileRepository.getConfigEnums(type: EnumType.discountType);
          emit(SaleAddingState().copyWith(
            customers: customers,
            paymentMethods: paymentMethods,
            batches: allBatches,
            charges: charges,
            discountTypes: discountTypes,
          ));
        }
      }

      // go to edit sale page
      if (event is GoToEditSalePage) {
        emit(SaleEditPageLoading());
        var saleModel =
            await saleRepository.getSingleSale(id: event.saleInvoiceId);
        var customers = await settingsRepository.getCustomers();
        var allBatches = await productRepository.getAllBatches();
        var paymentMethods =
            profileRepository.getConfigEnums(type: EnumType.paymentMethod);
        var discountTypes =
            profileRepository.getConfigEnums(type: EnumType.discountType);

        emit(const SaleEditingState().copyWith(
          saleModel: saleModel,
          customers: customers,
          paymentMethods: paymentMethods,
          batches: allBatches,
          discountTypes: discountTypes,
        ));
      }
    });
  }
}
