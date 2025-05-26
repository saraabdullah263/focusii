import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, UserModel>>userProfile(String token);
   Future<Either<Failure, String>> uploadProfilePicture(String token, File image);
    Future<Either<Failure, void>> logout(String token); 
}
