/// Model for a trusted contact. Matches React ContactsScreen data shape.
class ContactItem {
  const ContactItem({
    required this.name,
    required this.relation,
    required this.phone,
    required this.email,
    required this.priority,
    required this.verified,
  });

  final String name;
  final String relation;
  final String phone;
  final String email;
  final int priority;
  final bool verified;
}
