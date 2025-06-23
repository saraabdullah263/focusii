import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focusi/features/children_test/children_test_pages/vedio_test/model_veiw/cubit/camera_tracking_state.dart';
import 'package:path/path.dart' as p;

class CameraTrackingCubit extends Cubit<CameraTrackingState> {
  int totalPhotosSent = 0;
  int truePhotoCount = 0;

  CameraTrackingCubit() : super(CameraTrackingInitial());

  Future<void> trackImage(File imageFile) async {
    emit(CameraTrackingLoading());

    try {
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: p.basename(imageFile.path),
        ),
      });

      final dio = Dio();
      final response = await dio.post(
        "https://amira44-newfocus.hf.space/predict",
        data: formData,
      );

      totalPhotosSent++;
      final isFocused = response.data['isFocused'] == true;

      if (isFocused) {
        truePhotoCount++;
      }

      emit(CameraTrackingSuccess(isFocused));
    } catch (e) {
      emit(CameraTrackingFailure(e.toString()));
    }
  }
  Future<void> submitTrackingResult(String token, {required int truePhotos, required int totalPhotos}) async {
  emit(CameraTrackingLoading()); // ممكن تستبدلها بحالة خاصة لو حبيت تفرق

  try {
    final dio = Dio();

    final response = await dio.put(
      'https://focusi.runasp.net/api/Tests/gameTest',
      data: {
        "totalPhotos": totalPhotosSent,
        "truePhotos": truePhotoCount,
      },
      options: Options(
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    emit(CameraTrackingSubmitSuccess(response.statusCode??0)); 
  } catch (e) {
    emit(CameraTrackingFailure(e.toString()));
  }
}

  

  int get getTotalPhotos => totalPhotosSent;
  int get getTruePhotos => truePhotoCount;
}
