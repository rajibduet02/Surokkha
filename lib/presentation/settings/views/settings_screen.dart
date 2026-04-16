import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../widgets/floating_navbar.dart';
import '../../widgets/profile_settings_components.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  static const Color _bg = AppPremiumTokens.bg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: MediaQuery.sizeOf(context).height < 640 ? 16 : 24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 24),
                        _buildAccountSection(context),
                        const SizedBox(height: 24),
                        _buildSafetySection(),
                        const SizedBox(height: 24),
                        _buildNotificationSection(),
                        const SizedBox(height: 24),
                        _buildAppSection(),
                        const SizedBox(height: 24),
                        _buildSupportSection(),
                        const SizedBox(height: 24),
                        _buildLegalSection(),
                        const SizedBox(height: 32),
                        _buildSignOutButton(context),
                        const SizedBox(height: 24),
                        _buildFooter(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const FloatingNavBar(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Get.back();
            } else {
              Get.offNamed('/dashboard');
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppPremiumTokens.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppPremiumTokens.gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_rounded, color: AppPremiumTokens.gold, size: 22),
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

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Account'),
        const SizedBox(height: 12),
        SettingsGroupedCard(
          children: [
            SettingsNavTile(
              icon: Icons.person_rounded,
              title: 'Personal Information',
              subtitle: 'Name, phone, email',
              onTap: () => Get.toNamed('/profile'),
            ),
            if (Get.isRegistered<DashboardController>())
              Obx(() {
                final dash = Get.find<DashboardController>();
                dash.profileType.value;
                return SettingsNavTile(
                  icon: dash.isChild ? Icons.child_care_rounded : Icons.person_outline_rounded,
                  title: 'Profile Type',
                  subtitle: dash.isChild ? 'Child profile' : 'Woman profile',
                  badge: dash.isChild ? 'Child' : 'Woman',
                  onTap: () => Get.toNamed('/profile-type'),
                );
              })
            else
              SettingsNavTile(
                icon: Icons.person_outline_rounded,
                title: 'Profile Type',
                subtitle: 'Woman profile',
                badge: 'Woman',
                onTap: () => Get.toNamed('/profile-type'),
              ),
            SettingsNavTile(
              icon: Icons.workspace_premium_rounded,
              title: 'Subscription',
              subtitle: 'Manage your plan',
              badge: 'Premium',
              badgeGradient: true,
              onTap: () => Get.toNamed('/premium'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSafetySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Safety settings'),
        const SizedBox(height: 12),
        Obx(
          () => SettingsGroupedCard(
            children: [
              SettingsNavTile(
                icon: Icons.phone_rounded,
                title: 'Emergency Contacts',
                subtitle: 'Trusted contacts for SOS',
                onTap: () => Get.toNamed('/contacts'),
              ),
              SettingsNavTile(
                icon: Icons.map_rounded,
                title: 'Safe Zones',
                subtitle: 'Geofenced safe areas',
                onTap: () => Get.toNamed('/safe-zones'),
              ),
              AppToggleTile(
                icon: Icons.location_on_rounded,
                title: 'Location Sharing',
                subtitle: 'Share live location with guardians',
                value: controller.locationSharing.value,
                onChanged: (v) => controller.locationSharing.value = v,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Notifications'),
        const SizedBox(height: 12),
        Obx(
          () => SettingsGroupedCard(
            children: [
              AppToggleTile(
                icon: Icons.notifications_rounded,
                title: 'Push Notifications',
                subtitle: 'In-app alerts',
                value: controller.pushNotifications.value,
                onChanged: (v) => controller.pushNotifications.value = v,
              ),
              AppToggleTile(
                icon: Icons.sms_rounded,
                title: 'SMS Alerts',
                subtitle: 'Text message alerts',
                value: controller.smsAlerts.value,
                onChanged: (v) => controller.smsAlerts.value = v,
              ),
              AppToggleTile(
                icon: Icons.warning_rounded,
                title: 'Emergency Alerts',
                subtitle: 'Critical safety notifications',
                value: controller.emergencyAlerts.value,
                onChanged: (v) => controller.emergencyAlerts.value = v,
              ),
              AppToggleTile(
                icon: Icons.volume_up_rounded,
                title: 'Sound',
                subtitle: 'Alert sounds',
                value: controller.soundEnabled.value,
                onChanged: (v) => controller.soundEnabled.value = v,
              ),
              AppToggleTile(
                icon: Icons.vibration_rounded,
                title: 'Vibration',
                subtitle: 'Haptic feedback for alerts',
                value: controller.vibrationEnabled.value,
                onChanged: (v) => controller.vibrationEnabled.value = v,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'App settings'),
        const SizedBox(height: 12),
        Obx(
          () => SettingsGroupedCard(
            children: [
              AppToggleTile(
                icon: Icons.dark_mode_rounded,
                title: 'Dark Mode',
                subtitle: 'Use dark appearance (UI preview)',
                value: controller.darkModeEnabled.value,
                onChanged: (v) => controller.darkModeEnabled.value = v,
              ),
              SettingsLanguageRow(controller: controller),
              SettingsNavTile(
                icon: Icons.shield_rounded,
                title: 'Privacy & Security',
                subtitle: 'Data protection & account security',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Support'),
        const SizedBox(height: 12),
        SettingsGroupedCard(
          children: [
            SettingsNavTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & FAQ',
              subtitle: 'Answers to common questions',
              onTap: () {},
            ),
            SettingsNavTile(
              icon: Icons.support_agent_rounded,
              title: 'Contact Support',
              subtitle: 'Reach our care team',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Legal'),
        const SizedBox(height: 12),
        SettingsGroupedCard(
          children: [
            SettingsNavTile(
              icon: Icons.description_rounded,
              title: 'Terms of Service',
              subtitle: 'Read our terms',
              onTap: () {},
            ),
            SettingsNavTile(
              icon: Icons.lock_rounded,
              title: 'Privacy Policy',
              subtitle: 'How we protect your data',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () async {
          final confirm = await showAppSignOutDialog(context);
          if (confirm == true && context.mounted) {
            Get.offAllNamed(AppRoutes.auth);
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPremiumTokens.red,
          side: BorderSide(color: AppPremiumTokens.red.withValues(alpha: 0.55)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Sign Out',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text(
          'Safety Shield v2.1.0',
          style: TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          '© 2026 Safety Shield. All rights reserved.',
          style: TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
