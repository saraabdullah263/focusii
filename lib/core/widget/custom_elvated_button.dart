import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';


class CustomElvatedButton extends StatelessWidget {
  final  void Function()? onPressed;
  final String title;
  const CustomElvatedButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
            backgroundColor: Colors.white,
           
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: onPressed,
        child:  Center(
          child: Text(
                    title,
                    style:const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor),
                  ),
        ));
  }
}
