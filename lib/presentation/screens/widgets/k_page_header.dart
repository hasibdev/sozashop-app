import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KPageheader extends StatelessWidget {
  final Function()? onButtonTap;
  final bool? hasPermission;
  final String title;
  final String? btnText;
  final double? topPadding;
  final double? bottomPadding;

  const KPageheader({
    Key? key,
    this.onButtonTap,
    this.hasPermission,
    required this.title,
    this.btnText,
    this.topPadding,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding?.h ?? 0,
        bottom: bottomPadding?.h ?? 15.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              softWrap: true,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.sp,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          SizedBox(
            width: kPaddingX,
          ),
          (hasPermission == true && btnText != null)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 1,
                  ),
                  onPressed: onButtonTap,
                  child: Text(
                    btnText ?? "Button",
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
