import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/features/home/date/model/feedback_model.dart';
import 'package:focusi/features/home/model_veiw/feedback_cubit/feedback_cubit.dart';
import 'package:focusi/features/home/model_veiw/feedback_cubit/feedback_state.dart';
import 'package:focusi/features/home/widget/custom_button.dart';
import 'package:focusi/features/home/widget/custom_group.dart';
import 'package:focusi/features/home/widget/custom_rating_widget.dart';
import 'package:focusi/features/home/widget/custom_text_faild.dart';
import 'package:go_router/go_router.dart';

class FeedbackVeiw extends StatefulWidget {
  const FeedbackVeiw({super.key});

  @override
  State<FeedbackVeiw> createState() => _FeedbackVeiwState();
}

class _FeedbackVeiwState extends State<FeedbackVeiw> {
  String questionFourAnswer = 'Yes';
  String questionFiveAnswer = 'Yes';
  String questionSixAnswer = 'Yes';

  List<String> dropdownItems = ['Games', 'Vedios', 'Stories', 'Advices'];
  String? questionSevenAnswer;

  TextEditingController controller = TextEditingController();

  double q1 = 0;
  double q2 = 0;
  double q3 = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<FeedbackCubit, FeedbackState>(
      listener: (context, state) {
        if (state is FeedbackSuccess) {
          Fluttertoast.showToast(
            msg: "Feedback sent successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: AppColors.primaryColor,
            fontSize: 16.0,
          );
          GoRouter.of(context).push(AppRoutes.kmainVeiw);
        } else if (state is FeedbackFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.logoWhite),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                ),
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
                            initialRating: q1,
                            onRatingChanged: (value) {
                              q1 = value;
                            },
                          ),
                          CustomRatingWidget(
                            title:
                                "2- Were the activities suitable for child's age? ",
                            initialRating: q2,
                            onRatingChanged: (value) {
                              q2 = value;
                            },
                          ),
                          CustomRatingWidget(
                            title:
                                "3- Was the content clear and easy to understand? ",
                            initialRating: q3,
                            onRatingChanged: (value) {
                              q3 = value;
                            },
                          ),
                          CustomGroup(
                            title:
                                "4- Did you notice any improvement in your child's attention or behavior?",
                            options: ["Yes", "No", "NOT Sure"],
                            groupValue: questionFourAnswer,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  questionFourAnswer = newValue;
                                });
                              }
                            },
                          ),
                          CustomGroup(
                            title:
                                "5- Would you like to continue using this program?",
                            options: ["Yes", "No", "NOT Sure"],
                            groupValue: questionFiveAnswer,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  questionFiveAnswer = newValue;
                                });
                              }
                            },
                          ),
                          CustomGroup(
                            title:
                                "6- Would you recommend this program to other parents?",
                            options: ["Yes", "No"],
                            groupValue: questionSixAnswer,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  questionSixAnswer = newValue;
                                });
                              }
                            },
                          ),
                          Text(
                            "7- Which part of the program did you find most helpful?",
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
                              value: dropdownItems.contains(questionSevenAnswer)
                                  ? questionSevenAnswer
                                  : null,
                              hint: Text("Select an item"),
                              items: dropdownItems.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  questionSevenAnswer = newValue!;
                                });
                              },
                            ),
                          ),
                          Text(
                            "8- Do you have any suggestions to improve the program?",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomTextfaild(
                              controller: controller,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: height * .02),
                          CustomButton(
                            title: state is FeedbackLoading
                                ? 'Submitting...'
                                : 'Submit',
                            onPressed: state is FeedbackLoading
                                ? null
                                : () {
                                    final token = CacheHelper.getData(
                                      key: 'userToken',
                                    );

                                    if (token == null) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "User not logged in or token missing.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.white,
                                        textColor: AppColors.primaryColor,
                                        fontSize: 16.0,
                                      );
                                      return;
                                    }

                                    final model = FeedbackModel(
                                      q1Answer: q1.toInt(),
                                      q2Answer: q2.toInt(),
                                      q3Answer: q3.toInt(),
                                      q4Answer: questionFourAnswer,
                                      q5Answer: questionFiveAnswer,
                                      q6Answer: questionSixAnswer,
                                      q7Answer: questionSevenAnswer ?? '',
                                      suggestions: controller.text.trim(),
                                    );

                                    context
                                        .read<FeedbackCubit>()
                                        .sendFeedback(model, token);
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
