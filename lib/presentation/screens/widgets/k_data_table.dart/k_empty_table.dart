import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sozashop_app/core/core.dart';

import '../k_container.dart';

class KEmptyTable extends StatelessWidget {
  const KEmptyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Stack(
        children: [
          KContainer(
            margin: 0,
            height: double.maxFinite,
            xPadding: kPaddingX,
            yPadding: kPaddingY,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 90.h,
                      // maxWidth: 80,
                    ),
                    child: SvgPicture.asset(
                      'assets/svgs/empty-list.svg',
                      height: 120.h,
                      color: Colors.grey.shade400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    $t('placeholder.noDataFound'),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView(
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
