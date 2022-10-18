import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sozashop_app/core/core.dart';
import 'package:sozashop_app/data/models/profile_model.dart';
import 'package:sozashop_app/logic/bloc/profile_bloc/profile_bloc.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/main_sidebar_logic.dart';
import 'package:sozashop_app/presentation/screens/main_sidebar/widgets/sidebar_item.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_logo.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../logic/user_details.dart';
import '../widgets/k_snackbar.dart';

class MainSidebar extends StatelessWidget {
  MainSidebar({Key? key}) : super(key: key);
  ProfileModel? user = UserDetails.user;

  @override
  Widget build(BuildContext context) {
    List menuItems;

    return SafeArea(
      bottom: false,
      child: Container(
        width: 260.w,
        color: KColors.secondary,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 0.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20.h,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150.w,
                    child: const KLogo(),
                  ),
                ),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileFetched) {
                    menuItems = MainSidebarLogic().items;

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...menuItems
                                .where((element) =>
                                    !element.containsKey('children'))
                                .map((item) => SidebarItem(
                                      title: item['title'].toString(),
                                      isSubItem: false,
                                      onPressed: () =>
                                          Navigator.popAndPushNamed(
                                        context,
                                        item['href'].toString(),
                                      ),
                                      icon: item['icon'],
                                    ))
                                .toList(),
                            Stack(
                              children: [
                                Transform.translate(
                                  // offset: Offset(0, -28.h),
                                  offset: Offset(0, 0.h),
                                  child: SizedBox(
                                    child: ToggleList(
                                      scrollDirection: Axis.vertical,
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollPosition: AutoScrollPosition.end,
                                      scrollDuration:
                                          const Duration(milliseconds: 150),
                                      toggleAnimationDuration:
                                          const Duration(milliseconds: 200),
                                      trailing: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.h, horizontal: 15.w),
                                          child: const Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: KColors.grey,
                                          )),
                                      trailingExpanded: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h, horizontal: 15.w),
                                        child: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: KColors.grey,
                                        ),
                                      ),
                                      shrinkWrap: true,
                                      divider: SizedBox(height: 0.h),
                                      viewPadding: const EdgeInsets.all(0),
                                      children: [
                                        ...menuItems
                                            .where((element) =>
                                                element.containsKey('children'))
                                            .map((item) {
                                          var itemChildren =
                                              item['children'] as List<Map>;
                                          return customToggleListItem(
                                            text: item['title'].toString(),
                                            icon: item['icon'] as IconData,
                                            items: [
                                              ...itemChildren.map((child) {
                                                return SidebarItem(
                                                  title: child['title'],
                                                  onPressed: child['href'] !=
                                                          null
                                                      ? () => Navigator
                                                              .popAndPushNamed(
                                                            context,
                                                            child['href']
                                                                .toString(),
                                                          )
                                                      : () {
                                                          Navigator.pop(
                                                              context);

                                                          KSnackBar(
                                                            context: context,
                                                            type: AlertType
                                                                .notImplemented,
                                                          );
                                                        },
                                                );
                                              }),
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // empty items
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                            baseColor: KColors.secondaryDark,
                            highlightColor: KColors.secondary,
                            direction: ShimmerDirection.ltr,
                            child: ListTile(
                              minVerticalPadding: 0,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.h,
                                horizontal: 20.w,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 12.r,
                              ),
                              minLeadingWidth: 2.w,
                              title: Container(
                                height: 18.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 8.r,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ToggleListItem customToggleListItem({
    required String text,
    required IconData icon,
    List<Widget>? items,
  }) {
    return ToggleListItem(
      itemDecoration: const BoxDecoration(
        color: KColors.secondaryLight,
      ),
      headerDecoration: const BoxDecoration(
        color: KColors.secondary,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: KColors.grey,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        child: Icon(
          icon,
          color: KColors.grey,
        ),
      ),
      content: Column(
        children: items ?? [],
      ),
    );
  }
}
