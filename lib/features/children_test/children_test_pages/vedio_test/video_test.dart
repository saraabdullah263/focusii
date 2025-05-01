import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:go_router/go_router.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({super.key});

  @override
  State<VideoTest> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
   bool isCameraOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Open Camera",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: isCameraOn,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          isCameraOn = value;
                        });
                      },
                    ),
                  ],
                               ),
               ),
               SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
               Center(child: Image.asset('assets/images/testgame.png')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: CustomElvatedButton(title: 'Submit',onPressed: () {
                   GoRouter.of(context).push(AppRoutes.kqestionTest);
                 },),
               )
        ]
       )
    );
  }
}