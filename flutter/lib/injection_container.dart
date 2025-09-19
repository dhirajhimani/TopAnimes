import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_client.dart';
import 'data/datasources/anime_local_data_source.dart';
import 'data/datasources/anime_remote_data_source.dart';
import 'data/repositories/anime_repository_impl.dart';
import 'domain/repositories/anime_repository.dart';
import 'domain/usecases/get_top_anime.dart';
import 'presentation/cubit/anime_cubit.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initializes all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // Core
  sl.registerLazySingleton(() => NetworkClient());
  
  // Data sources
  sl.registerLazySingleton<AnimeRemoteDataSource>(
    () => AnimeRemoteDataSourceImpl(networkClient: sl()),
  );
  
  sl.registerLazySingleton<AnimeLocalDataSource>(
    () => AnimeLocalDataSourceImpl(sharedPreferences: sl()),
  );
  
  // Repository
  sl.registerLazySingleton<AnimeRepository>(
    () => AnimeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  
  // Use cases
  sl.registerLazySingleton(() => GetTopAnime(sl()));
  
  // Cubit
  sl.registerFactory(() => AnimeCubit(getTopAnime: sl()));
}