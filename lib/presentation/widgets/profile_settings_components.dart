import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../settings/controllers/settings_controller.dart';

/// Shared design tokens for Profile & Settings (matches dashboard / app premium theme).
abstract final class AppPremiumTokens {
  static const Color bg = Color(0xFF0A0A0F);
  static const Color card = Color(0xFF1A1A22);
  static const Color cardBorder = Color(0xFF2A2A32);
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF6D365);
  static const Color green = Color(0xFF10B981);
  static const Color muted = Color(0xFF8A8A92);
  static const Color bgDark = Color(0xFF0A0A0F);
  static const Color red = Color(0xFFEF4444);
}

/// Section title above grouped cards.
class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppPremiumTokens.muted,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Gradient bordered card container for grouped rows.
class SettingsGroupedCard extends StatelessWidget {
  const SettingsGroupedCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPremiumTokens.card, AppPremiumTokens.cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPremiumTokens.gold.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppPremiumTokens.gold.withValues(alpha: 0.05),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Profile hero: avatar, name, contact line, badges; tap opens edit sheet callback.
class AppProfileHeroCard extends StatelessWidget {
  const AppProfileHeroCard({
    super.key,
    required this.name,
    required this.contactLine,
    required this.showPremiumBadge,
    required this.showVerifiedBadge,
    this.onAvatarTap,
    required this.onCardTap,
  });

  final String name;
  final String contactLine;
  final bool showPremiumBadge;
  final bool showVerifiedBadge;
  final VoidCallback? onAvatarTap;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onCardTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppPremiumTokens.card, AppPremiumTokens.cardBorder],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppPremiumTokens.gold.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onAvatarTap ?? onCardTap,
                child: SizedBox(
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
                            colors: [AppPremiumTokens.gold, AppPremiumTokens.goldLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: const TextStyle(
                            color: AppPremiumTokens.bgDark,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (showVerifiedBadge)
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppPremiumTokens.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppPremiumTokens.card, width: 4),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.shield_rounded, color: Colors.white, size: 14),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contactLine,
                      style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (showPremiumBadge) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.workspace_premium_rounded, color: AppPremiumTokens.gold, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Premium',
                            style: TextStyle(
                              color: AppPremiumTokens.gold,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.edit_rounded, color: AppPremiumTokens.muted, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// One stat cell in the profile stats row.
class AppStatCell extends StatelessWidget {
  const AppStatCell({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPremiumTokens.card, AppPremiumTokens.cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPremiumTokens.gold.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppPremiumTokens.gold,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 11),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Three dashboard-style stat pills.
class AppStatsRow extends StatelessWidget {
  const AppStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: AppStatCell(label: 'Protected Days', value: '87')),
        const SizedBox(width: 12),
        const Expanded(child: AppStatCell(label: 'Safe Zones', value: '12')),
        const SizedBox(width: 12),
        const Expanded(child: AppStatCell(label: 'Check-ins', value: '234')),
      ],
    );
  }
}

/// Profile list row: icon, label, optional badge, chevron (no subtitle).
class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.icon,
    required this.label,
    this.badge,
    this.danger = false,
    this.onTap,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final String? badge;
  final bool danger;
  final VoidCallback? onTap;
  final bool showChevron;

