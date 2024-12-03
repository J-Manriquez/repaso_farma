import 'package:flutter/material.dart';
import 'package:repaso_farma/content/class_content.dart';
import 'package:repaso_farma/screens/gallery_screen.dart';
import 'package:repaso_farma/screens/notes_screen.dart';
import 'transcip_review_screen.dart';
import '../managers/note_manager.dart';

class ClassDetailScreen extends StatefulWidget {
  final String className;

  const ClassDetailScreen({
    super.key,
    required this.className,
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
    'Video',
    'Test',
  ];

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
          ),
        );
      case 'Repaso de la Clase':
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: HighlightedText(
            text: _getReviewText(),
            className: widget.className,
            isTranscription: false,
          ),
        );
      case 'Material Visual':
        return GalleryScreen(className: widget.className);
      case 'Video':
        return const Center(
          child: Text('Próximamente: Sección de Video'),
        );
      case 'Test':
        return const Center(
          child: Text('Próximamente: Sección de Test'),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _getTranscriptionText() {
    // Aquí puedes poner el texto real de la transcripción
    return ClassContent.getTranscription(widget.className);
  }

  String _getReviewText() {
    // Aquí puedes poner el texto real del repaso
    return ClassContent.getReview(widget.className);
  }
}
