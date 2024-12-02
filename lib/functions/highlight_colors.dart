import 'package:flutter/material.dart';

class HighlightColors {
  // Colores predefinidos para resaltado
  static const List<Color> colors = [
    // Amarillos
    Color(0xFFFFEB3B), // Amarillo primario
    Color(0xFFFFF176), // Amarillo claro
    
    // Verdes
    Color(0xFF81C784), // Verde claro
    Color(0xFFA5D6A7), // Verde más claro
    
    // Azules
    Color(0xFF64B5F6), // Azul claro
    Color(0xFF90CAF9), // Azul más claro
    
    // Rosas
    Color(0xFFF48FB1), // Rosa claro
    Color(0xFFF8BBD0), // Rosa más claro
  ];

  // Métodos de utilidad para manejar colores
  
  // Obtener color por índice con validación
  static Color getColorByIndex(int index) {
    if (index < 0 || index >= colors.length) {
      return colors[0]; // Retorna el color por defecto si el índice es inválido
    }
    return colors[index];
  }

  // Obtener color con opacidad específica
  static Color getColorWithOpacity(Color color, {double opacity = 0.3}) {
    return color.withOpacity(opacity);
  }

  // Obtener el índice de un color en la lista
  static int getColorIndex(Color color) {
    return colors.indexOf(color);
  }

  // Verificar si un color está en la lista de colores predefinidos
  static bool isPresetColor(Color color) {
    return colors.contains(color);
  }

  // Obtener el siguiente color en la lista (útil para rotación de colores)
  static Color getNextColor(Color currentColor) {
    int currentIndex = getColorIndex(currentColor);
    if (currentIndex == -1) return colors[0];
    
    int nextIndex = (currentIndex + 1) % colors.length;
    return colors[nextIndex];
  }

  // Obtener el color anterior en la lista
  static Color getPreviousColor(Color currentColor) {
    int currentIndex = getColorIndex(currentColor);
    if (currentIndex == -1) return colors[0];
    
    int previousIndex = (currentIndex - 1 + colors.length) % colors.length;
    return colors[previousIndex];
  }

  // Obtener un color aleatorio de la lista
  static Color getRandomColor() {
    return colors[DateTime.now().millisecond % colors.length];
  }

  // Verificar si un color es claro u oscuro
  static bool isLightColor(Color color) {
    return color.computeLuminance() > 0.5;
  }

  // Obtener el color de texto apropiado basado en el color de fondo
  static Color getAppropriateTextColor(Color backgroundColor) {
    return isLightColor(backgroundColor) ? Colors.black : Colors.white;
  }

  // Obtener una descripción del color (útil para accesibilidad)
  static String getColorDescription(Color color) {
    if (color == colors[0] || color == colors[1]) return 'Amarillo';
    if (color == colors[2] || color == colors[3]) return 'Verde';
    if (color == colors[4] || color == colors[5]) return 'Azul';
    if (color == colors[6] || color == colors[7]) return 'Rosa';
    return 'Color personalizado';
  }

  // Agrupar colores por tonalidad
  static Map<String, List<Color>> getColorsByHue() {
    return {
      'Amarillos': colors.sublist(0, 2),
      'Verdes': colors.sublist(2, 4),
      'Azules': colors.sublist(4, 6),
      'Rosas': colors.sublist(6, 8),
    };
  }

  // Obtener el color complementario
  static Color getComplementaryColor(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor.withHue((hslColor.hue + 180) % 360).toColor();
  }

  // Obtener una versión más clara del color
  static Color getLighterVersion(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor.withLightness((hslColor.lightness + 0.1).clamp(0.0, 1.0)).toColor();
  }

  // Obtener una versión más oscura del color
  static Color getDarkerVersion(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor.withLightness((hslColor.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }

  // Obtener una paleta de colores basada en un color
  static List<Color> getColorPalette(Color baseColor) {
    final hslColor = HSLColor.fromColor(baseColor);
    return [
      hslColor.withLightness((hslColor.lightness - 0.2).clamp(0.0, 1.0)).toColor(),
      hslColor.withLightness((hslColor.lightness - 0.1).clamp(0.0, 1.0)).toColor(),
      baseColor,
      hslColor.withLightness((hslColor.lightness + 0.1).clamp(0.0, 1.0)).toColor(),
      hslColor.withLightness((hslColor.lightness + 0.2).clamp(0.0, 1.0)).toColor(),
    ];
  }
}