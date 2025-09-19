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

// Domain layer
import 'domain/repositories/anime_repository.dart';
import 'domain/usecases/get_top_anime.dart';

// Presentation layer
import 'presentation/cubit/anime_cubit.dart';
import 'presentation/cubit/home_cubit.dart';

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
  
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  // Legacy use cases (keeping for backward compatibility)
  sl.registerLazySingleton(() => GetTopAnime(sl()));
  
  // Cubits
  sl.registerFactory(() => HomeCubit(repository: sl()));
  sl.registerFactory(() => AnimeCubit(getTopAnime: sl()));
}