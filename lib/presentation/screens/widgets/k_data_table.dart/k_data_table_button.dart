import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

enum ButtonType {
  details,
  edit,
  delete,
  barcode,
  image,
  add,
  returns,
  pay,
  invoice,
  share,
  confirm,
}

class KDataTableButton extends StatelessWidget {
  String? buttonText;
  IconData? icon;
  Color? btnColor;
  ButtonType type;
  Function()? onPressed;
  final bool hasPermission;
  KDataTableButton({
    Key? key,
    required this.type,
    required this.onPressed,
    this.buttonText,
    this.icon,
    this.btnColor,
    this.hasPermission = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasPermission
        ? Expanded(
            child: InkWell(
              splashColor: Colors.grey,
              highlightColor: Colors.white,
              onTap: onPressed,
              child: Container(
                // height: 55.h,
                decoration: BoxDecoration(
                  color: btnColor ?? generateBtnColor(type),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 6.h,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon ?? generateIcon(type),
                        color: generateItemColor(type),
                        size: 22.h,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        buttonText ?? generateText(type),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: generateItemColor(type),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  // color of the button
  Color? generateBtnColor(ButtonType type) {
    switch (type) {
      case ButtonType.details:
        return KColors.success;
      case ButtonType.edit:
        return Colors.amber.shade700;
      case ButtonType.delete:
        return Colors.red[600];
      case ButtonType.barcode:
        return Colors.black45;
      case ButtonType.returns:
        return KColors.primary.shade700;
      case ButtonType.image:
        return KColors.blue;
      case ButtonType.add:
        return KColors.success;
      case ButtonType.invoice:
        return KColors.blue;
      case ButtonType.pay:
        return Colors.black45;
      case ButtonType.confirm:
        return Colors.black45;
      case ButtonType.share:
        return KColors.success;
      default:
        return KColors.primary.shade700;
    }
  }

  // color of the items
  Color? generateItemColor(ButtonType type) {
    switch (type) {
      default:
        return Colors.white;
    }
  }

  // text of the button
  generateText(ButtonType type) {
    switch (type) {
      case ButtonType.details:
        return $t("buttons.details");
      case ButtonType.edit:
        return $t("buttons.edit");
      case ButtonType.delete:
        return $t("buttons.delete");
      case ButtonType.barcode:
        return $t("buttons.barcode");
      case ButtonType.image:
        return $t("buttons.image");
      case ButtonType.add:
        return $t("buttons.add");
      case ButtonType.returns:
        return $t("buttons.return");
      case ButtonType.invoice:
        return $t("buttons.invoice");
      case ButtonType.share:
        return $t("buttons.share");
      case ButtonType.pay:
        return $t("buttons.pay");
      case ButtonType.confirm:
        return $t("buttons.confirm");
      default:
        return 'Button';
    }
  }

  // icon of the button
  generateIcon(ButtonType type) {
    switch (type) {
      case ButtonType.details:
        return Icons.remove_red_eye_rounded;
      case ButtonType.edit:
        return Icons.edit;
      case ButtonType.delete:
        return Icons.delete_forever;
      case ButtonType.barcode:
        return Icons.qr_code;
      case ButtonType.image:
        return Icons.image;
      case ButtonType.add:
        return Icons.add;
      case ButtonType.returns:
        return Icons.restart_alt_rounded;
      case ButtonType.invoice:
        return Icons.receipt_outlined;
      case ButtonType.share:
        return Icons.share;
      case ButtonType.confirm:
        return Icons.check;
      default:
        return Icons.remove_red_eye_rounded;
    }
  }
}
