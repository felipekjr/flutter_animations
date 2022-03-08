import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hint;
  final bool hide;
  final Function(String) onChanged;
  final VoidCallback? onTap;

  const Input({
    required this.hint,
    required this.onChanged,
    this.hide = false,
    this.onTap
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.transparent)
        ),
        filled: true,
        hintText: hint,
        fillColor: const Color(0xffF7FBFE)
      ),
      obscureText: hide,
      onTap: onTap ?? () {},
      onChanged: (String v) {
        onChanged(v);
      },
    );
  }
}