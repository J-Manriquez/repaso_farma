import 'package:flutter/material.dart';
import 'package:repaso_farma/models/storage_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteManager {
  static const String _storageKey = 'app_storage_data';
  StorageData? _cachedData;

  // Obtener los datos almacenados
  Future<StorageData> _getStorageData() async {
    if (_cachedData != null) return _cachedData!;

    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      _cachedData = StorageData(classes: {});
      return _cachedData!;
    }

    try {
      _cachedData = StorageData.fromJsonString(jsonString);
      return _cachedData!;
    } catch (e) {
      print('Error parsing storage data: $e');
      _cachedData = StorageData(classes: {});
      return _cachedData!;
    }
  }

  // Guardar los datos en SharedPreferences
  Future<void> _saveStorageData(StorageData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, data.toJsonString());
    _cachedData = data;
  }

  // GESTIÓN DE NOTAS

  // Agregar o actualizar una nota
  Future<void> saveNote({
    required String className,
    required String text,
    required String note,
    required int startPosition,
    required int endPosition,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    final noteData = NoteData(
      text: text,
      note: note,
      startPosition: startPosition,
      endPosition: endPosition,
      className: className,
      isTranscription: isTranscription,
    );

    // Crear o actualizar la clase en el storage
    final classData = storageData.classes[className] ??
        ClassData(className: className, highlights: [], notes: []);

    // Remover nota existente si hay una en la misma posición
    classData.notes.removeWhere((n) =>
        n.startPosition == startPosition &&
        n.endPosition == endPosition &&
        n.isTranscription == isTranscription);

    // Agregar la nueva nota
    classData.notes.add(noteData);
    storageData.classes[className] = classData;

    await _saveStorageData(storageData);
  }

  // Eliminar una nota
  Future<void> deleteNote({
    required String className,
    required int startPosition,
    required int endPosition,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (storageData.classes.containsKey(className)) {
      final classData = storageData.classes[className]!;
      classData.notes.removeWhere((note) =>
          note.startPosition == startPosition &&
          note.endPosition == endPosition &&
          note.isTranscription == isTranscription);

      await _saveStorageData(storageData);
    }
  }

  // Obtener todas las notas de una clase
  Future<List<NoteData>> getNotes({
    required String className,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (!storageData.classes.containsKey(className)) {
      return [];
    }

    return storageData.classes[className]!.getNotesForType(isTranscription);
  }

  // GESTIÓN DE RESALTADOS

  // Agregar o actualizar un resaltado
  Future<void> saveHighlight({
    required String className,
    required String text,
    required Color color,
    required int startPosition,
    required int endPosition,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    final highlightData = HighlightData(
      text: text,
      startPosition: startPosition,
      endPosition: endPosition,
      colorValue: color.value,
      className: className,
      isTranscription: isTranscription,
    );

    // Crear o actualizar la clase en el storage
    final classData = storageData.classes[className] ??
        ClassData(className: className, highlights: [], notes: []);

    // Remover highlight existente si hay uno en la misma posición
    classData.highlights.removeWhere((h) =>
        h.startPosition == startPosition &&
        h.endPosition == endPosition &&
        h.isTranscription == isTranscription);

    // Agregar el nuevo highlight
    classData.highlights.add(highlightData);
    storageData.classes[className] = classData;

    await _saveStorageData(storageData);
  }

  // Actualizar el color de un resaltado
  Future<void> updateHighlightColor({
    required String className,
    required int startPosition,
    required int endPosition,
    required Color newColor,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (storageData.classes.containsKey(className)) {
      final classData = storageData.classes[className]!;
      final highlightIndex = classData.highlights.indexWhere((h) =>
          h.startPosition == startPosition &&
          h.endPosition == endPosition &&
          h.isTranscription == isTranscription);

      if (highlightIndex != -1) {
        final oldHighlight = classData.highlights[highlightIndex];
        final newHighlight = HighlightData(
          text: oldHighlight.text,
          startPosition: oldHighlight.startPosition,
          endPosition: oldHighlight.endPosition,
          colorValue: newColor.value,
          className: oldHighlight.className,
          isTranscription: oldHighlight.isTranscription,
        );

        classData.highlights[highlightIndex] = newHighlight;
        await _saveStorageData(storageData);
      }
    }
  }

  // Eliminar un resaltado
  Future<void> deleteHighlight({
    required String className,
    required int startPosition,
    required int endPosition,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (storageData.classes.containsKey(className)) {
      final classData = storageData.classes[className]!;
      classData.highlights.removeWhere((highlight) =>
          highlight.startPosition == startPosition &&
          highlight.endPosition == endPosition &&
          highlight.isTranscription == isTranscription);

      await _saveStorageData(storageData);
    }
  }

  // Obtener todos los resaltados de una clase
  Future<List<HighlightData>> getHighlights({
    required String className,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (!storageData.classes.containsKey(className)) {
      return [];
    }

    return storageData.classes[className]!
        .getHighlightsForType(isTranscription);
  }

  // UTILIDADES

  // Limpiar todos los datos almacenados
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    _cachedData = null;
  }

  // Verificar si existe una nota o resaltado en una posición específica
  Future<bool> hasContentAtPosition({
    required String className,
    required int position,
    required bool isTranscription,
  }) async {
    final storageData = await _getStorageData();

    if (!storageData.classes.containsKey(className)) {
      return false;
    }

    final classData = storageData.classes[className]!;

    // Verificar notas
    final hasNote = classData.notes.any((note) =>
        position >= note.startPosition &&
        position < note.endPosition &&
        note.isTranscription == isTranscription);

    // Verificar highlights
    final hasHighlight = classData.highlights.any((highlight) =>
        position >= highlight.startPosition &&
        position < highlight.endPosition &&
        highlight.isTranscription == isTranscription);

    return hasNote || hasHighlight;
  }
}
