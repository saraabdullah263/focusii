// ignore_for_file: avoid_print, deprecated_member_use

import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    print('💥 DIO ERROR TYPE: ${dioError.type}');
    print('💥 DIO ERROR: ${dioError.toString()}');
    print('💥 REQUEST PATH: ${dioError.requestOptions.path}');
    print('💥 STATUS CODE: ${dioError.response?.statusCode}');
    print('💥 RESPONSE DATA: ${dioError.response?.data}');

    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return ServerFailure('Connection Timeout');
      case DioErrorType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final path = dioError.requestOptions.path;

        if (statusCode == 400) {
          if (path.contains('login')) {
            return ServerFailure('Invalid email or password');
          }
        }

        // Try to extract message if the data is a Map
        final responseData = dioError.response?.data;
        if (responseData is Map && responseData.containsKey('message')) {
          return ServerFailure(responseData['message']);
        }

        print('Unexpected server error: ${dioError.response?.data}');
        return ServerFailure(
            'Unexpected server error: ${dioError.response?.data}');

      case DioErrorType.cancel:
        return ServerFailure('Request Cancelled');
      case DioErrorType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioErrorType.unknown:
      default:
        return ServerFailure('Unexpected Error, Please try again');
    }
  }
}