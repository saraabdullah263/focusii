import 'package:focusi/features/auth/data/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

class UserFailure extends UserState {
  final String error;
  UserFailure(this.error);
}
