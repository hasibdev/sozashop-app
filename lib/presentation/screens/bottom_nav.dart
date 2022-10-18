import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sozashop_app/data/repositories/profile_repository.dart';
import 'package:sozashop_app/presentation/screens/dashboard_screen/dashboard_screen.dart';
import 'package:sozashop_app/presentation/screens/last_demo_screen.dart';
import 'package:sozashop_app/presentation/screens/notification_screen.dart';

import '../../logic/bloc/profile_bloc/profile_bloc.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    var screens = [
      const DashboardScreen(),
      // BlocProvider.value(
      //   value: BlocProvider.of<SaleBloc>(context),
      //   //! check this later
      //   // ..add(FetchSales()),
      //   child: const SaleBlocLogic(),
      // ),
      const NotificationScreen(),
      const SizedBox.shrink(),
      const NotificationScreen(),
      const LastDemoScreen(),
    ];

    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
    return Scaffold(
      extendBody: true,
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10.r,
              spreadRadius: 5.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: BottomNavigationBar(
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xff333547),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            enableFeedback: false,
            selectedLabelStyle: const TextStyle(fontSize: 0),
            unselectedLabelStyle: const TextStyle(fontSize: 0),
            selectedItemColor: const Color(0xffb4c9de),
            unselectedItemColor: const Color(0xffb4c9de).withOpacity(.4),
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_outlined),
                activeIcon: Icon(Icons.receipt_rounded),
                label: 'Sales',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                activeIcon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded),
                activeIcon: Icon(Icons.notifications_rounded),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              ProfileRepository repository = ProfileRepository();

              // repository.getConfig();
              var items = repository.getConfigEnums(type: EnumType.accountType);
              print(items);

              // getActiveStatus(type: EnumType.activeStatus);

              if (state is ProfileFetched) {}
            },
            child: Icon(
              Icons.add_rounded,
              size: 30.h,
            ),
          );
        },
      ),
    );
  }
}
