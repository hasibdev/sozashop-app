import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/currency_settings_model.dart';

import '../../../../data/repositories/settings_repository.dart';

part 'currency_settings_event.dart';
part 'currency_settings_state.dart';

class CurrencySettingsBloc
    extends Bloc<CurrencySettingsEvent, CurrencySettingsState> {
  SettingsRepository settingsRepository = SettingsRepository();

  CurrencySettingsBloc() : super(CurrencySettingsInitial()) {
    on<CurrencySettingsEvent>((event, emit) async {
      // Fetch Currency Settings
      if (event is FetchCurrencySettings) {
        emit(CurrencySettingsLoading());
        var currencySettings = await settingsRepository.getCurrencySettings();
        emit(CurrencySettingsFetched(currencySettingsModel: currencySettings));
      }
    });
  }
}
