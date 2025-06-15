import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/model/task_model.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/home/model_veiw/task_cubit/task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  final HomeRepo repo;

  TaskManagerCubit(this.repo) : super(TaskManagerInitial());

  Future<void> fetchTasks(String token) async {
    emit(TaskManagerLoading());
    final result = await repo.fetchTasks(token);

    result.fold(
      (failure) => emit(TaskManagerFailure(failure.errMessage)),
      (tasks) => emit(TaskManagerSuccess(tasks)),
    );
  }

  Future<void> addTask(TaskModel task, String token) async {
    emit(TaskManagerLoading());

    final result = await repo.addTask(task, token);
     //final addedTask = await repo.addTask(task, token);

    result.fold(
      (failure) => emit(TaskManagerFailure(failure.errMessage)),
      (task) => emit(AddTaskSuccess(task)),
    );
  }
  Future<void> updateTask(TaskModel task, String token) async {
   // emit(TaskManagerLoading());

    final result = await repo.updateTask(task, token);

    result.fold(
      (failure) => emit(TaskManagerFailure(failure.errMessage)),
      (updatedTask) => emit(UpdateTaskSuccess(updatedTask)),
    );
  }
  Future<void> deleteTask(String taskName, String token) async {
  //emit(TaskManagerLoading());
  final result = await repo.deleteTask(token, taskName);

  result.fold(
    (failure) => emit(TaskManagerFailure(failure.errMessage)),
    (_) => emit(DeleteTaskSuccess(taskName)),
  );
}
 
  
}

