import 'package:sozashop_app/data/models/client_settings_model.dart';
import 'package:sozashop_app/data/models/currency_settings_model.dart';
import 'package:sozashop_app/data/models/customer_model.dart';
import 'package:sozashop_app/data/services/settings_service.dart';

class SettingsRepository {
  SettingsService settingsService = SettingsService();

  Future<ClientSettingsModel> getClientSettings() async {
    final rawData = await settingsService.getClientSettings();
    var clientSettingsModel = ClientSettingsModel.fromJson(rawData);
    print(clientSettingsModel.toString());
    return clientSettingsModel;
  }

  // get currency settings
  Future<CurrencySettingsModel> getCurrencySettings() async {
    final rawData = await settingsService.getCurrencySettings();
    var currencySettingsModel = CurrencySettingsModel.fromJson(rawData);
    print(currencySettingsModel.toString());
    return currencySettingsModel;
  }

  // get customers
  Future<List<CustomerModel>> getCustomers() async {
    final rawData = await settingsService.getCustomers();
    var customers = List<CustomerModel>.from(
        rawData['data'].map((x) => CustomerModel.fromJson(x)));
    return customers;
  }

  // update settings
  updateClientSettings({
    required name,
    required address,
    required website,
    required invoiceFooter,
    required defaultCustomerId,
  }) async {
    final res = await settingsService.updateClientSettings(
      name: name,
      address: address,
      website: website,
      invoiceFooter: invoiceFooter,
      defaultCustomerId: defaultCustomerId,
    );
    print(res);

    return res;
  }

  // reset account
  resetAccount({required clientId}) async {
    final res = await settingsService.resetAccount(clientId);
    print(res);
    return res;
  }

  // change logo
  changeLogo({required id, required primaryImage}) async {
    final res = await settingsService.changeLogo(id, primaryImage);
    return res;
  }
}
