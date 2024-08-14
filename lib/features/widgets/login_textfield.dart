import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final Icon prefixIcon;
  const LoginTextfield(
      {super.key,
      required this.controller,
      required this.prefixIcon,
      required this.labelStyle,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          labelText: labelText,
          prefixIcon: prefixIcon,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          labelStyle: labelStyle),
    );
  }
}
