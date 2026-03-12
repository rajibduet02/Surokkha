import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../widgets/floating_navbar.dart';

// Design tokens (match React ProfileScreen)
const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _red = Color(0xFFEF4444);
const Color _bgDark = Color(0xFF0A0A0F);

/// Single setting row item. Matches React settingsSections item shape.
class SettingItem {
  const SettingItem({
    required this.icon,
    required this.label,
    this.badge,
    this.danger = false,
    this.route,
  });

  final IconData icon;
  final String label;
  final String? badge;
  final bool danger;
  final String? route;
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  _buildProfileCard(),
                  const SizedBox(height: 24),
                  _buildStatsRow(),
                  const SizedBox(height: 24),
                  _buildAccountSection(),
                  const SizedBox(height: 24),
                  _buildSafetySettingsSection(),
                  const SizedBox(height: 24),
                  _buildSupportSection(),
                  const SizedBox(height: 24),
                  _buildAppVersionFooter(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          FloatingNavBar(currentRoute: '/profile'),
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
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed('/settings'),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.settings_rounded, color: _gold, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_card, _cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_gold, _goldLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.person_rounded, color: _bgDark, size: 40),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _green,
                      shape: BoxShape.circle,
                      border: Border.all(color: _card, width: 4),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.shield_rounded, color: Colors.white, size: 14),
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
                  'Ayesha Rahman',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ayesha.r@email.com',
                  style: TextStyle(color: _muted, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.workspace_premium_rounded, color: _gold, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        color: _gold,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _StatsCardWidget(label: 'Protected Days', value: '87')),
        const SizedBox(width: 16),
        Expanded(child: _StatsCardWidget(label: 'Safe Zones', value: '12')),
        const SizedBox(width: 16),
        Expanded(child: _StatsCardWidget(label: 'Check-ins', value: '234')),
      ],
    );
  }

  List<SettingItem> _accountItems() {
    final isChild = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>().isChild
        : false;
    return [
      const SettingItem(icon: Icons.person_rounded, label: 'Personal Information'),
      SettingItem(
        icon: isChild ? Icons.child_care_rounded : Icons.person_rounded,
        label: 'Profile Type',
        badge: isChild ? 'Child' : 'Woman',
        route: '/profile-type',
      ),
      const SettingItem(
        icon: Icons.workspace_premium_rounded,
        label: 'Premium Subscription',
        badge: 'Active',
      ),
      const SettingItem(icon: Icons.shield_rounded, label: 'Privacy & Security'),
    ];
  }

  static const List<SettingItem> _safetyItems = [
    SettingItem(icon: Icons.phone_rounded, label: 'Emergency Contacts', badge: '5'),
    SettingItem(icon: Icons.location_on_rounded, label: 'Location Sharing', badge: 'On'),
    SettingItem(icon: Icons.notifications_rounded, label: 'Alert Preferences'),
  ];

  static const List<SettingItem> _supportItems = [
    SettingItem(icon: Icons.help_outline_rounded, label: 'Help & FAQ'),
    SettingItem(icon: Icons.settings_rounded, label: 'App Settings'),
    SettingItem(icon: Icons.logout_rounded, label: 'Sign Out', danger: true),
  ];

  Widget _buildAccountSection() {
    return _SettingsSectionWidget(
      title: 'Account',
      items: _accountItems(),
    );
  }

  Widget _buildSafetySettingsSection() {
    return _SettingsSectionWidget(
      title: 'Safety Settings',
      items: _safetyItems,
    );
  }

  Widget _buildSupportSection() {
    return _SettingsSectionWidget(
      title: 'Support',
      items: _supportItems,
    );
  }

  Widget _buildAppVersionFooter() {
    return Column(
      children: [
        Text(
          'Surokkha v2.1.0',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          'Made with care for Bangladesh',
          style: TextStyle(color: _muted, fontSize: 12),
        ),
      ],
    );
  }

  /// Shows sign-out confirmation dialog. Returns true if user confirmed Sign Out.
  static Future<bool?> _showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Sign Out',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to sign out? You will need to sign in again to access your account.',
          style: TextStyle(color: _muted, fontSize: 14, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: _gold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Sign Out', style: TextStyle(color: _red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _StatsCardWidget extends StatelessWidget {
  const _StatsCardWidget({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_card, _cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: _gold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionWidget extends StatelessWidget {
  const _SettingsSectionWidget({required this.title, required this.items});

  final String title;
  final List<SettingItem> items;

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
                  _SettingItemWidget(item: items[i]),
                  if (i < items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: _gold.withValues(alpha: 0.05),
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
  const _SettingItemWidget({required this.item});

  final SettingItem item;

  Color get _badgeColor {
    if (item.badge == null) return _muted;
    switch (item.badge!) {
      case 'Active':
        return _green;
      case 'On':
      case 'Woman':
      case 'Child':
        return _gold;
      default:
        return _muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          if (item.label == 'Sign Out') {
            final confirm = await ProfileScreen._showSignOutDialog(context);
            if (confirm == true && context.mounted) {
              Get.offAllNamed(AppRoutes.auth);
            }
          } else if (item.route != null) {
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
                  color: item.danger
                      ? _red.withValues(alpha: 0.1)
                      : _gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 22,
                  color: item.danger ? _red : _gold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: item.danger ? _red : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (item.badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.badge == 'Active'
                        ? _green.withValues(alpha: 0.1)
                        : item.badge == 'On' ||
                              item.badge == 'Woman' ||
                              item.badge == 'Child'
                            ? _gold.withValues(alpha: 0.1)
                            : _cardBorder,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.badge!,
                    style: TextStyle(
                      color: _badgeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (!item.danger)
                Icon(Icons.chevron_right_rounded, color: _muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
