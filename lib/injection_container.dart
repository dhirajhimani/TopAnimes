import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core services
import 'core/network/network_client.dart';

// Data layer
import 'data/datasources/anime_local_data_source.dart';
import 'data/datasources/anime_remote_data_source.dart';
import 'data/datasources/home_data_source.dart';
import 'data/repositories/anime_repository_impl.dart';
import 'data/repositories/home_repository.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';

// Domain layer
import 'domain/repositories/anime_repository.dart';
import 'domain/usecases/get_top_anime.dart';
import 'features/home/domain/repositories/home_repository.dart' as home_repo;
import 'features/home/domain/usecases/get_top_airing_anime.dart';
import 'features/home/domain/usecases/get_top_manga.dart';

// Presentation layer
import 'presentation/cubit/anime_cubit.dart';
import 'presentation/cubit/home_cubit.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initializes all dependencies with simplified architecture
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // Core services
  sl.registerLazySingleton(() => NetworkClient());
  
  // Data sources
  sl.registerLazySingleton<HomeDataSource>(
    () => HomeDataSource(networkClient: sl()),
  );
  
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(networkClient: sl()),
  );
  
  sl.registerLazySingleton<AnimeRemoteDataSource>(
    () => AnimeRemoteDataSourceImpl(networkClient: sl()),
  );
  
  sl.registerLazySingleton<AnimeLocalDataSource>(
    () => AnimeLocalDataSourceImpl(sharedPreferences: sl()),
  );
  
  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(dataSource: sl()),
  );
  
  sl.registerLazySingleton<home_repo.HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  // Legacy use cases (keeping for backward compatibility)
  sl.registerLazySingleton(() => GetTopAnime(sl()));
  
  // Home feature use cases
  sl.registerLazySingleton(() => GetTopAiringAnime(sl<home_repo.HomeRepository>()));
  sl.registerLazySingleton(() => GetTopManga(sl<home_repo.HomeRepository>()));
  
  // Cubits and BLoCs
  sl.registerFactory(() => HomeCubit(repository: sl()));
  sl.registerFactory(() => AnimeCubit(getTopAnime: sl()));
  sl.registerFactory(() => HomeBloc(
    getTopAiringAnime: sl(), 
    getTopManga: sl(),
  ));
}