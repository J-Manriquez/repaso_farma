import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'text_selection_controls.dart';
import 'package:repaso_farma/class_screens/highlight_colors.dart';
import 'note_manager.dart';
import 'color_picker.dart';
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
  int tapCount = 0;
  Timer? _tapTimer;
  Timer? _longPressTimer;
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
    _tapTimer?.cancel();
    _longPressTimer?.cancel();
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

      // Convertir los highlights cargados al formato TextRange
      loadedHighlights.forEach((text, color) {
        int start = widget.text.indexOf(text);
        if (start != -1) {
          highlights[TextRange(start: start, end: start + text.length)] = color;
        }
      });

      // Cargar las notas
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

  void _handleDoubleTap(TextRange range) {
    if (_isMenuOpen) return;

    _tapTimer?.cancel();
    tapCount++;

    if (tapCount == 2) {
      _showHighlightOptions(range);
      tapCount = 0;
    } else {
      _tapTimer = Timer(const Duration(milliseconds: 300), () {
        tapCount = 0;
      });
    }
  }

  void _handleNoteLongPress(TextRange range) {
    if (_isMenuOpen) return;

    _longPressTimer = Timer(const Duration(seconds: 1), () {
      String text = widget.text.substring(range.start, range.end);
      _showNoteOptions(text, range);
    });
  }

  void _handleNoteRelease() {
    _longPressTimer?.cancel();
  }

  void _showNoteOptions(String text, TextRange range) {
    setState(() => _isMenuOpen = true);

    if (!context.mounted) return;

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.highlight, 'Agregar resaltado'),
          onTap: () => _handleHighlight(range.start, range.end),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.edit, 'Editar nota'),
          onTap: () => _handleNoteAdd(text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar nota',
              color: Colors.red),
          onTap: () async {
            await _noteManager.deleteNote(
              widget.className,
              text,
              widget.isTranscription,
            );
            if (!mounted) return;
            setState(() {
              notes.remove(text);
            });
          },
        ),
      ],
    ).then((_) => setState(() => _isMenuOpen = false));
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

  void _showHighlightOptions(TextRange range) {
    setState(() => _isMenuOpen = true);
    String text = widget.text.substring(range.start, range.end);

    if (!context.mounted) return;

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.content_copy, 'Copiar'),
          onTap: () => _handleCopy(text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Cambiar color'),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 0),
              () => _showColorPickerDialog(range),
            );
          },
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.note_add, 'Agregar nota'),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 0),
              () => _handleNoteAdd(text),
            );
          },
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar resaltado',
              color: Colors.red),
          onTap: () => _removeHighlight(range),
        ),
      ],
    ).then((_) => setState(() => _isMenuOpen = false));
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

  void _showColorPickerDialog(TextRange range) {
    if (!context.mounted) return;
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

      final text = widget.text.substring(range.start, range.end);
      final hasNote = notes.containsKey(text);

      spans.add(TextSpan(
        text: text,
        style: TextStyle(
          backgroundColor: highlights[range]?.withOpacity(0.3),
          decoration: hasNote ? TextDecoration.underline : null,
          decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
          decorationColor: Colors.black,
        ),
        recognizer: TapGestureRecognizer()
          ..onTapDown = (details) {
            if (hasNote) {
              _handleNoteLongPress(range);
            }
          }
          ..onTapUp = (details) {
            if (hasNote) {
              _handleNoteRelease();
            } else {
              _handleDoubleTap(range);
            }
          }
          ..onTapCancel = () {
            _handleNoteRelease();
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
}
