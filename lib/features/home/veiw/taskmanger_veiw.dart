import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/core/utles/app_images.dart';
import 'package:focusi/core/widget/custom_loading.dart';
import 'package:focusi/features/home/date/model/task_model.dart';
import 'package:focusi/features/home/model_veiw/task_cubit/task_manager_cubit.dart';
import 'package:focusi/features/home/model_veiw/task_cubit/task_manager_state.dart';
import 'package:focusi/features/home/widget/button_sheet_form.dart';
import 'package:focusi/features/home/widget/custom_card.dart';



class TaskmangerVeiw extends StatefulWidget {
  const TaskmangerVeiw({super.key});

  @override
  State<TaskmangerVeiw> createState() => _TaskmangerVeiwState();
}

class _TaskmangerVeiwState extends State<TaskmangerVeiw> {
  final EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();
  final TextEditingController taskNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  final token = CacheHelper.getData(key: 'userToken');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final token = CacheHelper.getData(key: 'userToken');
      if (token != null) {
        context.read<TaskManagerCubit>().fetchTasks(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.logoWhite),
          SizedBox(height: MediaQuery.of(context).size.height * .06),
          EasyInfiniteDateTimeLine(
            controller: controller,
            firstDate: DateTime(2020),
            focusDate: selectedDate,
            lastDate: DateTime(2026),
            showTimelineHeader: false,
            dayProps: EasyDayProps(
              todayStyle: DayStyle(
                dayNumStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inactiveDayStyle: DayStyle(
                dayNumStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
                monthStrStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
                dayStrStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
                monthStrStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
                dayStrStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: AppColors.primaryColor,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onDateChange: (date) {
              setState(() {
                selectedDate = date;
                selectedDateTime=date;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .03,
              ),
              child: BlocConsumer<TaskManagerCubit, TaskManagerState>(
                listener: (context, state) {
                  if (state is AddTaskSuccess) {
                    taskNameController.clear();
                    Navigator.pop(context);
                    context.read<TaskManagerCubit>().fetchTasks(token);
                    Fluttertoast.showToast(
                      msg: "Task added successfully!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.white,
                      textColor: AppColors.primaryColor,
                      fontSize: 16.0,
                    );
                  } else if (state is TaskManagerFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TaskManagerLoading) {
                    return const CustomLoading();
                  } else if (state is TaskManagerFailure) {
                    return Center(child: Text(state.error));
                  } else if (state is TaskManagerSuccess) {
                    final tasks = state.tasks.where((task) {
                      return task.date.year == selectedDateTime.year &&
                          task.date.month == selectedDateTime.month &&
                          task.date.day == selectedDateTime.day;
                    }).toList();

                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text("You Don't Have any Tasks Now"),
                      );
                    }
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) =>
                          CustomCard(task: tasks[index],token: token,),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * .05,
                bottom: MediaQuery.of(context).size.height * .02,
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ButtonSheetForm(
      taskNameController: taskNameController,
      selectedDateTime: selectedDateTime,  
      onDateTimeChanged: (newDateTime) {
        setState(() {
          selectedDateTime = newDateTime; 
          print('--------------------------------------------------------Parent selectedDateTime updated: $selectedDateTime'); // هنا بنحدث المتغير في parent فعلاً
        });
      },
      onPressed: (taskName, dateTime) {
        final token = CacheHelper.getData(key: 'userToken');
        if (taskName.isEmpty || token == null) return;

        final task = TaskModel(
          name: taskName,
          date: selectedDateTime, 
          isCompleted: true,
          isDateAndTimeEnded: true,
        );

        context.read<TaskManagerCubit>().addTask(task, token);
      },
    ),
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

