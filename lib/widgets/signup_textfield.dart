// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

class SignupTextFormField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const SignupTextFormField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _SignupTextFormFieldState createState() => _SignupTextFormFieldState();
}

class _SignupTextFormFieldState extends State<SignupTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
