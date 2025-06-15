import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  final HomeRepo repo;

  AdviceCubit(this.repo) : super(AdviceInitial());

  Future<void> getAdvice(String token) async {
    emit(AdviceLoading());
    final result = await repo.getAdvice(token);
    result.fold(
      (failure) => emit(AdviceError(failure.errMessage)),
      (advice) => emit(AdviceLoaded(advice)),
    );
  }
}
