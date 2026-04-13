import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/floating_navbar.dart';
import '../controllers/safe_contacts_controller.dart';
import '../../../data/models/contact_item.dart';
import 'add_contact_screen.dart';

// Design tokens (match React)
const Color _bg = Color(0xFF0A0A0F);
const Color _card = Color(0xFF1A1A22);
const Color _cardBorder = Color(0xFF2A2A32);
const Color _gold = Color(0xFFD4AF37);
const Color _goldLight = Color(0xFFF6D365);
const Color _green = Color(0xFF10B981);
const Color _muted = Color(0xFF8A8A92);
const Color _bgDark = Color(0xFF0A0A0F);

class SafeContactsScreen extends GetView<SafeContactsController> {
  const SafeContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildInfoBanner(),
                  const SizedBox(height: 24),
                  _buildContactsSection(),
                  const SizedBox(height: 24),
                  _buildAddContactButton(),
                  const SizedBox(height: 24),
                  _buildPriorityInfoCard(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          const FloatingNavBar(currentRoute: '/contacts'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.offNamed('/dashboard'),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _gold.withValues(alpha: 0.2)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, color: _gold, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Center(
            child: Text(
              'Safe Contacts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => Get.to(() => const AddContactScreen()),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_gold, _goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.add_rounded, color: _bgDark, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _gold.withValues(alpha: 0.1),
            _goldLight.withValues(alpha: 0.1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_rounded, color: _gold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency Protocol Active',
                  style: TextStyle(
                    color: _gold,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'These contacts will be notified instantly during an SOS alert '
                  'with your live location and emergency details.',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsSection() {
    return Obx(() {
        final contacts = controller.contacts;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trusted Contacts (${contacts.length})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Max: 10',
                    style: TextStyle(color: _muted, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...contacts.map((contact) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ContactCard(contact: contact),
                )),
          ],
        );
    });
  }

  Widget _buildAddContactButton() {
    return GestureDetector(
      onTap: () => Get.to(() => const AddContactScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_card, _cardBorder],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _gold.withValues(alpha: 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: _gold, size: 20),
            const SizedBox(width: 8),
            Text(
              'Add Another Contact',
              style: TextStyle(
                color: _gold,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: _gold, size: 18),
              const SizedBox(width: 8),
              Text(
                'Priority Levels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _PriorityInfoLine(
            priority: 1,
            text: 'Notified instantly + Auto-call',
          ),
          const SizedBox(height: 4),
          _PriorityInfoLine(
            priority: 2,
            text: 'Notified within 10 seconds',
          ),
          const SizedBox(height: 4),
          _PriorityInfoLine(
            priority: 3,
            text: 'Notified after Priority 1 & 2',
          ),
        ],
      ),
    );
  }
}

class _PriorityInfoLine extends StatelessWidget {
  const _PriorityInfoLine({required this.priority, required this.text});

  final int priority;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color strongColor;
    switch (priority) {
      case 1:
        strongColor = _gold;
        break;
      case 2:
        strongColor = _goldLight;
        break;
      default:
        strongColor = _muted;
    }
    return RichText(
      text: TextSpan(
        style: TextStyle(color: _muted, fontSize: 12),
        children: [
          TextSpan(
            text: 'Priority $priority: ',
            style: TextStyle(color: strongColor, fontWeight: FontWeight.w600),
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.contact});

  final ContactItem contact;

  void _showContactMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.delete_rounded, color: Colors.red),
                  title: const Text(
                    'Delete Contact',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _confirmDelete(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete Contact',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete ${contact.name}?',
          style: const TextStyle(color: Color(0xFF8A8A92)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Get.find<SafeContactsController>().deleteContact(contact);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_card, _cardBorder],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            contact.relation,
                            style: TextStyle(color: _muted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showContactMenu(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _cardBorder,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.more_vert_rounded, color: _muted, size: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone_rounded, size: 14, color: _muted),
                    const SizedBox(width: 8),
                    Text(
                      contact.phone,
                      style: TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.mail_rounded, size: 14, color: _muted),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        contact.email,
                        style: TextStyle(color: _muted, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _PriorityBadge(priority: contact.priority),
                    if (contact.verified) ...[
                      const SizedBox(width: 8),
                      _VerifiedBadge(),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_gold, _goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
              style: TextStyle(
                color: _bgDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (contact.priority == 1)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _gold,
                  shape: BoxShape.circle,
                  border: Border.all(color: _card, width: 2),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.star_rounded, color: _bgDark, size: 14),
              ),
            ),
          if (contact.verified)
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                  border: Border.all(color: _card, width: 2),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.shield_rounded, color: Colors.white, size: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});

  final int priority;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (priority) {
      case 1:
        bg = _gold.withValues(alpha: 0.1);
        fg = _gold;
        break;
      case 2:
        bg = _goldLight.withValues(alpha: 0.1);
        fg = _goldLight;
        break;
      default:
        bg = _muted.withValues(alpha: 0.1);
        fg = _muted;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Priority $priority',
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Verified',
        style: TextStyle(color: _green, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
