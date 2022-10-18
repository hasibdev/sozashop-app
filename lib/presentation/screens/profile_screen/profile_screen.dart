import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sozashop_app/core/constants/constants.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_button.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_image_picker_wrapper.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_page_middle.dart';
import 'package:sozashop_app/presentation/screens/widgets/k_text_field.dart';

import '../../../data/models/profile_model.dart';
import '../../../logic/bloc/profile_bloc/profile_bloc.dart';
import '../widgets/k_loading_icon.dart';
import '../widgets/k_page_buttons_row.dart';
import '../widgets/k_snackbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileModel? profile;

  String? clientId = "...";

  var photo;

  File? selectedPhoto;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController industryController = TextEditingController();

  Future<String?> getImgUrl() async {
    try {
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(photo)).load(photo))
          .buffer
          .asUint8List();
      print("The image exists!");
      return photo as String;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  ImageProvider getImage() {
    if (selectedPhoto != null) {
      return FileImage(selectedPhoto!);
    }
    if (selectedPhoto == null && photo != null) {
      print('photo: $photo');

      return NetworkImage(photo);
    } else {
      return const AssetImage('assets/images/no_user.jpg');
    }
  }

  getImageWidget() {
    if (selectedPhoto != null) {
      return Image.file(
        selectedPhoto!,
        fit: BoxFit.fitWidth,
        height: 110.h,
        width: 110.w,
      );
    }
    if (selectedPhoto == null && photo != null) {
      return FutureBuilder(
          future: getImgUrl(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(
                snapshot.data as String,
                fit: BoxFit.fitWidth,
                height: 110.h,
                width: 110.w,
              );
            } else {
              return Image.asset(
                'assets/images/no_user.jpg',
                fit: BoxFit.fitWidth,
                height: 110.h,
                width: 110.w,
              );
            }
          });
    } else {
      return Image.asset(
        'assets/images/no_user.jpg',
        fit: BoxFit.fitWidth,
        height: 110.h,
        width: 110.w,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text($t('profile.label')),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdatedState) {
            KSnackBar(
              context: context,
              type: AlertType.success,
              message: "Profile Updated Successfully!",
            );
          }

          if (state is ProfileUpdatingFailed) {
            var errorsAsList = state.error.errorsToString();
            KSnackBar(
              context: context,
              type: AlertType.failed,
              message: errorsAsList,
              durationSeconds: 4,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: KLoadingIcon(),
            );
          }
          if (state is ProfileFetched) {
            profile = state.profile;
            if (profile != null) {
              clientId = profile?.clientId.toString();
              photo = profile?.profilePhotoUrl;
              firstNameController.text = profile!.firstName;
              lastNameController.text = profile!.lastName;
              emailController.text = profile!.email;
              countryController.text = profile!.client!.countryName;
              industryController.text = profile!.client!.industryName;
            } else {
              firstNameController.text = '...';
            }
            getImage();
          }
          return Form(
            key: _formKey,
            child: KPage(
              children: [
                KPageMiddle(
                  xPadding: kPaddingX,
                  yPadding: kPaddingY,
                  children: [
                    // image widget
                    SizedBox(
                      height: 110.h,
                      width: 110.w,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: CircleAvatar(
                              child: ClipOval(
                                child: getImageWidget(),
                              ),
                            ),
                            // child: CircleAvatar(
                            //   onBackgroundImageError: (exception, stackTrace) {

                            //   },
                            //   backgroundImage: getImage(),
                            //   backgroundColor: Colors.grey.shade200,
                            // ),
                          ),
                          Positioned(
                            right: -16.w,
                            bottom: 0,
                            child: KImagePickerWrapper(
                              context: context,
                              wrapperHeight: 45.h,
                              wrapperWidth: 45.w,
                              wrapperChild: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(13.w),
                                  child: SvgPicture.asset(
                                      "assets/svgs/camera-icon.svg"),
                                ),
                              ),
                              selectedImage: selectedPhoto,
                              onImageSelect: (value) {
                                setState(() {
                                  selectedPhoto = value;
                                  getImageWidget();
                                  getImage();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      '$clientId',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: KColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    // fields

                    KTextField(
                      labelText: $t('fields.firstName'),
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'First Name is required!';
                        }
                        return null;
                      },
                    ),
                    KTextField(
                      labelText: $t('fields.lastName'),
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Last Name is required!';
                        }
                        return null;
                      },
                    ),
                    KTextField(
                      labelText: $t('fields.email'),
                      controller: emailController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Email is required!';
                        }
                        return null;
                      },
                    ),
                    KTextField(
                      labelText: $t('fields.country'),
                      controller: countryController,
                      isDisabled: true,
                    ),
                    KTextField(
                      labelText: $t('fields.industry'),
                      controller: industryController,
                      isDisabled: true,
                      hasMargin: false,
                    ),
                  ],
                ),
                KPageButtonsRow(
                  marginTop: 15.h,
                  buttons: [
                    Expanded(
                      child: KFilledButton(
                        text: $t("buttons.submit"),
                        onPressed: () {
                          var isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(UpdateProfile(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              countryName: countryController.text,
                              industryName: industryController.text,
                              photo: selectedPhoto,
                            ));
                          } else {
                            KSnackBar(
                              context: context,
                              type: AlertType.failed,
                              message: 'Please add all the required fields!',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
