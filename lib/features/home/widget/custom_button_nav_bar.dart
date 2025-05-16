import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focusi/core/helper_function.dart/is_device_in_portrait.dart';
import 'package:focusi/features/home/widget/custom_bitton_nav_bar_item.dart';
import 'package:focusi/features/home/widget/custom_button_nav_bar_entity.dart';

// ignore: must_be_immutable
class CustomButtonNavBar extends StatefulWidget {
  int selectedIndex = 0;
 final ValueChanged<int> onItemTapped;
   CustomButtonNavBar({super.key,this.selectedIndex = 0, required this.onItemTapped});

  @override
  State<CustomButtonNavBar> createState() => _CustomButtonNavBarState();
}

class _CustomButtonNavBarState extends State<CustomButtonNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: isDeviceInPortrait(context) ? 70.h : 120.h,
        decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            shadows: [
              BoxShadow(
                color: Color(0x19000000),
                offset: Offset(0, -2),
                blurRadius: 25,
                spreadRadius: 0,
              )
            ]),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttonNavigationBarEntityList.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onItemTapped(index);
                  });
                },
                child: CustomBittonNavBarItem(
                  isSelected: widget.selectedIndex == index,
                  barEntity: item,
                ));
          }).toList(),
        ));
  }
  }
