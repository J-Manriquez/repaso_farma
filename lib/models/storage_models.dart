import 'dart:convert';
import 'package:flutter/material.dart';

// Modelo para los datos de un resaltado
class HighlightData {
  final String text;
  final int startPosition;
  final int endPosition;
  final int colorValue;
  final double opacity;
  final String className;
  final bool isTranscription;
  final DateTime timestamp;

  HighlightData({
    required this.text,
    required this.startPosition,
    required this.endPosition,
    required this.colorValue,
    this.opacity = 0.3,
    required this.className,
    required this.isTranscription,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'text': text,
        'startPosition': startPosition,
        'endPosition': endPosition,
        'colorValue': colorValue,
        'opacity': opacity,
        'className': className,
        'isTranscription': isTranscription,
        'timestamp': timestamp.toIso8601String(),
      };

  // Crear desde JSON
  factory HighlightData.fromJson(Map<String, dynamic> json) => HighlightData(
        text: json['text'],
        startPosition: json['startPosition'],
        endPosition: json['endPosition'],
        colorValue: json['colorValue'],
        opacity: json['opacity'],
        className: json['className'],
        isTranscription: json['isTranscription'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  // Obtener el color del resaltado
  Color get color => Color(colorValue);

  // Crear un TextRange para el resaltado
  TextRange get range => TextRange(start: startPosition, end: endPosition);
}

// Modelo para los datos de una nota
class NoteData {
  final String text;
  final String note;
  final int startPosition;
  final int endPosition;
  final String className;
  final bool isTranscription;
  final DateTime timestamp;

  NoteData({
    required this.text,
    required this.note,
    required this.startPosition,
    required this.endPosition,
    required this.className,
    required this.isTranscription,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'text': text,
        'note': note,
        'startPosition': startPosition,
        'endPosition': endPosition,
        'className': className,
        'isTranscription': isTranscription,
        'timestamp': timestamp.toIso8601String(),
      };

  // Crear desde JSON
  factory NoteData.fromJson(Map<String, dynamic> json) => NoteData(
        text: json['text'],
        note: json['note'],
        startPosition: json['startPosition'],
        endPosition: json['endPosition'],
        className: json['className'],
        isTranscription: json['isTranscription'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  // Crear un TextRange para la nota
  TextRange get range => TextRange(start: startPosition, end: endPosition);
}

// Modelo para almacenar todos los datos de una clase
class ClassData {
  final String className;
  final List<HighlightData> highlights;
  final List<NoteData> notes;

  ClassData({
    required this.className,
    required this.highlights,
    required this.notes,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'className': className,
        'highlights': highlights.map((h) => h.toJson()).toList(),
        'notes': notes.map((n) => n.toJson()).toList(),
      };

  // Crear desde JSON
  factory ClassData.fromJson(Map<String, dynamic> json) => ClassData(
        className: json['className'],
        highlights: (json['highlights'] as List)
            .map((h) => HighlightData.fromJson(h))
            .toList(),
        notes: (json['notes'] as List)
            .map((n) => NoteData.fromJson(n))
            .toList(),
      );

  // Métodos de utilidad
  List<HighlightData> getHighlightsForType(bool isTranscription) {
    return highlights
        .where((h) => h.isTranscription == isTranscription)
        .toList();
  }

  List<NoteData> getNotesForType(bool isTranscription) {
    return notes
        .where((n) => n.isTranscription == isTranscription)
        .toList();
  }
}

// Gestor de almacenamiento principal
class StorageData {
  final Map<String, ClassData> classes;

  StorageData({
    required this.classes,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() => {
        'classes': classes.map((key, value) => MapEntry(key, value.toJson())),
      };

  // Crear desde JSON
  factory StorageData.fromJson(Map<String, dynamic> json) => StorageData(
        classes: (json['classes'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, ClassData.fromJson(value)),
        ),
      );

  // Convertir a string JSON
  String toJsonString() => jsonEncode(toJson());

  // Crear desde string JSON
  factory StorageData.fromJsonString(String jsonString) =>
      StorageData.fromJson(jsonDecode(jsonString));
}