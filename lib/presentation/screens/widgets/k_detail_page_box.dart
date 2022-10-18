import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KDetailPageBox extends StatelessWidget {
  final List<Widget> children;
  final Color? bgColor;
  final Color? borderColor;
  final double? padding;
  final double? yMargin;
  final double? bottomPadding;
  final double? topPadding;
  final double? leftPadding;
  final double? rightPadding;
  const KDetailPageBox({
    Key? key,
    required this.children,
    this.bgColor,
    this.borderColor,
    this.padding,
    this.yMargin,
    this.bottomPadding,
    this.topPadding,
    this.leftPadding,
    this.rightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: yMargin ?? 10.h),
      decoration: BoxDecoration(
        color: bgColor ?? KColors.primary.shade400,
        border: Border.all(
          width: 0.5.w,
          color: borderColor ?? KColors.primary.shade200,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottomPadding ?? padding ?? 0,
            top: topPadding ?? padding ?? 0,
            left: leftPadding ?? padding ?? 0,
            right: rightPadding ?? padding ?? 0,
          ),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
