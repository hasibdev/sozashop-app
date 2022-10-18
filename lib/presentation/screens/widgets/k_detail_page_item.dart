import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_badge.dart';

class KDetailPageItem extends StatelessWidget {
  final String? titleText;
  final String? valueText;
  final Widget? valueWidget;
  final bool isBadge;
  final bool hasPermission;
  final bool hasTitleText;
  final bool bigYPadding;
  final bool hasBottomBorder;
  final Color? textColor;
  final double? yPadding;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final Color? badgeColor;
  final Color? bgColor;
  final TextAlign? textAlign;

  const KDetailPageItem({
    Key? key,
    this.titleText,
    this.valueText,
    this.isBadge = false,
    this.hasPermission = true,
    this.textColor,
    this.valueWidget,
    this.bigYPadding = false,
    this.hasTitleText = true,
    this.hasBottomBorder = true,
    this.yPadding = 25,
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    this.badgeColor,
    this.bgColor,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasPermission
        ? Container(
            decoration: BoxDecoration(
              color: bgColor,
              border: hasBottomBorder
                  ? Border(
                      bottom: BorderSide(
                        width: 0.5.w,
                        color: KColors.primary.shade200,
                      ),
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: leftPadding ?? 20.w,
                right: rightPadding ?? 20.w,
                top: topPadding ?? (bigYPadding ? 20.h : 15.h),
                bottom: bottomPadding ?? (bigYPadding ? 20.h : 15.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hasTitleText
                      ? Flexible(
                          flex: 2,
                          child: Text(
                            titleText ?? '',
                            style: TextStyle(
                              color: textColor ?? KColors.primary.shade100,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Container(),
                  hasTitleText ? SizedBox(width: 10.w) : Container(),
                  valueWidget != null
                      ? Flexible(
                          flex: 4,
                          child: valueWidget!,
                        )
                      : isBadge
                          ? Flexible(
                              flex: 4,
                              child: KBadge(
                                value: valueText!,
                                badgeColor: badgeColor,
                              ),
                            )
                          : Flexible(
                              flex: 4,
                              child: Text(
                                valueText ?? '',
                                textAlign: textAlign,
                                style: TextStyle(
                                  color: textColor ?? KColors.primary.shade50,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                ],
              ),
            ),
          )
        : SizedBox.fromSize(
            size: const Size(0, 0),
          );
  }
}
