import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/core/helper_function.dart/get_user_data.dart';
import 'package:focusi/core/utles/app_endpoints.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
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
      final userModelData = UserModel.fromJson(response.data);
      await saveUserData(userModelData);

      return right(userModelData);
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
    try {
      final token = getUserData()..token;
      final response = await dio.post(
        AppEndpoints.login,
        data: {'email': email, 'password': password},
      );
      final userModelData = UserModel.fromJson(response.data);
      await saveUserData(userModelData);
      print(token);
      return right(userModelData);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401 ||
            (e.response?.data.toString().toLowerCase().contains("invalid") ??
                false) ||
            (e.response?.data.toString().toLowerCase().contains(
                  "unauthorized",
                ) ??
                false)) {
          return left(
            ServerFailure("Incorrect email or password. Please try again."),
          );
        }
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<void> saveUserData(UserModel userModelData) async {
    var userData = jsonEncode(userModelData.toJson());

    await CacheHelper.saveData(key: 'kSaveUserDataKey', value: userData);
    if (userModelData.token != null) {
      await CacheHelper.saveData(key: 'userToken', value: userModelData.token);
      print(userData);
    }
  }

  @override
  Future<void> confirmEmail({
    required String userId,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        AppEndpoints.confirmPassword,
        queryParameters: {
          'userId': userId,
          'token': Uri.encodeComponent(token),
        },
      );

      if (response.statusCode == 200) {
        print('✅ Email confirmed');
      } else {
        throw Exception('❌ Failed to confirm email: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data.toString() ?? e.message;
      throw Exception('💥 Confirmation error: $errorMsg');
    }
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword({
    required email,
    required newpassword,
    required confirmPassword,
    required token,
  }) async {
    try {
      final response = await dio.post(
        '${AppEndpoints.resetPassword}?token=$token',
        data: {
          'email': email,
          'newPassword': newpassword,
          'confirmPassword': confirmPassword,
        },
      );
      print('🚀 Sending reset password with token: $response');

      return right(token ?? 'Password reset successful.');
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> forgetPassword({required email}) async {
    try {
      final response = await dio.post(
        AppEndpoints.forgetPassword,
        data: {'email': email},
      );
      print("🔥 forgetPassword response: ${response.data}");
      final token = response.data['token'];
      if (token != null) {
        await CacheHelper.saveData(key: 'reset_token', value: token);
        print("🔐 Reset token saved: $token");
      }

      return right(token?? 'Token sent to your email.');
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
