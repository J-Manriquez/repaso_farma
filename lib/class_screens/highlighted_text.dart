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

  void _handleTap(String text) {
    if (lastTappedText != text) {
      tapCount = 0;
      _tapTimer?.cancel();
    }

    lastTappedText = text;
    tapCount++;

    _tapTimer?.cancel();
    _tapTimer = Timer(const Duration(milliseconds: 500), () {
      if (tapCount == 2) {
        // Double tap to edit highlight
        _showHighlightOptions(text);
      }
      tapCount = 0;
    });
  }

  void _handleNoteLongPress(String text) {
    if (!context.mounted) return;
    
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.edit, 'Edit note'),
          onTap: () => _handleNoteAdd(text),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Delete note', color: Colors.red),
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
    );
  }

  void _handleCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Text copied to clipboard")),
    );
  }

  void _handleHighlight(int start, int end) {
    final selectedText = widget.text.substring(start, end);
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a color'),
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
              child: const Text('Cancel'),
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
        spans.add(TextSpan(
          text: highlightedText,
          style: TextStyle(
            backgroundColor: highlightColor?.withOpacity(0.3),
            decoration: notes.containsKey(highlightedText)
                ? TextDecoration.underline
                : null,
            decorationStyle: TextDecorationStyle.dotted,
            decorationColor: Colors.black,
            decorationThickness: 2,
            color: Colors.black,
            height: 1.5,
          ),
          recognizer: GestureRecognizer()
            ..onTapDown = (details) {
              if (notes.containsKey(highlightedText)) {
                _longPressTimer?.cancel();
                _longPressTimer = Timer(
                  const Duration(milliseconds: 1500),
                  () => _handleNoteLongPress(highlightedText!),
                );
              }
            }
            ..onTapUp = (details) {
              _longPressTimer?.cancel();
              _handleTap(highlightedText!);
            },
        ));
        remainingText = remainingText.substring(highlightedText.length);
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

  void _handleNoteAdd(String text) {
    final textController = TextEditingController();
    if (notes.containsKey(text)) {
      textController.text = notes[text]!;
    }

    if (!context.mounted) return;
    showDialog(
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
                  title: const Text('Add/Edit Note'),
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
                          'Selected text:',
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
                          'Your note:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Write your note here',
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
                        child: const Text('Cancel'),
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
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            await _loadData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Note saved')),
                            );
                          }
                        },
                        child: const Text('Save'),
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

  void _showHighlightOptions(String highlightedText) {
    if (!context.mounted) return;

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(Icons.content_copy, 'Copy'),
          onTap: () => _handleCopy(highlightedText),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.delete, 'Remove highlight',
              color: Colors.red),
          onTap: () => _removeHighlight(highlightedText),
        ),
        PopupMenuItem(
          child: _buildMenuOption(Icons.color_lens, 'Change color'),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 0),
              () => _showColorPickerDialog(highlightedText),
            );
          },
        ),
      ],
    );
  }

  void _showColorPickerDialog(String highlightedText) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select color'),
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
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
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

  void _removeHighlight(String text) {
    setState(() {
      highlights.remove(text);
    });
    _noteManager.removeHighlight(
      widget.className,
      widget.isTranscription,
      text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Highlight removed')),
    );
  }
}