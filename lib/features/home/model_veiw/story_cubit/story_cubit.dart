import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final HomeRepo repo;

  StoryCubit(this.repo) : super(StoryInitial());

  Future<void> fetchStories(String token) async {
    emit(StoryLoading());

    final result = await repo.getStories(token);

    result.fold(
      (failure) => emit(StoryFailure(failure.errMessage)),
      (stories) => emit(StorySuccess(stories)),
    );
  }
}
