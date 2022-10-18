import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/currency_settings_model.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../../core/core.dart';
import '../../../../logic/bloc/settings_bloc/currency_settings_bloc/currency_settings_bloc.dart';
import '../../../../logic/permissions.dart';
import '../../widgets/k_detail_page_item.dart';

class CurrencySettingsScreen extends StatelessWidget {
  CurrencySettingsScreen({Key? key}) : super(key: key);

  CurrencySettingsModel? currencySettingsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($t('currencySettings.label')),
      ),
      body: BlocConsumer<CurrencySettingsBloc, CurrencySettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrencySettingsFetched) {
            currencySettingsModel = state.currencySettingsModel;
          }
          if (state is CurrencySettingsLoading) {
            return const Center(child: KLoadingIcon());
          }
          return KPage(
            // isScrollable: true,
            children: [
              KPageMiddle(
                isExpanded: false,
                // bgColor: KColors.primary,
                children: [
                  KDetailPageItem(
                    titleText: $t('fields.currencyName'),
                    bigYPadding: true,
                    valueText: currencySettingsModel?.data.currencyName ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.currency-settings.currency-name'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.currencyCode'),
                    bigYPadding: true,
                    valueText: currencySettingsModel?.data.currencyCode ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.currency-settings.currency-code'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.currencySymbol'),
                    bigYPadding: true,
                    valueText:
                        currencySettingsModel?.data.currencySymbol ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.currency-settings.currency-symbol'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
