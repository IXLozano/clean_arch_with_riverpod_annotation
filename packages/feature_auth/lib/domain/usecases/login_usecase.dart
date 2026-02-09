import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async =>
      await repository.login(email: params.email, password: params.password);
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
