import 'package:flutter/material.dart';
import 'package:repaso_farma/content/class_content.dart';
import 'package:repaso_farma/content/test_content.dart';
import 'package:repaso_farma/screens/gallery_screen.dart';
import 'package:repaso_farma/screens/notes_screen.dart';
import 'package:repaso_farma/managers/test_clase_manager.dart';
import 'package:repaso_farma/screens/test_clase_screen.dart';
import 'package:repaso_farma/screens/video_player_screen.dart';
import 'transcip_review_screen.dart';

class ClassDetailScreen extends StatefulWidget {
  final String className;
  final String? highlightedTextToShow;

  const ClassDetailScreen({
    super.key,
    required this.className,
    this.highlightedTextToShow,
  });

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  String _selectedOption = 'Transcripción de la Clase';
  final List<String> _options = [
    'Transcripción de la Clase',
    'Repaso de la Clase',
    'Material Visual',
    'Video de la Clase',
    'Test',
  ];

  @override
  void didUpdateWidget(ClassDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.className != widget.className) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.highlightedTextToShow != null) {
      // Si hay texto para mostrar, seleccionar la opción correcta
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToHighlightedText();
      });
    }
  }

  void _scrollToHighlightedText() {
    if (widget.highlightedTextToShow != null) {
      // Determinar si el texto está en la transcripción o en el repaso
      final transcriptionText = _getTranscriptionText();
      final reviewText = _getReviewText();

      if (transcriptionText.contains(widget.highlightedTextToShow!)) {
        setState(() {
          _selectedOption = 'Transcripción de la Clase';
        });
      } else if (reviewText.contains(widget.highlightedTextToShow!)) {
        setState(() {
          _selectedOption = 'Repaso de la Clase';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.note),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesScreen(
                    className: widget.className,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedOption,
              items: _options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
                });
              },
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedOption) {
      case 'Transcripción de la Clase':
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: HighlightedText(
            text: _getTranscriptionText(),
            className: widget.className,
            isTranscription: true,
            textToHighlight: widget.highlightedTextToShow,
          ),
        );
      case 'Repaso de la Clase':
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: HighlightedText(
            text: _getReviewText(),
            className: widget.className,
            isTranscription: false,
            textToHighlight: widget.highlightedTextToShow,
          ),
        );
      case 'Material Visual':
        return GalleryScreen(className: widget.className);
      case 'Video de la Clase': // Agregar este caso
        final videoId = ClassContent.getVideoId(widget.className);
        if (videoId.isEmpty) {
          return const Center(
            child: Text('No hay video disponible para esta clase'),
          );
        }
        return VideoPlayerScreen(
          className: widget.className,
          videoId: videoId,
        );
      case 'Test':
        return TestScreen(className: widget.className);
      default:
        return const SizedBox.shrink();
    }
  }

  String _getTranscriptionText() {
    return ClassContent.getTranscription(widget.className);
  }

  String _getReviewText() {
    return ClassContent.getReview(widget.className);
  }
}
