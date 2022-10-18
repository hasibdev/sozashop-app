import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozashop_app/data/models/models_barrel.dart';
import 'package:sozashop_app/logic/user_details.dart';
import 'package:sozashop_app/presentation/router/app_router.dart';

import '../../../core/core.dart';
import '../../../logic/bloc/login_bloc/login_bloc.dart';
import '../../../logic/bloc/profile_bloc/profile_bloc.dart';

enum MenuItem { item1, item2, item3 }

class KAppbarAvatar extends StatefulWidget {
  const KAppbarAvatar({Key? key}) : super(key: key);

  @override
  State<KAppbarAvatar> createState() => _KAppbarAvatarState();
}

class _KAppbarAvatarState extends State<KAppbarAvatar> {
  String demoImage = 'assets/images/no_user.jpg';

  ProfileModel? user = UserDetails.user;

  var userProfile;

  ImageProvider getImage() {
    if (userProfile == null) {
      return AssetImage(demoImage);
    } else if ((userProfile?.profilePhotoUrl.isNotEmpty)) {
      return NetworkImage(
        userProfile?.profilePhotoUrl,
        scale: 1.0,
      );
    } else {
      return AssetImage(demoImage);
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 3,
      onSelected: (value) {
        if (value == MenuItem.item1) {}
        if (value == MenuItem.item2) {}
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: itemBuilder(
              title: 'Profile',
              icon: Icons.account_circle,
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
                Navigator.popAndPushNamed(context, AppRouter.profileScreen);
              },
            ),
            value: MenuItem.item1,
          ),
          PopupMenuItem(
            child: itemBuilder(
              title: 'Logout',
              icon: Icons.lock_open_rounded,
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoggingOut());
                Navigator.popAndPushNamed(context, AppRouter.home);
              },
            ),
            value: MenuItem.item2,
          )
        ];
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFetched) {
            userProfile = state.profile;
          }
          return SizedBox(
            height: 28.h,
            width: 28.w,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CircleAvatar(
                backgroundColor: KColors.primary.shade100,
                backgroundImage: getImage(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class itemBuilder extends StatelessWidget {
  String title;
  IconData icon;
  Function()? onPressed;
  itemBuilder({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      minLeadingWidth: 10,
      onTap: onPressed,
    );
  }
}
