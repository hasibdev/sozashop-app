import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:sozashop_app/logic/bloc/login_bloc/login_bloc.dart';
import 'package:sozashop_app/presentation/screens/bottom_nav.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

class InternetCheckingScreen extends StatelessWidget {
  const InternetCheckingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is ConnectionGainedState) {
          KSnackBar(
            context: context,
            type: AlertType.success,
            durationSeconds: 3,
            message: 'Internet Connected!',
          );
        }
        if (state is ConnectionLostState) {
          KSnackBar(
              context: context,
              type: AlertType.warning,
              durationSeconds: 40,
              message: 'Internet Disconnected!',
              isDismissible: false,
              onActionButtonTap: () {
                print('log out for no internet');
                BlocProvider.of<LoginBloc>(context).add(LoggingOut());
              });
        }
      },
      builder: (context, state) {
        // if (state is InternetDisconnectedState) {
        //   // BlocProvider.of<LoginBloc>(context).add(LoggingOut());
        //   return LoginScreen();
        //   // return const NoInternetScreen();
        // } else if (state is InternetConnectedState) {
        //   return const BottomNav();
        // } else {
        //   return const BottomNav();
        // }
        return const BottomNav();
      },
    );
  }
}
