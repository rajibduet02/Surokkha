/// Input validation helpers (email, phone, required, etc.).
abstract class Validators {
  Validators._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    // TODO: Add email regex validation
    return null;
  }
}
