import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repaso_farma/class_screens/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteManager {
  final StorageManager _storage = StorageManager();
  static const String _notesKey = 'class_notes';
  static const String _highlightsKey = 'class_highlights';

  Future<void> saveNote(
    String className,
    String highlightedText,
    String note,
    bool isTranscription,
  ) async {
    await _storage.saveNote({
      'className': className,
      'highlightedText': highlightedText,
      'note': note,
      'isTranscription': isTranscription,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> saveHighlight(
      String className, bool isTranscription, String text, Color color) async {
    await _storage.saveHighlight(
      className,
      isTranscription,
      text,
      0, // Necesitarás pasar el inicio real
      text.length, // Y el final real
      color,
    );
  }

  Future<Map<TextRange, Color>> getHighlights(
    String className,
    bool isTranscription,
  ) async {
    return await _storage.getHighlights(className, isTranscription);
  }

  Future<void> updateHighlightColor(
    String className,
    bool isTranscription,
    TextRange range,
    Color color,
  ) async {
    await _storage.updateHighlight(
      className,
      isTranscription,
      range.start,
      range.end,
      color,
    );
  }

  Future<void> removeHighlight(
    String className,
    bool isTranscription,
    TextRange range,
  ) async {
    await _storage.removeHighlight(
      className,
      isTranscription,
      range.start,
      range.end,
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

}
