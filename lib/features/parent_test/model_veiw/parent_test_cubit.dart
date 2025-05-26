import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/parent_test/data/repo/test_repo.dart';
import 'package:focusi/features/parent_test/model_veiw/parent_test_state.dart';

class ParentTestCubit extends Cubit<ParentTestState> {
  final TestRepo testRepo;

  ParentTestCubit(this.testRepo) : super(ParentTestInitial());

  Future<void> submitAnswers({
    required String token,
    required List<int> answers,
  }) async {
    emit(ParentTestLoading());

    final result = await testRepo.submitTestAnswers(token: token, answers: answers);

   result.fold(
  (failure) {
    String error = failure.errMessage.toLowerCase();
    String errorMessage = failure.errMessage;

    if (error.contains('unauthorized') || error.contains('expired') || error.contains('forbidden')) {
      errorMessage = 'Your session has expired or is unauthorized.';
    } else if (error.contains('timeout') || error.contains('network')) {
      errorMessage = 'Network issue. Please check your internet connection.';
    }

    emit(ParentTestFailure(message: errorMessage));
  },
  (_) => emit(ParentTestSuccess()),
);

  }
}
