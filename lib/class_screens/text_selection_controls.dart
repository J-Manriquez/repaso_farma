import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String)? onCopy;
  final Function(int, int)? onHighlight;
  final Function(String)? onNote;

  CustomTextSelectionControls({this.onCopy, this.onHighlight, this.onNote});

  @override
  Widget buildHandle(
    BuildContext context, 
    TextSelectionHandleType type,
    double textHeight, // Asegúrate de que esto coincida
    [VoidCallback? onTap]
  ) {
    return Container(); // Implementación personalizada
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight, // Asegúrate de que esto coincida
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus, // Tipo correcto para usar
    Offset? lastSecondaryTapDownPosition,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () => onCopy?.call(delegate.textEditingValue.text.substring(delegate.textEditingValue.selection.start, delegate.textEditingValue.selection.end)),
          ),
          IconButton(
            icon: const Icon(Icons.highlight),
            onPressed: () => onHighlight?.call(delegate.textEditingValue.selection.start, delegate.textEditingValue.selection.end),
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: () => onNote?.call(delegate.textEditingValue.text.substring(delegate.textEditingValue.selection.start, delegate.textEditingValue.selection.end)),
          ),
        ],
      ),
    );
  }
}