part of 'currency_settings_bloc.dart';

abstract class CurrencySettingsEvent extends Equatable {
  const CurrencySettingsEvent();

  @override
  List<Object> get props => [];
}

class FetchCurrencySettings extends CurrencySettingsEvent {}
