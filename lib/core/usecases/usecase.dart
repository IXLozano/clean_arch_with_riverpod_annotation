import 'package:clean_architecture_example/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {}
