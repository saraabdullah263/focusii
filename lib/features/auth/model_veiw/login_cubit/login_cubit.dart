import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/auth/model_veiw/login_cubit/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final HomeRepo homeRepo;

  LoginCubit(this.authRepo, this.homeRepo) : super(LoginInitial());

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());

    final result = await authRepo.loginUser(email: email, password: password);

    await result.fold(
      (failure) async {
        String error = failure.errMessage.toLowerCase();
        String errorMessage = failure.errMessage;

        if (error.contains('invalid') ||
            error.contains('unauthorized') ||
            error.contains('incorrect') ||
            error.contains('wrong')) {
          errorMessage = 'Incorrect email or password. Please try again.';
        }

        emit(LoginFailure(errorMessage));
      },
      (UserModel) async {
        final userResult = await homeRepo.userProfile(UserModel.token.toString());

        userResult.fold(
          (failure) {
            emit(LoginFailure("Failed to fetch user profile."));
          },
          (user) {
            emit(LoginSuccess(user));
          },
        );
      },
    );
  }

  void emitInitial() {
    emit(LoginInitial());
  }
}

