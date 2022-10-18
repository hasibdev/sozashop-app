import 'package:flutter/material.dart';
import 'package:toggle_list/toggle_list.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_data_table.dart/k_data_table_main_item.dart';

class KDetailPageToggle extends StatelessWidget {
  String? title;
  List<Widget>? items;
  List<Widget>? buttons;
  KDetailPageToggle({
    Key? key,
    this.title,
    this.items,
    this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleList(
      scrollDirection: Axis.vertical,
      scrollPosition: AutoScrollPosition.middle,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      curve: Curves.easeIn,
      scrollDuration: const Duration(milliseconds: 200),
      toggleAnimationDuration: const Duration(milliseconds: 250),
      trailing: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
          child: const Icon(
            Icons.unfold_more_rounded,
            color: KColors.grey,
          )),
      trailingExpanded: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        child: const Icon(
          Icons.unfold_less_rounded,
          color: KColors.grey,
        ),
      ),
      shrinkWrap: true,
      divider: SizedBox(height: 3.h),
      viewPadding: const EdgeInsets.all(0),
      children: [
        kDataTableMainItem(
          detailBg: KColors.primary,
          isInitiallyExpanded: true,
          text: title ?? '',
          items: items,
          buttons: buttons,
        ),
      ],
    );
  }
}
