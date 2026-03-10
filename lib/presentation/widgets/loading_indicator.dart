import 'package:flutter/material.dart';

/// Full-screen or inline loading indicator.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.fullScreen = false});

  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final child = const Center(child: CircularProgressIndicator());
    if (fullScreen) {
      return Scaffold(body: child);
    }
    return child;
  }
}
