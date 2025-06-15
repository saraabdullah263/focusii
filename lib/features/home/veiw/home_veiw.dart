import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:go_router/go_router.dart';

class HomeVeiw extends StatelessWidget {
  const HomeVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.logoWhite),
            SizedBox(height: MediaQuery.of(context).size.height * .06),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.07),
              child: Text(
                'Welcome to\nyour activites 🤝',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            Center(
              child: Text(
                'please select any activity',
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.07,vertical: MediaQuery.of(context).size.height*.03),
              child: Column(
                children: [
                  CustomElvatedButton(title: 'Videos', onPressed: () {}),
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  CustomElvatedButton(title: 'Games', onPressed: () {}),
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  CustomElvatedButton(title: 'Stories', onPressed: () {
                      GoRouter.of(context).go(AppRoutes.kstoriesVeiw);
                  }),
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  CustomElvatedButton(title: 'Advice', onPressed: () {
                     GoRouter.of(context).go(AppRoutes.kadvicesVeiw);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
