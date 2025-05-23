import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusi/core/helper_function.dart/is_device_in_portrait.dart';
import 'package:focusi/core/utles/app_colors.dart';

class ActiveButton extends StatelessWidget {
   final String image, title;
  const ActiveButton({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
       padding: const EdgeInsets.symmetric(horizontal: 12),
        height: isDeviceInPortrait(context) ? 45.h : 90.h,
        decoration: ShapeDecoration(
            color: const Color(0xffEEEEEE),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Row(
          children: [
            Container(
              height: isDeviceInPortrait(context) ? 40.h : 80.h,
              width: 30.w,
              padding: const EdgeInsets.all(5),
              decoration: ShapeDecoration(
                //color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: SvgPicture.asset(
                image,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}