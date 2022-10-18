import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_badge.dart';

class KDataTableDetailItem extends StatelessWidget {
  final String titleText;
  final String? valueText;
  final bool isBadge;

  const KDataTableDetailItem({
    Key? key,
    required this.titleText,
    this.valueText,
    this.isBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5.w,
            color: KColors.primary.shade300,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 10.h,
          bottom: 10.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                titleText,
                style: TextStyle(
                  color: KColors.primary.shade100,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            isBadge
                ? Flexible(
                    flex: 4,
                    child: KBadge(value: valueText!),
                  )
                : Flexible(
                    flex: 4,
                    child: Text(
                      valueText ?? '',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: KColors.primary.shade50,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
