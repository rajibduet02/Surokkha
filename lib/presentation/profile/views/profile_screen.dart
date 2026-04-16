import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/controllers/dashboard_controller.dart';
import '../../widgets/floating_navbar.dart';
import '../../widgets/profile_settings_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                        _buildProfileHero(context),
                        const SizedBox(height: 24),
                        const AppStatsRow(),
                        const SizedBox(height: 24),
                        _buildPersonalSection(context),
                        const SizedBox(height: 24),
                        _buildSafetySection(context),
                        const SizedBox(height: 24),
                        const SettingsSectionTitle(title: 'Recent Activity'),
                        const SizedBox(height: 12),
                        const ProfileActivityPanel(),
                        const SizedBox(height: 24),
                        _buildAppVersionFooter(),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const FloatingNavBar(currentRoute: '/profile'),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.offNamed('/dashboard'),
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
              color: AppPremiumTokens.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppPremiumTokens.gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.settings_rounded, color: AppPremiumTokens.gold, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHero(BuildContext context) {
    if (!Get.isRegistered<DashboardController>()) {
      return AppProfileHeroCard(
        name: 'Ayesha Rahman',
        contactLine: 'ayesha.r@email.com',
        showPremiumBadge: true,
        showVerifiedBadge: true,
        onAvatarTap: () => showEditProfileBottomSheet(context),
        onCardTap: () => showEditProfileBottomSheet(context),
      );
    }
    return Obx(() {
      final dash = Get.find<DashboardController>();
      dash.userProfileName.value;
      dash.profileType.value;
      return AppProfileHeroCard(
        name: dash.userProfileName.value,
        contactLine: 'ayesha.r@email.com',
        showPremiumBadge: true,
        showVerifiedBadge: true,
        onAvatarTap: () => showEditProfileBottomSheet(context),
        onCardTap: () => showEditProfileBottomSheet(context),
      );
    });
  }

  Widget _buildPersonalSection(BuildContext context) {
    if (!Get.isRegistered<DashboardController>()) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SettingsSectionTitle(title: 'Personal'),
          const SizedBox(height: 12),
          SettingsGroupedCard(
            children: [
              ProfileActionTile(
                icon: Icons.person_rounded,
                label: 'Personal Information',
                onTap: () {},
              ),
              ProfileActionTile(
                icon: Icons.person_rounded,
                label: 'Profile Type',
                badge: 'Woman',
                onTap: () => Get.toNamed('/profile-type'),
              ),
            ],
          ),
        ],
      );
    }
    return Obx(() {
      final dash = Get.find<DashboardController>();
      dash.profileType.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SettingsSectionTitle(title: 'Personal'),
          const SizedBox(height: 12),
          SettingsGroupedCard(
            children: [
              ProfileActionTile(
                icon: Icons.person_rounded,
                label: 'Personal Information',
                onTap: () {},
              ),
              ProfileActionTile(
                icon: dash.isChild ? Icons.child_care_rounded : Icons.person_rounded,
                label: 'Profile Type',
                badge: dash.isChild ? 'Child' : 'Woman',
                onTap: () => Get.toNamed('/profile-type'),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildSafetySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SettingsSectionTitle(title: 'Safety shortcuts'),
        const SizedBox(height: 12),
        SettingsGroupedCard(
          children: [
            ProfileActionTile(
              icon: Icons.phone_rounded,
              label: 'Emergency Contacts',
              badge: '5',
              onTap: () => Get.toNamed('/contacts'),
            ),
            ProfileActionTile(
              icon: Icons.location_on_rounded,
              label: 'Safe Zones',
              badge: '12',
              onTap: () => Get.toNamed('/safe-zones'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppVersionFooter() {
    return const Column(
      children: [
        Text(
          'Surokkha v2.1.0',
          style: TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
        ),
        SizedBox(height: 4),
        Text(
          'Made with care for Bangladesh',
          style: TextStyle(color: AppPremiumTokens.muted, fontSize: 12),
        ),
      ],
    );
  }
}
