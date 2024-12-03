import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repaso_farma/managers/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteManager {
  final StorageManager _storage = StorageManager();
  static const String _notesKey = 'class_notes';
  static const String _highlightsKey = 'class_highlights';

  Future<void> saveNote(Map<String, dynamic> noteData) async {
    await _storage.saveNote(noteData);
  }

  Future<void> saveHighlight(
    String className,
    bool isTranscription,
    String text,
    Color color,
  ) async {
    await _storage.saveHighlight(
      className,
      isTranscription,
      text,
      0,
      text.length,
      color,
    );
  }

  Future<Map<String, Color>> getHighlights(
    String className,
    bool isTranscription,
  ) async {
    return await _storage.getHighlights(className, isTranscription);
  }

  Future<void> updateHighlightColor(
    String className,
    bool isTranscription,
    String text,
    Color color,
  ) async {
    await _storage.updateHighlightColor(
      className,
      isTranscription,
      text,
      color,
    );
  }

  Future<void> removeHighlight(
    String className,
    bool isTranscription,
    String text,
  ) async {
    await _storage.removeHighlight(
      className,
      isTranscription,
      text,
    );
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

  Future<void> deleteNote(
    String className,
    String highlightedText,
    bool isTranscription,
  ) async {
    await _storage.deleteNote(className, highlightedText, isTranscription);
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    return await _storage.getNotes();
  }

  Future<void> updateNote(
    String className,
    String highlightedText,
    String newNote,
    bool isTranscription,
  ) async {
    await _storage.saveNote({
      'className': className,
      'highlightedText': highlightedText,
      'note': newNote,
      'isTranscription': isTranscription,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Método para guardar datos en SharedPreferences
  Future<void> _saveToPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Método para obtener datos de SharedPreferences
  Future<String?> _getFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
