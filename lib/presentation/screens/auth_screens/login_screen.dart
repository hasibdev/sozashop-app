import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/logic/bloc/login_bloc/login_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/widgets/auth_screen_header.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_container.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../widgets/k_snackbar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // emailController.text = 'fuad@gmail.com';
    // passwordController.text = '111111';

    // emailController.text = '05@sozashop.com';
    // passwordController.text = '111111';

    // emailController.text = 'shamim3280@gmail.com';
    // passwordController.text = '111111';

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessful) {
          KSnackBar(
            context: context,
            type: AlertType.success,
            message: 'Login Successful!',
          );
        }
        if (state is LoginFailure) {
          KSnackBar(
            context: context,
            type: AlertType.failed,
            message: 'Email or password doesn\'t match',
          );
        }
        return;
      },
      child: Scaffold(
        backgroundColor: KColors.greyLight,
        body: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: KContainer(
              margin: 20.w,
              xPadding: 0,
              yPadding: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AuthScreenHeader(
                    title: 'Welcome Back!',
                    subtitle: 'Sign in to continue on Sozashop',
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 15.h,
                      bottom: 20.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          KTextField(
                            labelText: 'Email',
                            controller: emailController,
                            isRequired: true,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          KTextField(
                            labelText: 'Enter password',
                            isPassword: true,
                            isRequired: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 5.h),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return KFilledButton.iconText(
                                  leading: const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                  text: 'Loading...',
                                  onPressed: () {},
                                );
                              }
                              return KFilledButton(
                                text: 'Log In',
                                onPressed: () {
                                  var isValid =
                                      _formKey.currentState!.validate();

                                  if (isValid) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginSubmitted(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  } else {
                                    KSnackBar(
                                      context: context,
                                      type: AlertType.failed,
                                      message:
                                          'Email and password fields are required!',
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.registerScreen);
                                },
                                child: Text(
                                  'Register now',
                                  style: TextStyle(
                                    color: KColors.primary,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'I forgot my password',
                              style: TextStyle(
                                color: KColors.primary,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
