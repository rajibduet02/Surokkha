import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import '../../widgets/floating_navbar.dart';

// Design tokens (match React SettingsScreen)
const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _bgDark = Color(0xFF0A0A0F);

/// Single setting row item. Matches React settingsSections item shape.
class SettingItem {
  const SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.route,
    this.action,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final String? route;
  /// e.g. 'language' for language selector row
  final String? action;
}

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  const _UserCardWidget(),
                  const SizedBox(height: 24),
                  _buildAccountSection(),
                  const SizedBox(height: 24),
                  _buildEmergencySettingsSection(),
                  const SizedBox(height: 24),
                  _buildAppSettingsSection(),
                  const SizedBox(height: 24),
                  _buildLegalSection(),
                  const SizedBox(height: 24),
                  _buildFooter(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          const FloatingNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.offNamed('/dashboard'),
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
        const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  static const List<SettingItem> _accountItems = [
    SettingItem(
      icon: Icons.person_rounded,
      title: 'Personal Information',
      subtitle: 'Name, phone, email',
      route: '/profile',
    ),
    SettingItem(
      icon: Icons.workspace_premium_rounded,
      title: 'Subscription Status',
      subtitle: 'Premium • 12 days trial left',
      badge: 'Premium',
      route: '/premium',
    ),
  ];

  static const List<SettingItem> _emergencyItems = [
    SettingItem(
      icon: Icons.phone_rounded,
      title: 'Emergency Contacts',
      subtitle: '5 contacts added',
      route: '/contacts',
    ),
    SettingItem(
      icon: Icons.location_on_rounded,
      title: 'Safe Zones',
      subtitle: '3 zones configured',
      route: '/safe-zones',
    ),
    SettingItem(
      icon: Icons.notifications_rounded,
      title: 'Alert Preferences',
      subtitle: 'Customize notifications',
    ),
  ];

  static const List<SettingItem> _appItems = [
    SettingItem(
      icon: Icons.language_rounded,
      title: 'Language',
      subtitle: 'English',
      action: 'language',
    ),
    SettingItem(
      icon: Icons.shield_rounded,
      title: 'Privacy & Security',
      subtitle: 'Data protection settings',
    ),
  ];

  static const List<SettingItem> _legalItems = [
    SettingItem(
      icon: Icons.description_rounded,
      title: 'Terms of Service',
      subtitle: 'Read our terms',
    ),
    SettingItem(
      icon: Icons.lock_rounded,
      title: 'Privacy Policy',
      subtitle: 'How we protect your data',
    ),
  ];

  Widget _buildAccountSection() {
    return _SettingsSectionWidget(
      title: 'Account',
      items: _accountItems,
      controller: controller,
    );
  }

  Widget _buildEmergencySettingsSection() {
    return _SettingsSectionWidget(
      title: 'Emergency Settings',
      items: _emergencyItems,
      controller: controller,
    );
  }

  Widget _buildAppSettingsSection() {
    return _SettingsSectionWidget(
      title: 'App Settings',
      items: _appItems,
      controller: controller,
    );
  }

  Widget _buildLegalSection() {
    return _SettingsSectionWidget(
      title: 'Legal',
      items: _legalItems,
      controller: controller,
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'Safety Shield v2.1.0',
          style: TextStyle(color: _muted, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '© 2026 Safety Shield. All rights reserved.',
          style: TextStyle(color: _muted, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _UserCardWidget extends StatelessWidget {
  const _UserCardWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_card, _cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_gold, _goldLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'SR',
                    style: TextStyle(
                      color: _bgDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_gold, _goldLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: _card, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.workspace_premium_rounded, color: _bgDark, size: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sarah Rahman',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+880 1712-345678',
                  style: TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: _green, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'Verified Account',
                      style: TextStyle(
                        color: _green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: _muted, size: 22),
        ],
      ),
    );
  }
}

class _SettingsSectionWidget extends StatelessWidget {
  const _SettingsSectionWidget({
    required this.title,
    required this.items,
    required this.controller,
  });

  final String title;
  final List<SettingItem> items;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title,
            style: TextStyle(
              color: _muted,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_card, _cardBorder],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _gold.withValues(alpha: 0.1)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  _SettingItemWidget(item: items[i], controller: controller),
                  if (i < items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: _cardBorder,
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingItemWidget extends StatelessWidget {
  const _SettingItemWidget({
    required this.item,
    required this.controller,
  });

  final SettingItem item;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    if (item.action == 'language') {
      return _buildLanguageRow();
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (item.route != null && item.route!.isNotEmpty) {
            Get.toNamed(item.route!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(item.icon, size: 22, color: _gold),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (item.badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_gold, _goldLight],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.badge!,
                    style: TextStyle(
                      color: _bgDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(Icons.chevron_right_rounded, color: _muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageRow() {
    return Obx(() {
      final isEnglish = controller.selectedLanguage.value == 'english';
      final subtitle = isEnglish ? 'English' : 'বাংলা';
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(item.icon, size: 22, color: _gold),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setLanguage('english'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        gradient: isEnglish
                            ? const LinearGradient(
                                colors: [_gold, _goldLight],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        color: isEnglish ? null : _cardBorder,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'English',
                        style: TextStyle(
                          color: isEnglish ? _bgDark : _muted,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setLanguage('bangla'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        gradient: !isEnglish
                            ? const LinearGradient(
                                colors: [_gold, _goldLight],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        color: !isEnglish ? null : _cardBorder,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                          color: !isEnglish ? _bgDark : _muted,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
