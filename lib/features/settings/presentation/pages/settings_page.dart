import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../presentation/cubit/home_cubit.dart';

/// Settings page for debugging and configuration
class SettingsPage extends StatefulWidget {
  /// Creates a [SettingsPage]
  const SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Debug Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bug_report,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Debug Settings',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Mock Data Toggle
                  SwitchListTile(
                    title: const Text('Use Mock Data'),
                    subtitle: const Text('Use sample data instead of real API calls'),
                    value: AppConfig.useMockData,
                    onChanged: (value) async {
                      setState(() {
                        AppConfig.toggleMockData();
                      });
                      
                      // Reload home data with new setting
                      final homeCubit = context.read<HomeCubit?>();
                      if (homeCubit != null) {
                        await homeCubit.loadHomeData();
                      }
                      
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppConfig.useMockData 
                                  ? 'Mock data enabled' 
                                  : 'Real API calls enabled',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    secondary: Icon(
                      AppConfig.useMockData 
                          ? Icons.theater_comedy 
                          : Icons.cloud,
                      color: theme.primaryColor,
                    ),
                  ),
                  
                  const Divider(),
                  
                  // API Logging Toggle
                  SwitchListTile(
                    title: const Text('API Logging'),
                    subtitle: const Text('Show detailed API request/response logs'),
                    value: AppConfig.enableApiLogging,
                    onChanged: (value) {
                      setState(() {
                        AppConfig.toggleApiLogging();
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppConfig.enableApiLogging 
                                ? 'API logging enabled' 
                                : 'API logging disabled',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    secondary: Icon(
                      AppConfig.enableApiLogging 
                          ? Icons.list_alt 
                          : Icons.visibility_off,
                      color: theme.primaryColor,
                    ),
                  ),
                  
                  const Divider(),
                  
                  // API Timing Toggle
                  SwitchListTile(
                    title: const Text('API Timing'),
                    subtitle: const Text('Show API response times in debug logs'),
                    value: AppConfig.showApiTiming,
                    onChanged: (value) {
                      setState(() {
                        AppConfig.toggleApiTiming();
                      });
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppConfig.showApiTiming 
                                ? 'API timing enabled' 
                                : 'API timing disabled',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    secondary: Icon(
                      AppConfig.showApiTiming 
                          ? Icons.timer 
                          : Icons.timer_off,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // API Information Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.api,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'API Information',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  _buildApiInfoTile(
                    'Jikan API v4',
                    AppConfig.jikanBaseUrl,
                    'Anime and Manga data from MyAnimeList',
                    Icons.public,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildApiInfoTile(
                    'RanobeDB API',
                    AppConfig.ranobeDbBaseUrl,
                    'Light novel database information',
                    Icons.book,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // App Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'App Information',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  ListTile(
                    leading: const Icon(Icons.apps),
                    title: const Text('Otaku Hub Lite'),
                    subtitle: const Text('Version 1.0.0'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  ListTile(
                    leading: const Icon(Icons.architecture),
                    title: const Text('Architecture'),
                    subtitle: const Text('Clean Architecture with BLoC pattern'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  ListTile(
                    leading: Icon(
                      AppConfig.isDebug ? Icons.bug_report : Icons.verified,
                      color: AppConfig.isDebug ? Colors.orange : Colors.green,
                    ),
                    title: Text(AppConfig.isDebug ? 'Debug Mode' : 'Release Mode'),
                    subtitle: Text(
                      AppConfig.isDebug 
                          ? 'Debug features enabled' 
                          : 'Optimized for production',
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds an API information tile
  Widget _buildApiInfoTile(
    String title,
    String url,
    String description,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  url,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.primaryColor,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}