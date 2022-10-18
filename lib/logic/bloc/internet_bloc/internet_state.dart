part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class ConnectionLostState extends InternetState {}

class ConnectionGainedState extends InternetState {}

class InternetDisconnectedState extends InternetState {}

class InternetConnectedState extends InternetState {
  final internetType;
  const InternetConnectedState({
    this.internetType,
  });
}

class RefreshInternetState extends InternetState {}
