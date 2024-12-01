import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart'; // Añade esta importación
import 'text_selection_controls.dart'; // Volvemos a necesitar esta importación
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
  Map<String, String> notes = {}; // Para almacenar texto -> nota

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

  Future<void> _loadData() async {
    final loadedHighlights = await _noteManager.getHighlights(
      widget.className,
      widget.isTranscription,
    );
    final loadedNotes = await _noteManager.getNotes();

    if (!mounted) return;

    setState(() {
      highlights = loadedHighlights;
      notes = Map.fromEntries(
        loadedNotes
            .where((note) =>
                note['className'] == widget.className &&
                note['isTranscription'] == widget.isTranscription)
            .map((note) => MapEntry(
                note['highlightedText'] as String, note['note'] as String)),
      );
    });
  }

  // // Añadir este método
  // Future<void> _loadNotes() async {
  //   final allNotes = await _noteManager.getNotes();
  //   if (!mounted) return; // Verificar si el widget aún está montado
  //   setState(() {
  //     notes = Map.fromEntries(
  //       allNotes
  //           .where((note) =>
  //               note['className'] == widget.className &&
  //               note['isTranscription'] == widget.isTranscription)
  //           .map((note) => MapEntry(
  //               note['highlightedText'] as String, note['note'] as String)),
  //     );
  //   });
  // }

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
    if (highlights.isEmpty && notes.isEmpty) {
      return [TextSpan(text: widget.text)];
    }

    List<TextSpan> spans = [];
    int currentIndex = 0;

    // Crear un mapa combinado de highlights y notas
    var allRanges = <TextRange, Map<String, dynamic>>{};

    // Añadir highlights existentes
    for (var entry in highlights.entries) {
      allRanges[entry.key] = {
        'type': 'highlight',
        'color': entry.value,
        'hasNote': false,
      };
    }

    // Añadir o combinar notas
    for (var entry in notes.entries) {
      var start = widget.text.indexOf(entry.key);
      if (start != -1) {
        var range = TextRange(start: start, end: start + entry.key.length);

        if (allRanges.containsKey(range)) {
          // Si ya existe un highlight en este rango, añadir la nota
          allRanges[range]!['hasNote'] = true;
          allRanges[range]!['note'] = entry.value;
        } else {
          // Si no existe highlight, crear nuevo rango solo con nota
          allRanges[range] = {
            'type': 'note',
            'note': entry.value,
            'hasNote': true,
          };
        }
      }
    }

    var sortedRanges = allRanges.keys.toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    for (var range in sortedRanges) {
      if (currentIndex < range.start) {
        spans.add(
            TextSpan(text: widget.text.substring(currentIndex, range.start)));
      }

      var info = allRanges[range]!;
      var gestureRecognizer;
      
      if (info['type'] == 'highlight') {
        gestureRecognizer = DoubleTapGestureRecognizer()
          ..onDoubleTap = () {
            setState(() {
              selectedHighlight = range;
              selectedText = widget.text.substring(range.start, range.end);
            });
            _showHighlightOptions(range);
          };
      } else if (info['hasNote']) {
        gestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _handleNoteAdd(widget.text.substring(range.start, range.end));
          };
      }

      spans.add(TextSpan(
        text: widget.text.substring(range.start, range.end),
        style: TextStyle(
          backgroundColor: info['type'] == 'highlight' ? info['color'] : null,
          decoration: info['hasNote'] ? TextDecoration.underline : null,
          decorationStyle: info['hasNote'] ? TextDecorationStyle.dotted : null,
          decorationColor: const Color.fromARGB(255, 0, 0, 0),
          decorationThickness: 2,
        ),
        recognizer: gestureRecognizer,
      ));

      currentIndex = range.end;
    }

    if (currentIndex < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(currentIndex)));
    }

    return spans;
  }

  // Modificar el método _handleNoteAdd para actualizar la UI después de guardar
  void _handleNoteAdd(String text) {
    final textController = TextEditingController();
    if (notes.containsKey(text)) {
      textController.text = notes[text]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height *
                  0.8, // 80% de la altura de la pantalla
              maxWidth: MediaQuery.of(context).size.width *
                  0.9, // 90% del ancho de la pantalla
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('Añadir/Editar nota'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Texto seleccionado:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Text(text),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tu nota:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Escribe tu nota aquí',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          if (textController.text.isNotEmpty) {
                            await _noteManager.saveNote(
                              widget.className,
                              text,
                              textController.text,
                              widget.isTranscription,
                            );
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            await _loadData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Nota guardada')),
                            );
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNoteDialog(String highlightedText, String note) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('Nota'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(dialogContext).pop(),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Texto seleccionado:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Text(highlightedText),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Nota:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Text(note),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _handleNoteAdd(highlightedText);
                        },
                        child: const Text('Editar'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          await _noteManager.deleteNote(
                            widget.className,
                            highlightedText,
                            widget.isTranscription,
                          );
                          if (!mounted) return;
                          Navigator.pop(dialogContext);
                          _loadData();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHighlightOptions(TextRange range) {
    // Obtener la posición global del texto resaltado
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    // Calcular la posición del menú
    const double topOffset = 60.0; // Ajusta este valor según necesites

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
          child: _buildMenuOption(Icons.delete, 'Eliminar resaltado',
              color: Colors.red),
          onTap: () => _removeHighlight(range),
        ),
      ],
    );
  }

  // Future<void> _loadHighlights() async {
  //   final loadedHighlights = await _noteManager.getHighlights(
  //     widget.className,
  //     widget.isTranscription,
  //   );
  //   setState(() {
  //     highlights = loadedHighlights;
  //   });
  // }

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
