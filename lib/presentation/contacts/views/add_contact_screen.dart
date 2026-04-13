import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/models/contact_item.dart';
import '../controllers/safe_contacts_controller.dart';

const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _bgDark = Color(0xFF0A0A0F);

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final relationController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final priority = 1.obs;
  final verified = true.obs;

  final _nameFocus = FocusNode();
  final _relationFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    void refresh() => setState(() {});
    nameController.addListener(refresh);
    phoneController.addListener(refresh);
    _nameFocus.addListener(refresh);
    _relationFocus.addListener(refresh);
    _phoneFocus.addListener(refresh);
    _emailFocus.addListener(refresh);
  }

  @override
  void dispose() {
    nameController.dispose();
    relationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    _nameFocus.dispose();
    _relationFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  bool get _canSave {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isEmpty || phone.isEmpty) return false;
    return RegExp(r'^\d+$').hasMatch(phone);
  }

  void _save() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isEmpty) {
      Get.snackbar('Error', 'Name is required',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (phone.isEmpty) {
      Get.snackbar('Error', 'Phone is required',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      Get.snackbar('Error', 'Phone must contain digits only',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    HapticFeedback.mediumImpact();
    Get.find<SafeContactsController>().addContact(
      ContactItem(
        name: name,
        relation: relationController.text.trim(),
        phone: phone,
        email: emailController.text.trim(),
        priority: priority.value,
        verified: verified.value,
      ),
    );
    Get.back();
  }

  Widget _glassField({
    required FocusNode focusNode,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    final focused = focusNode.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _card.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: focused ? _gold : _cardBorder,
          width: focused ? 1.5 : 1,
        ),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: _gold,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: _muted, fontSize: 16),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
          child: Text(
            'Add Safe Contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityChips() {
    return Obx(() {
      return Row(
        children: [1, 2, 3].map((p) {
          final selected = priority.value == p;
          return Padding(
            padding: EdgeInsets.only(right: p < 3 ? 10 : 0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => priority.value = p,
                borderRadius: BorderRadius.circular(999),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? _gold.withValues(alpha: 0.15)
                        : _card.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: selected ? _gold : _cardBorder,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    '$p',
                    style: TextStyle(
                      color: selected ? _gold : _muted,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _verifiedRow() {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: _card.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _cardBorder),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Verified',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Switch(
              value: verified.value,
              onChanged: (v) => verified.value = v,
              activeTrackColor: _green,
              inactiveTrackColor: _muted.withValues(alpha: 0.35),
              activeThumbColor: Colors.white,
              inactiveThumbColor: _muted,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSaveButton() {
    final enabled = _canSave;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.45,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? _save : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: enabled
                  ? const LinearGradient(
                      colors: [_gold, _goldLight],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              color: enabled ? null : _cardBorder,
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: _gold.withValues(alpha: 0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              'Save Contact',
              style: TextStyle(
                color: enabled ? _bgDark : _muted,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewInsetsBottom = MediaQuery.viewInsetsOf(context).bottom;
    final screenH = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: _bg,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: viewInsetsBottom + 20,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenH,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _glassField(
                      focusNode: _nameFocus,
                      controller: nameController,
                      hint: 'Name',
                    ),
                    const SizedBox(height: 14),
                    _glassField(
                      focusNode: _relationFocus,
                      controller: relationController,
                      hint: 'Relation',
                    ),
                    const SizedBox(height: 14),
                    _glassField(
                      focusNode: _phoneFocus,
                      controller: phoneController,
                      hint: 'Phone (digits only)',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 14),
                    _glassField(
                      focusNode: _emailFocus,
                      controller: emailController,
                      hint: 'Email (optional)',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Priority',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPriorityChips(),
                    const SizedBox(height: 20),
                    _verifiedRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: ColoredBox(
          color: _bg,
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: viewInsetsBottom + 16,
              top: 8,
            ),
            child: SafeArea(
              top: false,
              child: _buildSaveButton(),
            ),
          ),
        ),
      ),
    );
  }
}
