import 'package:flutter/material.dart';
import '../managers/highlight_colors_manager.dart';

class ColorPicker extends StatelessWidget {
  final Function(Color) onColorSelected;

  const ColorPicker({
    super.key,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: HighlightColors.colors.map((color) {
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
        );
      }).toList(),
    );
  }
}