  Color get _badgeColor {
    if (badge == null) return AppPremiumTokens.muted;
    switch (badge!) {
      case 'Active':
        return AppPremiumTokens.green;
      case 'Woman':
      case 'Child':
        return AppPremiumTokens.gold;
      default:
        return AppPremiumTokens.muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: danger
                      ? AppPremiumTokens.red.withValues(alpha: 0.1)
                      : AppPremiumTokens.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 22,
                  color: danger ? AppPremiumTokens.red : AppPremiumTokens.gold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: danger ? AppPremiumTokens.red : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badge == 'Active'
                        ? AppPremiumTokens.green.withValues(alpha: 0.1)
                        : badge == 'Woman' || badge == 'Child'
                            ? AppPremiumTokens.gold.withValues(alpha: 0.1)
                            : AppPremiumTokens.cardBorder,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      color: _badgeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (showChevron && !danger)
                const Icon(Icons.chevron_right_rounded, color: AppPremiumTokens.muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

/// Settings navigation row with title + subtitle.
class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.badgeGradient = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final bool badgeGradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppPremiumTokens.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 22, color: AppPremiumTokens.gold),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (badge != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: badgeGradient
                        ? const LinearGradient(
                            colors: [AppPremiumTokens.gold, AppPremiumTokens.goldLight],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : null,
                    color: badgeGradient ? null : AppPremiumTokens.cardBorder,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      color: badgeGradient ? AppPremiumTokens.bgDark : AppPremiumTokens.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Icon(Icons.chevron_right_rounded, color: AppPremiumTokens.muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

/// Settings row with trailing switch.
class AppToggleTile extends StatelessWidget {
  const AppToggleTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppPremiumTokens.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 22, color: AppPremiumTokens.gold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppPremiumTokens.green,
            inactiveTrackColor: AppPremiumTokens.muted.withValues(alpha: 0.35),
            activeThumbColor: Colors.white,
            inactiveThumbColor: AppPremiumTokens.muted,
          ),
        ],
      ),
    );
  }
}

/// Language selector (English / Bangla) bound to [SettingsController].
class SettingsLanguageRow extends StatelessWidget {
  const SettingsLanguageRow({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEnglish = controller.selectedLanguage.value == 'english';
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
                    color: AppPremiumTokens.gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.language_rounded, size: 22, color: AppPremiumTokens.gold),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isEnglish ? 'English' : 'বাংলা',
                        style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
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
                                colors: [AppPremiumTokens.gold, AppPremiumTokens.goldLight],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        color: isEnglish ? null : AppPremiumTokens.cardBorder,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'English',
                        style: TextStyle(
                          color: isEnglish ? AppPremiumTokens.bgDark : AppPremiumTokens.muted,
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
                                colors: [AppPremiumTokens.gold, AppPremiumTokens.goldLight],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        color: !isEnglish ? null : AppPremiumTokens.cardBorder,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                          color: !isEnglish ? AppPremiumTokens.bgDark : AppPremiumTokens.muted,
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

/// Glass-style activity block (dashboard timeline pattern).
class ProfileActivityPanel extends StatelessWidget {
  const ProfileActivityPanel({super.key});

  static const _items = [
    ('Location shared with contacts', '2 hours ago'),
    ('Safe zone arrival detected', '5 hours ago'),
    ('Night mode activated', '8 hours ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppPremiumTokens.card.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppPremiumTokens.green.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppPremiumTokens.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.timeline_rounded, size: 24, color: AppPremiumTokens.green),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Last 24 hours',
                        style: TextStyle(color: AppPremiumTokens.muted, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(
                _items.length,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: i < _items.length - 1 ? 12 : 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 64),
                      const Icon(Icons.check_circle_rounded, size: 16, color: AppPremiumTokens.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _items[i].$1,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              _items[i].$2,
                              style: const TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> showAppSignOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppPremiumTokens.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Sign Out',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      content: const Text(
        'Are you sure you want to sign out? You will need to sign in again to access your account.',
        style: TextStyle(color: AppPremiumTokens.muted, fontSize: 14, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel', style: TextStyle(color: AppPremiumTokens.gold)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            'Sign Out',
            style: TextStyle(color: AppPremiumTokens.red, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

void showEditProfileBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppPremiumTokens.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (ctx) {
      final bottom = MediaQuery.viewInsetsOf(ctx).bottom;
      return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppPremiumTokens.cardBorder,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Update your name, photo, and contact details. Full editing will be available in a future update.',
              style: TextStyle(color: AppPremiumTokens.muted, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Navigator.pop(ctx),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppPremiumTokens.gold,
                side: BorderSide(color: AppPremiumTokens.gold.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
