import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focusi/core/helper_function.dart/is_device_in_portrait.dart';
import 'package:flutter_svg/svg.dart';

class InactiveButton extends StatelessWidget {
  final String image;
  const InactiveButton({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
     return SvgPicture.asset(
      image,
      height: isDeviceInPortrait(context) ? 25.h : 65.h,
      width: 25.w,
    );
  }
}