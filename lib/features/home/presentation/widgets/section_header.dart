import 'package:flutter/material.dart';

/// Widget for section headers with optional "See All" button
class SectionHeader extends StatelessWidget {
  /// Title of the section
  final String title;
  
  /// Optional subtitle
  final String? subtitle;
  
  /// Callback when "See All" is pressed
  final VoidCallback? onSeeAllPressed;
  
  /// Creates a [SectionHeader]
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAllPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onSeeAllPressed != null)
          TextButton(
            onPressed: onSeeAllPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: theme.primaryColor,
                ),
              ],
            ),
          ),
      ],
    );
  }
}