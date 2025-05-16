import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/auth/data/repos/auth_repo.dart';

part 'email_confirmation_state.dart';

class EmailConfirmationCubit extends Cubit<EmailConfirmationState> {
  final AuthRepo authRepo;

  EmailConfirmationCubit(this.authRepo) : super(EmailConfirmationInitial());

  Future<void> confirmEmail(String userId, String token) async {
    emit(EmailConfirmationLoading());
    try {
      await authRepo.confirmEmail(userId: userId, token: token);
      emit(EmailConfirmationSuccess());
    } catch (e) {
      emit(EmailConfirmationFailure(error: e.toString()));
    }
  }
}
