import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    this.action,
    this.onTap,
    this.readOnly = false,
    this.obscure = false,
    this.keyboardType,
    this.controller,
    this.hintText,
    super.key,
  });

  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final bool obscure;
  final TextInputAction? action;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: widget.action,
      obscureText: isObscure,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        label: Text(widget.label),
        suffixIcon: widget.obscure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: isObscure
                    ? const Icon(
                        Icons.visibility,
                      )
                    : const Icon(
                        Icons.visibility_off,
                      ),
              )
            : null,
      ),
      onTap: widget.onTap,
    );
  }
}
