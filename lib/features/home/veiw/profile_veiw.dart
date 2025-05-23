import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
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

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      // TODO: Add upload logic using Dio or your ApiService here
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AppImages.logoWhite),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout, size: 35, color: Colors.white),
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
                      // Profile photo inside white frame
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 60,
                        backgroundImage:
                            _image != null
                                ? FileImage(_image!)
                                : const AssetImage(
                                  "assets/images/a-person-icon-on-a-transparent-background-png.webp",
                                ),
                      ),

                      SizedBox(height: height * 0.02),

                      CustomButton(title: 'Upload Photo', onPressed:_pickImage),

                      SizedBox(height: height * 0.02),

                      BuildInfoRow(label: 'Name: ', value: 'Sara abdullah'),
                      BuildInfoRow(label: 'Email: ', value: 'sara@gmail.com'),
                      BuildInfoRow(label: 'Age: ', value: '7 years'),
                      BuildInfoRow(label: 'Gender: ', value: 'Female'),
                      BuildInfoRow(
                        label: 'Account Created: ',
                        value: 'April 30, 2025',
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
                          CustomButton(title: 'Edit Profile', onPressed: () {}),
                          CustomButton(title: 'FeedBack', onPressed: () =>GoRouter.of(context).push(AppRoutes.kfeedbackVeiw)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
