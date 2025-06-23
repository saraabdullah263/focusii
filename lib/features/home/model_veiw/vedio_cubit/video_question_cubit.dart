import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/home/model_veiw/vedio_cubit/video_question_state.dart';

class VideoQuestionCubit extends Cubit<VideoQuestionState> {
  final HomeRepo homeRepo;

  VideoQuestionCubit(this.homeRepo) : super(VideoQuestionInitial());

  Future<void> fetchAllVideos(String token) async {
    emit(VideoQuestionLoading());

    final result = await homeRepo.getAllVideos(token);

    result.fold(
      (failure) => emit(VideoQuestionFailure(failure.errMessage)),
      (videos) => emit(VideoQuestionSuccess(videos)),
    );
  }
}
