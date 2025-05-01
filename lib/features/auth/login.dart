import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/utles/app_routes.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';
import 'package:go_router/go_router.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                const Text('Welcome\nBack !',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
                const SizedBox(
                  height: 20,
                ),
                Customtextform(
                  hintText: 'Enter Your Email',
                  myController: email,
                  prefixIcon: const Icon(Icons.person),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Customtextform(
                  hintText: 'Enter Password',
                  myController: password,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  keyboardType: TextInputType.visiblePassword,
                  password: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      onTap: () {
                        GoRouter.of(context).push(AppRoutes.kforgetPassword);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                 CustomElvatedButton(title: 'Login',onPressed: () => GoRouter.of(context).push(AppRoutes.kparentTestWelcom),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Center(
                    child: Text(
                  '- Or Login With -',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                const CircleBorder(side: BorderSide()))),
                        onPressed: () {},
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(AppImages.googleimage),
                        )),
                    OutlinedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                const CircleBorder(side: BorderSide()))),
                        onPressed: () {},
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage(AppImages.feacbookimage),
                        )),
                    OutlinedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                const CircleBorder(side: BorderSide()))),
                        onPressed: () {},
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(AppImages.logoMac),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "if you don't have account ?",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                         GoRouter.of(context).push(AppRoutes.ksignUp);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
