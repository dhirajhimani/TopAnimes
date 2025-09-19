import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_client.dart';
import 'data/datasources/anime_local_data_source.dart';
import 'data/datasources/anime_remote_data_source.dart';
import 'data/repositories/anime_repository_impl.dart';
import 'domain/repositories/anime_repository.dart';
import 'domain/usecases/get_top_anime.dart';
import 'presentation/cubit/anime_cubit.dart';

// Home feature dependencies
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_top_airing_anime.dart';
import 'features/home/domain/usecases/get_top_manga.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initializes all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // Core
  sl.registerLazySingleton(() => NetworkClient());
  
  // Legacy data sources (keeping for backward compatibility)
  sl.registerLazySingleton<AnimeRemoteDataSource>(
    () => AnimeRemoteDataSourceImpl(networkClient: sl()),
  );
  
  sl.registerLazySingleton<AnimeLocalDataSource>(
    () => AnimeLocalDataSourceImpl(sharedPreferences: sl()),
  );
  
  // Legacy repository
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  // Legacy use cases
  sl.registerLazySingleton(() => GetTopAnime(sl()));
  
  // Legacy cubit
  sl.registerFactory(() => AnimeCubit(getTopAnime: sl()));
  
  // Home feature dependencies
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(networkClient: sl()),
  );
  
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  
  sl.registerLazySingleton(() => GetTopAiringAnime(sl<HomeRepository>()));
  sl.registerLazySingleton(() => GetTopManga(sl<HomeRepository>()));
  
  sl.registerFactory(() => HomeBloc(
    getTopAiringAnime: sl(),
    getTopManga: sl(),
  ));
}