part of 'general_settings_bloc.dart';

abstract class GeneralSettingsEvent extends Equatable {
  const GeneralSettingsEvent();

  @override
  List<Object> get props => [];
}

class FetchClientSettings extends GeneralSettingsEvent {}

class GoEditGeneralSettingsPage extends GeneralSettingsEvent {
  ClientSettingsModel? clientSettingsData;
  GoEditGeneralSettingsPage({
    required this.clientSettingsData,
  });
}

class GoGeneralSettingsPage extends GeneralSettingsEvent {}

class UpdateClientSettings extends GeneralSettingsEvent {
  dynamic name;
  dynamic address;
  dynamic website;
  dynamic invoiceFooter;
  dynamic defaultCustomerId;
  UpdateClientSettings({
    required this.name,
    required this.address,
    required this.website,
    required this.invoiceFooter,
    required this.defaultCustomerId,
  });
}

class ResetAccount extends GeneralSettingsEvent {
  final int clientId;
  const ResetAccount({
    required this.clientId,
  });
}

class GoGeneralSettingsChangeLogoPage extends GeneralSettingsEvent {
  final int id;
  var primaryImage;
  GoGeneralSettingsChangeLogoPage({
    required this.id,
    required this.primaryImage,
  });
}

class ChangeLogo extends GeneralSettingsEvent {
  final int id;
  final File? primaryImage;
  const ChangeLogo({
    required this.id,
    required this.primaryImage,
  });
}
