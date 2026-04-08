import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = <AppNotification>[].obs;

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  void onInit() {
    super.onInit();

    notifications.assignAll([
      AppNotification(
        title: 'Emergency SOS triggered',
        subtitle: 'Your emergency contacts were notified',
        icon: Icons.warning_rounded,
        color: Colors.red,
        time: '2 min ago',
      ),
      AppNotification(
        title: 'Location shared',
        subtitle: 'Live location sent to contacts',
        icon: Icons.location_on_rounded,
        color: const Color(0xFF10B981),
        time: '10 min ago',
      ),
      AppNotification(
        title: 'Entered Safe Zone',
        subtitle: 'You arrived at a safe location',
        icon: Icons.map_rounded,
        color: const Color(0xFFD4AF37),
        time: '1 hour ago',
      ),
      AppNotification(
        title: 'System update',
        subtitle: 'New safety features available',
        icon: Icons.notifications_active_rounded,
        color: const Color(0xFF8B5CF6),
        time: 'Yesterday',
      ),
    ]);
  }

  void markAsRead(AppNotification n) {
    n.isRead = true;
    notifications.refresh();
  }

  void markAllAsRead() {
    for (final n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
  }

  void removeNotification(AppNotification n) {
    notifications.remove(n);
  }
}

class AppNotification {
  AppNotification({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.time,
    this.isRead = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String time;
  bool isRead;
}
