import 'package:feature_auth/data/datasources/auth_local_datasource.dart';
import 'package:feature_auth/data/datasources/auth_remote_datasource.dart';
import 'package:feature_auth/data/repository/auth_repository_impl.dart';
import 'package:feature_auth/domain/repository/auth_repository.dart';
import 'package:feature_auth/domain/usecases/check_auth_usecase.dart';
import 'package:feature_auth/domain/usecases/get_current_user_usecase.dart';
import 'package:feature_auth/domain/usecases/login_usecase.dart';
import 'package:feature_auth/domain/usecases/logout_usecase.dart';
import 'package:feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AuthBloc(loginUseCase: sl(), logoutUseCase: sl(), getCurrentUserUseCase: sl(), checkAuthUseCase: sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(repository: sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
