import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:go_router/go_router.dart';


class QestionTest extends StatefulWidget {
  const QestionTest({super.key});

  @override
  State<QestionTest> createState() => _QestionTestState();
}

class _QestionTestState extends State<QestionTest> {
  int totalquestion = 2;
  String? selectedOption;
  final List<String> options = ["1", "2", "6", "4"];
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
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () {},
                        ),
                        Text(
                          '${totalquestion - 1}/$totalquestion',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 10,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 10,
                              width: constraints.maxWidth *
                                  (totalquestion - 1) /
                                  totalquestion,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD1D1D1)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '1- How many items appeared in this video?  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                           ...options
                        .map((option) => RadioListTile<String>(
                              title: Text(
                                option,
                                style: const TextStyle(fontSize: 18),
                              ),
                              value: option,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value;
                                });
                              },
                              activeColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                backgroundColor:  Colors.grey[800],
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            onPressed: (){GoRouter.of(context).push(AppRoutes.kchildrenResult);}, child: Text('next →',style: const TextStyle(fontSize: 20),)),
                        ),
                          SizedBox(height: 10,)

                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
