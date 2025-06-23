import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/home/model_veiw/user_cubit/user_cubit.dart';
import 'package:focusi/features/home/model_veiw/user_cubit/user_state.dart';
import 'package:go_router/go_router.dart';


class ChildrenResult extends StatelessWidget {
  const ChildrenResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFailure) {
            return Center(child: Text("❌ ${state.error}"));
          } else if (state is UserLoaded) {
            final user = state.user;
                 
            final int score = user.totalScore ?? 0;
            final String childClass = user.childClass ?? 'Unknown';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(AppImages.logoWhite),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Center(
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            "Your Score is $score",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * .03),
                          Text(
                            "Your class is $childClass",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .07),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1),
                  child: CustomElvatedButton(
                    title: 'Go To Class -->',
                    onPressed: () {
                      GoRouter.of(context).push(AppRoutes.kmainVeiw);
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("No user data available"));
        },
      ),
    );
  }
}
