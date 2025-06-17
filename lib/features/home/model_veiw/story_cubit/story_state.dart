import 'package:focusi/features/home/date/model/story_model.dart';

abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryFailure extends StoryState {
  final String errorMessage;

  StoryFailure(this.errorMessage);
}

class StorySuccess extends StoryState {
  final List<StoryModel> stories;

  StorySuccess(this.stories);
}
