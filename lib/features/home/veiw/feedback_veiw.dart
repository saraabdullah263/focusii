import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/features/home/widget/custom_button.dart';
import 'package:focusi/features/home/widget/custom_group.dart';
import 'package:focusi/features/home/widget/custom_rating_widget.dart';
import 'package:focusi/features/home/widget/custom_text_faild.dart';

class FeedbackVeiw extends StatefulWidget {
  const FeedbackVeiw({super.key});

  @override
  State<FeedbackVeiw> createState() => _FeedbackVeiwState();
}

class _FeedbackVeiwState extends State<FeedbackVeiw> {
  String selectedOption = 'Yes';
  List<String> dropdownItems = ['Games', 'Vedios', 'Stories', 'Advices'];
  String? selectedItem;
   TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*.04),
            child: Text(
              "We'd love your feedback to help us improve the platform",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsets.all(height * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomRatingWidget(
                        title:
                            "1- To what extent did the program help you to understand your child's behavior? ",
                        initialRating: 3.5,
                        onRatingChanged: (value) {},
                      ),
                      CustomRatingWidget(
                        title:
                            "2- Were the activities suitable for child's age? ",
                        initialRating: 3.5,
                        onRatingChanged: (value) {},
                      ),
                      CustomRatingWidget(
                        title:
                            "3- Was the contant clear and easy to understand? ",
                        initialRating: 3.5,
                        onRatingChanged: (value) {},
                      ),
                      CustomGroup(
                        title:
                            "4- Did you notic any improvement in your child's attention or behavior? ",
                        options: ["Yes", "No", "NOT Sure"],
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      CustomGroup(
                        title:
                            "5- Would you like to continue using this program? ",
                        options: ["Yes", "No", "NOT Sure"],
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      CustomGroup(
                        title:
                            "6- Would you recommended this program to other parents? ",
                        options: ["Yes", "No"],
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                      Text(
                        "7- Which part of the program did you find most help? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                          value: selectedItem,
                          hint: Text("Select an item"),
                          items:
                              dropdownItems.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItem = newValue!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "8- Did any have any suggestions to improve the program? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextfaild(controller: controller,maxLines: 3,),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02),
                    CustomButton(title: 'Submit',onPressed: () {
                      
                    },)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
