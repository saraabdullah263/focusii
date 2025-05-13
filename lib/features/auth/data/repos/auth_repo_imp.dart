import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/core/utles/app_endpoints.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final Dio dio;
  AuthRepoImp(this.dio, {required ApiServecis apiService}) {
    dio.options.baseUrl = AppEndpoints.baseUrl;
  }
  @override
  Future<Either<Failure, UserModel>> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int age,
  }) async {
    try {
      final response = await dio.post(
        AppEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'gender': gender,
          'password': password,
          'confirmPassword': confirmPassword,
          'age': age,
        },
      );

      return right(UserModel.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginUser({
    required email,
    required password,
  }) async {
    try{
      final response=await dio.post(AppEndpoints.login,
      data: {
        'email':email,
        'password':password
      });
      return right(UserModel.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }


    
  }
}
