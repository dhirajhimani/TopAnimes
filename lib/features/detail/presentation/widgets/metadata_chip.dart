import 'package:flutter/material.dart';

/// Chip widget for displaying metadata information
class MetadataChip extends StatelessWidget {
  /// Label text to display
  final String label;
  
  /// Icon to display (optional)
  final IconData? icon;
  
  /// Background color (optional)
  final Color? backgroundColor;
  
  /// Creates a [MetadataChip]
  const MetadataChip({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: theme.primaryColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}