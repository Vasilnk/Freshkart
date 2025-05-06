import 'package:flutter/material.dart';

class OutlinedTextFormfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumberKeybord;

  const OutlinedTextFormfield({
    super.key,
    required this.controller,
    required this.label,
    this.isNumberKeybord = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },

      keyboardType: isNumberKeybord ? TextInputType.number : TextInputType.name,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
