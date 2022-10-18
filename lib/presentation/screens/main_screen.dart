import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:sozashop_app/logic/bloc/profile_bloc/profile_bloc.dart';
import 'package:sozashop_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:sozashop_app/presentation/screens/internet_checking_screen.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_loading_icon.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
          return const InternetCheckingScreen();
        } else if (state is AuthenticationUnauthenticated) {
          return LoginScreen();
        }
        if (state is AuthenticationUninitialized) {
          return LoginScreen();
        }

        return const Scaffold(
          body: Center(
            child: KLoadingIcon(),
          ),
        );
      },
    );
  }
}
