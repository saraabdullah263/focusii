import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:focusi/core/api/api_servecis.dart';
import 'package:focusi/core/errors/failure.dart';
import 'package:focusi/core/utles/app_endpoints.dart';
import 'test_repo.dart';

class TestRepoImpl implements TestRepo {
  final ApiServecis apiServecis;

  TestRepoImpl(this.apiServecis);

  @override
  Future<Either<Failure, Unit>> submitTestAnswers({
    required String token,
    required List<int> answers,
  }) async {
    try {
      await apiServecis.put(
        endPoint: AppEndpoints.parentTest,
       data: answers,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
      return right(unit); // Success but no data returned
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
