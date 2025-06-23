abstract class CameraTrackingState {}

class CameraTrackingInitial extends CameraTrackingState {}

class CameraTrackingLoading extends CameraTrackingState {}

class CameraTrackingSuccess extends CameraTrackingState {
  final bool isFocused;

  CameraTrackingSuccess(this.isFocused);
}

class CameraTrackingFailure extends CameraTrackingState {
  final String error;

  CameraTrackingFailure(this.error);
}


class CameraTrackingSubmitSuccess extends CameraTrackingState {
  final int statusCode;

  CameraTrackingSubmitSuccess(this.statusCode);
}

class CameraTrackingSubmitFailure extends CameraTrackingState {
  final String error;

  CameraTrackingSubmitFailure(this.error);
}
