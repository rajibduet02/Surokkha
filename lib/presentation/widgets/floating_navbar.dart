import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// —— Routes (match React FloatingNav) ——
const String routeDashboard = '/dashboard';
const String routeSafeZones = '/safe-zones';
const String routeEmergency = '/emergency';
const String routeContacts = '/contacts';
const String routeProfile = '/profile';

// —— Colors (Figma / React) ——
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _bgDark = Color(0xFF0A0A0F);
const Color _barFill = Color(0xFF1A1A22);
const Color _barBorder = Color(0xFF2A2A32);
const Color _inactiveIcon = Color(0xFF8A8A92);
const Color _inactiveLabel = Color(0xFF8A8A92);
const Color _sosRed = Color(0xFFEF4444);

// —— Layout ——
const double _kMaxBarWidth = 382;
const double _kHorizontalInset = 24; // screen width − 48 max content gutter
const double _kBottomPadding = 22;
const double _kBarBorderRadius = 24;
const double _kPillBorderRadius = 16;
const double _kPillHorizontalInset = 4;
const double _kBarInnerPaddingV = 10;
const double _kBarInnerPaddingH = 6;
const double _kIconContainerSize = 40;
const double _kIconContainerRadius = 12;
const double _kIconSize = 24;
const double _kIconLabelGap = 4;
/// Room for one line of 10px text (incl. web font metrics) + item vertical padding (2+2).
const double _kLabelSlotHeight = 15;
const double _kItemPaddingV = 4;
const int _kAnimationMs = 300;
const double _kBlurSigma = 16;
const double _kBarFillOpacity = 0.95;
const double _kShadowBlur = 20;
const double _kPillFillOpacity = 0.1;
const double _kPillBorderOpacity = 0.3;
const double _kSosGlowBlur = 14;
const double _kSosGlowSpread = 0;
const double _kSosGlowOpacity = 0.35;

/// Floating bottom navigation: glass bar, animated active pill, GetX routing.
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key, this.currentRoute});

  final String? currentRoute;

  String get _activeRoute => currentRoute ?? Get.currentRoute;

  int get _activeIndex {
    final r = _activeRoute;
    final items = _NavItemData.items;
    for (var i = 0; i < items.length; i++) {
      if (items[i].route == r) return i;
    }
    return 0;
  }

  void _navigate(String route) {
    if (Get.currentRoute == route) return;
    Get.offNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardBottom = MediaQuery.viewInsetsOf(context).bottom;
    final bottomPad = _kBottomPadding + keyboardBottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            _kHorizontalInset,
            0,
            _kHorizontalInset,
            bottomPad,
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                final barWidth = math.min(maxW, _kMaxBarWidth);
                final innerW = barWidth - 2 * _kBarInnerPaddingH;
                final segmentW = innerW / _NavItemData.items.length;
                final pillW = segmentW - 2 * _kPillHorizontalInset;
                final pillLeft =
                    _activeIndex * segmentW + _kPillHorizontalInset;

                return _GlassNavBar(
                  width: barWidth,
                  activeIndex: _activeIndex,
                  pillLeft: pillLeft,
                  pillWidth: pillW,
                  onItemTap: _navigate,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({
    required this.width,
    required this.activeIndex,
    required this.pillLeft,
    required this.pillWidth,
    required this.onItemTap,
  });

  final double width;
  final int activeIndex;
  final double pillLeft;
  final double pillWidth;
  final void Function(String route) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kBarBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: _kShadowBlur,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_kBarBorderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _kBlurSigma,
              sigmaY: _kBlurSigma,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _barFill.withValues(alpha: _kBarFillOpacity),
                borderRadius: BorderRadius.circular(_kBarBorderRadius),
                border: Border.all(color: _barBorder, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: _kBarInnerPaddingH,
                  vertical: _kBarInnerPaddingV,
                ),
                child: SizedBox(
                  height: _navContentHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: _kAnimationMs),
                        curve: Curves.easeOut,
                        left: pillLeft,
                        top: 0,
                        bottom: 0,
                        width: pillWidth,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _gold.withValues(alpha: _kPillFillOpacity),
                            borderRadius:
                                BorderRadius.circular(_kPillBorderRadius),
                            border: Border.all(
                              color: _gold.withValues(
                                alpha: _kPillBorderOpacity,
                              ),
                              width: 1,
                            ),
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                      Row(
                        children: [
                          for (var i = 0;
                              i < _NavItemData.items.length;
                              i++) ...[
                            Expanded(
                              child: _NavItem(
                                data: _NavItemData.items[i],
                                isActive: i == activeIndex,
                                onTap: () => onItemTap(_NavItemData.items[i].route),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Stack height = icon + gap + label slot + InkWell vertical padding.
double get _navContentHeight =>
    _kIconContainerSize +
    _kIconLabelGap +
    _kLabelSlotHeight +
    _kItemPaddingV;

class _NavItemData {
  const _NavItemData({
    required this.route,
    required this.label,
    this.icon,
    this.isSos = false,
  });

  final String route;
  final String label;
  final bool isSos;
  final IconData? icon;

  static const List<_NavItemData> items = [
    _NavItemData(route: routeDashboard, label: 'Home', icon: Icons.home_rounded),
    _NavItemData(
      route: routeSafeZones,
      label: 'Zones',
      icon: Icons.location_on_rounded,
    ),
    _NavItemData(
      route: routeEmergency,
      label: 'SOS',
      icon: Icons.emergency_rounded,
      isSos: true,
    ),
    _NavItemData(
      route: routeContacts,
      label: 'Contacts',
      icon: Icons.people_rounded,
    ),
    _NavItemData(
      route: routeProfile,
      label: 'Profile',
      icon: Icons.person_rounded,
    ),
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
    return _inactiveIcon;
  }

  Color get _labelColor {
    if (isActive) return _gold;
    if (data.isSos) return _sosRed;
    return _inactiveLabel;
  }

  @override
  Widget build(BuildContext context) {
    return _NavItemTapScale(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: _gold.withValues(alpha: 0.12),
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(_kPillBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: _kAnimationMs),
                  curve: Curves.easeOut,
                  width: _kIconContainerSize,
                  height: _kIconContainerSize,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_kIconContainerRadius),
                    gradient: isActive
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_gold, _goldLight],
                          )
                        : null,
                    color: isActive ? null : Colors.transparent,
                    boxShadow: data.isSos
                        ? [
                            BoxShadow(
                              color: _sosRed.withValues(alpha: _kSosGlowOpacity),
                              blurRadius: _kSosGlowBlur,
                              spreadRadius: _kSosGlowSpread,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: data.isSos
                        ? SvgPicture.asset(
                            'assets/icons/shield-alert.svg',
                            width: _kIconSize,
                            height: _kIconSize,
                            colorFilter: ColorFilter.mode(
                              _iconColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : Icon(
                            data.icon,
                            size: _kIconSize,
                            color: _iconColor,
                          ),
                  ),
                ),
                SizedBox(height: _kIconLabelGap),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: _kAnimationMs),
                  curve: Curves.easeOut,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                    color: _labelColor,
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

/// Scale to 0.95 on press; does not handle navigation (child [InkWell] does).
class _NavItemTapScale extends StatefulWidget {
  const _NavItemTapScale({required this.child});

  final Widget child;

  @override
  State<_NavItemTapScale> createState() => _NavItemTapScaleState();
}

class _NavItemTapScaleState extends State<_NavItemTapScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _c.forward(),
      onPointerUp: (_) => _c.reverse(),
      onPointerCancel: (_) => _c.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
