import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

import 'k_text_field.dart';

class KSearchField extends StatelessWidget {
  final TextEditingController controller;
  final dynamic Function(String)? onSubmitted;
  final Function()? onSearchTap;
  final Function()? onClearSearch;
  bool? showClearSearchWidget;
  KSearchField({
    Key? key,
    required this.controller,
    required this.onSearchTap,
    required this.onClearSearch,
    this.onSubmitted,
    this.showClearSearchWidget,
  }) : super(key: key);

  showWidget() {
    return showClearSearchWidget = showClearSearchWidget ??
        (controller.text.trim().isNotEmpty ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KTextField(
          labelText: '',
          showLabel: false,
          showHintText: true,
          hintText: 'Search...',
          controller: controller,
          suffixIcon: Icons.search,
          inputAction: TextInputAction.search,
          onSubmitted: onSubmitted ??
              (String value) {
                onSearchTap?.call();
              },
          suffixIconAction: onSearchTap,
        ),
        showWidget()
            ? Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Search Results for: ${controller.text}'),
                    GestureDetector(
                      onTap: () {
                        controller.clear();
                        onClearSearch?.call();
                      },
                      child: const Icon(
                        Icons.clear_all_rounded,
                        color: KColors.danger,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
