import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/features/home/model_veiw/log_out_cubit/logout_cubit.dart';
import 'package:focusi/features/home/model_veiw/log_out_cubit/logout_state.dart';
import 'package:focusi/features/home/model_veiw/upload_picture_cubit/upload_picture_cubit.dart';
import 'package:focusi/features/home/model_veiw/upload_picture_cubit/upload_picture_state.dart';
import 'package:focusi/features/home/model_veiw/user_cubit/user_cubit.dart';
import 'package:focusi/features/home/model_veiw/user_cubit/user_state.dart';
import 'package:focusi/features/home/widget/build_info_row.dart';
import 'package:focusi/features/home/widget/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileVeiw extends StatefulWidget {
  const ProfileVeiw({super.key});

  @override
  State<ProfileVeiw> createState() => _ProfileVeiwState();
}

class _ProfileVeiwState extends State<ProfileVeiw> {
  File? _image;
  bool _hasFetchedUser = false;
  

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final token = CacheHelper.getData(key: 'userToken');
      if (_image != null) {
        context.read<UploadPictureCubit>().uploadPicture(token, _image!);
      }
    }
  }

  @override
void initState() {
  super.initState();

  if (!_hasFetchedUser) {
    final token = CacheHelper.getData(key: 'userToken');
    debugPrint("🔐 Retrieved Token: $token");

    if (token != null && token is String && token.isNotEmpty) {
      // نحط النداء جوه post frame، لكن نمنع التكرار هنا
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserCubit>().fetchCurrentUser(token);
      });

      _hasFetchedUser = true;
    } else {
      debugPrint('❌ Token is null or empty');
    }
  }
}


 @override
Widget build(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  

  return Scaffold(
    body: BlocConsumer<UploadPictureCubit, UploadPictureState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
           Fluttertoast.showToast(
            msg: "Profile picture uploaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor:Colors.white,
            textColor: AppColors.primaryColor,
            fontSize: 16.0,
          );
          // Optionally refresh user data here if needed
        } else if (state is UploadPictureFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${state.error}')),
          );
        }
      },
      builder: (context, uploadState) {
        return BlocConsumer<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              CacheHelper.removeData(key: 'userToken'); // Clear stored token on logout
              GoRouter.of(context).go(AppRoutes.klogin); // Navigate to login page
            } else if (state is LogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout failed: ${state.error}')),
              );
            }
          },
          builder: (context, logoutState) {
            return BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is UserLoaded) {
                  final user = state.user;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AppImages.logoWhite),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                final token = CacheHelper.getData(key: 'userToken');
                                if (token != null &&
                                    token is String &&
                                    token.isNotEmpty) {
                                  context.read<LogoutCubit>().logoutUser(token);
                                } else {
                                  debugPrint('Logout failed: no token found');
                                }
                              },
                              child: const Icon(
                                Icons.logout,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: EdgeInsets.all(height * 0.02),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 60,
                                    backgroundImage:
                                        _image != null
                                            ? FileImage(_image!)
                                            : NetworkImage(user.pictureUrl ?? '')
                                                as ImageProvider,
                                  ),

                                  SizedBox(height: height * 0.02),

                                  CustomButton(
                                    title: 'Upload Photo',
                                    onPressed: _pickImage,
                                  ),

                                  SizedBox(height: height * 0.02),

                                  BuildInfoRow(
                                    label: 'Name: ',
                                    value: user.name ?? '',
                                  ),
                                  BuildInfoRow(
                                    label: 'Age: ',
                                    value: '${user.age} years',
                                  ),
                                  BuildInfoRow(
                                    label: 'Gender: ',
                                    value: user.gender ?? '',
                                  ),
                                  BuildInfoRow(
                                    label: 'Account Created: ',
                                    value: user.dateOfCreation != null
                                        ? user.dateOfCreation!
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0]
                                        : 'Unknown',
                                  ),
                                  BuildInfoRow(
                                    label: 'Assigned Class: ',
                                    value: 'Not assigned yet',
                                  ),
                                  BuildInfoRow(label: 'Current Score: ', value: '0%'),

                                  SizedBox(height: height * 0.03),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton(
                                        title: 'Edit Profile',
                                        onPressed: () {},
                                      ),
                                      CustomButton(
                                        title: 'FeedBack',
                                        onPressed: () =>
                                            GoRouter.of(context).push(AppRoutes.kfeedbackVeiw),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const Center(child: Text('No user data'));
              },
            );
          },
        );
      },
    ),
  );
}

  }

