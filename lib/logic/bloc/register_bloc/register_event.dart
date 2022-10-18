part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final shopName;
  final moduleId;
  final industryId;
  final firstName;
  final lastName;
  final mobile;
  final email;
  final password;
  final passwordConfirmation;

  const RegisterSubmitted({
    required this.shopName,
    required this.moduleId,
    required this.industryId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  String toString() => 'RegisterSubmitted { email: $email}';
}

class GetIndustries extends RegisterEvent {}

class SelectIndustry extends RegisterEvent {
  final IndustryModel industry;
  const SelectIndustry({required this.industry});
  @override
  List<Object> get props => [industry];
}

class CompleteFirstStep extends RegisterEvent {
  String shopName;
  int industryId;
  int moduleId;
  CompleteFirstStep({
    required this.shopName,
    required this.industryId,
    required this.moduleId,
  });

  @override
  List<Object> get props => [shopName, industryId, moduleId];
}

class CompleteSecondStep extends RegisterEvent {
  String firstName;
  String lastName;
  dynamic mobile;
  CompleteSecondStep({
    required this.firstName,
    required this.lastName,
    required this.mobile,
  });

  @override
  List<Object> get props => [firstName, lastName, mobile];
}
