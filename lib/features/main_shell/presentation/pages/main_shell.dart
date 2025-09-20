import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main shell widget containing the bottom navigation bar
class MainShell extends StatefulWidget {
  /// The child widget to display in the body
  final Widget child;
  
  /// Creates a [MainShell]
  const MainShell({
    super.key,
    required this.child,
  });
  
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  /// Navigation items configuration
  static const List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.movie_outlined,
      activeIcon: Icons.movie,
      label: 'Anime',
      route: '/anime',
    ),
    NavigationItem(
      icon: Icons.book_outlined,
      activeIcon: Icons.book,
      label: 'Manga',
      route: '/manga',
    ),
    NavigationItem(
      icon: Icons.library_books_outlined,
      activeIcon: Icons.library_books,
      label: 'Light Novel',
      route: '/lightnovel',
    ),
    NavigationItem(
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      label: 'Favorites',
      route: '/favorites',
    ),
    NavigationItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
  ];
  
  /// Get current index based on location
  int _getCurrentIndex(String location) {
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location.startsWith(_navigationItems[i].route)) {
        return i;
      }
    }
    return 0; // Default to first tab
  }
  
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).location;
    final currentIndex = _getCurrentIndex(location);
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onNavBarTap(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: _navigationItems.map((item) {
          final isSelected = _navigationItems[currentIndex] == item;
          return BottomNavigationBarItem(
            icon: Icon(isSelected ? item.activeIcon : item.icon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
  
  /// Handles navigation bar tap
  void _onNavBarTap(int index) {
    final targetRoute = _navigationItems[index].route;
    context.go(targetRoute);
  }
}

/// Configuration for a navigation item
class NavigationItem {
  /// Icon when not selected
  final IconData icon;
  
  /// Icon when selected
  final IconData activeIcon;
  
  /// Label text
  final String label;
  
  /// Route path
  final String route;
  
  /// Creates a [NavigationItem]
  const NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}