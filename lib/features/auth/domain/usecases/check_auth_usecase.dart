import 'package:clean_architecture_example/core/error/failures.dart';
import 'package:clean_architecture_example/core/usecases/usecase.dart';
import 'package:clean_architecture_example/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CheckAuthUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async => await repository.isAuthenticated();
}
