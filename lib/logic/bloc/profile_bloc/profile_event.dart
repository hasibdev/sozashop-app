part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  String firstName;
  String lastName;
  String email;
  String countryName;
  String industryName;
  var photo;
  UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryName,
    required this.industryName,
    required this.photo,
  });
}
