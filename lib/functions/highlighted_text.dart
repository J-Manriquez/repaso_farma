import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'text_selection_controls.dart';
import 'package:repaso_farma/managers/note_manager.dart';
import 'package:repaso_farma/models/storage_models.dart';
import 'color_picker.dart';
// import 'package:repaso_farma/functions/highlighted_text.dart';

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
  List<HighlightData> highlights = [];
  List<NoteData> notes = [];

  // Variables para manejar el estado de selección
  TextRange? selectedHighlight;
  TextRange? selectedNote;
  String? selectedText;

  @override
  void initState() {
    super.initState();
    customControls = CustomTextSelectionControls(
      onCopy: _handleCopy,
      onHighlight: _handleHighlight,
      onNote: _handleNoteAdd,
    );
    _loadData();
  }

  void _handleNoteAdd(String text) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Agregar nota'),
                const SizedBox(height: 16),
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu nota aquí',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (textController.text.isNotEmpty) {
                          await _noteManager.saveNote(
                            className: widget.className,
                            text: text,
                            note: textController.text,
                            startPosition: widget.text.indexOf(text),
                            endPosition:
                                widget.text.indexOf(text) + text.length,
                            isTranscription: widget.isTranscription,
                          );
                          if (!mounted) return;
                          Navigator.pop(context);
                          _loadData();
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadData() async {
    final loadedHighlights = await _noteManager.getHighlights(
      className: widget.className,
      isTranscription: widget.isTranscription,
    );

    final loadedNotes = await _noteManager.getNotes(
      className: widget.className,
      isTranscription: widget.isTranscription,
    );

    setState(() {
      highlights = loadedHighlights;
      notes = loadedNotes;
    });
  }

  void _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Texto copiado al portapapeles")),
    );
  }

  void _handleHighlight(int start, int end) {
    _showColorPicker(
      onColorSelected: (color) async {
        await _noteManager.saveHighlight(
          className: widget.className,
          text: widget.text.substring(start, end),
          color: color,
          startPosition: start,
          endPosition: end,
          isTranscription: widget.isTranscription,
        );
        _loadData();
      },
    );
  }

  void _showColorPicker({required Function(Color) onColorSelected}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: ColorPicker(onColorSelected: (color) {
            onColorSelected(color);
            Navigator.of(context).pop();
          }),
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
        // Capa base con el texto
        SelectableText.rich(
          TextSpan(
            children: _buildTextSpans(),
          ),
          selectionControls: customControls,
        ),

        // Capa de resaltados
        if (highlights.isNotEmpty)
          CustomPaint(
            painter: HighlightPainter(
              highlights: highlights,
              textStyle: DefaultTextStyle.of(context).style,
              context: context,
            ),
            size: Size.infinite,
          ),
      ],
    );
  }

//   List<TextSpan> _buildTextSpans() {
//   List<TextSpan> spans = [];
//   int currentIndex = 0;
//   final allRanges = _getAllRanges();

//   for (var range in allRanges) {
//     if (currentIndex < range.start) {
//       spans.add(
//           TextSpan(text: widget.text.substring(currentIndex, range.start)));
//     }

//     final hasNote = notes.any((note) =>
//         note.startPosition == range.start && note.endPosition == range.end);

//     spans.add(TextSpan(
//       text: widget.text.substring(range.start, range.end),
//       style: TextStyle(
//         decoration: hasNote ? TextDecoration.underline : null,
//         decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
//         decorationColor: Colors.black,
//         decorationThickness: 2,
//       ),
//       recognizer: TapGestureRecognizer()
//         ..onTapDown = (details) {
//           _handleTapDown(details, range);
//         },
//     ));

//     spans.add(TextSpan(
//       text: widget.text.substring(range.start, range.end),
//       style: TextStyle(
//         decoration: hasNote ? TextDecoration.underline : null,
//         decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
//         decorationColor: Colors.black,
//         decorationThickness: 2,
//       ),
//       recognizer: LongPressGestureRecognizer()
//         ..onLongPress = () {
//           _handleLongPress(range);
//         },
//     ));

//     currentIndex = range.end;
//   }

//   if (currentIndex < widget.text.length) {
//     spans.add(TextSpan(text: widget.text.substring(currentIndex)));
//   }

