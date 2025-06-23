import 'package:focusi/features/home/date/model/question_vedio_model.dart';

abstract class VideoQuestionState {}

class VideoQuestionInitial extends VideoQuestionState {}

class VideoQuestionLoading extends VideoQuestionState {}

class VideoQuestionSuccess extends VideoQuestionState {
  final List<QestionVedioModel> videos;

  VideoQuestionSuccess(this.videos);
}

class VideoQuestionFailure extends VideoQuestionState {
  final String message;

  VideoQuestionFailure(this.message);
}
