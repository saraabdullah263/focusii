import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/core/helper_function.dart/cache_helper.dart';
import 'package:focusi/features/auth/model_veiw/forget_pasword_cubit/forget_reset_password_state.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final AuthRepo authRepo;

  PasswordCubit(this.authRepo) : super(PasswordInitial());

  Future<void> forgetPassword(String email) async {
    emit(PasswordLoading());
    final result = await authRepo.forgetPassword(email: email);

    await CacheHelper.saveData(key: 'email', value: email);

    result.fold(
      (failure) => emit(PasswordFailure(failure.errMessage)),
      (response) async {
    
        await CacheHelper.saveData(key: 'reset_token', value: response);
        emit(PasswordSuccess(response));
      },
    );
  }

  Future<void> resetPassword({
  required String email,
  required String newPassword,
  required String confirmPassword,
}) async {
  emit(PasswordLoading());

  final token = CacheHelper.getData(key: 'reset_token');
  print('🧪 Reset token being used: $token');

  if (token == null || token.isEmpty) {
    emit(PasswordFailure("Token is missing. Please request a new reset link."));
    return;
  }

  final result = await authRepo.resetPassword(
    email: email,
    newpassword: newPassword,
    confirmPassword: confirmPassword,
    token: token, // نبعته هنا وهيتم إدراجه في الرابط داخل الـ Repo
  );

  result.fold(
    (failure) => emit(PasswordFailure(failure.errMessage)),
    (message) => emit(PasswordSuccess(message)),
  );
}


}
