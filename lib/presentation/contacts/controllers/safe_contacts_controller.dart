import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';
import '../../../data/models/contact_item.dart';

/// Provides contact list based on profile type (woman vs child). Matches React ContactsScreen.
class SafeContactsController extends GetxController {
  final RxList<ContactItem> contacts = <ContactItem>[].obs;

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

  @override
  void onInit() {
    super.onInit();
    try {
      final dashboard = Get.find<DashboardController>();
      contacts.assignAll(
        dashboard.isChild ? _contactsChild : _contactsWoman,
      );
    } catch (_) {
      contacts.assignAll(_contactsWoman);
    }
  }

  void addContact(ContactItem contact) {
    if (contacts.length >= 10) {
      Get.snackbar(
        'Limit reached',
        'Maximum 10 contacts allowed',
        backgroundColor: const Color(0xFF1A1A22),
        colorText: Colors.white,
      );
      return;
    }

    contacts.add(contact);
    contacts.refresh();
  }

  void deleteContact(ContactItem contact) {
    contacts.remove(contact);
    contacts.refresh();
    Get.snackbar(
      'Contact Removed',
      '${contact.name} has been deleted',
      backgroundColor: const Color(0xFF1A1A22),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }
}
