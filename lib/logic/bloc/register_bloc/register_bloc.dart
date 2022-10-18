import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sozashop_app/data/models/industry_model.dart';
import 'package:sozashop_app/data/models/module_model.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/industry_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IndustryRepository industryRepository;
  final AuthRepository authRepository;

  RegisterBloc({
    required this.industryRepository,
    required this.authRepository,
  }) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterSubmitted) {
        emit(RegisterLoading());
        // try {
        var data = await authRepository.register(
            event.shopName,
            event.moduleId,
            event.industryId,
            event.firstName,
            event.lastName,
            event.mobile,
            event.email,
            event.password,
            event.passwordConfirmation);
        print('{bloc data >>>>>>>>>> $data}');
        if (data == 200) {
          emit(RegisterSuccessful(
            shopName: event.shopName,
            industryId: event.industryId,
            moduleId: event.moduleId,
          ));
        } else {
          var errorList = (data.values.map((e) => e[0]).toList());
          var stringErrorList = errorList.join('\n');
          emit(RegisterFailed(error: stringErrorList));
          // data.forEach((key, value) {
          //   print('dErrors key: $key');
          //   print('dErrors value: $value');
          //   if (key == 'email') {
          //     emit(RegisterFailed(
          //         error: stringErrorList, emailError: '${value.first}'));
          //   } else if (key == 'password') {
          //     emit(RegisterFailed(
          //         error: stringErrorList, passwordError: '${value.first}'));
          //   }
          // });
          print(data);
        }
        // } catch (error) {
        //   emit(const RegisterFailed(error: 'why why why'));
        //   print(
        //       ' State register failed >>>>>>> ShopName: ${event.shopName}, industryId: ${event.industryId} , moduleId: ${event.moduleId}');
        // }
      }

      if (event is GetIndustries) {
        emit(IndustryLoading());
        var industries = await industryRepository.fetchIndustries();
        emit(IndustryFetched(industries: industries));
      }

      if (event is SelectIndustry) {
        emit(SelectedIndustry(
            industry: event.industry, modules: event.industry.modules));
        print(
            ' State industry >>>>>>> Name: ${event.industry.name}, Id: ${event.industry.id}');
      }

      if (event is CompleteFirstStep) {
        emit(FirstStepCompleted(
            shopName: event.shopName,
            industryId: event.industryId,
            moduleId: event.moduleId));
        print(
            ' State industry >>>>>>> ShopName: ${event.shopName}, industryId: ${event.industryId} , moduleId: ${event.moduleId}');
      }

      if (event is CompleteSecondStep) {
        emit(SecondStepCompleted(
          firstName: event.firstName,
          lastName: event.lastName,
          mobile: event.mobile,
        ));
        print(
            ' State industry >>>>>>> firstName: ${event.firstName}, lastName: ${event.lastName} , mobile: ${event.mobile}');
      }
    });
  }
}
