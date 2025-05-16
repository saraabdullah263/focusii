import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/forget_reset_password_state.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/password_cubit.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';
import 'package:go_router/go_router.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = CacheHelper.getData(key: 'email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PasswordCubit, PasswordState>(
        listener: (context, state) {
          if (state is PasswordSuccess) {
            GoRouter.of(context).push(AppRoutes.klogin);
          } else if (state is PasswordFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo
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
                    const SizedBox(height: 30),

                    /// Email
                    const Text(
                      'Enter Email:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Customtextform(
                      hintText: 'Please enter your Email',
                      myController: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    /// New Password
                    const Text(
                      'New Password:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Customtextform(
                      hintText: 'Enter new password',
                      myController: passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                      keyboardType: TextInputType.visiblePassword,
                      password: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Confirm Password
                    const Text(
                      'Confirm Password:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Customtextform(
                      hintText: 'Confirm password',
                      myController: confirmPasswordController,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                      keyboardType: TextInputType.visiblePassword,
                      password: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    /// Submit Button
                    CustomElvatedButton(
                      title:
                          state is PasswordLoading ? 'Updating...' : 'Update',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          context.read<PasswordCubit>().resetPassword(
                            email: emailController.text,
                            newPassword: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            //token: token,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
