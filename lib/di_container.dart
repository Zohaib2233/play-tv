import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:play_tv/data/repository/auth_repo.dart';
import 'package:play_tv/data/repository/channel_repo.dart';
import 'package:play_tv/provider/auth_provider.dart';
import 'package:play_tv/provider/channel_provider.dart';
import 'package:play_tv/provider/localization_provider.dart';
import 'package:play_tv/provider/splash_provider.dart';
import 'package:play_tv/provider/theme_provider.dart';
import 'package:play_tv/util/apis_end_point.dart';
import 'package:play_tv/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // core
  sl.registerLazySingleton(() => DioClient(ApiEndPoints.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
          () =>AuthRepo(dioClient: sl(), sharedPreferences: sl()) );
  sl.registerLazySingleton(
          () =>ChannelRepo(dioClient: sl(), sharedPreferences: sl()) );

  // provider
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ChannelProvider(channelRepo: sl()));
  sl.registerFactory(() => SplashProvider());
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl(), dioClient: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
