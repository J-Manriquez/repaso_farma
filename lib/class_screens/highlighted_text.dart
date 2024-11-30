import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextSelectionControls? customControls;

  @override
  void initState() {
    super.initState();
    customControls = CustomTextSelectionControls(
      onCopy: (value) {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Copied: $value")),
        );
      },
      onHighlight: (start, end) {
        // Implementa lógica para resaltar texto
      },
      onNote: (text) {
        // Implementa lógica para añadir notas
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SelectableText(
          widget.text,
          style: TextStyle(fontSize: 16),
          selectionControls: customControls,
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () {
              showColorPicker(context);
            },
            child: Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  void showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              // Implementa un selector de color
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }
}