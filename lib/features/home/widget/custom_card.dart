import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focusi/core/utles/app_colors.dart';
import 'package:focusi/features/home/date/model/task_model.dart';
import 'package:focusi/features/home/model_veiw/task_cubit/task_manager_cubit.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatefulWidget {
  final TaskModel task;
  final String token;

  const CustomCard({super.key, required this.task, required this.token});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
      //print("Task date: ${widget.task.date}");
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .04,
        vertical: MediaQuery.of(context).size.height * .004,
      ),
      color: Colors.white,
      child: Slidable(
        // key: ValueKey(widget.task.name),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () {
          //     // Optional: Call delete function from cubit
          //   },
          // ),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              onPressed: (context) {
                  context
                    .read<TaskManagerCubit>()
                    .deleteTask(widget.task.name, widget.token);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
               
                
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: MediaQuery.of(context).size.width * .01,
            height: MediaQuery.of(context).size.height * .05,
            color:
                widget.task.isCompleted ? Colors.green : AppColors.primaryColor,
          ),
          title: Text(
            widget.task.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
 DateFormat('yyyy-MM-dd – HH:mm').format(widget.task.date),
  style: TextStyle(color: Colors.black),
          ),
          trailing: GestureDetector(
            onTap: () {
               context.read<TaskManagerCubit>().updateTask(widget.task, widget.token);
            },
            child:
                widget.task.isCompleted == false
                    ? Container(
                      width: MediaQuery.of(context).size.width * .15,
                      height: MediaQuery.of(context).size.height * .036,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                    : Text(
                      "IsDone!",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
          ),
        ),
      ),
    );
  }
}
