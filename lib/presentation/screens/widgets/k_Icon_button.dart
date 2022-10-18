import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KIconButton extends StatelessWidget {
  VoidCallback onPressed;
  IconData? icon;
  Color? iconColor;
  KIconButton({
    Key? key,
    required this.onPressed,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: iconColor ?? KColors.primary,
            border: Border.all(
              color: iconColor ?? KColors.primary,
              width: 1,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 11.w,
            vertical: 11.h,
          ),
          child: Icon(
            icon ?? Icons.add,
            size: 24.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
