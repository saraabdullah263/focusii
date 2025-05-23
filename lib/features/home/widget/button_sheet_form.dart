import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/features/home/widget/custom_text_faild.dart';
import 'package:intl/intl.dart';

class ButtonSheetForm extends StatefulWidget {
  const ButtonSheetForm({super.key});

  @override
  State<ButtonSheetForm> createState() => _ButtonSheetFormState();
}

class _ButtonSheetFormState extends State<ButtonSheetForm> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Text(
                'Add New Task',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              CustomTextfaild(
                hintText: 'Task Name',
                controller: taskNameController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              CustomTextfaild(
                hintText: 'Task Details',
                controller: taskDetailsController,
                maxLines: 5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Text(
                'Select Date',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: selectedDate,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data:
                            Theme.of(context).brightness == Brightness.light
                                ? ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        AppColors
                                            .primaryColor, // Header, selected date
                                    onPrimary:
                                        Colors.white, // Text on primary color
                                    onSurface:
                                        AppColors
                                            .primaryColor, // Default text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                                : ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: AppColors.primaryColor,
                                    onPrimary: Colors.black,
                                    onSurface: AppColors.primaryColor,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                        child: child!,
                      );
                    },
                  );

                  if (date != null) {
                    setState(() {
                      selectedDate = DateTime(date.year, date.month, date.day);
                    });
                  }
                },
                child: Text(
                  dateFormat.format(selectedDate),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .02,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: AppColors.primaryColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
