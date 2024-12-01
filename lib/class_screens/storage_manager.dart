// storage_manager.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class StorageManager {
  static const String _fileName = 'app_data.json';

  // Estructura del JSON:
  // {
  //   "highlights": {
  //     "className_isTranscription": [
  //       {
  //         "text": "texto resaltado",
  //         "start": 0,
  //         "end": 10,
  //         "color": 4294967295
  //       }
  //     ]
  //   },
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
        return {"highlights": {}, "notes": []};
      }

      String contents = await file.readAsString();
      return json.decode(contents) as Map<String, dynamic>;
    } catch (e) {
      print('Error loading data: $e');
      return {"highlights": {}, "notes": []};
    }
  }

  Future<void> saveData(Map<String, dynamic> data) async {
    try {
      final file = await _localFile;
      await file.writeAsString(json.encode(data));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> saveHighlight(
    String className,
    bool isTranscription,
    String text,
    int start,
    int end,
    Color color,
  ) async {
    final data = await loadData();
    final key = '${className}_${isTranscription ? 'trans' : 'review'}';

    if (!data.containsKey('highlights')) {
      data['highlights'] = {};
    }

    if (!data['highlights'].containsKey(key)) {
      data['highlights'][key] = [];
    }

    data['highlights'][key].add({
      'text': text,
      'start': start,
      'end': end,
      'color': color.value,
    });

    await saveData(data);
  }

  Future<void> updateHighlight(
    String className,
    bool isTranscription,
    int start,
    int end,
    Color newColor,
  ) async {
    final data = await loadData();
    final key = '${className}_${isTranscription ? 'trans' : 'review'}';

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
    int start,
    int end,
  ) async {
    final data = await loadData();
    final key = '${className}_${isTranscription ? 'trans' : 'review'}';

    if (data['highlights'].containsKey(key)) {
      final highlights = data['highlights'][key] as List;
      highlights.removeWhere(
        (h) => h['start'] == start && h['end'] == end,
      );
      await saveData(data);
    }
  }

  Future<Map<TextRange, Color>> getHighlights(
    String className,
    bool isTranscription,
  ) async {
    final data = await loadData();
    final key = '${className}_${isTranscription ? 'trans' : 'review'}';

    Map<TextRange, Color> result = {};

    if (data['highlights'].containsKey(key)) {
      final highlights = data['highlights'][key] as List;
      for (var highlight in highlights) {
        result[TextRange(
          start: highlight['start'] as int,
          end: highlight['end'] as int,
        )] = Color(highlight['color'] as int);
      }
    }

    return result;
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
    if (!data.containsKey('notes')) {
      return [];
    }
    return (data['notes'] as List).cast<Map<String, dynamic>>();
  }
}
