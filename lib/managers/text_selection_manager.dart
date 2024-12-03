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
    double textHeight, [
    VoidCallback? onTap,
  ]) {
    // Implementación de los controladores de selección
    final Widget handle = SizedBox(
      width: 22.0,
      height: 22.0,
      child: CustomPaint(
        painter: _HandlePainter(
          color: Theme.of(context).primaryColor,
          type: type,
        ),
      ),
    );

    // Hacemos el controlador interactivo
    return GestureDetector(
      onTap: onTap,
      child: handle,
    );
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
    // Constantes de dimensiones
    const double toolbarHeight = 48.0;
    const double toolbarWidth = 144.0;

    // Obtenemos las dimensiones de la pantalla
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Calculamos la posición para centrar el toolbar
    final double toolbarX = (screenWidth - toolbarWidth) / 2;
    final double toolbarY = (screenHeight - toolbarHeight) / 2;

    return Stack(
      children: [
        Positioned(
          left: toolbarX,
          top: toolbarY,
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToolbarButton(
                  context,
                  Icons.content_copy,
                  () => _handleCopy(delegate),
                ),
                const SizedBox(width: 4),
                _buildToolbarButton(
                  context,
                  Icons.highlight,
                  () => _handleHighlight(delegate),
                ),
                const SizedBox(width: 4),
                _buildToolbarButton(
                  context,
                  Icons.note_add,
                  () => _handleNote(delegate),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleCopy(TextSelectionDelegate delegate) {
    final String selectedText = delegate.textEditingValue.text.substring(
      delegate.textEditingValue.selection.start,
      delegate.textEditingValue.selection.end,
    );
    onCopy?.call(selectedText);
  }

  void _handleHighlight(TextSelectionDelegate delegate) {
    onHighlight?.call(
      delegate.textEditingValue.selection.start,
      delegate.textEditingValue.selection.end,
    );
  }

  void _handleNote(TextSelectionDelegate delegate) {
    final String selectedText = delegate.textEditingValue.text.substring(
      delegate.textEditingValue.selection.start,
      delegate.textEditingValue.selection.end,
    );
    onNote?.call(selectedText);
  }

  Widget _buildToolbarButton(
    BuildContext context,
    IconData icon,
    VoidCallback? onPressed,
  ) {
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

class _HandlePainter extends CustomPainter {
  final Color color;
  final TextSelectionHandleType type;

  _HandlePainter({
    required this.color,
    required this.type,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double radius = size.width / 2;
    final double handleHeight = size.height;

    switch (type) {
      case TextSelectionHandleType.left:
        _paintLeftHandle(canvas, size, paint, radius, handleHeight);
        break;
      case TextSelectionHandleType.right:
        _paintRightHandle(canvas, size, paint, radius, handleHeight);
        break;
      case TextSelectionHandleType.collapsed:
        _paintCollapsedHandle(canvas, size, paint, radius, handleHeight);
        break;
    }
  }

  void _paintLeftHandle(
    Canvas canvas,
    Size size,
    Paint paint,
    double radius,
    double handleHeight,
  ) {
    final Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, handleHeight / 2)
      ..lineTo(size.width, handleHeight)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        Offset(size.width - radius, handleHeight / 2), radius, paint);
  }

  void _paintRightHandle(
    Canvas canvas,
    Size size,
    Paint paint,
    double radius,
    double handleHeight,
  ) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, handleHeight / 2)
      ..lineTo(0, handleHeight)
      ..close();
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(radius, handleHeight / 2), radius, paint);
  }

  void _paintCollapsedHandle(
    Canvas canvas,
    Size size,
    Paint paint,
    double radius,
    double handleHeight,
  ) {
    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, handleHeight / 2)
      ..lineTo(size.width / 2, handleHeight)
      ..lineTo(size.width, handleHeight / 2)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) {
    return color != oldDelegate.color || type != oldDelegate.type;
  }
}
