import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String)? onCopy;
  final Function(int, int)? onHighlight;
  final Function(String)? onNote;

  CustomTextSelectionControls({
    this.onCopy,
    this.onHighlight,
    this.onNote,
  });

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
    // Calculamos la posición para que aparezca sobre el texto seleccionado
    const double toolbarHeight = 56.0;
    const double paddingAbove = 20.0;
    const double buttonWidth = 40.0;
    const double totalWidth = buttonWidth * 3 + 16.0; // 3 botones + espaciado

    // Calculamos el centro de la selección
    final Offset midpoint = selectionMidpoint;

    // Ajustamos la posición horizontal para centrar el toolbar
    double x = midpoint.dx - (totalWidth / 2);
    
    // Aseguramos que el toolbar no se salga de los bordes de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;
    x = x.clamp(8.0, screenWidth - totalWidth - 8.0);

    // La posición vertical siempre será sobre el texto
    final double y = endpoints.first.point.dy - toolbarHeight - paddingAbove;

    // Construimos el toolbar con elevación para asegurar que esté por encima
    return Positioned(
      left: x,
      top: y,
      child: Material(
        elevation: 4.0, // Añadimos sombra para enfatizar que está por encima
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: toolbarHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToolbarButton(
                context: context,
                icon: Icons.content_copy,
                onPressed: () {
                  final text = delegate.textEditingValue.text.substring(
                    delegate.textEditingValue.selection.start,
                    delegate.textEditingValue.selection.end,
                  );
                  onCopy?.call(text);
                  delegate.hideToolbar();
                },
                tooltip: 'Copiar',
              ),
              _buildToolbarButton(
                context: context,
                icon: Icons.highlight,
                onPressed: () {
                  final selection = delegate.textEditingValue.selection;
                  onHighlight?.call(selection.start, selection.end);
                  delegate.hideToolbar();
                },
                tooltip: 'Resaltar',
              ),
              _buildToolbarButton(
                context: context,
                icon: Icons.note_add,
                onPressed: () {
                  final text = delegate.textEditingValue.text.substring(
                    delegate.textEditingValue.selection.start,
                    delegate.textEditingValue.selection.end,
                  );
                  onNote?.call(text);
                  delegate.hideToolbar();
                },
                tooltip: 'Agregar nota',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 22,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
    double? startGlyphHeight,
    double? endGlyphHeight,
  ]) {
    // Personalizamos los controles de selección para que sean más visibles
    final Widget handle = SizedBox(
      width: 22.0,
      height: 22.0,
      child: CustomPaint(
        painter: _SelectionHandlePainter(
          color: Theme.of(context).primaryColor,
          type: type,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: handle,
      );
    }

    return handle;
  }

  @override
  bool canSelectAll(TextSelectionDelegate delegate) => true;

  // Ajustamos el tamaño del área de selección para mejor precisión
  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    switch (type) {
      case TextSelectionHandleType.left:
        return const Offset(11.0, 22.0);
      case TextSelectionHandleType.right:
        return const Offset(11.0, 22.0);
      case TextSelectionHandleType.collapsed:
        return const Offset(11.0, 22.0);
    }
  }
}

// Clase para dibujar los controles de selección personalizados
class _SelectionHandlePainter extends CustomPainter {
  final Color color;
  final TextSelectionHandleType type;

  _SelectionHandlePainter({
    required this.color,
    required this.type,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final double handleHeight = size.height * 0.6;

    final Path path = Path();
    
    switch (type) {
      case TextSelectionHandleType.left:
        path.moveTo(size.width, 0);
        path.lineTo(0, handleHeight);
        path.lineTo(size.width, size.height);
        break;
      case TextSelectionHandleType.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, handleHeight);
        path.lineTo(0, size.height);
        break;
      case TextSelectionHandleType.collapsed:
        path.addOval(Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        ));
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SelectionHandlePainter oldDelegate) =>
      color != oldDelegate.color || type != oldDelegate.type;
}