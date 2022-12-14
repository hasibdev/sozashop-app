part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class CheckInternetEvent extends InternetEvent {}

class ConnectionLostEvent extends InternetEvent {}

class ConnectionGainedEvent extends InternetEvent {}

class InternetDisconnectedEvent extends InternetEvent {}

class InternetConnectedEvent extends InternetEvent {
  final internetType;
  const InternetConnectedEvent({
    this.internetType,
  });
}

class RefreshInternet extends InternetEvent {}
