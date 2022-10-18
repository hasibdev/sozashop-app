part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessful extends RegisterState {
  var shopName;
  // var email;
  // var firstName;
  // var lastName;
  // var mobile;
  var moduleId;
  var industryId;
  RegisterSuccessful({
    required this.shopName,
    //   required this.email,
    //   required this.firstName,
    //   required this.lastName,
    //   required this.mobile,
    required this.industryId,
    required this.moduleId,
  });

  // RegisterSuccessful copyWith({
  //   String? email,
  //   String? password,
  // }) {
  //   return RegisterSuccessful(
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //   );
  // }

  @override
  List<Object> get props => [
        // shopName, email, firstName, lastName, mobile, industryId, moduleId
      ];
}

class RegisterFailed extends RegisterState {
  final String error;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  RegisterFailed({
    required this.error,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  @override
  List<Object> get props => [error];

  // @override
  // String toString() => 'RegisterFailed { error: $error }';
}

class IndustryLoading extends RegisterState {}

class IndustryFetched extends RegisterState {
  final List<IndustryModel> industries;

  const IndustryFetched({required this.industries});

  @override
  List<Object> get props => [industries];
}

class SelectedIndustry extends RegisterState {
  final IndustryModel industry;
  List<ModuleModel> modules;
  ModuleModel? selectedModule;

  SelectedIndustry(
      {required this.industry, required this.modules, this.selectedModule});

  @override
  List<Object> get props => [industry, modules];
}

class FirstStepCompleted extends RegisterState {
  String shopName;
  int industryId;
  int moduleId;
  FirstStepCompleted({
    required this.shopName,
    required this.industryId,
    required this.moduleId,
  });

  @override
  List<Object> get props => [shopName, industryId, moduleId];
}

class SecondStepCompleted extends RegisterState {
  String firstName;
  String lastName;
  dynamic mobile;
  SecondStepCompleted({
    required this.firstName,
    required this.lastName,
    required this.mobile,
  });

  @override
  List<Object> get props => [firstName, lastName, mobile];
}
