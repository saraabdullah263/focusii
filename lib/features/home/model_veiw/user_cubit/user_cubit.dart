import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';// Your repo interface
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final HomeRepo userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> fetchCurrentUser(String token) async {
    emit(UserLoading());

    final result = await userRepository.userProfile(token);

    result.fold(
    (failure) {
      debugPrint("❌ API Failure: ${failure.errMessage}");
      emit(UserFailure(failure.errMessage));
    },
    (user) {
      debugPrint("✅ User data fetched: ${user.name}");
      emit(UserLoaded(user));
    },
  );
}
}