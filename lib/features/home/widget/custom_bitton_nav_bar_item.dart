import 'package:flutter/material.dart';
import 'package:focusi/features/home/widget/active_button.dart';
import 'package:focusi/features/home/widget/custom_button_nav_bar_entity.dart';
import 'package:focusi/features/home/widget/inactive_button.dart';

class CustomBittonNavBarItem extends StatelessWidget {
  final bool isSelected;
  final CustomButtonNavBarEntity barEntity;
  const CustomBittonNavBarItem({super.key, required this.isSelected, required this.barEntity});

  @override
  Widget build(BuildContext context) {
    return  isSelected
        ? ActiveButton(
            title: barEntity.name(context), image: barEntity.activeImage)
        : InactiveButton(image: barEntity.inActiveImage);
  }
  }
