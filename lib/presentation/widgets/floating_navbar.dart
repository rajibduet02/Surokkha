import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Route paths (match React FloatingNav).
const String _routeDashboard = '/dashboard';
const String _routeSafeZones = '/safe-zones';
const String _routeEmergency = '/emergency';
const String _routeContacts = '/contacts';
const String _routeProfile = '/profile';

// Design tokens.
const Color _navBg = Color(0xFF1A1A22);
const Color _navBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _bgDark = Color(0xFF0A0A0F);
const Color _inactive = Color(0xFF8A8A92);
const Color _sosRed = Color(0xFFEF4444);

const double _navHeight = 85;
const double _navHorizontalPadding = 8;
const double _navVerticalPadding = 8;
const double _navBorderRadius = 24;
const double _maxNavWidth = 382;
const double _activeBgBorderRadius = 16;
const double _iconSize = 40;
const double _iconBorderRadius = 12;
const double _iconInnerSize = 24;
const double _blurSigma = 10;
const int _entranceDelayMs = 300;
const int _entranceDurationMs = 300;
const int _activeIndicatorDurationMs = 300;
const int _tapScaleDurationMs = 100;

/// Floating glassmorphism bottom nav bar. Matches React FloatingNav layout and behavior.
class FloatingNavBar extends StatefulWidget {
  const FloatingNavBar({super.key});

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _entranceDurationMs),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    ));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );
    Future.delayed(
      const Duration(milliseconds: _entranceDelayMs),
      () {
        if (mounted) _entranceController.forward();
      },
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  String get _currentRoute => Get.currentRoute;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _entranceController,
            builder: (context, child) {
              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: child,
                ),
              );
            },
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxNavWidth),
              child: _NavGlassContainer(
                currentRoute: _currentRoute,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavGlassContainer extends StatelessWidget {
  const _NavGlassContainer({required this.currentRoute});

  final String currentRoute;

  static const List<_NavItemData> _items = [
    _NavItemData(route: _routeDashboard, label: 'Home', icon: Icons.home_rounded),
    _NavItemData(route: _routeSafeZones, label: 'Zones', icon: Icons.location_on_rounded),
    _NavItemData(route: _routeEmergency, label: 'SOS', icon: Icons.emergency_rounded, isSos: true),
    _NavItemData(route: _routeContacts, label: 'Contacts', icon: Icons.people_rounded),
    _NavItemData(route: _routeProfile, label: 'Profile', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_navBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
        child: Container(
          height: _navHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: _navHorizontalPadding,
            vertical: _navVerticalPadding,
          ),
          decoration: BoxDecoration(
            color: _navBg.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(_navBorderRadius),
            border: Border.all(color: _navBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _items
                .map(
                  (item) => _NavItem(
                    route: item.route,
                    label: item.label,
                    icon: item.icon,
                    isSos: item.isSos,
                    isActive: currentRoute == item.route,
                    onTap: () => Get.toNamed(item.route),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.route,
    required this.label,
    required this.icon,
    this.isSos = false,
  });
  final String route;
  final String label;
  final IconData icon;
  final bool isSos;
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.isSos,
    required this.isActive,
    required this.onTap,
  });

  final String route;
  final String label;
  final IconData icon;
  final bool isSos;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _tapScaleDurationMs),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Color get _labelColor {
    if (widget.isActive) return _gold;
    if (widget.isSos) return _sosRed;
    return _inactive;
  }

  Color get _iconColor {
    if (widget.isActive) return _bgDark;
    if (widget.isSos) return _sosRed;
    return _inactive;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) => _scaleController.reverse(),
      onTapCancel: () => _scaleController.reverse(),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: _activeIndicatorDurationMs),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_activeBgBorderRadius),
                    color: widget.isActive
                        ? _gold.withValues(alpha: 0.10)
                        : Colors.transparent,
                    border: widget.isActive
                        ? Border.all(
                            color: _gold.withValues(alpha: 0.30),
                            width: 1,
                          )
                        : null,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconArea(),
                  const SizedBox(height: 4),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: _labelColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconArea() {
    final showSosGlow = widget.isSos && !widget.isActive;
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: showSosGlow,
          child: Container(
            width: _iconSize,
            height: _iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_iconBorderRadius),
              color: _sosRed.withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: _sosRed.withValues(alpha: 0.3),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ),
        _buildIconContainer(),
      ],
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_iconBorderRadius),
        gradient: widget.isActive
            ? const LinearGradient(
                colors: [_gold, _goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      alignment: Alignment.center,
      child: Icon(
        widget.icon,
        size: _iconInnerSize,
        color: _iconColor,
      ),
    );
  }
}
