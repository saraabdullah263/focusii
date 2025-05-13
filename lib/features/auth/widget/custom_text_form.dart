import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';


class Customtextform extends StatefulWidget {
  final TextEditingController myController;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool password;
    final void Function(String)? onChanged;
  const Customtextform(
      {super.key,
      required this.hintText,
      required this.myController,
      this.password = false,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.keyboardType,
      this.onChanged
      });

  @override
  State<Customtextform> createState() => _CustomtextformState();
}

class _CustomtextformState extends State<Customtextform> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.myController,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: widget.password && !showPass,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(15)),
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.password == true
            ? IconButton(
                onPressed: () {
                  showPass = !showPass;
                  setState(() {});
                },
                icon: Icon(
                  showPass ? Icons.visibility_off : Icons.visibility,
                  size: 25,
                ))
            : widget.suffixIcon,
            errorStyle: const TextStyle(color: Colors.black,fontSize: 15),
      ),
    );
  }
}
