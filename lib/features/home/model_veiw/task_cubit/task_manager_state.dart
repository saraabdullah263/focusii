import 'package:focusi/features/home/date/model/task_model.dart';

abstract class TaskManagerState {}

class TaskManagerInitial extends TaskManagerState {}

class TaskManagerLoading extends TaskManagerState {}

class TaskManagerSuccess extends TaskManagerState {
  final List<TaskModel> tasks;
  TaskManagerSuccess(this.tasks);
}

class AddTaskSuccess extends TaskManagerState {
  final TaskModel task;
  AddTaskSuccess(this.task);
}

class TaskManagerFailure extends TaskManagerState {
  final String error;
  TaskManagerFailure(this.error);
}
class UpdateTaskSuccess extends TaskManagerState {
  final TaskModel updatedTask;

  UpdateTaskSuccess(this.updatedTask);
}
class DeleteTaskSuccess extends TaskManagerState {
  final String deletedTaskName;

  DeleteTaskSuccess(this.deletedTaskName);
}

