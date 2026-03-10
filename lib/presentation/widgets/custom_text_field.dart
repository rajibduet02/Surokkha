import 'package:flutter/material.dart';

/// Reusable text field with optional validator and decoration.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.validator,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validator,
      obscureText: obscureText,
    );
  }
}
