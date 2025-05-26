abstract class UploadPictureState {}

class UploadPictureInitial extends UploadPictureState {}

class UploadPictureLoading extends UploadPictureState {}

class UploadPictureSuccess extends UploadPictureState {
  final String message;
  UploadPictureSuccess(this.message);
}

class UploadPictureFailure extends UploadPictureState {
  final String error;
  UploadPictureFailure(this.error);
}
