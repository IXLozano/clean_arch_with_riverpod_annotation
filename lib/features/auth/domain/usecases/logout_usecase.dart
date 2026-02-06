import 'package:clean_architecture_example/core/error/failures.dart';
import 'package:clean_architecture_example/core/usecases/usecase.dart';
import 'package:clean_architecture_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async => await repository.logout();
}
