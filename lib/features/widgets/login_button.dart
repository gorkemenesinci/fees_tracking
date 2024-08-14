import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPress, required this.text});
  final void Function() onPress;
  final Text text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontal = screenWidth * 0.8;
    final vertical = screenHeight * 0.06;

    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            alignment: Alignment.center,
            fixedSize: Size(horizontal, vertical),
            backgroundColor: Colors.white38),
        onPressed: onPress,
        child: text);
  }
}
