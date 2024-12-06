import 'package:flutter/material.dart';

class CustomadrressTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const CustomadrressTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.teal, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
