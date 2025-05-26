import 'package:dio/dio.dart';
import 'package:focusi/core/utles/app_endpoints.dart';

class ApiServecis {

   ApiServecis(this.dio);
  final _baseUrl = AppEndpoints.baseUrl;
  final Dio dio;

  Future<Map<String, dynamic>> post({required String endPoint, data}) async {
    var response = await dio.post(
      '$_baseUrl$endPoint',
      data: data,
    );
    return response.data;
  }

  Future<dynamic> get({required String endPoint}) async {
    var response = await dio.get(
      '$_baseUrl$endPoint',
    );

    return response.data;
  }
  Future<dynamic> put({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.put(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }
}
