import 'package:flutter/material.dart';
import 'package:repaso_farma/class_screens/text_selection_controls.dart';
import 'note_manager.dart';

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
  final CustomTextSelectionControls _selectionControls = CustomTextSelectionControls();
  String? selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          widget.text,
          selectionControls: _selectionControls,
          onSelectionChanged: (selection, cause) {
            if (selection != null) {
              setState(() {
                selectedText = widget.text.substring(
                  selection.start,
                  selection.end,
                );
              });
            }
          },
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _showHighlightOptions(BuildContext context, int start, int end) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Selección: ${selectedText ?? ""}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorButton(Colors.yellow),
                  _buildColorButton(Colors.green.shade200),
                  _buildColorButton(Colors.blue.shade200),
                  _buildColorButton(Colors.pink.shade200),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _addNote(context);
                },
                child: const Text('Agregar Nota'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorButton(Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  void _addNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String note = '';
        return AlertDialog(
          title: const Text('Agregar Nota'),
          content: TextField(
            maxLines: 3,
            onChanged: (value) => note = value,
            decoration: const InputDecoration(
              hintText: 'Escribe tu nota aquí',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (selectedText != null && note.isNotEmpty) {
                  _noteManager.saveNote(
                    widget.className,
                    selectedText!,
                    note,
                    widget.isTranscription,
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}