//   return spans;
// }

  // List<TextSpan> _buildTextSpans() {
  //   List<TextSpan> spans = [];
  //   int currentIndex = 0;
  //   final allRanges = _getAllRanges();

  //   for (var range in allRanges) {
  //     // Agregar el texto antes del rango actual
  //     if (currentIndex < range.start) {
  //       spans.add(
  //           TextSpan(text: widget.text.substring(currentIndex, range.start)));
  //     }

  //     // Verificar si hay una nota en este rango
  //     final hasNote = notes.any((note) =>
  //         note.startPosition == range.start && note.endPosition == range.end);

  //     // Verificar si hay un resaltado en este rango
  //     final highlight = highlights.firstWhere(
  //       (h) => h.startPosition == range.start && h.endPosition == range.end,
  //       orElse: () => null,
  //     );

  //     // Crear el TextSpan para el rango actual
  //     spans.add(TextSpan(
  //       text: widget.text.substring(range.start, range.end),
  //       style: TextStyle(
  //         backgroundColor: highlight.color.withOpacity(0.3),
  //         decoration: hasNote ? TextDecoration.underline : null,
  //         decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
  //         decorationColor: Colors.black,
  //         decorationThickness: 2,
  //       ),
  //       recognizer: TapGestureRecognizer()
  //         ..onTap = () {
  //           // Manejar el tap si es necesario
  //           _handleLongPress(range);
  //         },
  //     ));

  //     currentIndex = range.end;
  //   }

  //   // Agregar el texto restante después del último rango
  //   if (currentIndex < widget.text.length) {
  //     spans.add(TextSpan(text: widget.text.substring(currentIndex)));
  //   }

  //   return spans;
  // }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    int currentIndex = 0;
    final allRanges = _getAllRanges();

    for (var range in allRanges) {
      // Agregar el texto antes del rango actual
      if (currentIndex < range.start) {
        spans.add(
            TextSpan(text: widget.text.substring(currentIndex, range.start)));
      }

      // Verificar si hay una nota en este rango
      final hasNote = notes.any((note) =>
          note.startPosition == range.start && note.endPosition == range.end);

      // Verificar si hay un resaltado en este rango
      final highlight = highlights.cast<HighlightData?>().firstWhere(
            (h) =>
                h != null &&
                h.startPosition == range.start &&
                h.endPosition == range.end,
            orElse: () => null,
          );

      // Crear el TextSpan para el rango actual
      spans.add(TextSpan(
        text: widget.text.substring(range.start, range.end),
        style: TextStyle(
          backgroundColor: highlight?.color.withOpacity(0.3),
          decoration: hasNote ? TextDecoration.underline : null,
          decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
          decorationColor: Colors.black,
          decorationThickness: 2,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Manejar el tap si es necesario
            if (highlight != null) {
              _handleTapDown(TapDownDetails(), range);
            }
          },
      ));

      currentIndex = range.end;
    }

    // Agregar el texto restante después del último rango
    if (currentIndex < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(currentIndex)));
    }

    return spans;
  }

  List<TextRange> _getAllRanges() {
    final Set<TextRange> ranges = {};

    // Agregar rangos de highlights
    for (var highlight in highlights) {
      ranges.add(highlight.range);
    }

    // Agregar rangos de notas
    for (var note in notes) {
      ranges.add(note.range);
    }

    // Ordenar por posición
    return ranges.toList()..sort((a, b) => a.start.compareTo(b.start));
  }

  void _handleTapDown(TapDownDetails details, TextRange range) {
    // Manejar tap simple
  }

  // Corregir las funciones firstWhere para el manejo de nulos
  HighlightData? _findHighlight(TextRange range) {
    try {
      return highlights.firstWhere(
        (h) => h.startPosition == range.start && h.endPosition == range.end,
      );
    } catch (e) {
      return null;
    }
  }

  NoteData? _findNote(TextRange range) {
    try {
      return notes.firstWhere(
        (n) => n.startPosition == range.start && n.endPosition == range.end,
      );
    } catch (e) {
      return null;
    }
  }

  void _handleDoubleTapDown(TapDownDetails details, TextRange range) {
    final highlight = _findHighlight(range);
    if (highlight != null) {
      _showHighlightMenu(details.globalPosition, highlight);
    }
  }

  void _handleLongPress(TextRange range) {
    final note = _findNote(range);
    if (note != null) {
      _showNoteMenu(note);
    }
  }

  void _showNoteMenu(NoteData note) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Opciones de nota'),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.highlight),
                  title: const Text('Agregar resaltado'),
                  onTap: () {
                    Navigator.pop(context);
                    _handleHighlight(note.startPosition, note.endPosition);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar nota'),
                  onTap: () {
                    Navigator.pop(context);
                    _handleNoteAdd(
                        note.text); // Esto actualizará la nota existente
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Eliminar nota',
                      style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await _noteManager.deleteNote(
                      className: widget.className,
                      startPosition: note.startPosition,
                      endPosition: note.endPosition,
                      isTranscription: widget.isTranscription,
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                    _loadData();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHighlightMenu(Offset position, HighlightData highlight) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.content_copy, 'Copiar'),
          onTap: () => _handleCopy(highlight.text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Cambiar color'),
          onTap: () => _showColorPicker(
            onColorSelected: (color) => _updateHighlightColor(highlight, color),
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.note_add, 'Agregar nota'),
          onTap: () => _handleNoteAdd(highlight.text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar resaltado',
              color: Colors.red),
          onTap: () => _deleteHighlight(highlight),
        ),
      ],
    );
  }

  void _updateHighlightColor(HighlightData highlight, Color newColor) async {
    await _noteManager.updateHighlightColor(
      className: widget.className,
      startPosition: highlight.startPosition,
      endPosition: highlight.endPosition,
      newColor: newColor,
      isTranscription: widget.isTranscription,
    );
    _loadData();
  }

  void _deleteHighlight(HighlightData highlight) async {
    await _noteManager.deleteHighlight(
      className: widget.className,
      startPosition: highlight.startPosition,
      endPosition: highlight.endPosition,
      isTranscription: widget.isTranscription,
    );
    _loadData();
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

  // Implementar los demás métodos auxiliares...
}

// Clase auxiliar para pintar los resaltados
class HighlightPainter extends CustomPainter {
  final List<HighlightData> highlights;
  final TextStyle textStyle;
  final BuildContext context;

  HighlightPainter({
    required this.highlights,
    required this.textStyle,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var highlight in highlights) {
      paint.color = highlight.color.withOpacity(0.3);
      // Implementar la lógica de pintura del resaltado
      // Calcular la posición del texto resaltado
      final textPainter = TextPainter(
        text: TextSpan(
          text: highlight.text,
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Dibujar el resaltado
      final rect = Rect.fromLTWH(
        0, // Posición X
        highlight.startPosition.toDouble(), // Posición Y
        textPainter.width, // Ancho
        textPainter.height, // Alto
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
