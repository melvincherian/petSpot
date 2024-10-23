import 'package:flutter/material.dart';

class UserTextfield extends StatelessWidget {
  const UserTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              );
  }
}