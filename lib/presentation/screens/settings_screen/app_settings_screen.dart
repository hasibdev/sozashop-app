import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';

import 'package:sozashop_app/l10n/l10n.dart';
import 'package:sozashop_app/logic/bloc/language_bloc/language_bloc.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/widgets/settings_category.dart';
import 'package:sozashop_app/presentation/screens/settings_screen/widgets/settings_item.dart';

import '../../../l10n/app_localization.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($t('menu.appSettings')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsCategory(
            name: 'General',
            items: [
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  String? languageName;
                  if (state is LanguageChanged) {
                    languageName = state.name;
                  } else if (state is LanguageInitial) {
                    languageName = L10n.getLanguageName(state.code.toString());
                  } else {
                    languageName = 'Default';
                  }
                  return SettingsItem(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.languageSettings);
                    },
                    icon: Icons.language_outlined,
                    title: AppLocalizations.of(context)!
                        .translate('language.label'),
                    subTitle: languageName,
                  );
                },
              ),
            ],
          ),
          // SettingsCategory(
          //   name: '(Moved to profile dropdown)',
          //   items: [
          //     SettingsItem(
          //       onPressed: () {},
          //       icon: Icons.close,
          //       title: 'Moved',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
