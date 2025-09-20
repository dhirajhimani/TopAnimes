import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_anime/features/anime/presentation/bloc/anime_cubit.dart';

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
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/favorites/data/datasources/favorites_local_data_source.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/favorites/domain/repositories/favorites_repository.dart';
import 'features/favorites/domain/usecases/add_to_favorites.dart';
import 'features/favorites/domain/usecases/get_favorites.dart';
import 'features/favorites/domain/usecases/is_favorite.dart';
import 'features/favorites/domain/usecases/remove_from_favorites.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';

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
  
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(),
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
  
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(localDataSource: sl()),
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
  
  // Favorites feature use cases
  sl.registerLazySingleton(() => GetFavorites(sl<FavoritesRepository>()));
  sl.registerLazySingleton(() => AddToFavorites(sl<FavoritesRepository>()));
  sl.registerLazySingleton(() => RemoveFromFavorites(sl<FavoritesRepository>()));
  sl.registerLazySingleton(() => IsFavorite(sl<FavoritesRepository>()));
  
  // Cubits and BLoCs
  sl.registerFactory(() => AnimeCubit(getTopAnime: sl()));
  sl.registerFactory(() => HomeBloc(
    getTopAiringAnime: sl(), 
    getTopManga: sl(),
  ));
  sl.registerFactory(() => FavoritesBloc(
    getFavorites: sl(),
    addToFavorites: sl(),
    removeFromFavorites: sl(),
    isFavorite: sl(),
  ));
}