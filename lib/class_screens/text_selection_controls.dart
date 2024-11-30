import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  CustomTextSelectionControls();

  @override
  Widget buildHandle(
      BuildContext context, 
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
    ValueListenable<ClipboardStatus>? clipboardStatus, // Cambiado aquí
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
              delegate.cutSelection(SelectionChangedCause.toolbar);
              super
                  .handleToolbarButtonPress(context, delegate, clipboardStatus);
            },
          ),
          IconButton(
            icon: const Icon(Icons.highlight),
            onPressed: () {
              // Implementa la lógica de resaltado aquí
              super
                  .handleToolbarButtonPress(context, delegate, clipboardStatus);
            },
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: () {
              // Implementa la lógica para agregar notas aquí
              super
                  .handleToolbarButtonPress(context, delegate, clipboardStatus);
            },
          ),
        ],
      ),
    );
  }

  @override
  void handleTap(TextPosition position) {
    // Implementa según necesites
  }

  @override
  bool canCut(TextSelectionDelegate delegate) => delegate.cutEnabled;

  @override
  bool canCopy(TextSelectionDelegate delegate) => delegate.copyEnabled;

  @override
  bool canPaste(TextSelectionDelegate delegate) => delegate.pasteEnabled;

  @override
  bool canSelectAll(TextSelectionDelegate delegate) =>
      delegate.selectAllEnabled;
}
