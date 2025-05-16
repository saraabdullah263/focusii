import 'package:dartz/dartz.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String gender,
    required int age,
  });
  Future<Either<Failure,UserModel>>loginUser({
    required email,
    required password
  });
  Future<Either<Failure,dynamic>>forgetPassword({
    required email
  });
  Future<Either<Failure,dynamic>>resetPassword({
    required email,
    required newpassword,
    required confirmPassword,
    required token
  });
   Future<void> confirmEmail({
    required String userId,
    required String token,
  });
}
