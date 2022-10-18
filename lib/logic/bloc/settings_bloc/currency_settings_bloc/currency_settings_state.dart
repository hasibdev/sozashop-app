part of 'currency_settings_bloc.dart';

abstract class CurrencySettingsState extends Equatable {
  const CurrencySettingsState();

  @override
  List<Object> get props => [];
}

class CurrencySettingsInitial extends CurrencySettingsState {}

class CurrencySettingsLoading extends CurrencySettingsState {}

class ButtonLoading extends CurrencySettingsState {}

class CurrencySettingsFetched extends CurrencySettingsState {
  CurrencySettingsModel currencySettingsModel;
  CurrencySettingsFetched({
    required this.currencySettingsModel,
  });
  @override
  List<Object> get props => [currencySettingsModel];
}
