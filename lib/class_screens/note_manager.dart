import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteManager {
  static const String _notesKey = 'class_notes';
  static const String _highlightsKey = 'class_highlights';

  Future<void> saveNote(
    String className,
    String highlightedText,
    String note,
    bool isTranscription,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();

    final newNote = {
      'className': className,
      'highlightedText': highlightedText,
      'note': note,
      'isTranscription': isTranscription,
      'timestamp': DateTime.now().toIso8601String(),
    };

    notes.add(newNote);
    await prefs.setString(_notesKey, jsonEncode(notes));
  }

  Future<void> saveHighlight(String className, bool isTranscription, String text, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    // Assumes you have a suitable function to convert Color to a string or store its value in a suitable format and vice versa.
    final highlights = (json.decode(prefs.getString('highlights_$className') ?? "{}") as Map).cast<String, dynamic>();

    final highlightEntry = {
      'text': text,
      'color': color.value,
    };

    highlights[isTranscription ? 'transcription' : 'review'].add(highlightEntry);

    await prefs.setString('highlights_$className', json.encode(highlights));
  }


  Future<Map<TextRange, Color>> getHighlights(
    String className,
    bool isTranscription,
  ) async {
    final highlights = await getHighlightsData();
    final key = '${className}_${isTranscription ? 'trans' : 'review'}';
    
    Map<TextRange, Color> result = {};
    if (highlights.containsKey(key)) {
      for (var highlight in highlights[key]!) {
        result[TextRange(
          start: highlight['start'],
          end: highlight['end'],
        )] = Color(highlight['color']);
      }
    }
    return result;
  }

  Future<Map<String, List<Map<String, dynamic>>>> getHighlightsData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? highlightsString = prefs.getString(_highlightsKey);
    if (highlightsString == null) return {};

    final Map<String, dynamic> decoded = jsonDecode(highlightsString);
    Map<String, List<Map<String, dynamic>>> result = {};
    
    decoded.forEach((key, value) {
      result[key] = (value as List).cast<Map<String, dynamic>>();
    });
    
    return result;
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString(_notesKey);
    if (notesString == null) return [];

    final List<dynamic> decoded = jsonDecode(notesString);
    return decoded.cast<Map<String, dynamic>>();
  }
}