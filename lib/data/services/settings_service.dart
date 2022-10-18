import 'dart:io';

import 'package:dio/dio.dart';

import '../http/dio_client.dart';

class SettingsService {
  final DioClient _dioClient = DioClient();

  Future getClientSettings() async {
    var response =
        await _dioClient.get(endPoint: "/client-settings?type=application");
    return response;
  }

  // get currency
  Future getCurrencySettings() async {
    var response =
        await _dioClient.get(endPoint: "/client-settings?type=currency");
    return response;
  }

  Future getCustomers() async {
    var response = await _dioClient.get(endPoint: "/customers");
    return response;
  }

  Future updateClientSettings({
    required name,
    required address,
    required website,
    required invoiceFooter,
    required defaultCustomerId,
  }) async {
    FormData datas = FormData.fromMap({
      'name': name,
      'address': address,
      'website': website,
      'defaultCustomer': defaultCustomerId,
      'invoiceFooter': invoiceFooter,
    });

    FormData formData = FormData.fromMap({
      'data': datas,
      // "type": "application",
    });

    var response = await _dioClient.post(
      endPoint: "/client-settings",
      data: formData,
    );
    return response;
  }

  // reset account
  Future resetAccount(int clientId) async {
    var response = await _dioClient.post(endPoint: "/clients/$clientId/reset");
    return response;
  }

  // change logo
  Future changeLogo(int id, File? primaryImage) async {
    FormData formData = FormData.fromMap({
      'primary': await MultipartFile.fromFile(primaryImage!.path),
    });

    var response = await _dioClient.post(
      endPoint: "/client-settings/$id/primary-media",
      data: formData,
    );
    return response;
  }
}
