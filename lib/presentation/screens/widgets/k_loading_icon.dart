import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sozashop_app/core/core.dart';

class KLoadingIcon extends StatelessWidget {
  const KLoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: KColors.primary,
      size: 30.w,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
