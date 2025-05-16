import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';

class CustomButtonNavBarEntity {
  final String activeImage, inActiveImage;
  final String Function(BuildContext)
      name; 

  CustomButtonNavBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.name,
  });
}
  List<CustomButtonNavBarEntity> buttonNavigationBarEntityList = [
  CustomButtonNavBarEntity(
    name: (context) => 'Home', // Use localized text
    activeImage: AppImages.homeActive,
    inActiveImage: AppImages.homeInactive,
  ),
  CustomButtonNavBarEntity(
    name: (context) => 'Task manager',
    activeImage:AppImages.taskmangerActive,
    inActiveImage: AppImages.taskmangerInactive,
  ),
  CustomButtonNavBarEntity(
    name: (context) => 'Analytics',
    activeImage: AppImages.analyticsActive,
    inActiveImage: AppImages.analyticsInactive,
  ),
  CustomButtonNavBarEntity(
    name: (context) => 'Profile',
    activeImage: AppImages.personActive,
    inActiveImage: AppImages.personInactive,
  ),
];
