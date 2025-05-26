import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/home/date/repo/home_repo.dart';
import 'package:focusi/features/home/model_veiw/upload_picture_cubit/upload_picture_state.dart';


class UploadPictureCubit extends Cubit<UploadPictureState> {
  final HomeRepo homeRepo;

  UploadPictureCubit(this.homeRepo) : super(UploadPictureInitial());

  Future<void> uploadPicture(String token, File image) async {
    emit(UploadPictureLoading());

    final result = await homeRepo.uploadProfilePicture(token, image);

    result.fold(
      (failure) => emit(UploadPictureFailure(failure.errMessage)),
      (message) => emit(UploadPictureSuccess(message)),
    );
  }
}
