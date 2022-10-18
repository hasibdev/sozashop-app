import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:toggle_list/toggle_list.dart';

class KDataTable extends StatelessWidget {
  List<ToggleListItem> dataTableItems;
  KDataTable({
    required this.dataTableItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ToggleList(
        scrollDirection: Axis.vertical,
        scrollPosition: AutoScrollPosition.middle,
        curve: Curves.easeIn,
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        scrollDuration: const Duration(milliseconds: 200),
        toggleAnimationDuration: const Duration(milliseconds: 250),
        trailing: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
            child: const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: KColors.grey,
            )),
        trailingExpanded: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: KColors.grey,
          ),
        ),
        shrinkWrap: false,
        divider: SizedBox(height: 3.h),
        viewPadding: const EdgeInsets.all(0),
        children: dataTableItems,
      ),
    );
  }
}
