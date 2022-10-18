import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .80,
                  child:
                      Lottie.asset('assets/animations/no_internet_globe.json'),
                ),
                SizedBox(height: 20.h),
                Text(
                  'No Internet Connection!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 45.h,
                  width: 135.w,
                  child: state is RefreshInternetState
                      ? KFilledButton.iconText(
                          leading: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: const FittedBox(
                              fit: BoxFit.contain,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {},
                        )
                      : KFilledButton(
                          text: 'Refresh'.toUpperCase(),
                          onPressed: () {
                            BlocProvider.of<InternetBloc>(context)
                                .add(RefreshInternet());
                          },
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
