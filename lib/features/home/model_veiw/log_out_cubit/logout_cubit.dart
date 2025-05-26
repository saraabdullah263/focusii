import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/home/model_veiw/log_out_cubit/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final HomeRepo homeRepo;

  LogoutCubit(this.homeRepo) : super(LogoutInitial());

  Future<void> logoutUser(String token) async {
    emit(LogoutLoading());

    final result = await homeRepo.logout(token);

    result.fold(
      (failure) => emit(LogoutFailure(failure.errMessage)),
      (_) => emit(LogoutSuccess()),
    );
  }
}