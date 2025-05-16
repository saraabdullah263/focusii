import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());

    final result = await authRepo.loginUser(email: email, password: password);

    result.fold(
      (failure) {
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
      (user) => emit(LoginSuccess()),
    );
  }
}
