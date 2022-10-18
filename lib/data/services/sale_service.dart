import 'package:dio/dio.dart';
import 'package:sozashop_app/data/http/dio_client.dart';
import 'package:sozashop_app/data/models/new_sale_item_model.dart';
import 'package:sozashop_app/data/models/new_sale_model.dart';

class SaleService {
  final DioClient _dioClient = DioClient();

  // get all sales
  Future getSales(
      {required int pageNo, required int perPage, String? searchText}) async {
    var response = await _dioClient.get(
        endPoint:
            "/sale-invoices?page=$pageNo&search=$searchText&perPage=$perPage&dateRange=&status=&sort=id,desc");
    return response;
  }

  // get single sale
  Future getSingleSale({
    required id,
  }) async {
    var res = await _dioClient.get(endPoint: "/sale-invoices/$id");
    return res;
  }

  // confirm sale
  Future confirmSale({
    required ids,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/actions/sale-invoices/confirm",
      data: {
        "ids": ids,
      },
    );
    return res;
  }

  // delete sale
  Future deleteSale({
    required id,
  }) async {
    var res = await _dioClient.delete(endPoint: "/sale-invoices/$id");
    return res;
  }

  // fetch payments
  Future getSalePayments({
    required paymentableId,
    required int pageNo,
    required int perPage,
    required String searchText,
  }) async {
    const paymentableType = 'App\\Models\\SaleInvoice';

    var res = await _dioClient.get(
        endPoint:
            '/payments?page=$pageNo&search=$searchText&perPage=$perPage&paymentableId=$paymentableId&paymentableType=$paymentableType&sort=id,desc');
    return res;
  }

  // add payment
  Future addPayment({
    required paymentableId,
    required amount,
    required method,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/sale-invoices/$paymentableId/payments",
      data: {
        "paymentable_id": paymentableId,
        "amount": amount,
        "method": method,
      },
    );
    return res;
  }

  // get charges
  Future getCharges() async {
    var res = await _dioClient.get(endPoint: "/charge/sale");
    return res;
  }

  // create new customer in sale
  Future createNewCustomerInSale({
    required name,
    required mobile,
    required email,
    required address,
  }) async {
    var res = await _dioClient.post(
      endPoint: "/customers",
      data: {
        "name": name,
        "mobile": mobile,
        "email": email,
        "address": address,
      },
    );
    return res;
  }

  // create new sale
  Future createNewSale({
    required NewSaleModel newSaleModel,
  }) async {
    var jsonCharges = newSaleModel.charges.map((e) => e.toMap()).toList();

    var jsonSaleItems = List<NewSaleItemModel>.from(newSaleModel.saleItems)
        .map((e) => e.toMap())
        .toList();

    var formData = FormData.fromMap({
      'charges': jsonCharges,
      'saleItems': jsonSaleItems,
      'date': newSaleModel.date,
      'dueDate': newSaleModel.dueDate,
      'discountType': newSaleModel.discountType,
      'paidAmount': newSaleModel.paidAmount,
      'customerId': newSaleModel.customerId,
      'totalDiscount': newSaleModel.totalDiscount,
      'paymentMethod': newSaleModel.paymentMethod,
      'note': newSaleModel.note,
    });

    var res = await _dioClient.post(
      endPoint: "/sale-invoices",
      data: formData,
    );
    return res;
  }
}
