import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_container.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_picker_wrapper.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_buttons_row.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';

import '../../../../logic/bloc/settings_bloc/general_settings_bloc/general_settings_bloc.dart';
import '../../widgets/k_snackbar.dart';

class GeneralSettingsChangeLogoScreen extends StatelessWidget {
  GeneralSettingsChangeLogoScreen({Key? key}) : super(key: key);

  var selectedPrimaryImage;
  int? id;
  var statePrimaryImage;

  getImage() {
    if (selectedPrimaryImage != null) {
      return Image.file(
        selectedPrimaryImage!,
        fit: BoxFit.contain,
      );
    } else if (statePrimaryImage != null) {
      return Image.network(
        statePrimaryImage,
        fit: BoxFit.contain,
        loadingBuilder: (ctx, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.shade400,
                ),
              ),
            );
          }
        },
      );
    } else if (selectedPrimaryImage == null && statePrimaryImage == null) {
      return null;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<GeneralSettingsBloc>(context)
            .add(GoGeneralSettingsPage());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Primary Logo'),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<GeneralSettingsBloc>(context)
                  .add(GoGeneralSettingsPage());
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocBuilder<GeneralSettingsBloc, GeneralSettingsState>(
          builder: (context, state) {
            if (state is GeneralSettingsLogoChangingState) {
              id = state.id;
              statePrimaryImage = state.primaryImage;
            }

            return KPage(
              children: [
                KPageMiddle(
                  isExpanded: false,
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) => KImagePickerWrapper(
                        context: context,
                        onImageSelect: (newImage) {
                          setState(() {
                            selectedPrimaryImage = newImage;
                            getImage();
                          });
                        },
                        wrapperChild: KImageContainer(
                          image: getImage(),
                        ),
                      ),
                    ),
                  ],
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Flexible(
                      flex: 1,
                      child: KFilledButton(
                        text: $t("buttons.cancel"),
                        buttonColor: Colors.grey.shade300,
                        textColor: Colors.grey.shade600,
                        onPressed: () {
                          BlocProvider.of<GeneralSettingsBloc>(context)
                              .add(GoGeneralSettingsPage());
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    BlocBuilder<GeneralSettingsBloc, GeneralSettingsState>(
                      builder: (context, state) {
                        return Flexible(
                          flex: 2,
                          child: state is ButtonLoading
                              ? KFilledButton.iconText(
                                  leading: const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                  // text: 'Loading...',
                                  onPressed: () {},
                                )
                              : KFilledButton(
                                  text: $t("buttons.update"),
                                  onPressed: () {
                                    if (selectedPrimaryImage != null) {
                                      BlocProvider.of<GeneralSettingsBloc>(
                                              context)
                                          .add(ChangeLogo(
                                        id: id!,
                                        primaryImage: selectedPrimaryImage,
                                      ));
                                    } else {
                                      KSnackBar(
                                        context: context,
                                        type: AlertType.failed,
                                        message: 'Please select a new logo!',
                                        durationSeconds: 3,
                                      );
                                    }
                                  },
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
