import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KPageButtonsRow extends StatelessWidget {
  final List<Widget> buttons;
  final double? marginTop;
  const KPageButtonsRow({
    Key? key,
    required this.buttons,
    this.marginTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: marginTop ?? 15.h),
        Row(
          children: buttons,
        ),
      ],
    );
  }
}
