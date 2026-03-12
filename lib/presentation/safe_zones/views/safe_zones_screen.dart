import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/floating_navbar.dart';
import '../controllers/safe_zones_controller.dart';

const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _amber = Color(0xFFF59E0B);
const Color _muted = Color(0xFF8A8A92);
const Color _bgDark = Color(0xFF0A0A0F);

class SafeZonesScreen extends GetView<SafeZonesController> {
  const SafeZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          _buildBackgroundGlows(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildAddButton(),
                  const SizedBox(height: 24),
                  _buildInfoCard(),
                  const SizedBox(height: 24),
                  _buildZonesSection(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          FloatingNavBar(currentRoute: '/safe-zones'),
        ],
      ),
    );
  }

  Widget _buildBackgroundGlows() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: -64,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _gold.withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.05),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            right: -64,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _goldLight.withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(
                    color: _goldLight.withValues(alpha: 0.05),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('/dashboard'),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, color: _gold, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Safe Zones',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${controller.activeCount} active zones',
                  style: TextStyle(color: _muted, fontSize: 14),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildAddButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [_gold, _goldLight],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _gold.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: _bgDark, size: 26),
              const SizedBox(width: 12),
              Text(
                'Add New Safe Zone',
                style: TextStyle(
                  color: _bgDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.3)),
      ),
      child: Text(
        'Safe Zones notify your guardians when you enter or exit designated areas for added security.',
        style: TextStyle(color: _gold, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildZonesSection() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Your Zones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...controller.zones.map((zone) => _ZoneCard(
                zone: zone,
                onToggleZone: controller.toggleZone,
                onToggleEntry: controller.toggleEntryAlert,
                onToggleExit: controller.toggleExitAlert,
              )),
        ],
      );
    });
  }
}

class _ZoneCard extends StatelessWidget {
  const _ZoneCard({
    required this.zone,
    required this.onToggleZone,
    required this.onToggleEntry,
    required this.onToggleExit,
  });

  final SafeZone zone;
  final void Function(int id) onToggleZone;
  final void Function(int id) onToggleEntry;
  final void Function(int id) onToggleExit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: _card.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: zone.active
                    ? _gold.withValues(alpha: 0.3)
                    : _cardBorder,
              ),
              boxShadow: zone.active
                  ? [
                      BoxShadow(
                        color: _gold.withValues(alpha: 0.05),
                        blurRadius: 16,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: zone.active
                                  ? const LinearGradient(
                                      colors: [_gold, _goldLight],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: zone.active ? null : _cardBorder,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.location_on_rounded,
                              size: 24,
                              color: zone.active ? _bgDark : _muted,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  zone.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  zone.address,
                                  style: TextStyle(color: _muted, fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _gold.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        zone.radius,
                                        style: TextStyle(
                                          color: _gold,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (zone.active) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: _green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Active',
                                        style: TextStyle(
                                          color: _green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _ZoneToggle(
                            value: zone.active,
                            onTap: () => onToggleZone(zone.id),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        alignment: Alignment.topCenter,
                        child: zone.active
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 1,
                                    color: _cardBorder,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Notifications',
                                    style: TextStyle(
                                      color: _muted,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _EntryExitAlerts(
                                    zone: zone,
                                    onToggleEntry: onToggleEntry,
                                    onToggleExit: onToggleExit,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ZoneToggle extends StatelessWidget {
  const _ZoneToggle({required this.value, required this.onTap});

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: value
              ? const LinearGradient(
                  colors: [_gold, _goldLight],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: value ? null : _cardBorder,
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? _bgDark : _muted,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EntryExitAlerts extends StatelessWidget {
  const _EntryExitAlerts({
    required this.zone,
    required this.onToggleEntry,
    required this.onToggleExit,
  });

  final SafeZone zone;
  final void Function(int id) onToggleEntry;
  final void Function(int id) onToggleExit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onToggleEntry(zone.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: zone.entryAlert
                  ? _green.withValues(alpha: 0.1)
                  : _cardBorder.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: zone.entryAlert
                    ? _green.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  size: 16,
                  color: zone.entryAlert ? _green : _muted,
                ),
                const SizedBox(width: 8),
                Text(
                  'Entry Alert',
                  style: TextStyle(
                    fontSize: 14,
                    color: zone.entryAlert ? _green : _muted,
                  ),
                ),
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: zone.entryAlert ? _green : Colors.transparent,
                    border: Border.all(
                      color: zone.entryAlert ? _green : _muted,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: zone.entryAlert
                      ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => onToggleExit(zone.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: zone.exitAlert
                  ? _amber.withValues(alpha: 0.1)
                  : _cardBorder.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: zone.exitAlert
                    ? _amber.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_off_rounded,
                  size: 16,
                  color: zone.exitAlert ? _amber : _muted,
                ),
                const SizedBox(width: 8),
                Text(
                  'Exit Alert',
                  style: TextStyle(
                    fontSize: 14,
                    color: zone.exitAlert ? _amber : _muted,
                  ),
                ),
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: zone.exitAlert ? _amber : Colors.transparent,
                    border: Border.all(
                      color: zone.exitAlert ? _amber : _muted,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: zone.exitAlert
                      ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
