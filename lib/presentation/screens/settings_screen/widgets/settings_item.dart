import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sozashop_app/core/constants/colors.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String title;
  final String? subTitle;
  const SettingsItem({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: KColors.primary,
                size: 24.h,
              ),
              SizedBox(width: 18.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black87,
                    ),
                  ),
                  (subTitle != null)
                      ? Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: Text(
                            subTitle.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
