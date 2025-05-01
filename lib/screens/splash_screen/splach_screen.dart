import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:go_router/go_router.dart';


class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      GoRouter.of(context).pushReplacement(AppRoutes.klogin);
    });
    return Scaffold(
      //backgroundColor: Colors.white,
       body: Center(
         child: Image.asset(
           AppImages.splachIcon
         ),
       )
        
    );
  }
}
