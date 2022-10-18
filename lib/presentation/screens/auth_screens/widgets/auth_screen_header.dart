import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_logo.dart';

class AuthScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthScreenHeader({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: Container(
                height: 120.h,
                width: double.infinity,
                color: KColors.primary,
                child: Align(
                  alignment: Alignment(0.0, -0.3.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 35.h,
              color: Colors.white,
            ),
          ],
        ),
        Positioned.fill(
          bottom: -75.h,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 68.h,
              width: 68.w,
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.all(
                //   Radius.circular(50.r),
                // ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.r,
                    offset: Offset(0, 2.h),
                    color: KColors.green,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              child: const KLogo(),
            ),
          ),
        ),
      ],
    );
  }
}
