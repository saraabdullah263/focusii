import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/model/feedback_model.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/home/model_veiw/feedback_cubit/feedback_state.dart';


class FeedbackCubit extends Cubit<FeedbackState> {
  final HomeRepo homeRepo;

  FeedbackCubit(this.homeRepo) : super(FeedbackInitial());

  Future<void> sendFeedback(FeedbackModel model,String token) async {
    emit(FeedbackLoading());

    final result = await homeRepo.sendFeedback(model,token);

    result.fold(
      (failure) => emit(FeedbackFailure(failure.errMessage)),
      (message) => emit(FeedbackSuccess(message)),
    );
  }
}
