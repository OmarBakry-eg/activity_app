import 'package:activity_app/src/core/dio/dio_client.dart';
import 'package:activity_app/src/core/internet/internet_info.dart';
import 'package:activity_app/src/features/activites/presentation/cubit/activity_cubit.dart';
import 'package:activity_app/src/features/home/data/repo/data_repo.dart';
import 'package:activity_app/src/features/home/data/source/remote_source.dart';
import 'package:activity_app/src/features/home/domain/repo/repo.dart';
import 'package:activity_app/src/features/home/domain/usecases/get_random_activites.dart';
import 'package:activity_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // BLOC
  sl.registerFactory(() => HomeCubit(getRandomActivites: sl()));
  sl.registerFactory(() => ActivityCubit());
  
  // USECASES
  sl.registerLazySingleton(() => GetRandomActivites(sl()));

  //REPO
  sl.registerLazySingleton<HomeActivityRepo>(
      () => HomeActivityRepoImpl(homeRemoteActivitesImpl: sl()));

  //DATA
  sl.registerLazySingleton<HomeRemoteActivitesImpl>(
      () => HomeRemoteActivitesImpl(sl()));

  //CORE
  sl.registerLazySingleton(() => DioClient(sl()));

  sl.registerLazySingleton<InternetInfo>(() => InternetInfoImpl(sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
