import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import '../managers/text_selection_manager.dart';
import 'package:repaso_farma/managers/highlight_colors_manager.dart';
import '../managers/note_manager.dart';
import '../widgets/color_picker.dart';
import 'dart:async';

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
  Map<String, String> notes = {};
  Color currentHighlightColor = HighlightColors.colors[0];
  TextRange? selectedHighlight;
  String? selectedText;
  Timer? _doubleTapTimer;
  int _tapCount = 0;
  Offset _tapPosition = Offset.zero;
  bool _isMenuOpen = false;

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

  @override
  void dispose() {
    _doubleTapTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    final loadedHighlights = await _noteManager.getHighlights(
      widget.className,
      widget.isTranscription,
    );
    final loadedNotes = await _noteManager.getNotes();

    if (!mounted) return;

    setState(() {
      highlights.clear();
      notes.clear();

      loadedHighlights.forEach((text, color) {
        int start = widget.text.indexOf(text);
        if (start != -1) {
          highlights[TextRange(start: start, end: start + text.length)] = color;
        }
      });

      notes.addAll(
        Map.fromEntries(
          loadedNotes
              .where((note) =>
                  note['className'] == widget.className &&
                  note['isTranscription'] == widget.isTranscription)
              .map((note) => MapEntry(
                  note['highlightedText'] as String, note['note'] as String)),
        ),
      );
    });
  }

  void _handleTapDown(TapDownDetails details, TextRange range, String text) {
    if (_isMenuOpen) return;

    setState(() {
      _tapPosition = details.globalPosition;
      _tapCount++;
    });

    if (_tapCount == 1) {
      _doubleTapTimer?.cancel();
      _doubleTapTimer = Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _tapCount = 0;
        });
      });
    } else if (_tapCount == 2) {
      _doubleTapTimer?.cancel();
      setState(() {
        _tapCount = 0;
      });
      _showContextMenu(range, text);
    }
  }

  void _showContextMenu(TextRange range, String text) {
    setState(() => _isMenuOpen = true);

    final bool hasNote = notes.containsKey(text);
    final bool hasHighlight = highlights.containsKey(range);

    final RenderBox overlay = Overlay.of(context)
        .context
        .findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 0, 0),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: _buildMenuItems(range, text, hasNote, hasHighlight),
    ).then((_) => setState(() => _isMenuOpen = false));
  }

  List<PopupMenuEntry> _buildMenuItems(
    TextRange range,
    String text,
    bool hasNote,
    bool hasHighlight,
  ) {
    List<PopupMenuEntry> items = [];

    if (hasNote) {
      items.addAll([
        PopupMenuItem(
          child: _buildMenuOption(Icons.visibility, 'Ver nota'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _viewNote(text),
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.edit, 'Editar nota'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _handleNoteAdd(text),
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(
            Icons.delete_outline,
            'Eliminar nota',
            color: Colors.red,
          ),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _deleteNote(text),
          ),
        ),
        const PopupMenuDivider(),
      ]);
    }

    if (hasHighlight) {
      items.add(
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Cambiar color'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _showColorPickerDialog(range),
          ),
        ),
      );
      items.add(
        PopupMenuItem(
          child: _buildMenuOption(
            Icons.highlight_off,
            'Eliminar resaltado',
            color: Colors.red,
          ),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _removeHighlight(range),
          ),
        ),
      );
    } else {
      items.add(
        PopupMenuItem(
          child: _buildMenuOption(Icons.highlight, 'Agregar resaltado'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _handleHighlight(range.start, range.end),
          ),
        ),
      );
    }

    if (!hasNote) {
      items.add(
        PopupMenuItem(
          child: _buildMenuOption(Icons.note_add, 'Agregar nota'),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _handleNoteAdd(text),
          ),
        ),
      );
    }

    return items;
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

  void _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Texto copiado al portapapeles")),
    );
  }

  void _handleHighlight(int start, int end) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar color'),
          content: ColorPicker(
            onColorSelected: (color) {
              setState(() {
                TextRange range = TextRange(start: start, end: end);
                highlights[range] = color;
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

  void _viewNote(String text) {
    if (notes.containsKey(text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Nota'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Texto resaltado:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(text),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nota:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(notes[text]!),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  void _deleteNote(String text) async {
    await _noteManager.deleteNote(
      widget.className,
      text,
      widget.isTranscription,
    );
    if (!mounted) return;
    setState(() {
      notes.remove(text);
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nota eliminada')),
    );
  }

  void _showColorPickerDialog(TextRange range) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar color'),
        content: ColorPicker(
          onColorSelected: (color) {
            setState(() {
              highlights[range] = color;
            });
            _noteManager.saveHighlight(
              widget.className,
              widget.isTranscription,
              widget.text.substring(range.start, range.end),
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
      ),
    );
  }

  void _removeHighlight(TextRange range) {
    String text = widget.text.substring(range.start, range.end);
    setState(() {
      highlights.remove(range);
    });
    _noteManager.removeHighlight(
      widget.className,
      widget.isTranscription,
      text,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resaltado eliminado')),
    );
  }

  Future<void> _handleNoteAdd(String text) async {
    final textController = TextEditingController();
    if (notes.containsKey(text)) {
      textController.text = notes[text]!;
    }

    if (!context.mounted) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
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
                  title: const Text('Agregar/Editar Nota'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(false),
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
                          child: Text(text),
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
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            Navigator.pop(context, true);
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

    if (result == true && textController.text.isNotEmpty) {
      await _noteManager.saveNote(
        widget.className,
        text,
        textController.text,
        widget.isTranscription,
      );

      if (!mounted) return;

      setState(() {
        notes[text] = textController.text;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nota guardada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: _buildTextSpans(),
      ),
      selectionControls: customControls,
    );
  }

  List<TextSpan> _buildTextSpans() {
    if (highlights.isEmpty && notes.isEmpty) {
      return [TextSpan(text: widget.text)];
    }

    List<TextSpan> spans = [];
    int currentIndex = 0;

    // Crear una lista de todos los rangos que necesitan procesamiento
    List<Map<String, dynamic>> allRanges = [];

    // Agregar rangos de resaltados
    highlights.forEach((range, color) {
      allRanges.add({
        'range': range,
        'color': color,
        'text': widget.text.substring(range.start, range.end),
        'type': 'highlight'
      });
    });

    // Agregar rangos de notas que no tienen resaltado
    notes.forEach((text, note) {
      int start = widget.text.indexOf(text);
      if (start != -1) {
        // Verificar si este texto ya está incluido en un resaltado
        bool isAlreadyHighlighted = allRanges.any((rangeData) {
          TextRange range = rangeData['range'] as TextRange;
          return range.start <= start && range.end >= start + text.length;
        });

        if (!isAlreadyHighlighted) {
          allRanges.add({
            'range': TextRange(start: start, end: start + text.length),
            'text': text,
            'type': 'note'
          });
        }
      }
    });

    // Ordenar rangos por posición
    allRanges.sort((a, b) => (a['range'] as TextRange).start.compareTo((b['range'] as TextRange).start));

    for (var rangeData in allRanges) {
      final TextRange range = rangeData['range'] as TextRange;
      final String text = rangeData['text'] as String;
      final String type = rangeData['type'] as String;

      if (currentIndex < range.start) {
        spans.add(TextSpan(
          text: widget.text.substring(currentIndex, range.start),
        ));
      }

      final bool hasNote = notes.containsKey(text);
      final bool hasHighlight = type == 'highlight';

      spans.add(TextSpan(
        text: text,
        style: TextStyle(
          backgroundColor: hasHighlight 
              ? (rangeData['color'] as Color).withOpacity(0.3) 
              : null,
          decoration: hasNote ? TextDecoration.underline : null,
          decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
          decorationColor: Colors.black,
        ),
        recognizer: TapGestureRecognizer()
          ..onTapDown = (details) => _handleTapDown(details, range, text),
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
}