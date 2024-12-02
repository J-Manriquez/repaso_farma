import 'package:flutter/material.dart';
import 'highlight_colors.dart';

class ColorPicker extends StatefulWidget {
  final Function(Color) onColorSelected;
  final Color? initialColor;

  const ColorPicker({
    super.key,
    required this.onColorSelected,
    this.initialColor,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grid de colores
        Container(
          constraints: const BoxConstraints(
            maxHeight: 200, // Altura máxima para el grid
          ),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 colores por fila
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: HighlightColors.colors.length,
            itemBuilder: (context, index) {
              final color = HighlightColors.colors[index];
              final isSelected = selectedColor == color;

              return ColorButton(
                color: color,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                  widget.onColorSelected(color);
                },
              );
            },
          ),
        ),

        // Previsualización del color seleccionado
        if (selectedColor != null) ...[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Color seleccionado:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              blurRadius: isSelected ? 6 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 24,
                ),
              )
            : null,
      ),
    );
  }
}

// Widget para mostrar una previsualización del texto resaltado
class HighlightPreview extends StatelessWidget {
  final String text;
  final Color color;

  const HighlightPreview({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Previsualización:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// Diálogo completo para seleccionar color
class ColorPickerDialog extends StatelessWidget {
  final Function(Color) onColorSelected;
  final String previewText;
  final Color? initialColor;

  const ColorPickerDialog({
    super.key,
    required this.onColorSelected,
    required this.previewText,
    this.initialColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 500,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecciona un color',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ColorPicker(
                onColorSelected: onColorSelected,
                initialColor: initialColor,
              ),
            ),
            const SizedBox(height: 16),
            if (previewText.isNotEmpty)
              Flexible(
                child: HighlightPreview(
                  text: previewText,
                  color: initialColor ?? HighlightColors.colors.first,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
