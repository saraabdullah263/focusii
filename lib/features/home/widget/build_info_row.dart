import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';

class BuildInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const BuildInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // vertical padding
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                      fontSize: 20),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  value,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.primaryColor,
          thickness: 1,
          indent: 40,
          endIndent: 40,

        ),
      ],
    );
  }
}
