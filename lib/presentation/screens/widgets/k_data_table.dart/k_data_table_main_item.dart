import 'package:flutter/material.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../../core/core.dart';

ToggleListItem kDataTableMainItem({
  required String text,
  List<Widget>? items,
  List<Widget>? buttons,
  Color? detailBg,
  bool? isInitiallyExpanded = false,
}) {
  return ToggleListItem(
    isInitiallyExpanded: isInitiallyExpanded == true ? true : false,
    itemDecoration: BoxDecoration(
      color: detailBg ?? KColors.primary.shade400,
      borderRadius: BorderRadius.circular(8.r),
    ),
    headerDecoration: BoxDecoration(
      color: KColors.primary,
      borderRadius: BorderRadius.circular(8.r),
    ),
    title: Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 15.w,
      ),
      child: Text(
        text.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: KColors.primary.shade50,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    content: ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: (buttons == null || buttons.isEmpty) ? 0 : 4.h),
        child: Column(
          children: [
            Column(
              children: items ?? [],
            ),
            (buttons == null || buttons.isEmpty)
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                      top: 8.h,
                      bottom: 3.h,
                    ),
                    child: Row(
                      children: buttons,
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}

ToggleListItem kDataTableLastBlankItem() {
  return ToggleListItem(
    isInitiallyExpanded: true,
    leading: AbsorbPointer(
      absorbing: true,
      child: Container(
        color: Colors.amber,
        height: double.minPositive,
        width: double.minPositive,
      ),
    ),
    expandedHeaderDecoration: const BoxDecoration(),
    itemDecoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
    ),
    headerDecoration: BoxDecoration(
      backgroundBlendMode: BlendMode.screen,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
    ),

    title: const Text('isLast', style: TextStyle(color: Colors.transparent)),
    // title: Padding(
    //   padding: EdgeInsets.symmetric(
    //     vertical: 0.h,
    //     horizontal: 0.w,
    //   ),
    // ),
    content: AbsorbPointer(
      absorbing: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.h),
      ),
    ),
  );
}
