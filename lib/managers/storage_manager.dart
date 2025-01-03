// storage_manager.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class StorageManager {
  static const String _fileName = 'app_data.json';

  StorageManager() {
    _ensureValidDataStructure();
  }

  // {
  //   "highlights": [
  //     {
  //       "className": "Clase 1",
  //       "text": "texto resaltado",
  //       "color": 4294967295,
  //       "isTranscription": true
  //     }
  //   ],
  //   "notes": [
  //     {
  //       "className": "Clase 1",
  //       "highlightedText": "texto",
  //       "note": "nota",
  //       "isTranscription": true
  //     }
  //   ]
  // }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<Map<String, dynamic>> loadData() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return {"highlights": [], "notes": []};
      }

      String contents = await file.readAsString();
      Map<String, dynamic> data = json.decode(contents);

      // Asegurar que la estructura es correcta
      if (!data.containsKey('highlights')) {
        data['highlights'] = [];
      }
      if (!data.containsKey('notes')) {
        data['notes'] = [];
      }

      return data;
    } catch (e) {
      print('Error loading data: $e');
      return {"highlights": [], "notes": []};
    }
  }

  Future<void> saveData(Map<String, dynamic> data) async {
    try {
      final file = await _localFile;
      // Asegurarse de que los datos tienen la estructura correcta
      if (!data.containsKey('highlights')) data['highlights'] = [];
      if (!data.containsKey('notes')) data['notes'] = [];

      await file.writeAsString(json.encode(data));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> saveHighlight(
    String className,
    bool isTranscription,
    String text,
    Color color,
  ) async {
    try {
      final data = await loadData();
      final highlights = data['highlights'] as List;

      final highlightData = {
        'className': className,
        'text': text,
        'color': color.value,
        'isTranscription': isTranscription,
      };

      // Buscar si ya existe un highlight similar
      final index = highlights.indexWhere((h) =>
          h['className'] == className &&
          h['text'] == text &&
          h['isTranscription'] == isTranscription);

      if (index != -1) {
        highlights[index] = highlightData;
      } else {
        highlights.add(highlightData);
      }

      await saveData(data);
    } catch (e) {
      print('Error saving highlight: $e');
    }
  }

  Future<void> _ensureValidDataStructure() async {
    try {
      final data = await loadData();
      bool needsSave = false;

      if (!data.containsKey('highlights') || !(data['highlights'] is List)) {
        data['highlights'] = [];
        needsSave = true;
      }

      if (!data.containsKey('notes') || !(data['notes'] is List)) {
        data['notes'] = [];
        needsSave = true;
      }

      if (needsSave) {
        await saveData(data);
      }
    } catch (e) {
      print('Error ensuring valid data structure: $e');
    }
  }

  Future<void> updateHighlight(
    String className,
    bool isTranscription,
    int start,
    int end,
    Color newColor,
  ) async {
    final data = await loadData();
    final key = _getHighlightKey(className, isTranscription);

    if (data['highlights'].containsKey(key)) {
      final highlights = data['highlights'][key] as List;
      final index = highlights.indexWhere(
        (h) => h['start'] == start && h['end'] == end,
      );

      if (index != -1) {
        highlights[index]['color'] = newColor.value;
        await saveData(data);
      }
    }
  }

  Future<void> removeHighlight(
    String className,
    bool isTranscription,
    String text,
  ) async {
    final data = await loadData();

    if (data.containsKey('highlights')) {
      final highlights = data['highlights'] as List;
      highlights.removeWhere((h) =>
          h['className'] == className &&
          h['text'] == text &&
          h['isTranscription'] == isTranscription);
      await saveData(data);
    }
  }

  String _getHighlightKey(String className, bool isTranscription) {
    // Crear una clave más específica que diferencie claramente entre transcripción y repaso
    return isTranscription
        ? '${className}_transcription_highlights'
        : '${className}_review_highlights';
  }

  Future<List<Map<String, dynamic>>> getHighlights() async {
    try {
      final data = await loadData();
      if (data['highlights'] is List) {
        return List<Map<String, dynamic>>.from(data['highlights']);
      }
      return [];
    } catch (e) {
      print('Error getting highlights: $e');
      return [];
    }
  }

  Future<void> updateHighlightColor(
    String className,
    bool isTranscription,
    String text,
    Color newColor,
  ) async {
    final data = await loadData();

    if (data.containsKey('highlights')) {
      final highlights = data['highlights'] as List;
      final index = highlights.indexWhere((h) =>
          h['className'] == className &&
          h['text'] == text &&
          h['isTranscription'] == isTranscription);

      if (index != -1) {
        highlights[index]['color'] = newColor.value;
        await saveData(data);
      }
    }
  }

  Future<void> saveNote(Map<String, dynamic> note) async {
    final data = await loadData();
    if (!data.containsKey('notes')) {
      data['notes'] = [];
    }

    final notes = data['notes'] as List;
    final index = notes.indexWhere((n) =>
        n['className'] == note['className'] &&
        n['highlightedText'] == note['highlightedText'] &&
        n['isTranscription'] == note['isTranscription']);

    if (index != -1) {
      notes[index] = note;
    } else {
      notes.add(note);
    }

    await saveData(data);
  }

  Future<void> deleteNote(
    String className,
    String highlightedText,
    bool isTranscription,
  ) async {
    final data = await loadData();
    if (data.containsKey('notes')) {
      final notes = data['notes'] as List;
      notes.removeWhere((note) =>
          note['className'] == className &&
          note['highlightedText'] == highlightedText &&
          note['isTranscription'] == isTranscription);
      await saveData(data);
    }
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final data = await loadData();
    return List<Map<String, dynamic>>.from(data['notes'] ?? []);
  }
}
