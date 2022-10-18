import 'package:flutter/material.dart';

import 'package:sozashop_app/core/constants/colors.dart';
import 'package:sozashop_app/core/constants/styles.dart';

class SettingsCategory extends StatelessWidget {
  final String name;
  final List<Widget> items;
  const SettingsCategory({
    Key? key,
    required this.name,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 15.h,
            bottom: 3.h,
            left: kPaddingX,
            right: kPaddingX,
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              color: KColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Column(
          children: items,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
            horizontal: kPaddingX,
          ),
          child: const Divider(),
        ),
      ],
    );
  }
}
