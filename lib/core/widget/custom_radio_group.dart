import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;

  const CustomRadioGroup({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option, style: const TextStyle(fontSize: 20)),
          activeColor: Colors.red,
          value: option,
          groupValue: selectedValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }
}
