import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sozashop_app/core/core.dart';

class KPageRefreshDemo extends StatelessWidget {
  final Widget child;
  final VoidCallback? onLoadMore;
  const KPageRefreshDemo({
    Key? key,
    required this.child,
    this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = 120.h;
    return CustomRefreshIndicator(
      onRefresh: () async => (onLoadMore != null ? onLoadMore!() : null),
      reversed: true,
      trailingScrollIndicatorVisible: false,
      leadingScrollIndicatorVisible: true,
      child: child,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final dy = controller.value.clamp(0.0, 1.25) *
                  -(height - (height * 0.25));
              return Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0.0, dy),
                    child: child,
                  ),
                  Positioned(
                    bottom: -height,
                    left: 0,
                    right: 0,
                    height: height,
                    child: onLoadMore != null
                        ? Container(
                            transform: Matrix4.translationValues(0.0, dy, 0.0),
                            padding: const EdgeInsets.only(top: 30.0),
                            constraints: const BoxConstraints.expand(),
                            child: Column(
                              children: [
                                if (controller.isLoading)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    width: 16.w,
                                    height: 16.h,
                                    child: const CircularProgressIndicator(
                                      color: KColors.primary,
                                      strokeWidth: 2,
                                    ),
                                  )
                                else
                                  const Icon(
                                    Icons.keyboard_arrow_up,
                                    color: KColors.primary,
                                  ),
                                Text(
                                  controller.isLoading
                                      ? "Fetching..."
                                      : "LOAD MORE",
                                  style: const TextStyle(
                                    color: KColors.primary,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              );
            });
      },
    );
  }
}

class SimpleIndicatorContent extends StatelessWidget {
  const SimpleIndicatorContent({
    Key? key,
    required this.controller,
    this.indicatorSize = _defaultIndicatorSize,
  })  : assert(indicatorSize > 0),
        super(key: key);

  final IndicatorController controller;
  static const _defaultIndicatorSize = 40.0;
  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: indicatorSize,
      width: indicatorSize,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 5, color: Color(0x42000000))],
      ),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              child: const Icon(
                Icons.refresh,
                color: Colors.blueAccent,
                size: 30,
              ),
              builder: (context, child) => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
