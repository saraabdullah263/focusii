import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';
import 'package:focusi/features/auth/data/models/user_model.dart';
import 'package:focusi/core/errors/failure.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit(this.authRepo) : super(SignUpInitial());

  Future<void> signUp(UserModel user) async {
    emit(SignUpLoading());

    final result = await authRepo.registerUser(
      name: user.name ?? '',
      email: user.email ?? '',
      password: user.password ?? '',
      confirmPassword: user.confirmPassword ?? '',
      gender: user.gender ?? '',
      age: user.age ?? 0,
    );

    result.fold(
      (failure) => emit(SignUpFailure(_mapFailureToMessage(failure))),
      (user) async {
       // await _cacheUserData(user); // Save user data
        emit(SignUpSuccess(user));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.errMessage;
    }
    return "Unexpected error occurred.";
  }

  // Future<void> _cacheUserData(UserModel user) async {
  //   if (user.token != null) {
  //     await SharedPreferance.setString('token', user.token!);
  //     await SharedPreferance.setString('email', user.email ?? '');
  //     await SharedPreferance.setString('name', user.name ?? '');
  //     await SharedPreferance.setBool('isSignedIn', true);
  //   }
  // }
}
