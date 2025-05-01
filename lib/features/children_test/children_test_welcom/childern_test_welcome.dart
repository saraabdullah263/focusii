import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:go_router/go_router.dart';


class ChildernTestWelcome extends StatelessWidget {
  const ChildernTestWelcome({super.key});

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
                  'After the parent test is done,  each child must do the test to determine his/her class',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                CustomElvatedButton(
                  title: 'Go To child Test',
                 onPressed: () =>GoRouter.of(context).push(AppRoutes.kchildTest)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}