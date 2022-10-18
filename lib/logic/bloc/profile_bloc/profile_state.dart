part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFetched extends ProfileState {
  ProfileModel profile;
  ProfileFetched({
    required this.profile,
  });

  @override
  List<Object> get props => [profile];
}

class ProfileUpdatedState extends ProfileState {}

class ProfileUpdatingState extends ProfileState {
  String? firstName;
  String? lastName;
  String? email;
  String? countryName;
  String? industryName;
  var photo;
  ProfileUpdatingState({
    this.firstName,
    this.lastName,
    this.email,
    this.countryName,
    this.industryName,
    this.photo,
  });
}

class ProfileUpdatingFailed extends ProfileState {
  final Map error;
  const ProfileUpdatingFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProfileUpdatingFailed { error: $error }';
}
