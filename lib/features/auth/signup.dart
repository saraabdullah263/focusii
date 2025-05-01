import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';
import 'package:go_router/go_router.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController childAge = TextEditingController();
  DateTime? selectedDate;
  String? childAgeText;

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
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
                        borderRadius: BorderRadius.circular(50)),
                    child: const Image(
                      image: AssetImage(AppImages.primaryIcon),
                      height: 70,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                const Text('Child name:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                Customtextform(
                  hintText: "Enter Child's name",
                  myController: username,
                  prefixIcon: const Icon(Icons.person),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text('Child age:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                GestureDetector(
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now()
                          .subtract(const Duration(days: 365 * 5)),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                        final now = DateTime.now();
                        int age = now.year - picked.year;
                        if (now.month < picked.month ||
                            (now.month == picked.month &&
                                now.day < picked.day)) {
                          age--;
                        }
                        childAgeText = "$age years";
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                        const Icon(Icons.calendar_month, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text('Child gender:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  value: selectedGender,
                  hint: const Text("Select Gender"),
                  items: ['Male', 'Female']
                      .map((gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text('Email:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                Customtextform(
                  hintText: 'Enter Your Email',
                  myController: email,
                  prefixIcon: const Icon(Icons.email),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text('Password:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                Customtextform(
                  hintText: 'Enter password',
                  myController: password,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  keyboardType: TextInputType.visiblePassword,
                  password: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                const Text('Confirm Password:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
                Customtextform(
                  hintText: 'Confirm password',
                  myController: confirmpassword,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  keyboardType: TextInputType.visiblePassword,
                  password: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                ),
                CustomElvatedButton(
                  title: 'Sign Up',
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).push(AppRoutes.klogin);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
