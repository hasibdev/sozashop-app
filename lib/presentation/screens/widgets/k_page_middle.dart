import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

import 'k_container.dart';

class KPageMiddle extends StatelessWidget {
  final List<Widget> children;
  final Color? bgColor;
  final double? xPadding;
  final double? yPadding;
  final double? maxHeight;
  final bool isExpanded;
  final ScrollController? controller;
  final bool? dismissKeyboard;
  const KPageMiddle({
    Key? key,
    required this.children,
    this.bgColor,
    this.xPadding,
    this.yPadding,
    this.maxHeight,
    this.isExpanded = true,
    this.dismissKeyboard = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            child: _kContainerBody(),
          )
        : Column(
            children: [
              Container(
                // height: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: maxHeight ?? double.infinity,
                ),
                child: _kContainerBody(),
              ),
            ],
          );
  }

  Widget _kContainerBody() {
    return KContainer(
      bgColor: bgColor ?? Colors.white,
      margin: 0,
      xPadding: xPadding ?? kPaddingX,
      yPadding: yPadding ?? kPaddingY,
      child: SingleChildScrollView(
        primary: false,
        controller: controller,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: dismissKeyboard == true
            ? ScrollViewKeyboardDismissBehavior.onDrag
            : ScrollViewKeyboardDismissBehavior.manual,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
