import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/client_settings_model.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_data_table.dart/k_data_table_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_dialog.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_container.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../../core/core.dart';
import '../../../../logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';
import '../../../../logic/permissions.dart';
import '../../widgets/k_detail_page_item.dart';

class GeneralSettingsScreen extends StatelessWidget {
  GeneralSettingsScreen({Key? key}) : super(key: key);

  ClientSettingsModel? clientSettingsModel;
  var primaryImageLogo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($t('menu.generalSettings')),
      ),
      body: BlocConsumer<GeneralSettingsBloc, GeneralSettingsState>(
        listener: (context, state) {
          if (state is AccountResetState) {
            Navigator.popAndPushNamed(context, AppRouter.home);
          }
        },
        builder: (context, state) {
          if (state is ClientSettingsFetched) {
            clientSettingsModel = state.clientSettingsModel;

            if (clientSettingsModel!.primaryMediaUrl.isNotEmpty) {
              primaryImageLogo = state.clientSettingsModel.primaryMediaUrl;
            } else {
              primaryImageLogo = null;
            }
          }
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return KPage(
            isScrollable: true,
            children: [
              KPageMiddle(
                isExpanded: false,
                // bgColor: KColors.primary,
                children: [
                  KDetailPageItem(
                    titleText: $t('fields.logo'),
                    bigYPadding: true,
                    valueWidget: KImageContainer(
                      width: 150.w,
                      image: clientSettingsModel != null
                          ? clientSettingsModel!.primaryMediaUrl.isNotEmpty
                              ? Image.network(
                                  clientSettingsModel!.primaryMediaUrl,
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (ctx, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.grey.shade400,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              : null
                          : null,
                    ),
                    textColor: Colors.black54,
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.name'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.customer?.shopName ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.name'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.address'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.address ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.address'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.city'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.city ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.city'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.country'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.country ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.country'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.phone'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.phone ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.phone'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.website'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.website ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.website'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.country'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.country ?? '-',
                    textColor: Colors.black54,
                    hasPermission: Permissions.hasFieldPermission(
                        'settings.general-settings.country'),
                  ),
                  KDetailPageItem(
                    titleText: $t('fields.invoiceFooter'),
                    bigYPadding: true,
                    valueText: clientSettingsModel?.data.invoiceFooter ?? '-',
                    textColor: Colors.black54,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.h,
                      bottom: 40.h,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        KDialog(
                          context: context,
                          title: 'Are you sure?',
                          bodyText: "You won't be able to revert this!",
                          yesButtonText: "Yes, Reset Account!",
                          noButtonText: "Cancel",
                          yesBtnPressed: () {
                            BlocProvider.of<GeneralSettingsBloc>(context).add(
                              ResetAccount(
                                  clientId:
                                      clientSettingsModel?.clientId as int),
                            );
                          },
                        );
                      },
                      child: Text(
                        $t('fields.resetAccount'),
                        style: const TextStyle(
                          color: KColors.danger,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              KPageButtonsRow(
                marginTop: 15.h,
                buttons: [
                  KDataTableButton(
                    type: ButtonType.image,
                    buttonText: "Change Logo",
                    onPressed: () {
                      BlocProvider.of<GeneralSettingsBloc>(context)
                          .add(GoGeneralSettingsChangeLogoPage(
                        id: clientSettingsModel?.id as int,
                        primaryImage: primaryImageLogo,
                      ));
                    },
                  ),
                  KDataTableButton(
                    type: ButtonType.edit,
                    onPressed: () {
                      BlocProvider.of<GeneralSettingsBloc>(context)
                          .add(GoEditGeneralSettingsPage(
                        clientSettingsData: clientSettingsModel,
                      ));
                    },
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
