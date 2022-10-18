import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sozashop_app/core/constants/colors.dart';

class _KButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double? height;
  final double width;
  final VoidCallback onPressed;
  final Border? border;
  final bool? isDisabled;

  const _KButton({
    required this.child,
    required this.onPressed,
    this.backgroundColor = KColors.primary,
    this.height,
    this.width = double.infinity,
    this.border,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled == true ? null : onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: border,
            borderRadius: BorderRadius.circular(10.r)),
        child: child,
      ),
    );
  }
}

class KFilledButton extends _KButton {
  KFilledButton({
    required String text,
    required VoidCallback onPressed,
    Color buttonColor = KColors.primary,
    Color textColor = Colors.white,
    final double? height,
    final bool isDisabled = false,
  }) : super(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onPressed: onPressed,
          backgroundColor: isDisabled ? Colors.grey.shade400 : buttonColor,
          height: height ?? 47.h,
          isDisabled: isDisabled,
        );

  KFilledButton.iconText({
    IconData? icon,
    Widget? leading,
    String? text,
    required VoidCallback onPressed,
    final double? height,
    double? width,
    Color buttonColor = KColors.primary,
    Color? iconColor,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: iconColor ?? Colors.white,
                    )
                  : const SizedBox.shrink(),
              leading ?? const SizedBox.shrink(),
              text != null ? SizedBox(width: 18.w) : const SizedBox.shrink(),
              text != null
                  ? Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          onPressed: onPressed,
          backgroundColor: buttonColor,
          height: height ?? 47.h,
          width: width ?? double.infinity,
        );
}
