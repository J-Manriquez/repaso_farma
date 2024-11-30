import 'package:flutter/material.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  CustomTextSelectionControls();

  @override
  Widget buildHandle(BuildContext context, 
      TextSelectionHandleType type,
      double textLineHeight, // Cambiado aquí
      [VoidCallback? onTap]) {
    return Container(); // Implementa según necesites
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () {
              delegate.copySelection(SelectionChangedCause.toolbar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.highlight),
            onPressed: () {
              // Implement your custom highlighting logic here.
            },
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: () {
              // Insert your note-adding functionality here.
            },
          ),
        ],
      ),
    );
  }
}
