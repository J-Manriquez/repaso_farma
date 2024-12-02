import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'text_selection_controls.dart';
import 'package:repaso_farma/managers/note_manager.dart';
import 'package:repaso_farma/models/storage_models.dart';
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
  List<HighlightData> highlights = [];
  List<NoteData> notes = [];

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
      className: widget.className,
      isTranscription: widget.isTranscription,
    );

    final loadedNotes = await _noteManager.getNotes(
      className: widget.className,
      isTranscription: widget.isTranscription,
    );

    if (mounted) {
      setState(() {
        highlights = loadedHighlights;
        notes = loadedNotes;
      });
    }
  }

  void _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Texto copiado al portapapeles")),
      );
    }
  }

  void _handleHighlight(int start, int end) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar color'),
        content: ColorPicker(
          onColorSelected: (color) async {
            await _noteManager.saveHighlight(
              className: widget.className,
              text: widget.text.substring(start, end),
              color: color,
              startPosition: start,
              endPosition: end,
              isTranscription: widget.isTranscription,
            );
            if (mounted) {
              Navigator.of(context).pop();
              _loadData();
            }
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

  void _showColorPickerDialog(HighlightData highlight) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Seleccionar color'),
          content: ColorPicker(
            initialColor: highlight.color,
            onColorSelected: (color) async {
              await _noteManager.updateHighlightColor(
                className: widget.className,
                startPosition: highlight.startPosition,
                endPosition: highlight.endPosition,
                newColor: color,
                isTranscription: widget.isTranscription,
              );
              if (mounted) {
                Navigator.of(context).pop();
                _loadData();
              }
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
  }

  Future<void> _handleNoteAdd(String text) async {
    final textController = TextEditingController();
    final existingNote = notes.firstWhere(
      (note) => note.text == text,
      orElse: () => NoteData(
        text: text,
        note: '',
        startPosition: widget.text.indexOf(text),
        endPosition: widget.text.indexOf(text) + text.length,
        className: widget.className,
        isTranscription: widget.isTranscription,
      ),
    );

    textController.text = existingNote.note;

    if (!mounted) return;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
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
      ),
    );

    if (result == true && textController.text.isNotEmpty) {
      await _noteManager.saveNote(
        className: widget.className,
        text: text,
        note: textController.text,
        startPosition: widget.text.indexOf(text),
        endPosition: widget.text.indexOf(text) + text.length,
        isTranscription: widget.isTranscription,
      );

      if (mounted) {
        _loadData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nota guardada')),
        );
      }
    }
  }

  void _handleTapDown(TapDownDetails details, TextRange range) {
    final highlight = highlights.firstWhere(
      (h) => h.startPosition == range.start && h.endPosition == range.end,
      orElse: () => throw Exception('Highlight not found'),
    );
    _showHighlightMenu(details.globalPosition, highlight);
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
          onTap: () => _showColorPickerDialog(highlight),
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

  Future<void> _deleteHighlight(HighlightData highlight) async {
    await _noteManager.deleteHighlight(
      className: widget.className,
      startPosition: highlight.startPosition,
      endPosition: highlight.endPosition,
      isTranscription: widget.isTranscription,
    );
    if (mounted) {
      _loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resaltado eliminado')),
      );
    }
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
    List<TextSpan> spans = [];
    int currentIndex = 0;

    // Ordenar highlights por posición
    final sortedHighlights = List<HighlightData>.from(highlights)
      ..sort((a, b) => a.startPosition.compareTo(b.startPosition));

    for (var highlight in sortedHighlights) {
      // Agregar texto sin formato antes del highlight
      if (currentIndex < highlight.startPosition) {
        spans.add(TextSpan(
          text: widget.text.substring(currentIndex, highlight.startPosition),
        ));
      }

      // Verificar si hay una nota para este highlight
      final hasNote = notes.any((note) =>
          note.startPosition == highlight.startPosition &&
          note.endPosition == highlight.endPosition);

      // Agregar el texto resaltado
      spans.add(TextSpan(
        text: widget.text
            .substring(highlight.startPosition, highlight.endPosition),
        style: TextStyle(
          backgroundColor: highlight.color.withOpacity(0.3),
          decoration: hasNote ? TextDecoration.underline : null,
          decorationStyle: hasNote ? TextDecorationStyle.dotted : null,
          decorationColor: Colors.black,
        ),
        recognizer: TapGestureRecognizer()
          ..onTapDown = (details) => _handleTapDown(
              details,
              TextRange(
                start: highlight.startPosition,
                end: highlight.endPosition,
              )),
      ));

      currentIndex = highlight.endPosition;
    }

    // Agregar el texto restante sin formato
    if (currentIndex < widget.text.length) {
      spans.add(TextSpan(
        text: widget.text.substring(currentIndex),
      ));
    }

    return spans;
  }
}
