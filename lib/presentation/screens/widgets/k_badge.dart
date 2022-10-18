import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class KBadge extends StatelessWidget {
  final String value;
  final Color? badgeColor;
  KBadge({
    Key? key,
    required this.value,
    this.badgeColor,
  }) : super(key: key);

  var valueToColor = {
    'active': KColors.success,
    'inactive': KColors.danger,
    'draft': KColors.warning,
    'confirmed': KColors.primary,
    'partial': KColors.info,
    'paid': KColors.success,
    'private': KColors.info,
    'public': KColors.primary,
    'unverified': KColors.danger,
    'verified': KColors.info,
    'pending': KColors.warning,
    'approved': KColors.success,
    'rejected': KColors.danger,
    'completed': KColors.info,
    'low': KColors.info,
    'high': KColors.danger,
    'medium': KColors.warning,
    'open': KColors.primary,
    'close': KColors.warning,
  };

  @override
  Widget build(BuildContext context) {
    return Badge(
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(20.r),
      elevation: 0,
      badgeColor: badgeColor ?? valueToColor[value]!,
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      toAnimate: false,
      badgeContent: Text(
        value.toCapitalized(),
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
