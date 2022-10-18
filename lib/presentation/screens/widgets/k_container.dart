import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KContainer extends StatelessWidget {
  final Color bgColor;
  final Widget child;
  final double? height;
  final double? margin;
  final double? xPadding;
  final double? yPadding;

  const KContainer({
    Key? key,
    this.height,
    this.bgColor = Colors.white,
    this.margin,
    this.xPadding,
    this.yPadding,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: margin ?? 20.h,
        left: margin ?? 20.w,
        right: margin ?? 20.w,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        padding: EdgeInsets.symmetric(
          horizontal: xPadding ?? 15.w,
          vertical: yPadding ?? 15.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: .5.r,
              offset: Offset(0, 1.2.h),
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.3,
              // blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}
