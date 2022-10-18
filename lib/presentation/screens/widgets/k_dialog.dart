import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

enum DialogType { alert, form }

KDialog({
  required BuildContext context,
  String? title,
  String? yesButtonText,
  String? noButtonText,
  Color? yesButtonColor,
  Color? noButtonColor,
  String? bodyText,
  List<Widget>? formContent,
  DialogType? dialogType = DialogType.alert,
  required Function()? yesBtnPressed,
}) {
  // get body content
  Widget getWidget(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            bodyText ?? $t('placeholder.confirmDelete'),
          ),
        );
      case DialogType.form:
        return SingleChildScrollView(
          primary: false,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: formContent ?? []
              ..add(
                SizedBox(
                  height: 0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
          ),
        );

      default:
        return Text(
          bodyText ?? $t('placeholder.confirmDelete'),
        );
    }
  }

  // yes button text
  String getYesButtonText(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return $t('buttons.yes');
      case DialogType.form:
        return $t('buttons.submit');
      default:
        return $t('buttons.yes');
    }
  }

  // no button text
  String getNoButtonText(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return $t('buttons.no');
      case DialogType.form:
        return $t('buttons.cancel');
      default:
        return $t('buttons.no');
    }
  }

  // Yes button color
  Color getYesButtonColor(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return KColors.danger;
      case DialogType.form:
        return KColors.primary;
      default:
        return KColors.danger;
    }
  }

  // No button color
  Color getNoButtonColor(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return KColors.green;
      case DialogType.form:
        return Colors.grey.shade400;
      default:
        return KColors.green;
    }
  }

  // main dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            title ?? $t('placeholder.pleaseConfirm'),
            style: TextStyle(
              fontSize: 17.sp,
              color: KColors.primary,
            ),
          ),
          titlePadding: EdgeInsets.symmetric(
            horizontal: 18.w,
            vertical: 18.h,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0.h,
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 0.h,
          ),
          insetPadding: dialogType == DialogType.form
              ? EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 70.h,
                )
              : EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 24.h,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 20.h,
              bottom: dialogType == DialogType.form ? 5.h : 20.h,
              right: 20.w,
              left: 20.w,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: KColors.primary.shade300, width: 0.3.w),
                bottom:
                    BorderSide(color: KColors.primary.shade300, width: 0.3.w),
              ),
            ),
            child: getWidget(dialogType),
          ),
          actions: <Widget>[
            k_dialog_button(
              buttonText: noButtonText ?? getNoButtonText(dialogType),
              bgColor: noButtonColor ?? getNoButtonColor(dialogType),
              fontSize: dialogType == DialogType.form ? 15.5.sp : 14.sp,
            ),
            k_dialog_button(
              buttonText: yesButtonText ?? getYesButtonText(dialogType),
              bgColor: yesButtonColor ?? getYesButtonColor(dialogType),
              fontSize: dialogType == DialogType.form ? 15.5.sp : 14.sp,
              onPressed: yesBtnPressed,
            ),
          ],
        ),
      );
    },
  );
}

class k_dialog_button extends StatelessWidget {
  String buttonText;
  Color bgColor;
  Function()? onPressed;
  double? fontSize;
  k_dialog_button({
    Key? key,
    required this.buttonText,
    required this.bgColor,
    this.onPressed,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 11.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: bgColor,
      ),
    );
  }
}
