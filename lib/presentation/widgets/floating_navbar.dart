import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// Route paths (match React FloatingNav).
const String routeDashboard = '/dashboard';
const String routeSafeZones = '/safe-zones';
const String routeEmergency = '/emergency';
const String routeContacts = '/contacts';
const String routeProfile = '/profile';

// Design tokens (Figma/React).
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _bgDark = Color(0xFF0A0A0F);
const Color _inactive = Color(0xFF8A8A92);
const Color _sosRed = Color(0xFFFF2D55);

const double _navHeight = 88;
const double _navBorderRadius = 22;
const double _activePillBorderRadius = 16;
const double _iconContainerSize = 40;
const double _iconSize = 24;
const double _iconLabelGap = 4;
const int _animationMs = 250;

/// Floating bottom nav bar. Matches React/Figma: glass container, gold active pill,
/// red inactive SOS, equal-width tabs with centered pill, 250ms animation.
///
/// Pass [currentRoute] so the correct tab is highlighted. If null, uses [Get.currentRoute].
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key, this.currentRoute});

  final String? currentRoute;

  String get _activeRoute => currentRoute ?? Get.currentRoute;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Container(
            height: _navHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_navBorderRadius),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1C1C24),
                  Color(0xFF14141B),
                ],
              ),
              border: Border.all(
                color: const Color(0x22FFFFFF),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Center(child: _NavItem(data: _NavItemData.items[0], isActive: _activeRoute == _NavItemData.items[0].route, onTap: () => _navigate(_NavItemData.items[0].route)))),
                Expanded(child: Center(child: _NavItem(data: _NavItemData.items[1], isActive: _activeRoute == _NavItemData.items[1].route, onTap: () => _navigate(_NavItemData.items[1].route)))),
                Expanded(child: Center(child: _NavItem(data: _NavItemData.items[2], isActive: _activeRoute == _NavItemData.items[2].route, onTap: () => _navigate(_NavItemData.items[2].route)))),
                Expanded(child: Center(child: _NavItem(data: _NavItemData.items[3], isActive: _activeRoute == _NavItemData.items[3].route, onTap: () => _navigate(_NavItemData.items[3].route)))),
                Expanded(child: Center(child: _NavItem(data: _NavItemData.items[4], isActive: _activeRoute == _NavItemData.items[4].route, onTap: () => _navigate(_NavItemData.items[4].route)))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate(String route) {
    if (Get.currentRoute == route) return;
    Get.offNamed(route);
  }
}

class _NavItemData {
const _NavItemData({
  required this.route,
  required this.label,
  this.icon,
  this.svgPath,
  this.isSos = false,
});
  final String route;
  final String label;
  final bool isSos;
  final IconData? icon;
  final String? svgPath;

  static const List<_NavItemData> items = [
    _NavItemData(route: routeDashboard, label: 'Home', icon: Icons.home_rounded),
    _NavItemData(route: routeSafeZones, label: 'Zones', icon: Icons.location_on_rounded),
    _NavItemData(route: routeEmergency, label: 'SOS', icon: Icons.emergency_rounded, isSos: true),
    _NavItemData(route: routeContacts, label: 'Contacts', icon: Icons.people_rounded),
    _NavItemData(route: routeProfile, label: 'Profile', icon: Icons.person_rounded),
  ];
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  final _NavItemData data;
  final bool isActive;
  final VoidCallback onTap;

  Color get _iconColor {
    if (isActive) return _bgDark;
    if (data.isSos) return _sosRed;
    return _inactive;
  }

  Color get _textColor {
    if (isActive) return _bgDark;
    if (data.isSos) return _sosRed;
    return _inactive;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_activePillBorderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: _animationMs),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: isActive ? 10 : 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_activePillBorderRadius),
              gradient: isActive
                  ? const LinearGradient(
                      colors: [_gold, _goldLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0x33D4AF37),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _iconContainerSize,
                  height: _iconContainerSize,
                  child: Center(
                    child: data.isSos
                        ? SvgPicture.asset(
                            'assets/icons/shield-alert.svg',
                            width: _iconSize,
                            height: _iconSize,
                            colorFilter: ColorFilter.mode(
                              _iconColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : Icon(
                            data.icon,
                            size: _iconSize,
                            color: _iconColor,
                          ),
                  ),
                ),
                SizedBox(height: _iconLabelGap),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: _animationMs),
                  curve: Curves.easeOut,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    color: _textColor,
                  ),
                  child: Text(
                    data.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
