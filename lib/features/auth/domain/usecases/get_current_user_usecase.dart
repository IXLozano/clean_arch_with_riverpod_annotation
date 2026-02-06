import 'package:clean_architecture_example/core/error/failures.dart';
import 'package:clean_architecture_example/core/usecases/usecase.dart';
import 'package:clean_architecture_example/features/auth/domain/entity/user_entity.dart';
import 'package:clean_architecture_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async => await repository.getCurrentUser();
}
