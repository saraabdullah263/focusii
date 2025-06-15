import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/core/utles/app_endpoints.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
import 'package:focusi/features/home/date/model/advice_model.dart';
import 'package:focusi/features/home/date/model/feedback_model.dart';
import 'package:focusi/features/home/date/model/task_model.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';

class HomeRepoImp  extends HomeRepo{
  final Dio dio;
  
HomeRepoImp(this.dio, {required ApiServecis apiService}) {
    dio.options.baseUrl = AppEndpoints.baseUrl;
  }
  @override
  Future<Either<Failure, UserModel>> userProfile(String token)async {
     try {
      final response = await dio.get(
      AppEndpoints.currentUser,

      options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      final userModel = UserModel.fromJson(response.data);
    return right(userModel);
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
}

  @override
  Future<Either<Failure, String>> uploadProfilePicture(String token, File image)async {
    try {
      final fileName = image.path.split('/').last;

      final formData = FormData.fromMap({
        'picture': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await dio.put(
        AppEndpoints.profilePicture,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return right(response.data.toString()); // maybe URL or success message
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> logout(String token) async{
    try {
      final response = await dio.get(
        'Account/logout',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return right(null); // success, no data needed
      } else {
        return left(ServerFailure('Logout failed with status ${response.statusCode}'));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendFeedback(FeedbackModel feedback,String token)async {
    try {
      final response = await dio.post(
        AppEndpoints.feedback, 
        data: feedback.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.data.toString()); // "Your Feedback Saved Successfully :)"
      } else {
        return left(ServerFailure('Failed to submit feedback: ${response.statusCode}'));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel task, String token)async {
   try {
    final response = await dio.post(
      AppEndpoints.addTask,
      data: task.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    final addedTask = TaskModel.fromJson(response.data);
    return right(addedTask);
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchTasks(String token)async {
    try {
    final response = await dio.get(
      AppEndpoints.fetchTasks,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Handle response when there are no tasks
    if (response.data is String) {
      final message = response.data.toString().toLowerCase();
      if (message.contains("don't have any tasks")) {
        return right([]); // empty task list
      } else {
        return left(ServerFailure(response.data.toString()));
      }
    }

    // Otherwise, parse the task list
    final List<TaskModel> tasks = (response.data as List)
        .map((task) => TaskModel.fromJson(task))
        .toList();

    return right(tasks);
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
  }
  
  @override
  Future<Either<Failure, TaskModel>> updateTask(TaskModel task, String token) async{
    try {
    final response = await dio.put(
      AppEndpoints.updateTask,
      data: task.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    final updatedTask = TaskModel.fromJson(response.data);
    return right(updatedTask);
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
}

  @override
  Future<Either<Failure, void>> deleteTask(String token, String taskName) async{
    try {
    final response = await dio.delete(
      AppEndpoints.deleteTask, // e.g., 'api/DailyRoutine/deleteTask'
      data: {
        'name': taskName,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return right(null);
    } else {
      return left(ServerFailure('Delete failed with status ${response.statusCode}'));
    }
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
  }

  @override
  Future<Either<Failure, AdviceModel>> getAdvice(String token)async {
    try {
    final response = await dio.get(
      AppEndpoints.advice,
      options: Options(
    headers: {
      'Authorization': 'Bearer $token',
    },
  ),
    ); // Uses baseUrl

    if (response.statusCode == 200) {
      final adviceModel = AdviceModel.fromJson(response.data);
      return right(adviceModel);
    } else {
      return left(ServerFailure('Failed to fetch advice: ${response.statusCode}'));
    }
  } catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
  }
  }
  }
  


   
  

  