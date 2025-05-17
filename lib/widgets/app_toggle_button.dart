import 'package:flutter/material.dart';

class AppToggleButton extends StatefulWidget {
  const AppToggleButton({
    required this.labels,
    required this.onTap,
    super.key,
  });

  final List<String> labels;
  final void Function(int index) onTap;

  @override
  State<AppToggleButton> createState() => _AppToggleButtonState();
}

class _AppToggleButtonState extends State<AppToggleButton> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: List.generate(
        widget.labels.length,
        (i) => i == selectedIndex,
      ),
      onPressed: (index) {
        setState(() => selectedIndex = index);
        widget.onTap(index);
      },
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.white,
      color: Colors.blueGrey,
      fillColor: Colors.blueAccent,
      borderColor: Colors.grey.shade300,
      selectedBorderColor: Colors.blueAccent,
      children: [
        for (var label in widget.labels)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(label),
          ),
      ],
    );
  }
}
