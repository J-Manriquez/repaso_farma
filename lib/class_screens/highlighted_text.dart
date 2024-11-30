import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';  // Añade esta importación
import 'text_selection_controls.dart';  // Volvemos a necesitar esta importación
import 'package:repaso_farma/class_screens/highlight_colors.dart';
import 'note_manager.dart';
import 'color_picker.dart';

class HighlightedText extends StatefulWidget {
  final String text;
  final String className;
  final bool isTranscription;

  const HighlightedText({
    super.key,
    required this.text,
    required this.className,
    required this.isTranscription,
  });

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> {
  final NoteManager _noteManager = NoteManager();
  TextSelectionControls? customControls;
  Map<TextRange, Color> highlights = {};
  Color currentHighlightColor = HighlightColors.colors[0];
  
  TextRange? selectedHighlight;
  String? selectedText;

  @override
  void initState() {
    super.initState();
    _loadHighlights();
    customControls = CustomTextSelectionControls(
      onCopy: _handleCopy,
      onHighlight: _handleHighlight,
      onNote: _handleNoteAdd,
    );
  }

  void _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Texto copiado al portapapeles")),
    );
  }

  void _handleHighlight(int start, int end) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: ColorPicker(
            onColorSelected: (color) {
              setState(() {
                highlights[TextRange(start: start, end: end)] = color;
                currentHighlightColor = color;
              });
              _noteManager.saveHighlight(
                widget.className,
                widget.isTranscription,
                widget.text.substring(start, end),
                color,
              );
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SelectableText.rich(
          TextSpan(
            children: _buildTextSpans(),
          ),
          selectionControls: customControls,
        ),
      ],
    );
  }

  List<TextSpan> _buildTextSpans() {
    if (highlights.isEmpty) {
      return [TextSpan(text: widget.text)];
    }

    List<TextSpan> spans = [];
    int currentIndex = 0;
    
    var sortedRanges = highlights.keys.toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    for (var range in sortedRanges) {
      if (currentIndex < range.start) {
        spans.add(TextSpan(
          text: widget.text.substring(currentIndex, range.start),
        ));
      }
      
      spans.add(TextSpan(
        text: widget.text.substring(range.start, range.end),
        style: TextStyle(
          backgroundColor: highlights[range],
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            selectedHighlight = range;
            selectedText = widget.text.substring(range.start, range.end);
            _showHighlightOptions(range);
          },
      ));
      
      currentIndex = range.end;
    }

    if (currentIndex < widget.text.length) {
      spans.add(TextSpan(
        text: widget.text.substring(currentIndex),
      ));
    }

    return spans;
  }

  void _showHighlightOptions(TextRange range) {
    // Obtener la posición global del texto resaltado
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    // Calcular la posición del menú
    final double topOffset = 60.0; // Ajusta este valor según necesites
    
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + range.start.toDouble(),
        position.dy - topOffset,
        position.dx + range.start.toDouble() + 200,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.content_copy, 'Copiar'),
          onTap: () => _handleCopyHighlighted(),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Cambiar color'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _showColorPicker(range),
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.note_add, 'Agregar/Editar nota'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _handleNoteAdd(selectedText!),
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar resaltado', color: Colors.red),
          onTap: () => _removeHighlight(range),
        ),
      ],
    );
  }  

  Future<void> _loadHighlights() async {
    final loadedHighlights = await _noteManager.getHighlights(
      widget.className,
      widget.isTranscription,
    );
    setState(() {
      highlights = loadedHighlights;
    });
  }

  
  Widget _buildMenuOption(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: color)),
      ],
    );
  }

  void _handleCopyHighlighted() {
    if (selectedText != null) {
      Clipboard.setData(ClipboardData(text: selectedText!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Texto copiado al portapapeles")),
      );
    }
  }

  void _handleNoteAdd(String text) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir/Editar nota'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Texto seleccionado: $text'),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Escribe tu nota aquí',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  _noteManager.saveNote(
                    widget.className,
                    text,
                    textController.text,
                    widget.isTranscription,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nota guardada')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showColorPicker(TextRange range) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cambiar color'),
          content: ColorPicker(
            onColorSelected: (color) {
              setState(() {
                highlights[range] = color;
              });
              _noteManager.updateHighlightColor(
                widget.className,
                widget.isTranscription,
                range,
                color,
              );
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _removeHighlight(TextRange range) {
    setState(() {
      highlights.remove(range);
    });
    _noteManager.removeHighlight(
      widget.className,
      widget.isTranscription,
      range,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resaltado eliminado")),
    );
  }
}