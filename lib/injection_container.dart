import 'package:flutter_authentication_starter/features/auth_feature/data/repository/auth_repository_impl.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/repositories/auth_repository.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/use_cases/login_use_case.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/use_cases/register_use_case.dart';
import 'package:flutter_authentication_starter/features/auth_feature/presentation/login_bloc/login_bloc.dart';
import 'package:flutter_authentication_starter/features/auth_feature/presentation/register_bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'core/utils/pref_utils.dart';
import 'features/auth_feature/interceptor/AuthInterceptor.dart';
import 'features/auth_feature/interceptor/HttpInterceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs :
  sl.registerFactory(() => RegisterBloc(register: sl()));

  sl.registerFactory(() => LoginBloc(login: sl(), prefUtils: sl()));
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
  // Repositories :
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authRemoteDataSource: sl(), networkInfo: sl(), prefUtils: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<HttpInterceptor>(
          () => HttpInterceptorImpl(httpClient: sl()));
  sl.registerLazySingleton<PrefUtils>(() =>
      PrefUtilsImpl(sharedPreferences: sl(), httpClientInterceptor: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => AuthenticatedHttpClient(sharedPref: sl()));

}
