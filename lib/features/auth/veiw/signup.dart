import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/model_veiw/sign_up_cubit/sign_up_cubit.dart';
import 'package:focusi/features/auth/model_veiw/sign_up_cubit/sign_up_state.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';
import 'package:go_router/go_router.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  DateTime? selectedDate;
  String? childAgeText;
  String? selectedGender;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool submitted = false;

  int _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^\S+@\S+\.\S+$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters';

  final hasUppercase = RegExp(r'[A-Z]');
  final hasLowercase = RegExp(r'[a-z]');
  final hasDigit = RegExp(r'\d');
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  if (!hasUppercase.hasMatch(value)) {
    return 'Password must contain at  least one\nuppercase letter';
  }
  if (!hasLowercase.hasMatch(value)) {
    return 'Password must contain at least one\nlowercase letter';
  }
  if (!hasDigit.hasMatch(value)) {
    return 'Password must contain at least\none number';
  }
  if (!hasSpecialChar.hasMatch(value)) {
    return 'Password must contain at least one special\ncharacter';
  }

  return null;
}


  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != password.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          GoRouter.of(context).push(AppRoutes.kparentTest);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: autoValidateMode,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      const Text(
                        'Child name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Customtextform(
                        hintText: "Enter Child's name",
                        myController: username,
                        prefixIcon: const Icon(Icons.person),
                        validator: _validateUsername,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Text(
                        'Child age:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().subtract(
                              const Duration(days: 365 * 5),
                            ),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                              int age = _calculateAge(picked);
                              childAgeText = "$age years";
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                childAgeText ?? "Select Child's Birthday",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (submitted && selectedDate == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Please select a birthday',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Text(
                        'Child gender:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        value: selectedGender,
                        hint: const Text("Select Gender"),
                        validator:
                            (value) =>
                                value == null ? 'Gender is required' : null,
                        items:
                            ['Male', 'Female']
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) => setState(() => selectedGender = value),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Text(
                        'Email:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Customtextform(
                        hintText: 'Enter Your Email',
                        myController: email,
                        prefixIcon: const Icon(Icons.email),
                        validator: _validateEmail,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      const Text(
                        'Password:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Customtextform(
                        hintText: 'Enter password',
                        myController: password,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        keyboardType: TextInputType.visiblePassword,
                        password: true,
                        validator: _validatePassword,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
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
                        myController: confirmpassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        keyboardType: TextInputType.visiblePassword,
                        password: true,
                        validator: _validateConfirmPassword,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      CustomElvatedButton(
                        title:
                            state is SignUpLoading ? 'Loading...' : 'Sign Up',
                        onPressed:
                            state is SignUpLoading
                                ? null
                                : () {
                                  setState(() {
                                    submitted = true;
                                    autoValidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      selectedDate != null) {
                                    final user = UserModel(
                                      name: username.text,
                                      email: email.text,
                                      password: password.text,
                                      confirmPassword: confirmpassword.text,
                                      gender: selectedGender ?? '',
                                      age: _calculateAge(selectedDate),
                                    );
                                    BlocProvider.of<SignUpCubit>(
                                      context,
                                    ).signUp(user);
                                  } 
                                },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          InkWell(
                            onTap:
                                () =>
                                    GoRouter.of(context).push(AppRoutes.klogin),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
