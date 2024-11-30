import 'package:flutter/material.dart';
import 'package:repaso_farma/class_screens/highlight_colors.dart';
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

  // Cursor positions
  TextSelection? currentSelection;
  RangeValues? selectedRange;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () {
            setState(() {
              currentSelection = TextSelection(
                baseOffset: 0,
                extentOffset: widget.text.length,
              );
            });
          },
          child: SelectableText(
            widget.text,
            selectionControls: CustomTextSelectionControls(),
            onSelectionChanged: (selection, cause) {
              setState(() {
                currentSelection = selection;
              });
            },
          ),
        ),
        if (currentSelection != null)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => _showHighlightOptions(context),
              child: const Icon(Icons.edit),
            ),
          ),
      ],
    );
  }

  void _showHighlightOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: HighlightColors.colors.map((color) => _buildColorButton(color)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          _noteManager.saveHighlight(
            widget.className,
            widget.isTranscription,
            widget.text.substring(currentSelection!.start, currentSelection!.end),
            color,
          );
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}