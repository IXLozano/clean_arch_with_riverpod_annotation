import 'package:clean_architecture_example/core/error/failures.dart';
import 'package:clean_architecture_example/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({required String email, required String password});

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, bool>> isAuthenticated();
}
