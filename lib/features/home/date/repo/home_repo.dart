import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
import 'package:focusi/features/home/date/model/advice_model.dart';
import 'package:focusi/features/home/date/model/feedback_model.dart';
import 'package:focusi/features/home/date/model/task_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserModel>> userProfile(String token);
  Future<Either<Failure, String>> uploadProfilePicture(
    String token,
    File image,
  );
  Future<Either<Failure, void>> logout(String token);
  Future<Either<Failure, String>> sendFeedback(FeedbackModel feedback, String token,);
  Future<Either<Failure, List<TaskModel>>> fetchTasks(String token);
  Future<Either<Failure, TaskModel>> addTask(TaskModel task, String token);
  Future<Either<Failure, void>> deleteTask(String token, String taskName);
Future<Either<Failure, TaskModel>> updateTask(TaskModel task, String token);
 Future<Either<Failure, AdviceModel>> getAdvice(String token);


}
