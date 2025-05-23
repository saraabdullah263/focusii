import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/features/home/widget/button_sheet_form.dart';
import 'package:focusi/features/home/widget/custom_card.dart';

class TaskmangerVeiw extends StatefulWidget {
  const TaskmangerVeiw({super.key});

  @override
  State<TaskmangerVeiw> createState() => _TaskmangerVeiwState();
}

class _TaskmangerVeiwState extends State<TaskmangerVeiw> {
  EasyInfiniteDateTimelineController? controller =
      EasyInfiniteDateTimelineController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          SizedBox(
          height: MediaQuery.of(context).size.height * .06,
        ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime(2020),
            focusDate: selectedDate,
            lastDate: DateTime(2026),
            showTimelineHeader: false,
           dayProps: EasyDayProps(
            todayStyle: DayStyle(
              dayNumStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                color: AppColors.primaryColor
              ),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
            ),
              inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                  monthStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: AppColors.primaryColor),
                  dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: AppColors.primaryColor),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))),
              activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                  monthStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: AppColors.primaryColor),
                  dayStrStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: AppColors.primaryColor),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10))),
                      ),
                      onDateChange: (date) {
                        setState(() {
                          selectedDate=date;
                        });
                      },
          ), 
           Expanded(
            child: Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
          child: ListView.builder(
            itemBuilder: (context, index) => CustomCard(
             
            ),
            itemCount: 2
          ),
        )),
         Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width * .05, bottom: MediaQuery.of(context).size.height * .02),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const ButtonSheetForm(),
                );
            },
            child: const Icon(
              Icons.add,
              size: 30,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
        ],
      ),
    );
  }
}
