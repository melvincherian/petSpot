import 'package:flutter/material.dart';

class EditTextfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly; // Add readOnly property

  const EditTextfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.readOnly = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      readOnly: readOnly, // Use the readOnly property
      style: readOnly
          ? TextStyle(color: Colors.grey[600]) // Optional: Style for read-only field
          : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: readOnly ? Colors.grey[200] : Colors.grey[100], // Change background for read-only
      ),
    );
  }
}
