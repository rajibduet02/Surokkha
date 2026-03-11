import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';

class SafeZone {
  SafeZone({
    required this.id,
    required this.name,
    required this.address,
    required this.radius,
    required this.entryAlert,
    required this.exitAlert,
    required this.active,
  });

  final int id;
  final String name;
  final String address;
  final String radius;
  bool entryAlert;
  bool exitAlert;
  bool active;

  SafeZone copyWith({
    int? id,
    String? name,
    String? address,
    String? radius,
    bool? entryAlert,
    bool? exitAlert,
    bool? active,
  }) {
    return SafeZone(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      radius: radius ?? this.radius,
      entryAlert: entryAlert ?? this.entryAlert,
      exitAlert: exitAlert ?? this.exitAlert,
      active: active ?? this.active,
    );
  }
}

List<SafeZone> _zonesWoman() => [
      SafeZone(
        id: 1,
        name: 'Home',
        address: 'Gulshan 2, Dhaka',
        radius: '200m',
        entryAlert: true,
        exitAlert: true,
        active: true,
      ),
      SafeZone(
        id: 2,
        name: 'Office',
        address: 'Banani, Dhaka',
        radius: '150m',
        entryAlert: false,
        exitAlert: true,
        active: true,
      ),
      SafeZone(
        id: 3,
        name: "Sister's House",
        address: 'Dhanmondi, Dhaka',
        radius: '180m',
        entryAlert: true,
        exitAlert: true,
        active: false,
      ),
    ];

List<SafeZone> _zonesChild() => [
      SafeZone(
        id: 1,
        name: 'Home',
        address: 'Gulshan 2, Dhaka',
        radius: '200m',
        entryAlert: true,
        exitAlert: true,
        active: true,
      ),
      SafeZone(
        id: 2,
        name: 'School',
        address: 'Banani Model School, Dhaka',
        radius: '250m',
        entryAlert: true,
        exitAlert: true,
        active: true,
      ),
      SafeZone(
        id: 3,
        name: "Uncle's House",
        address: 'Dhanmondi, Dhaka',
        radius: '180m',
        entryAlert: true,
        exitAlert: true,
        active: true,
      ),
    ];

class SafeZonesController extends GetxController {
  final RxList<SafeZone> zones = <SafeZone>[].obs;

  int get activeCount => zones.where((z) => z.active).length;

  @override
  void onInit() {
    super.onInit();
    _loadZones();
  }

  void _loadZones() {
    final profileType = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>().profileType.value
        : 'woman';
    zones.assignAll(
      profileType == 'child' ? _zonesChild() : _zonesWoman(),
    );
  }

  void toggleZone(int id) {
    final i = zones.indexWhere((z) => z.id == id);
    if (i == -1) return;
    zones[i] = zones[i].copyWith(active: !zones[i].active);
    zones.refresh();
  }

  void toggleEntryAlert(int id) {
    final i = zones.indexWhere((z) => z.id == id);
    if (i == -1) return;
    zones[i] = zones[i].copyWith(entryAlert: !zones[i].entryAlert);
    zones.refresh();
  }

  void toggleExitAlert(int id) {
    final i = zones.indexWhere((z) => z.id == id);
    if (i == -1) return;
    zones[i] = zones[i].copyWith(exitAlert: !zones[i].exitAlert);
    zones.refresh();
  }
}
