import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import 'package:sozashop_app/data/services/internet_service.dart';
import 'package:sozashop_app/logic/bloc/login_bloc/login_bloc.dart';
import 'package:sozashop_app/logic/bloc/profile_bloc/profile_bloc.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetService internetService;
  ProfileBloc profileBloc;
  LoginBloc loginBloc;

  InternetBloc({
    required this.internetService,
    required this.profileBloc,
    required this.loginBloc,
  }) : super(InternetInitial()) {
    on<InternetEvent>((event, emit) async {
      // check internet
      if (event is CheckInternetEvent) {
        internetService.connectivityStream.stream.listen((event) {
          if (event == ConnectivityResult.none) {
            add(ConnectionLostEvent());
          } else {
            add(ConnectionGainedEvent());
          }
        });
      }

      // no connection event
      if (event is ConnectionLostEvent) {
        emit(ConnectionLostState());
      }

      // connection gained event
      if (event is ConnectionGainedEvent) {
        emit(ConnectionGainedState());
        add(const InternetConnectedEvent());
        profileBloc.add(FetchProfile());
      }

      // no internet event
      if (event is InternetDisconnectedEvent) {
        print('Disconnected');
        loginBloc.add(LoggingOut());
        emit(InternetDisconnectedState());
      }

      // internet connected event
      if (event is InternetConnectedEvent) {
        print('Connected');
        emit(const InternetConnectedState());
      }

      // Refresh Internet
      if (event is RefreshInternet) {
        var result = await internetService.connectivity.checkConnectivity();

        print('result $result');
        if (result == ConnectivityResult.none) {
          emit(ConnectionLostState());
          emit(InternetDisconnectedState());
          print('result none');
        } else {
          print('result $result');
          emit(ConnectionGainedState());
        }
      }
    });
  }
}
