import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class GuardianItem {
  GuardianItem({
    required this.name,
    required this.relation,
    required this.status,
    required this.time,
  });
  final String name;
  final String relation;
  final String status; // 'Viewed' | 'Connecting' | 'Notified'
  final String time;
}

List<GuardianItem> _guardiansWoman() => [
      GuardianItem(name: 'Ayesha Rahman', relation: 'Mother', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Kabir Hossain', relation: 'Father', status: 'Viewed', time: '2 sec ago'),
      GuardianItem(name: 'Nadia Ahmed', relation: 'Sister', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Dr. Farzana', relation: 'Emergency Contact', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Police 999', relation: 'Authority', status: 'Connecting', time: 'Just now'),
    ];

List<GuardianItem> _guardiansChild() => [
      GuardianItem(name: 'Ayesha Rahman', relation: 'Mother', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Kabir Hossain', relation: 'Father', status: 'Viewed', time: '2 sec ago'),
      GuardianItem(name: 'Ms. Farzana', relation: 'Teacher', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Uncle Rashid', relation: 'Trusted Adult', status: 'Notified', time: 'Just now'),
      GuardianItem(name: 'Police 999', relation: 'Authority', status: 'Connecting', time: 'Just now'),
    ];

class EmergencyController extends GetxController {
  final RxBool showCancelPIN = false.obs;
  final TextEditingController pinFieldController = TextEditingController();

  List<GuardianItem> get guardians {
    final profileType = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>().profileType.value
        : 'woman';
    return profileType == 'child' ? _guardiansChild() : _guardiansWoman();
  }

  void openPinModal() {
    pinFieldController.clear();
    showCancelPIN.value = true;
  }

  void closePinModal() {
    showCancelPIN.value = false;
    pinFieldController.clear();
  }

  void confirmCancel() {
    if (pinFieldController.text == '1234') {
      closePinModal();
      Get.offNamed('/dashboard');
    }
  }

  @override
  void onClose() {
    pinFieldController.dispose();
    super.onClose();
  }
}
