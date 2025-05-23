import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';

class CustomGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const CustomGroup({
    super.key,
    required this.title,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        const SizedBox(height: 8),
        ...options.map((option) {
          return RadioListTile<String>(
            activeColor: AppColors.primaryColor,
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        }).toList(),
        const Divider(color: Colors.grey, thickness: 1,endIndent: 20,indent: 20,),
      ],
    );
  }
}
