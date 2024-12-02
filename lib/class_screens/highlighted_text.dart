import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'text_selection_controls.dart';
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
  Map<String, Color> highlights = {};
  Map<String, String> notes = {};
  Color currentHighlightColor = HighlightColors.colors[0];
  String? selectedText;
  int tapCount = 0;
  String? lastTappedText;
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

  Widget _buildDecoratedText(String text, Color? highlightColor, bool hasNote) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            backgroundColor: highlightColor?.withOpacity(0.3),
            color: Colors.black,
            height: 1.5,
          ),
        ),
        if (hasNote)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.dotted,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _handleDoubleTap(String text) {
    if (_isMenuOpen) return;

    _tapTimer?.cancel();
    tapCount++;

    if (tapCount == 2) {
      _showHighlightOptions(text);
      tapCount = 0;
    } else {
      _tapTimer = Timer(const Duration(milliseconds: 300), () {
        tapCount = 0;
      });
    }
  }

  void _handleNoteLongPress(String text) {
    if (_isMenuOpen) return;

    _longPressTimer = Timer(const Duration(seconds: 1), () {
      _showNoteOptions(text);
    });
  }

  void _handleNoteRelease() {
    _longPressTimer?.cancel();
  }

  void _showNoteOptions(String text) {
    setState(() => _isMenuOpen = true);

    if (!context.mounted) return;
    
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.highlight, 'Agregar resaltado'),
          onTap: () => _handleHighlight(0, text.length),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.edit, 'Editar nota'),
          onTap: () => _handleNoteAdd(text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar nota', color: Colors.red),
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
    final selectedText = widget.text.substring(start, end);
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar color'),
          content: ColorPicker(
            onColorSelected: (color) {
              setState(() {
                highlights[selectedText] = color;
                currentHighlightColor = color;
              });
              _noteManager.saveHighlight(
                widget.className,
                widget.isTranscription,
                selectedText,
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

  void _showHighlightOptions(String highlightedText) {
    setState(() => _isMenuOpen = true);

    if (!context.mounted) return;
    
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.content_copy, 'Copiar'),
          onTap: () => _handleCopy(highlightedText),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Cambiar color'),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 0),
              () => _showColorPickerDialog(highlightedText),
            );
          },
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.note_add, 'Agregar nota'),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 0),
              () => _handleNoteAdd(highlightedText),
            );
          },
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Eliminar resaltado', color: Colors.red),
          onTap: () => _removeHighlight(highlightedText),
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

  void _showColorPickerDialog(String highlightedText) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar color'),
        content: ColorPicker(
          onColorSelected: (color) {
            setState(() {
              highlights[highlightedText] = color;
            });
            _noteManager.saveHighlight(
              widget.className,
              widget.isTranscription,
              highlightedText,
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

  void _removeHighlight(String text) {
    setState(() {
      highlights.remove(text);
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
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            Navigator.of(context).pop(true);
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

      await _loadData();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nota guardada')),
      );
    }
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
    List<TextSpan> spans = [];
    String remainingText = widget.text;

    while (remainingText.isNotEmpty) {
      bool foundHighlight = false;
      String? highlightedText;
      Color? highlightColor;

      for (var entry in highlights.entries) {
        int index = remainingText.indexOf(entry.key);
        if (index == 0) {
          highlightedText = entry.key;
          highlightColor = entry.value;
          foundHighlight = true;
          break;
        }
      }

      if (foundHighlight && highlightedText != null) {
        final currentText = highlightedText;
        final hasNote = notes.containsKey(currentText);
        
        spans.add(TextSpan(
          text: currentText,
          style: TextStyle(color: Colors.black),
          children: [WidgetSpan(
            child: _buildDecoratedText(currentText, highlightColor, hasNote),
          )],
          recognizer: TapGestureRecognizer()
            ..onTapDown = (details) {
              if (hasNote) {
                _handleNoteLongPress(currentText);
              }
            }
            ..onTapUp = (details) {
              if (hasNote) {
                _handleNoteRelease();
              } else {
                _handleDoubleTap(currentText);
              }
            }
            ..onTapCancel = () {
              _handleNoteRelease();
            },
        ));
        remainingText = remainingText.substring(currentText.length);
      } else {
        int nextHighlightIndex = remainingText.length;
        for (var text in highlights.keys) {
          int index = remainingText.indexOf(text);
          if (index > 0 && index < nextHighlightIndex) {
            nextHighlightIndex = index;
          }
        }

        spans.add(TextSpan(
          text: remainingText.substring(0, nextHighlightIndex),
          style: const TextStyle(
            height: 1.5,
            color: Colors.black,
          ),
        ));
        remainingText = remainingText.substring(nextHighlightIndex);
      }
    }

    return spans;
  }
}