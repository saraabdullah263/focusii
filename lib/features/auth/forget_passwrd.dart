import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/widget/custom_elvated_button.dart';
import 'package:focusi/features/auth/widget/custom_text_form.dart';


class ForgetPasswrd extends StatefulWidget {
  const ForgetPasswrd({super.key});

  @override
  State<ForgetPasswrd> createState() => _ForgetPasswrdState();
}

class _ForgetPasswrdState extends State<ForgetPasswrd> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
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
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Please Enter Your Email',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white)),
        ),
        const SizedBox(
          height: 10,
        ),
        Customtextform(
          hintText: 'Enter Your Email',
          myController: email,
          prefixIcon: const Icon(Icons.email),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        CustomElvatedButton(
          title: 'Submit',
          onPressed: () {},
        )
      ]),
    ));
  }
}
