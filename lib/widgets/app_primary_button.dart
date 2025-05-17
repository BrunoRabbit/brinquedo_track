import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.onTap,
    required this.label,
    this.colorText,
    this.color,
    super.key,
  });

  final VoidCallback onTap;
  final String label;
  final Color? colorText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.purple[400],
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: colorText ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
