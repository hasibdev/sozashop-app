import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/general_settings/edit_general_settings_screen.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/general_settings/general_settings_change_logo_screen.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/general_settings/general_settings_screen.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_snackbar.dart';

import '../../../../logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';
import '../../widgets/k_loading_icon.dart';

class GeneralSettingsBlocLogic extends StatelessWidget {
  const GeneralSettingsBlocLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GeneralSettingsBloc, GeneralSettingsState>(
        listener: (context, state) {
          if (state is GeneralSettingsEditedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Setting Edited Successfully!",
            );
          }
          if (state is GeneralSettingsLogoChangedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Logo Updated Successfully!",
            );
          }
          if (state is GeneralSettingsEditingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          if (state is GeneralSettingsLogoChangingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
          print(state);
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: KLoadingIcon());
          }
          if (state is ClientSettingsFetched) {
            return GeneralSettingsScreen();
          }
          if (state is GeneralSettingsEditingState ||
              state is GeneralSettingsEditingFailed) {
            return EditGeneralSettingsScreen();
          }
          if (state is GeneralSettingsLogoChangingState ||
              state is GeneralSettingsLogoChangingFailed ||
              state is GeneralSettingsLogoChangedState) {
            return GeneralSettingsChangeLogoScreen();
          }
          print(state);
          return GeneralSettingsScreen();
        },
      ),
    );
  }
}
