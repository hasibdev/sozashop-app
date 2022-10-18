import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KPage extends StatelessWidget {
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final List<Widget> children;
  final Color? bgColor;
  final bool isScrollable;
  final ScrollController? controller;
  final bool? dismissKeyboard;

  const KPage({
    Key? key,
    this.topPadding,
    this.bottomPadding,
    this.leftPadding,
    this.rightPadding,
    required this.children,
    this.bgColor,
    this.controller,
    this.dismissKeyboard = true,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? KColors.greyLight,
      child: isScrollable
          ? SingleChildScrollView(
              controller: controller,
              keyboardDismissBehavior: dismissKeyboard == true
                  ? ScrollViewKeyboardDismissBehavior.onDrag
                  : ScrollViewKeyboardDismissBehavior.manual,
              child: buildBody(
                topPadding: topPadding,
                bottomPadding: bottomPadding,
                leftPadding: leftPadding,
                rightPadding: rightPadding,
                children: children,
              ),
            )
          : buildBody(
              topPadding: topPadding,
              bottomPadding: bottomPadding,
              leftPadding: leftPadding,
              rightPadding: rightPadding,
              children: children,
            ),
    );
  }
}

class buildBody extends StatelessWidget {
  const buildBody({
    Key? key,
    required this.topPadding,
    required this.bottomPadding,
    required this.leftPadding,
    required this.rightPadding,
    required this.children,
  }) : super(key: key);

  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding ?? kPaddingY,
        bottom: bottomPadding ?? kPaddingY,
        left: leftPadding ?? kPaddingX,
        right: rightPadding ?? kPaddingX,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
