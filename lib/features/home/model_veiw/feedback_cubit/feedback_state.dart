abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {
  final String message;
  FeedbackSuccess(this.message);
}

class FeedbackFailure extends FeedbackState {
  final String error;
  FeedbackFailure(this.error);
}
