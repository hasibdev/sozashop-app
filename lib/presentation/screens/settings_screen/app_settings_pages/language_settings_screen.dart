import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/core.dart';

import 'package:sozashop_app/logic/bloc/language_bloc/language_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../widgets/k_snackbar.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) {
        if (state is LanguageChanged) {
          KSnackBar(
            context: context,
            type: AlertType.info,
            message: 'Language changed to ${state.name}',
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            String? _selectedLang;

            if (state is LanguageInitial) {
              _selectedLang = state.code;
            } else if (state is LanguageChanged) {
              _selectedLang = state.code;
            } else {
              _selectedLang = L10n.all[0].languageCode;
            }
            // AppLocalizations.of(context)!.language;

            return Scaffold(
              appBar: AppBar(
                title: Text($t('language.label')),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: L10n.all.length,
                  itemBuilder: (BuildContext context, int index) {
                    var language = L10n.all[index];
                    var lanName = L10n.getLanguageName(language.languageCode);

                    return RadioListTile<String?>(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kPaddingX,
                        vertical: 5.h,
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: language.languageCode,
                      groupValue: _selectedLang,
                      onChanged: (String? _language) {
                        BlocProvider.of<LanguageBloc>(context)
                            .add(ChangeLanguage(_language));
                      },
                      title: Text(
                        lanName,
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
