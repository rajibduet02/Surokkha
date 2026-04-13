import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/safe_zones_controller.dart';

const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _bgDark = Color(0xFF0A0A0F);

class AddSafeZoneScreen extends StatefulWidget {
  const AddSafeZoneScreen({super.key});

  @override
  State<AddSafeZoneScreen> createState() => _AddSafeZoneScreenState();
}

class _AddSafeZoneScreenState extends State<AddSafeZoneScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _slide;
  late final Animation<double> _opacity;

  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  String _radius = '100m';
  bool _entryAlert = true;
  bool _exitAlert = true;

  static const _radiusOptions = ['100m', '150m', '200m', '300m'];

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOut),
    );
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameCtrl.text.trim();
    final address = _addressCtrl.text.trim();
    if (name.isEmpty || address.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    Get.find<SafeZonesController>().addZone(
      name: name,
      address: address,
      radius: _radius,
      entryAlert: _entryAlert,
      exitAlert: _exitAlert,
    );
    Get.back();
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back_rounded, color: _gold, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Safe Zone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inputShell({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
      ),
      child: child,
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      hintText: hint,
      hintStyle: const TextStyle(color: _muted, fontSize: 16),
    );
  }

  Widget _buildNameField() {
    return _inputShell(
      child: TextField(
        controller: _nameCtrl,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: _gold,
        decoration: _fieldDecoration('Home, Office...'),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildAddressField() {
    return _inputShell(
      child: TextField(
        controller: _addressCtrl,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: _gold,
        decoration: _fieldDecoration('Address'),
        textInputAction: TextInputAction.done,
        maxLines: 3,
        minLines: 1,
      ),
    );
  }

  Widget _buildRadiusDropdown() {
    return _inputShell(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _radius,
          isExpanded: true,
          dropdownColor: _card,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: _gold),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: _radiusOptions
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _radius = v);
          },
        ),
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return _inputShell(
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: _green,
            inactiveTrackColor: _muted.withValues(alpha: 0.35),
            activeThumbColor: Colors.white,
            inactiveThumbColor: _muted,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _save,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [_gold, _goldLight],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _gold.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Save',
            style: TextStyle(
              color: _bgDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      backgroundColor: _bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (context, child) {
            return AnimatedOpacity(
              opacity: _opacity.value.clamp(0.0, 1.0),
              duration: Duration.zero,
              child: Transform.translate(
                offset: Offset(0, _slide.value),
                child: child,
              ),
            );
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 28),
                      _buildNameField(),
                      const SizedBox(height: 16),
                      _buildAddressField(),
                      const SizedBox(height: 16),
                      _buildRadiusDropdown(),
                      const SizedBox(height: 16),
                      _buildSwitchRow(
                        'Entry Alert',
                        _entryAlert,
                        (v) => setState(() => _entryAlert = v),
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchRow(
                        'Exit Alert',
                        _exitAlert,
                        (v) => setState(() => _exitAlert = v),
                      ),
                      SizedBox(height: 32 + (bottomInset > 0 ? 8 : 0)),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
