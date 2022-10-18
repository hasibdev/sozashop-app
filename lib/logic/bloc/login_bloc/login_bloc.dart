import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sozashop_app/data/repositories/auth_repository.dart';
import 'package:sozashop_app/logic/bloc/authentication_bloc/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.authRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginSubmitted) {
        emit(LoginLoading());
        try {
          var data = await authRepository.login(
            event.email,
            event.password,
          );

          var token = data['access_token'];

          authenticationBloc.add(LoggedIn(token: token));
          emit(LoginSuccessful(
            email: event.email,
            password: event.password,
          ));
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }

      if (event is LoggingOut) {
        await authRepository.logout();
        authenticationBloc.add(
          const LoggedOut(token: 'token'),
        );
      }
    });
  }
}
