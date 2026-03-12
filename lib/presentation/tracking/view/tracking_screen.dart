import 'package:flutter/material.dart';

// Design tokens (match React / design).
const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _gold = Color(0xFFD6B35B);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _textWhite = Color(0xFFFFFFFF);

/// Compact status card for top-right (Moving / Accuracy). Fixed 72×56, dark navy, gold border.
class TrackingStatusCard extends StatelessWidget {
  const TrackingStatusCard({
    super.key,
    required this.label,
    required this.labelColor,
    required this.value,
  });

  final String label;
  final Color labelColor;
  final Widget value;

  static const double _cardWidth = 72;
  static const double _cardHeight = 56;
  static const double _borderRadius = 14;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _cardWidth,
      height: _cardHeight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF070B16),
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
            width: 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
              const SizedBox(height: 4),
              DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                child: value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full-screen tracking view: map placeholder, coordinates/speed/accuracy panel,
/// radar pulse, bottom card with actions. Navigate from Emergency "View Full Map";
/// "Back to Emergency" pops.
class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          _buildMapBackground(),
          _buildMapGridOverlay(),
          SafeArea(
            child: Column(
              children: [
                _buildTopPanel(),
                const Spacer(),
                _buildBottomCard(),
              ],
            ),
          ),
          _buildCenterRadar(),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _bg,
              const Color(0xFF14141B),
              const Color(0xFF0D0D12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapGridOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _MapGridPainter(),
        ),
      ),
    );
  }

  Widget _buildTopPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildCoordinatesBox()),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TrackingStatusCard(
                label: 'Moving',
                labelColor: const Color(0xFF23D18B),
                value: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '12',
                      style: TextStyle(
                        color: _textWhite,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'km/h',
                      style: TextStyle(
                        color: _textWhite.withValues(alpha: 0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TrackingStatusCard(
                label: 'Accuracy',
                labelColor: const Color(0xFFD4AF37),
                value: Text(
                  '±5m',
                  style: TextStyle(
                    color: _textWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinatesBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _card.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '23.8103° N , 90.4125° E',
            style: TextStyle(
              color: _textWhite,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dhaka, Bangladesh',
            style: TextStyle(color: _muted, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterRadar() {
    return Center(
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildPulseRing(0.3),
              _buildPulseRing(0.6),
              _buildPulseRing(1.0),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _gold,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _gold.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPulseRing(double delay) {
    final t = (_pulseController.value + delay) % 1.0;
    final scale = 0.5 + t * 1.8;
    final opacity = (1.0 - t) * 0.4;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _gold.withValues(alpha: opacity),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: _card.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _gold.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          const SizedBox(height: 12),
          _buildLiveIndicator(),
          const SizedBox(height: 8),
          Text(
            'Sarah Rahman',
            style: TextStyle(
              color: _textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Last updated 2 min ago',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 16),
          const TrackingActionButtons(),
          const SizedBox(height: 14),
          _buildBackToEmergencyButton(),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: _muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildLiveIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: _green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _green.withValues(alpha: 0.6),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'Live Tracking Active',
          style: TextStyle(
            color: _green,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBackToEmergencyButton() {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_gold, _goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _gold.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Back to Emergency',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0A0A0F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Action button design tokens (match React).
const Color _actionCard = Color(0xFF1A1A22);
const Color _actionCardBorder = Color(0xFF2A2A32);
const Color _actionGold = Color(0xFFD4AF37);
const Color _actionGoldLight = Color(0xFFF6D365);
const Color _actionGreen = Color(0xFF10B981);
const Color _actionGreenDark = Color(0xFF059669);
const Color _actionTextMuted = Color(0xFFCFCFCF);

/// Action buttons row (Call, Share, Mark Safe) for Live Tracking panel. Matches React layout.
class TrackingActionButtons extends StatelessWidget {
  const TrackingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ScalableActionButton(
            onTap: () {},
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_actionCard, _actionCardBorder],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _actionGold.withValues(alpha: 0.3)),
            ),
            child: _ActionButtonContent(
              icon: Icons.phone_rounded,
              iconColor: _actionGold,
              iconBgColor: _actionGold.withValues(alpha: 0.1),
              label: 'Call',
              labelColor: _actionTextMuted,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ScalableActionButton(
            onTap: () {},
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_actionCard, _actionCardBorder],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _actionGoldLight.withValues(alpha: 0.3)),
            ),
            child: _ActionButtonContent(
              icon: Icons.share_rounded,
              iconColor: _actionGoldLight,
              iconBgColor: _actionGoldLight.withValues(alpha: 0.1),
              label: 'Share',
              labelColor: _actionTextMuted,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _ScalableActionButton(
            onTap: () {},
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _actionGreen.withValues(alpha: 0.2),
                  _actionGreenDark.withValues(alpha: 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _actionGreen.withValues(alpha: 0.3)),
            ),
            child: _ActionButtonContent(
              icon: Icons.check_circle_rounded,
              iconColor: _actionGreen,
              iconBgColor: _actionGreen.withValues(alpha: 0.1),
              label: 'Mark Safe',
              labelColor: _actionGreen,
            ),
          ),
        ),
      ],
    );
  }
}

class _ScalableActionButton extends StatefulWidget {
  const _ScalableActionButton({
    required this.onTap,
    required this.decoration,
    required this.child,
  });

  final VoidCallback onTap;
  final BoxDecoration decoration;
  final Widget child;

  @override
  State<_ScalableActionButton> createState() => _ScalableActionButtonState();
}

class _ScalableActionButtonState extends State<_ScalableActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: widget.decoration,
          child: widget.child,
        ),
      ),
    );
  }
}

class _ActionButtonContent extends StatelessWidget {
  const _ActionButtonContent({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.labelColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 24, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
      ],
    );
  }
}

/// Simple grid overlay for map placeholder.
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD6B35B).withValues(alpha: 0.06)
      ..strokeWidth = 1;
    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
