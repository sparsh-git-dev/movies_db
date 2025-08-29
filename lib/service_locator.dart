import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_db/networks/api_service.dart';
import 'package:movies_db/networks/interceptor.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AppInterceptor>(() => AppInterceptor());

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(_getOptions())..interceptors.add(getIt<AppInterceptor>());
    return dio;
  });

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
}

BaseOptions _getOptions() => BaseOptions(
  connectTimeout: const Duration(minutes: 5),
  receiveTimeout: const Duration(minutes: 5),
  sendTimeout: const Duration(minutes: 5),
);

final apiService = getIt<ApiService>();
