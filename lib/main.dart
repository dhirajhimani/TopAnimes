import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_anime/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:top_anime/features/home/presentation/bloc/home_event.dart';

import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'injection_container.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/favorites/domain/entities/favorite_content.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteContentAdapter());
  
  // Initialize dependencies
  await initializeDependencies();
  
  runApp(const OtakuHubLiteApp());
}

/// Root application widget
class OtakuHubLiteApp extends StatelessWidget {
  /// Creates an [OtakuHubLiteApp]
  const OtakuHubLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>()..add(const LoadHomeData()),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>()..add(const LoadFavorites()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Otaku Hub Lite',
        debugShowCheckedModeBanner: !AppConfig.isDebug,
        routerConfig: AppRouter.createRouter(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 2,
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 2,
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}