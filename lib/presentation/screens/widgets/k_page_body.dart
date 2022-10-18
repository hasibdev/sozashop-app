import 'package:flutter/material.dart';

import 'package:sozashop_app/core/core.dart';

import 'k_container.dart';

class KPageBody extends StatelessWidget {
  final String? title;
  final Function()? onButtonTap;
  final List<Widget> children;
  final bool hasHeader;
  final bool hasPermission;
  final IconData? icon;
  const KPageBody({
    Key? key,
    this.title,
    this.onButtonTap,
    this.hasHeader = true,
    this.hasPermission = true,
    this.icon,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // backgroundColor: const Color(0xffF8F8FA),
        Container(
      color: const Color(0xffF8F8FA),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kPaddingX,
          vertical: kPaddingY,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hasHeader
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title ?? 'Title',
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: kPaddingX,
                      ),
                      (hasPermission == true && onButtonTap != null)
                          ? GestureDetector(
                              onTap: onButtonTap,
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: KColors.primary,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                width: 30.w,
                                child: Center(
                                  child: Icon(
                                    icon ?? Icons.list,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  )
                : const SizedBox.shrink(),
            SizedBox(height: hasHeader ? 15.h : 0),
            Expanded(
              child: KContainer(
                // height: MediaQuery.of(context).size.height,
                // bgColor: Colors.green,
                margin: 0,
                xPadding: kPaddingX,
                yPadding: kPaddingY,
                child: SingleChildScrollView(
                  primary: false,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
