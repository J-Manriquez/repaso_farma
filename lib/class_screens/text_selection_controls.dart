import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String)? onCopy;
  final Function(int, int)? onHighlight;
  final Function(String)? onNote;

  CustomTextSelectionControls({this.onCopy, this.onHighlight, this.onNote});

  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textHeight,
      [VoidCallback? onTap]) {
    return Container(); // Implementación personalizada
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    // Ajustamos la posición para que aparezca sobre el texto seleccionado
    const double paddingAbove = 150.0; // Espacio sobre el texto
    const double toolbarHeight = 60.0;

    // Calculamos las posiciones
    final double y = endpoints.first.point.dy - paddingAbove - toolbarHeight;
    final double centerX =
        (endpoints.first.point.dx + endpoints.last.point.dx) / 2;

    // Construimos el contenedor de botones
    return Transform.translate(
      offset: Offset(centerX - 70,
          y), // 70 es aproximadamente la mitad del ancho total de los botones
      child: Container(
        height: toolbarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToolbarButton(
              context,
              Icons.content_copy,
              () => onCopy?.call(delegate.textEditingValue.text.substring(
                delegate.textEditingValue.selection.start,
                delegate.textEditingValue.selection.end,
              )),
            ),
            const SizedBox(width: 8),
            _buildToolbarButton(
              context,
              Icons.highlight,
              () => onHighlight?.call(
                delegate.textEditingValue.selection.start,
                delegate.textEditingValue.selection.end,
              ),
            ),
            const SizedBox(width: 8),
            _buildToolbarButton(
              context,
              Icons.note_add,
              () => onNote?.call(delegate.textEditingValue.text.substring(
                delegate.textEditingValue.selection.start,
                delegate.textEditingValue.selection.end,
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton(
      BuildContext context, IconData icon, VoidCallback? onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 20,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  bool canSelectAll(TextSelectionDelegate delegate) {
    return true;
  }
}
