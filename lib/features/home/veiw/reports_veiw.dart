import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';

class ReportsVeiw extends StatelessWidget {
  const ReportsVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          Center(
            child: Text(
              'Anayzing your child activites : ',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              child: 
               
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text('''Total time spent: 155 minutes\nMost time spent on: Stories (60 minutes) ''',style: TextStyle(color: AppColors.primaryColor,fontSize: 18),),
                            Icon(Icons.keyboard_arrow_down,size: 30,color:Colors.black ,)
                          ],
                        ),
                      Text('6/16/2025',style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),)
                      ],
                    ),
                  ),
            
                
            ),
          ),
        ],
      ),
    );
  }
}
