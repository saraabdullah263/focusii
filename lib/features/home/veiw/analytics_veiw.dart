import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';

class AnalyticsVeiw extends StatelessWidget {
  const AnalyticsVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
Expanded(child: Image.asset('assets/images/photo_2025-06-08_22-06-38.jpg'))
      ],),
    );
  }
}