import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPasswordField;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isPasswordField = false,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField ? !isPasswordVisible : false,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your ${widget.label}';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon:
            widget.isPasswordField
                ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
                : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
