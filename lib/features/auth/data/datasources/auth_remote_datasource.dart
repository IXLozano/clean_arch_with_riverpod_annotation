import 'package:clean_architecture_example/core/error/exception.dart';
import 'package:clean_architecture_example/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test@gmail.com' && password == '123456') {
      return Future.value(UserModel(id: '1', email: email, name: 'Test User'));
    } else {
      throw InvalidCredentialsException();
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));

    return Future.value();
  }
}
