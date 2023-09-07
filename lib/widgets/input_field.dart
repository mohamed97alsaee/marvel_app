import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.obSecure = false});

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obSecure;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obSecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
        validator: widget.validator);
  }
}
