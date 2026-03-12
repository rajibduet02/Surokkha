import 'dart:async';
import 'package:flutter/material.dart';

// Design tokens (match React EmergencyRecordingScreen).
const Color _bgTop = Color(0xFF0B0F1A);
const Color _bgBottom = Color(0xFF14040C);
const Color _cardFrom = Color(0xFF1B1F2A);
const Color _cardTo = Color(0xFF232838);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _red = Color(0xFFFF3B3B);
const Color _muted = Color(0xFF8A8A92);
const Color _textSoft = Color(0xFFCFCFCF);
const Color _amber = Color(0xFFF59E0B);

enum _RecordingStage {
  recording,
  capturing,
  encrypting,
  uploading,
  complete,
}

class EmergencyRecordingScreen extends StatefulWidget {
  const EmergencyRecordingScreen({super.key});

  @override
  State<EmergencyRecordingScreen> createState() => _EmergencyRecordingScreenState();
}

class _EmergencyRecordingScreenState extends State<EmergencyRecordingScreen>
    with TickerProviderStateMixin {
  int _recordingTime = 0;
  _RecordingStage _stage = _RecordingStage.recording;
  double _uploadProgress = 0;
  Timer? _timer;
  Timer? _stageTimer;
  AnimationController? _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _startRecordingTimer();
  }

  void _startRecordingTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_stage != _RecordingStage.recording) return;
      setState(() {
        if (_recordingTime >= 29) {
          _stage = _RecordingStage.capturing;
          _recordingTime = 30;
          _timer?.cancel();
          _scheduleStageTransition();
        } else {
          _recordingTime++;
        }
      });
    });
  }

  void _scheduleStageTransition() {
    _stageTimer?.cancel();
    if (_stage == _RecordingStage.capturing) {
      _stageTimer = Timer(const Duration(milliseconds: 1500), () {
        setState(() => _stage = _RecordingStage.encrypting);
        _scheduleStageTransition();
      });
    } else if (_stage == _RecordingStage.encrypting) {
      _stageTimer = Timer(const Duration(milliseconds: 2000), () {
        setState(() => _stage = _RecordingStage.uploading);
        _startUploadProgress();
      });
    }
  }

  void _startUploadProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      setState(() {
        if (_uploadProgress >= 100) {
          _stage = _RecordingStage.complete;
          _timer?.cancel();
        } else {
          _uploadProgress += 10;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stageTimer?.cancel();
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgTop,
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildMainCard(),
                  const SizedBox(height: 24),
                  _buildSecureStorageCard(),
                  if (_stage == _RecordingStage.complete) ...[
                    const SizedBox(height: 24),
                    _buildEvidenceCollectedSection(),
                    const SizedBox(height: 24),
                    _buildEvidenceSharedCard(),
                    const SizedBox(height: 24),
                    _buildViewEmergencyStatusButton(),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgBottom],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A22),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _gold.withValues(alpha: 0.5)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, color: _gold, size: 24),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'EMERGENCY RECORDING ACTIVE',
              style: TextStyle(
                color: _red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_cardFrom, _cardTo],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _red.withValues(alpha: 0.2)),
      ),
      child: _buildMainCardContent(),
    );
  }

  Widget _buildMainCardContent() {
    switch (_stage) {
      case _RecordingStage.recording:
        return _buildRecordingState();
      case _RecordingStage.capturing:
        return _buildCapturingState();
      case _RecordingStage.encrypting:
        return _buildEncryptingState();
      case _RecordingStage.uploading:
        return _buildUploadingState();
      case _RecordingStage.complete:
        return _buildCompleteState();
    }
  }

  Widget _buildRecordingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildRecordingIconWithPulse(),
        const SizedBox(height: 16),
        Text(
          '${_recordingTime}s',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Recording evidence...',
          style: TextStyle(color: _textSoft, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRecordingIconWithPulse() {
    return AnimatedBuilder(
      animation: _pulseController!,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (_stage == _RecordingStage.recording)
              Container(
                width: 96 + (_pulseController!.value * 24),
                height: 96 + (_pulseController!.value * 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _red.withValues(alpha: 0.3 - _pulseController!.value * 0.3),
                    width: 2,
                  ),
                ),
              ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: _red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: _red.withValues(alpha: 0.3), width: 2),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.videocam_rounded, color: _red, size: 48),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCapturingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _gold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.camera_alt_rounded, color: _gold, size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'Capturing Image',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Silent front camera capture',
          style: TextStyle(color: _textSoft, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildEncryptingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.lock_rounded, color: _green, size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'Encrypting Data',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'AES-256 end-to-end encryption',
          style: TextStyle(color: _textSoft, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildUploadingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _gold.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.upload_rounded, color: _gold, size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'Uploading',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Secure transfer to server',
          style: TextStyle(color: _textSoft, fontSize: 16),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: _uploadProgress / 100,
            minHeight: 12,
            backgroundColor: _bgTop,
            valueColor: AlwaysStoppedAnimation<Color>(_gold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_uploadProgress.toInt()}% complete',
          style: TextStyle(color: _gold, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildCompleteState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.check_circle_rounded, color: _green, size: 48),
        ),
        const SizedBox(height: 16),
        Text(
          'Evidence Secured',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'All data uploaded successfully',
          style: TextStyle(color: _textSoft, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSecureStorageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_green.withValues(alpha: 0.15), _green.withValues(alpha: 0.08)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _green.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_rounded, color: _green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Evidence Storage',
                  style: TextStyle(
                    color: _green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'All recordings are encrypted with AES-256 encryption and stored securely. Only you and your guardians can access this evidence.',
                  style: TextStyle(color: _muted, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceCollectedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evidence Collected',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildEvidenceCard(
          icon: Icons.videocam_rounded,
          iconColor: _red,
          iconBgColor: _red.withValues(alpha: 0.1),
          title: 'Video Recording',
          description: '30 seconds • 1080p • Audio included',
          tags: [
            _EvidenceTag(icon: Icons.lock_rounded, label: 'Encrypted', color: _green),
            _EvidenceTag(icon: Icons.cloud_upload_rounded, label: 'Uploaded', color: _gold),
          ],
        ),
        const SizedBox(height: 12),
        _buildEvidenceCard(
          icon: Icons.camera_alt_rounded,
          iconColor: _gold,
          iconBgColor: _gold.withValues(alpha: 0.1),
          title: 'Front Camera Image',
          description: 'Silent capture • High resolution',
          tags: [
            _EvidenceTag(icon: Icons.visibility_rounded, label: 'Silent Mode', color: _green),
            _EvidenceTag(icon: Icons.lock_rounded, label: 'Secured', color: _gold),
          ],
        ),
        const SizedBox(height: 12),
        _buildLocationEvidenceCard(),
      ],
    );
  }

  Widget _buildEvidenceCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required List<_EvidenceTag> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: tags
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: t.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(t.icon, size: 12, color: t.color),
                                const SizedBox(width: 4),
                                Text(
                                  t.label,
                                  style: TextStyle(
                                    color: t.color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationEvidenceCard() {
    final coords = '23.8103° N, 90.4125° E (Dhaka)';
    final timestamp = '3/12/2026, 6:02:53 AM';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _goldLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.location_on_rounded, color: _goldLight, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location & Metadata',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'GPS coordinates • Timestamp • Device info',
                  style: TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 16, color: _muted),
                    const SizedBox(width: 6),
                    Text(coords, style: TextStyle(color: _textSoft, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 16, color: _muted),
                    const SizedBox(width: 6),
                    Text(timestamp, style: TextStyle(color: _textSoft, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceSharedCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _amber.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: _amber, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Evidence Shared With',
                  style: TextStyle(
                    color: _amber,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your 5 guardians and emergency authorities have been notified and can access this evidence securely.',
                  style: TextStyle(color: _textSoft, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewEmergencyStatusButton() {
    return SizedBox(
      height: 56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(28),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [_gold, _goldLight],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'View Emergency Status',
              style: TextStyle(
                color: const Color(0xFF0A0A0F),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EvidenceTag {
  final IconData icon;
  final String label;
  final Color color;
  _EvidenceTag({required this.icon, required this.label, required this.color});
}
