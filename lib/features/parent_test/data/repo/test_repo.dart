import 'package:dartz/dartz.dart';
import 'package:focusi/core/errors/failure.dart';

abstract class TestRepo {
  Future<Either<Failure, Unit>> submitTestAnswers({
    required String token,
    required List<int> answers,
  });
}
