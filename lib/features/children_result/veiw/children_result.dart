import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';


class ChildrenResult extends StatelessWidget {
  const ChildrenResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              AppImages.logoWhite,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               SizedBox(height:MediaQuery.of(context).size.height*.03 ,),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '20',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.03 ,),
                
                const Text(
                  "Your Score",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                 SizedBox(height:MediaQuery.of(context).size.height*.03 ,),
                const Text(
                  "your class is c",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.07 ,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.1),
                  child: CustomElvatedButton(title: 'Go To Class -->',onPressed: () {
                    
                  },),
                )
              
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
