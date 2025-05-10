import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:go_router/go_router.dart';


class ChildTest extends StatelessWidget {
  const ChildTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                    child: Text(
                  'child will open the camera in this test and choose any option to do ',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                CustomElvatedButton(
                  title: 'Start Game',
                  onPressed: () =>GoRouter.of(context).push(AppRoutes.kgameScreen)
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                 CustomElvatedButton(
                  title: 'Start Video',
                  onPressed: () =>GoRouter.of(context).push(AppRoutes.kwebVeiwVideo)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}