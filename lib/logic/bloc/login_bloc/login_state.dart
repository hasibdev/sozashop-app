part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessful extends LoginState {
  String email = '';
  String password = '';
  LoginSuccessful({
    required this.email,
    required this.password,
  });

  LoginSuccessful copyWith({
    String? email,
    String? password,
  }) {
    return LoginSuccessful(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [email, password];
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
