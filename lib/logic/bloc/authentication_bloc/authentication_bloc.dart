import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/repositories/auth_repository.dart';
import 'package:sozashop_app/data/repositories/user_local_repositiory.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserLocalRepository userLocalRepository = UserLocalRepository();

  final AuthRepository authRepository;
  AuthenticationBloc({
    required this.authRepository,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // check if the token exists
      if (event is AppStarted) {
        emit(AuthenticationLoading());
        final bool hasToken = await authRepository.hasToken();
        print('hasToken >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $hasToken');
        if (hasToken) {
          print('oh yes');
          emit(AuthenticationAuthenticated());
        } else {
          print('oh no');
          emit(AuthenticationUnauthenticated());
        }
      }

      // if logged in
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await authRepository.saveToken(event.token);
        emit(AuthenticationAuthenticated());
      }

      // if logged out
      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await userLocalRepository.deleteUser('user');
        await authRepository.deleteToken(event.token);
        // emit(AuthenticationUnauthenticated());
        final bool hasToken = await authRepository.hasToken();
        print('hasToken >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $hasToken');
        if (hasToken) {
          print('oh yes');
          emit(AuthenticationAuthenticated());
          print('oh no');
        } else {
          emit(AuthenticationUnauthenticated());
        }
      }
    });
  }
}
