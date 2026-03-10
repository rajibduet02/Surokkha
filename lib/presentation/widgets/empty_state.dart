import 'package:flutter/material.dart';

/// Empty list/state placeholder with optional action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.message = 'No data',
    this.icon,
    this.onAction,
    this.actionLabel,
  });

  final String message;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 48),
          const SizedBox(height: 16),
          Text(message),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: 16),
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
