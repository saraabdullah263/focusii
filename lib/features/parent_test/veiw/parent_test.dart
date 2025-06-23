import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_loading.dart';
import 'package:focusi/core/widget/custom_radio_group.dart';
import 'package:focusi/features/provider/parent_test_provider.dart';
import 'package:focusi/features/parent_test/model_veiw/parent_test_state.dart';
import 'package:focusi/features/parent_test/model_veiw/parent_test_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ParentTest extends StatefulWidget {
  const ParentTest({super.key});

  @override
  State<ParentTest> createState() => _ParentTestState();
}

class _ParentTestState extends State<ParentTest> {
  @override
  void initState() {
    super.initState();
    Provider.of<ParentTestProvider>(context, listen: false).loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final testQuestions = Provider.of<ParentTestProvider>(context);

    return Scaffold(
      body: testQuestions.questions.isEmpty
          ? const CustomLoading()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AppImages.logoWhite),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new),
                                  onPressed: testQuestions.previousQuestion,
                                ),
                                Text(
                                  '${testQuestions.currentIndex + 1}/${testQuestions.questions.length}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .02,
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      height: 10,
                                      width: constraints.maxWidth *
                                          (testQuestions.currentIndex + 1) /
                                          testQuestions.questions.length,
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
                              height:
                                  MediaQuery.of(context).size.height * .02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(0xffD1D1D1)),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      testQuestions.questions[
                                          testQuestions.currentIndex]['question'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CustomRadioGroup(
                                    options: List<String>.from(testQuestions
                                            .questions[testQuestions.currentIndex]
                                        ['options']),
                                    selectedValue:
                                        testQuestions.getSelectedAnswer(
                                            testQuestions.currentIndex),
                                    onChanged: (value) {
                                      testQuestions.setSelectedAnswer(
                                          testQuestions.currentIndex, value!);
                                    },
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .1,
                            ),
                            // Here is the BlocConsumer wrapping your submit button
                            BlocConsumer<ParentTestCubit, ParentTestState>(
                              listener: (context, state) {
                                if (state is ParentTestSuccess) {
                                  // On success, navigate
                                  GoRouter.of(context).pushReplacement(AppRoutes.kchildTest);
                                } else if (state is ParentTestFailure) {
                                  // Show error snackbar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                final isLoading = state is ParentTestLoading;

                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: testQuestions.currentIndex ==
                                            testQuestions.questions.length - 1
                                        ? Colors.green
                                        : Colors.grey[800],
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (testQuestions.getSelectedAnswer(testQuestions.currentIndex) == null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Please select an answer!'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          if (testQuestions.currentIndex ==
                                              testQuestions.questions.length - 1) {
                                            // Prepare List<int> answers (non-null)
                                            final answers = testQuestions.selectedAnswers
                                                .map((e) => e ?? 1) // fallback 1 if null
                                                .toList();

                                            final token = CacheHelper.getData(key: 'userToken'); 
                                            print('Sending token: $token');

                                            // Submit answers with cubit
                                            context.read<ParentTestCubit>().submitAnswers(
                                                  token: token,
                                                  answers: answers,
                                                );
                                          } else {
                                            // Move to next question
                                            testQuestions.clearAnswer(testQuestions.currentIndex + 1);
                                            testQuestions.nextQuestion();
                                          }
                                        },
                                        
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          testQuestions.currentIndex ==
                                                  testQuestions.questions.length - 1
                                              ? "Done"
                                              : "Next →",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
