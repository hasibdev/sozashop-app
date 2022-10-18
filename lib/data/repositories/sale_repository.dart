import 'package:sozashop_app/data/models/charge_model.dart';
import 'package:sozashop_app/data/models/payment_model.dart';
import 'package:sozashop_app/data/models/sale_model.dart';
import 'package:sozashop_app/data/services/sale_service.dart';

import '../../core/constants/strings.dart';

class SaleRepository {
  SaleService saleService = SaleService();

  // get all sales
  Future<List<SaleModel>> getSales(
      {int? pageNo, int? perPage, String? searchText}) async {
    final raw = await saleService.getSales(
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    var sales = Sale.fromJson(raw);
    return sales.data;
  }

  // get single sale
  Future<dynamic> getSingleSale({required id}) async {
    final raw = await saleService.getSingleSale(id: id);
    var sale = SaleModel.fromJson(raw['data']);
    return sale;
  }

  // confirm sale
  Future<dynamic> confirmSale({required ids}) async {
    final raw = await saleService.confirmSale(ids: ids);
    return raw;
  }

  // delete sale
  Future<dynamic> deleteSale({required id}) async {
    final raw = await saleService.deleteSale(id: id);
    return raw;
  }

  // fetch sale payments
  Future<List<PaymentModel>> getSalePayments({
    required int paymentableId,
    int? pageNo,
    int? perPage,
    String? searchText,
  }) async {
    final raw = await saleService.getSalePayments(
      paymentableId: paymentableId,
      pageNo: pageNo ?? Ints().defaultPageNo,
      perPage: perPage ?? Ints().defaultPerPage,
      searchText: searchText ?? '',
    );
    final payments = List<PaymentModel>.from(
        raw['data'].map((e) => PaymentModel.fromJson(e)));
    return payments;
  }

  // add payment
  Future addPayment({
    required int paymentableId,
    required amount,
    required method,
  }) async {
    final raw = await saleService.addPayment(
        paymentableId: paymentableId, amount: amount, method: method);
    return raw;
  }

  // get charges
  Future<List<ChargeDetailModel>> getCharges() async {
    final raw = await saleService.getCharges();
    final charges = List<ChargeDetailModel>.from(
        raw['data'].map((e) => ChargeDetailModel.fromJson(e)));
    return charges;
  }

  // create new customer in sale
  Future<dynamic> createNewCustomerInSale({
    required String name,
    required String mobile,
    required String email,
    required String address,
  }) async {
    final raw = await saleService.createNewCustomerInSale(
        name: name, email: email, mobile: mobile, address: address);
    return raw;
  }

  // create new sale
  Future<dynamic> createNewSale({
    required newSaleModel,
  }) async {
    final raw = await saleService.createNewSale(newSaleModel: newSaleModel);
    return raw;
  }
}
