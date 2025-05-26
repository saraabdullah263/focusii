import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/core/utles/app_endpoints.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
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
  }

  