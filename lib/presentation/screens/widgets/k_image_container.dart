import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

class KImageContainer extends StatelessWidget {
  final Widget? image;
  final double? width;

  const KImageContainer({
    Key? key,
    this.image,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        // height: 80,
        width: width ?? double.infinity,
        child: AspectRatio(
          aspectRatio: 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: image ??
                Icon(
                  Icons.no_photography_outlined,
                  color: Colors.grey.shade400,
                  size: 25.w,
                ),
          ),
        ),
      ),
    );
  }
}
