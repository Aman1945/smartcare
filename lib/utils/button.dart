import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const Button(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ).merge(style),
    );
  }
}