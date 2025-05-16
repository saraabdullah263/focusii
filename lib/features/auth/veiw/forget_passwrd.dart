import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/forget_reset_password_state.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/password_cubit.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';
import 'package:go_router/go_router.dart';


class ForgetPasswrd extends StatefulWidget {
  const ForgetPasswrd({super.key});

  @override
  State<ForgetPasswrd> createState() => _ForgetPasswrdState();
}

class _ForgetPasswrdState extends State<ForgetPasswrd> {
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PasswordCubit, PasswordState>(
        listener: (context, state) {
          if (state is PasswordSuccess) {
            GoRouter.of(context).push(AppRoutes.kresetPassword);
          } else if (state is PasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.containerlogo,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Image(
                        image: AssetImage(AppImages.primaryIcon),
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Please Enter Your Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Customtextform(
                    hintText: 'Enter Your Email',
                    myController: email,
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  CustomElvatedButton(
                    title: state is PasswordLoading ? 'Sending...' : 'Submit',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<PasswordCubit>().forgetPassword(email.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
