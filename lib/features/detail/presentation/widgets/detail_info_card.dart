import 'package:flutter/material.dart';

/// Card widget for displaying detailed information sections
class DetailInfoCard extends StatelessWidget {
  /// Title of the information section
  final String title;
  
  /// Icon to display next to the title
  final IconData icon;
  
  /// Content to display in the card
  final Widget child;
  
  /// Creates a [DetailInfoCard]
  const DetailInfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: theme.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}