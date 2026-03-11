import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';
import '../../../data/models/contact_item.dart';

/// Provides contact list based on profile type (woman vs child). Matches React ContactsScreen.
class SafeContactsController extends GetxController {
  List<ContactItem> get contacts {
    try {
      final dashboard = Get.find<DashboardController>();
      return dashboard.isChild ? _contactsChild : _contactsWoman;
    } catch (_) {
      return _contactsWoman;
    }
  }

  static const List<ContactItem> _contactsWoman = [
    ContactItem(
      name: 'Fatima Rahman',
      relation: 'Mother',
      phone: '+880 1712-345678',
      email: 'fatima.r@email.com',
      priority: 1,
      verified: true,
    ),
    ContactItem(
      name: 'Karim Ahmed',
      relation: 'Father',
      phone: '+880 1812-345678',
      email: 'karim.a@email.com',
      priority: 1,
      verified: true,
    ),
    ContactItem(
      name: 'Nadia Islam',
      relation: 'Sister',
      phone: '+880 1912-345678',
      email: 'nadia.i@email.com',
      priority: 2,
      verified: true,
    ),
    ContactItem(
      name: 'Dr. Hasan Ali',
      relation: 'Colleague',
      phone: '+880 1612-345678',
      email: 'dr.hasan@work.com',
      priority: 2,
      verified: false,
    ),
    ContactItem(
      name: 'Riya Chowdhury',
      relation: 'Best Friend',
      phone: '+880 1512-345678',
      email: 'riya.c@email.com',
      priority: 3,
      verified: true,
    ),
  ];

  static const List<ContactItem> _contactsChild = [
    ContactItem(
      name: 'Fatima Rahman',
      relation: 'Mother',
      phone: '+880 1712-345678',
      email: 'fatima.r@email.com',
      priority: 1,
      verified: true,
    ),
    ContactItem(
      name: 'Karim Ahmed',
      relation: 'Father',
      phone: '+880 1812-345678',
      email: 'karim.a@email.com',
      priority: 1,
      verified: true,
    ),
    ContactItem(
      name: 'Ms. Farzana Haque',
      relation: 'Teacher',
      phone: '+880 1912-345678',
      email: 'farzana.h@school.edu',
      priority: 2,
      verified: true,
    ),
    ContactItem(
      name: 'Uncle Rashid',
      relation: 'Trusted Adult',
      phone: '+880 1612-345678',
      email: 'rashid@email.com',
      priority: 2,
      verified: true,
    ),
    ContactItem(
      name: 'Aunt Shirin',
      relation: 'Family Friend',
      phone: '+880 1512-345678',
      email: 'shirin@email.com',
      priority: 3,
      verified: true,
    ),
  ];
}
