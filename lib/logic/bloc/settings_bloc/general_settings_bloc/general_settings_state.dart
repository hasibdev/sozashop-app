part of 'general_settings_bloc.dart';

abstract class GeneralSettingsState extends Equatable {
  const GeneralSettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends GeneralSettingsState {}

class SettingsLoading extends GeneralSettingsState {}

class ButtonLoading extends GeneralSettingsState {}

class ClientSettingsFetched extends GeneralSettingsState {
  ClientSettingsModel clientSettingsModel;
  ClientSettingsFetched({
    required this.clientSettingsModel,
  });
  @override
  List<Object> get props => [clientSettingsModel];
}

class ProfileUpdatingFailed extends GeneralSettingsState {
  final Map error;
  const ProfileUpdatingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProfileUpdatingFailed { error: $error }';
}

class GeneralSettingsEditingState extends GeneralSettingsState {
  ClientSettingsModel? clientSettingsModel;
  List<CustomerModel>? customers;
  var name;
  var currency;
  var address;
  var website;
  var invoiceFooter;
  var defaultCustomerId;

  GeneralSettingsEditingState({
    this.clientSettingsModel,
    this.customers,
    this.name,
    this.currency,
    this.address,
    this.website,
    this.invoiceFooter,
    this.defaultCustomerId,
  });

  GeneralSettingsEditingState copyWith({
    ClientSettingsModel? clientSettingsModel,
    List<CustomerModel>? customers,
    dynamic name,
    dynamic currency,
    dynamic address,
    dynamic website,
    dynamic invoiceFooter,
    dynamic defaultCustomer,
  }) {
    return GeneralSettingsEditingState(
      clientSettingsModel: clientSettingsModel ?? this.clientSettingsModel,
      customers: customers ?? this.customers,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      address: address ?? this.address,
      website: website ?? this.website,
      invoiceFooter: invoiceFooter ?? this.invoiceFooter,
      defaultCustomerId: defaultCustomer ?? defaultCustomerId,
    );
  }

  @override
  List<Object> get props => [
        // name,
        // currency,
        // address,
        // website,
        // invoiceFooter,
        // selectedCustomer,
      ];
}

class GeneralSettingsEditedState extends GeneralSettingsState {}

class GeneralSettingsEditingFailed extends GeneralSettingsState {
  final Map error;
  const GeneralSettingsEditingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GeneralSettingsEditingFailed { error: $error }';
}

class AccountResetState extends GeneralSettingsState {}

// logo states
class GeneralSettingsLogoChangingState extends GeneralSettingsState {
  final int id;
  var primaryImage;
  GeneralSettingsLogoChangingState({
    required this.id,
    required this.primaryImage,
  });
}

class GeneralSettingsLogoChangedState extends GeneralSettingsState {}

class GeneralSettingsLogoChangingFailed extends GeneralSettingsState {
  final Map error;
  const GeneralSettingsLogoChangingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GeneralSettingsEditingFailed { error: $error }';
}
