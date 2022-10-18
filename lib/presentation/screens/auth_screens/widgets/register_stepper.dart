// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/logic/bloc/register_bloc/register_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';

import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dropdown.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../../data/models/industry_model.dart';
import '../../../../data/models/module_model.dart';
import '../../widgets/k_snackbar.dart';

class RegisterStepper extends StatefulWidget {
  const RegisterStepper({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  IndustryModel? industryModel;

  List<IndustryModel> allIndustries = [];
  IndustryModel? _selectedIndustry;
  List<ModuleModel>? allModules = [];
  ModuleModel? _selectedModule;
  String? _selectedCountry;

  final List _countries = [];

  final TextEditingController shopController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // shopController.text = 'testShop';
    // firstNameController.text = 'f name';
    // lastNameController.text = 'l name';
    // mobileController.text = '0123456789';
    // emailController.text = 'testshop3@gmail.com';
    // passwordController.text = '111111';
    // confirmPasswordController.text = '111111';

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessful) {
          KSnackBar(
            context: context,
            type: AlertType.success,
            message: 'Successfully Registered!',
          );

          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
          return;
        }
        if (state is RegisterFailed) {
          KSnackBar(
            context: context,
            type: AlertType.failed,
            message: state.error.toString(),
          );
          return;
        }
      },
      builder: (context, state) {
        if (state is IndustryFetched) {
          allIndustries = state.industries;
          _selectedIndustry = allIndustries[0];
        }
        if (state is SelectedIndustry) {
          allModules = state.modules;
          // _selectedModule = allModules?[0];
          // _selectedCountry = state.modules.;
        }

        return Form(
          key: _formKey,
          child: Stepper(
              physics: const NeverScrollableScrollPhysics(),
              elevation: 0,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                final isFirstStep = currentStep == 0;
                final isSecondStep = currentStep == 1;

                if (isFirstStep) {
                  print('isFirstStep');

                  if (shopController.text.trim().isNotEmpty &&
                      _selectedIndustry != null &&
                      _selectedModule != null) {
                    setState(() {
                      currentStep += 1;
                      debugPrint('FirstStep completed');
                    });

                    context.read<RegisterBloc>().add(
                          CompleteFirstStep(
                            shopName: shopController.text,
                            industryId: _selectedIndustry!.id,
                            moduleId: _selectedModule!.countryId,
                          ),
                        );

                    print('shopName >>>>>>> ${shopController.text}');
                    print('industryId >>>>>>> ${_selectedIndustry?.id}');
                    print('moduleId >>>>>>> ${_selectedModule?.countryId}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 1000),
                        content: Text('Please add the required fields!'),
                      ),
                    );
                  }
                }

                if (isSecondStep) {
                  debugPrint('isSecondStep');

                  if (firstNameController.text.trim().isNotEmpty &&
                      lastNameController.text.trim().isNotEmpty &&
                      mobileController.text.trim().isNotEmpty) {
                    setState(() {
                      currentStep += 1;
                      debugPrint('SecondStep completed');
                    });

                    context.read<RegisterBloc>().add(
                          CompleteSecondStep(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            mobile: mobileController.text,
                          ),
                        );
                  } else {
                    KSnackBar(
                      context: context,
                      type: AlertType.failed,
                      message: 'Please add the required fields!',
                    );
                  }
                }

                if (isLastStep) {
                  var isValid = _formKey.currentState?.validate();
                  if (emailController.text.trim().isNotEmpty &&
                      passwordController.text.trim().isNotEmpty &&
                      confirmPasswordController.text.trim().isNotEmpty &&
                      isValid!) {
                    BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterSubmitted(
                      shopName: shopController.text,
                      email: emailController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      mobile: mobileController.text,
                      password: passwordController.text,
                      passwordConfirmation: confirmPasswordController.text,
                      industryId: _selectedIndustry?.id,
                      moduleId: _selectedModule?.countryId,
                    ));
                  } else {
                    KSnackBar(
                      context: context,
                      type: AlertType.failed,
                      message: 'Please add the required fields!',
                    );
                  }
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() {
                        currentStep -= 1;
                      }),
              margin: const EdgeInsets.all(0),
              currentStep: currentStep,
              type: StepperType.horizontal,
              steps: getSteps(),
              onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
              controlsBuilder: (context, ControlsDetails details) {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    children: [
                      if (currentStep != 0)
                        Expanded(
                          child: KFilledButton(
                            text: 'Back',
                            buttonColor: KColors.greyLight,
                            textColor: Colors.grey,
                            // ignore: unnecessary_cast
                            onPressed: details.onStepCancel ?? () {},
                          ),
                        ),
                      if (currentStep != 0) SizedBox(width: 10.w),
                      Expanded(
                        flex: 2,
                        child: currentStep == getSteps().length - 1
                            ? BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  if (state is RegisterLoading) {
                                    return KFilledButton.iconText(
                                        leading:
                                            const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        ),
                                        text: 'Loading...',
                                        onPressed: () {});
                                  }

                                  return KFilledButton(
                                    text: 'Register',
                                    onPressed:
                                        details.onStepContinue as Function(),
                                  );
                                },
                              )
                            : KFilledButton(
                                text: 'Continue',
                                onPressed: details.onStepContinue as Function(),
                              ),
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: const Text('Shop'),
          isActive: currentStep >= 0,
          content: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Column(
                children: [
                  KTextField(
                    labelText: 'Shop Name',
                    isRequired: true,
                    controller: shopController,
                  ),
                  KDropdown(
                    items: (state is IndustryLoading)
                        ? []
                        : allIndustries.map((e) => e.name).toList(),
                    isRequired: true,
                    labelText: 'Industry',
                    value: (state is SelectedIndustry)
                        ? state.industry.name
                        : null,
                    onChanged: (dynamic industry) {
                      setState(() {
                        _selectedIndustry = allIndustries
                            .singleWhere((e) => e.name == industry);
                        print(state);
                      });

                      BlocProvider.of<RegisterBloc>(context)
                          .add(SelectIndustry(industry: _selectedIndustry!));
                    },
                  ),
                  KDropdown(
                    items: (state is SelectedIndustry)
                        ? state.modules.map((e) => e.countryName).toList()
                        : [],
                    isRequired: true,
                    labelText: 'Country',
                    value: (state is SelectedIndustry)
                        ? state.selectedModule?.countryName
                        : null,
                    onChanged: (selectedCountryName) {
                      setState(() {
                        if (state is SelectedIndustry) {
                          state.selectedModule = allModules!.singleWhere(
                              (e) => e.countryName == selectedCountryName);
                          _selectedModule = state.selectedModule;
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: const Text('Details'),
          isActive: currentStep >= 1,
          content: Column(
            children: [
              KTextField(
                labelText: 'First Name',
                isRequired: true,
                controller: firstNameController,
              ),
              KTextField(
                labelText: 'Last Name',
                isRequired: true,
                controller: lastNameController,
              ),
              KTextField(
                isRequired: true,
                labelText: 'Phone Number',
                controller: mobileController,
              ),
            ],
          ),
        ),
        Step(
          title: const Text('Confirm'),
          isActive: currentStep >= 2,
          content: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Column(
                children: [
                  KTextField(
                    labelText: 'Email',
                    isRequired: true,
                    controller: emailController,
                  ),
                  KTextField(
                    labelText: 'Enter Password',
                    isRequired: true,
                    isPassword: true,
                    controller: passwordController,
                  ),
                  KTextField(
                    labelText: 'Confirm Password',
                    isRequired: true,
                    isPassword: true,
                    controller: confirmPasswordController,
                  ),
                ],
              );
            },
          ),
        ),
      ];
}
