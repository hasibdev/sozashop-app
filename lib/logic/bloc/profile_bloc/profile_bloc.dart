import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';

import 'package:sozashop_app/data/repositories/profile_repository.dart';
import 'package:sozashop_app/data/repositories/user_local_repositiory.dart';
import 'package:sozashop_app/logic/user_details.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserLocalRepository userLocalRepository = UserLocalRepository();
  ProfileRepository profileRepository;
  ProfileBloc({
    required this.profileRepository,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is FetchProfile) {
        emit(ProfileLoading());
        await userLocalRepository.deleteUser('user');
        await profileRepository.getConfig();
        var profile = await profileRepository.getProfile();
        await userLocalRepository.saveUser(profile.toRawJson());
        await UserDetails.getUser();
        emit(ProfileFetched(profile: profile));
      }

      if (event is UpdateProfile) {
        Response response = await profileRepository.updateProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          countryName: event.countryName,
          industryName: event.industryName,
          photo: event.photo,
        );
        if (response.statusCode == 200) {
          emit(ProfileLoading());
          var profile = await profileRepository.getProfile();
          emit(ProfileUpdatedState());
          emit(ProfileFetched(profile: profile));
        } else if (response.statusCode == 413) {
          var profile = await profileRepository.getProfile();
          emit(ProfileFetched(profile: profile));
        } else {
          emit(ProfileUpdatingFailed(error: response.data));
          emit(ProfileUpdatingState(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            countryName: event.countryName,
            industryName: event.industryName,
          ));
        }
      }
    });
  }
}
