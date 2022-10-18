import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/logic/bloc/register_bloc/register_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/widgets/auth_screen_header.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/widgets/register_stepper.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_container.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: KColors.greyLight,
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 120,
                  minHeight: 650.h,
                ),
                child: KContainer(
                  margin: 20.w,
                  xPadding: 0,
                  yPadding: 0,
                  // height: 650.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AuthScreenHeader(
                        title: 'Welcome!',
                        subtitle: 'Sign up to continue on Sozashop',
                      ),
                      const Expanded(
                        child: RegisterStepper(),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .popAndPushNamed(AppRouter.loginScreen);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: KColors.primary,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
