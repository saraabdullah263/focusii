import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<String> options; // List of text labels
  final int? selectedValue;   // selected index
  final ValueChanged<int?> onChanged;

  const CustomRadioGroup({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        return RadioListTile<int>(
          title: Text(options[index]),
          value: index,
          groupValue: selectedValue,
          onChanged: onChanged,
        );
      }),
    );
  }
}

