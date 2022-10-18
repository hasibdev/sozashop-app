import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/client_settings_model.dart';
import 'package:sozashop_app/data/models/customer_model.dart';
import 'package:sozashop_app/data/repositories/settings_repository.dart';

part 'general_settings_event.dart';
part 'general_settings_state.dart';

class GeneralSettingsBloc
    extends Bloc<GeneralSettingsEvent, GeneralSettingsState> {
  SettingsRepository settingsRepository = SettingsRepository();
  GeneralSettingsBloc() : super(SettingsInitial()) {
    on<GeneralSettingsEvent>((event, emit) async {
      // Fetch Client Settings
      if (event is FetchClientSettings) {
        emit(SettingsLoading());
        var clientSettings = await settingsRepository.getClientSettings();
        emit(ClientSettingsFetched(clientSettingsModel: clientSettings));
      }

      if (event is GoEditGeneralSettingsPage) {
        emit(SettingsLoading());
        var customers = await settingsRepository.getCustomers();
        emit(GeneralSettingsEditingState(
          clientSettingsModel: event.clientSettingsData,
          customers: customers,
          name: event.clientSettingsData?.data.name,
          address: event.clientSettingsData?.data.address,
          website: event.clientSettingsData?.data.website,
          invoiceFooter: event.clientSettingsData?.data.invoiceFooter,
        ));
      }

      if (event is GoGeneralSettingsPage) {
        var clientSettingsModel = await settingsRepository.getClientSettings();
        emit(SettingsLoading());
        emit(ClientSettingsFetched(
          clientSettingsModel: clientSettingsModel,
        ));
      }

      // update settings
      if (event is UpdateClientSettings) {
        Response res = await settingsRepository.updateClientSettings(
          name: event.name,
          address: event.address,
          website: event.website,
          invoiceFooter: event.invoiceFooter,
          defaultCustomerId: event.defaultCustomerId,
        );

        if (res.statusCode == 200) {
          emit(GeneralSettingsEditedState());
        } else {
          emit(GeneralSettingsEditingFailed(error: res.data));
          // var clientSettingsModel =
          //     await settingsRepository.getClientSettings();
          var customers = await settingsRepository.getCustomers();
          emit(GeneralSettingsEditingState().copyWith(
            customers: customers,
            name: event.name,
            address: event.address,
            website: event.website,
            invoiceFooter: event.invoiceFooter,
            defaultCustomer: event.defaultCustomerId,
          ));
        }
      }

      // account reset
      if (event is ResetAccount) {
        Response res =
            await settingsRepository.resetAccount(clientId: event.clientId);
        if (res.statusCode == 200) {
          emit(SettingsLoading());
          emit(AccountResetState());
        }
      }

      // go change logo page
      if (event is GoGeneralSettingsChangeLogoPage) {
        emit(GeneralSettingsLogoChangingState(
          id: event.id,
          primaryImage: event.primaryImage,
        ));
      }

      // change logo
      if (event is ChangeLogo) {
        Response res = await settingsRepository.changeLogo(
          id: event.id,
          primaryImage: event.primaryImage,
        );
        print(res);
        if (res.statusCode == 200) {
          emit(GeneralSettingsLogoChangedState());
          var clientSettingsModel =
              await settingsRepository.getClientSettings();
          emit(SettingsLoading());
          emit(ClientSettingsFetched(
            clientSettingsModel: clientSettingsModel,
          ));
        } else if (res.statusCode == 413) {
          emit(const GeneralSettingsLogoChangingFailed(
              error: {"errors": '413 '}));
        } else {
          emit(GeneralSettingsLogoChangingFailed(error: res.data));
          emit(GeneralSettingsLogoChangingState(
            id: event.id,
            primaryImage: event.primaryImage,
          ));
        }
      }
    });
  }
}
