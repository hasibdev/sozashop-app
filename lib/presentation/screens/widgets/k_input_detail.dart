import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_badge.dart';

class KInputDetail extends StatelessWidget {
  final String titleText;
  final String? valueText;
  final bool hasPermission;
  final bool isBadge;

  const KInputDetail({
    Key? key,
    required this.titleText,
    this.valueText,
    this.hasPermission = true,
    this.isBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasPermission
        ? Container(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Text(
                    '$titleText :',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
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
                        fit: FlexFit.tight,
                        child: Text(
                          valueText ?? '',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
              ],
            ),
          )
        : SizedBox.fromSize(
            size: const Size(0, 0),
          );
  }
}
