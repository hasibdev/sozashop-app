import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class SidebarItem extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isSubItem;
  final IconData? icon;
  const SidebarItem({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isSubItem = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      visualDensity: VisualDensity.comfortable,
      leading: isSubItem
          ? SizedBox(width: 25.w)
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15.0.h,
                horizontal: 0,
              ),
              child: Icon(icon),
            ),
      iconColor: KColors.grey,
      selectedTileColor: Colors.amber,
      //  KColors.secondaryDark,
      minLeadingWidth: 15.w,
      minVerticalPadding: 0.h,
      contentPadding: EdgeInsets.only(
        left: 15.w,
        top: 0,
        bottom: 0,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: KColors.grey,
          fontSize: isSubItem ? 16.sp : 17.sp,
          fontWeight: isSubItem ? FontWeight.w400 : FontWeight.w500,
        ),
      ),
    );
  }
}
