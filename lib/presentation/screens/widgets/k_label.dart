import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KLabel extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  const KLabel({
    Key? key,
    required this.labelText,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: isRequired ? 0 : 1,
            child: Text(
              labelText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          isRequired
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Text(
                    '*',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(width: 0),
        ],
      ),
    );
  }
}
