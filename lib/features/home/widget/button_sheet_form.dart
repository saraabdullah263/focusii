import 'package:flutter/material.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/features/home/widget/custom_text_faild.dart';
import 'package:intl/intl.dart';

class ButtonSheetForm extends StatefulWidget {
  final void Function(String taskName, DateTime dateTime)? onPressed;
  final TextEditingController taskNameController;
  final DateTime selectedDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;

  ButtonSheetForm({
    super.key,
    required this.onPressed,
    required this.selectedDateTime,
    required this.taskNameController,
    required this.onDateTimeChanged,
  });

  @override
  State<ButtonSheetForm> createState() => _ButtonSheetFormState();
}

class _ButtonSheetFormState extends State<ButtonSheetForm> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.selectedDateTime;
  }

  final DateFormat dateTimeFormat = DateFormat('yyyy/MM/dd – hh:mm a');

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDateTime,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.light
              ? ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor,
                    onPrimary: Colors.white,
                    onSurface: AppColors.primaryColor,
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
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).brightness == Brightness.light
                  ? ColorScheme.light(
                      primary: AppColors.primaryColor,
                      onPrimary: Colors.white,
                      onSurface: AppColors.primaryColor,
                    )
                  : ColorScheme.dark(
                      primary: AppColors.primaryColor,
                      onPrimary: Colors.black,
                      onSurface: AppColors.primaryColor,
                    ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        final newDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        setState(() {
          selectedDateTime = newDateTime;
        });

        widget.onDateTimeChanged(newDateTime);
      }
    }
  }

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
                controller: widget.taskNameController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Text(
                'Select Date & Time',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              TextButton(
                onPressed: () => _selectDateTime(context),
                child: Text(
                  dateTimeFormat.format(selectedDateTime),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
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
                 onPressed: () {
  final taskName = widget.taskNameController.text.trim();
  if (taskName.isNotEmpty) {
    widget.onPressed?.call(taskName, selectedDateTime);
  }
},
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
