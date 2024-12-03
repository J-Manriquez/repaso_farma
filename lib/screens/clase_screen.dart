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

// // Widget para la pantalla de test
// class TestScreen extends StatefulWidget {
//   final String className;

//   const TestScreen({
//     super.key,
//     required this.className,
//   });

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   List<Map<String, dynamic>>? _currentTest;
//   List<String?> _userAnswers = [];
//   bool _testCompleted = false;
//   double _score = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _startNewTest();
//   }

//   void _startNewTest() {
//   setState(() {
//     // Siempre selecciona 5 preguntas aleatorias
//     _currentTest = TestContent.getRandomQuestions(widget.className, 5);
//     _userAnswers = List.filled(_currentTest?.length ?? 0, null);
//     _testCompleted = false;
//     _score = 0.0;
//   });
// }

//   void _submitTest() {
//     if (_userAnswers.contains(null)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Por favor responde todas las preguntas'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _testCompleted = true;
//       _score = TestManager.calculateScore(
//         _currentTest!,
//         _userAnswers.whereType<String>().toList(),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_currentTest == null || _currentTest!.isEmpty) {
//       return const Center(
//         child: Text('No hay preguntas disponibles para esta clase'),
//       );
//     }

//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: _currentTest!.length,
//             itemBuilder: (context, index) {
//               final question = _currentTest![index];
//               final bool isComplex = TestManager.isComplexQuestion(question);

//               return Card(
//                 margin: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pregunta ${index + 1}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(question['question']),
//                       if (isComplex) ...[
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Soluciones:',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         ...TestManager.getComplexSolutions(question)
//                             .map((solution) => Text('$solution')),
//                       ],
//                       const SizedBox(height: 16),
//                       ...question['options'].map<Widget>((option) {
//                         return RadioListTile<String>(
//                           title: Text(option),
//                           value: option,
//                           groupValue: _userAnswers[index],
//                           onChanged: _testCompleted
//                               ? null
//                               : (String? value) {
//                                   setState(() {
//                                     _userAnswers[index] = value;
//                                   });
//                                 },
//                         );
//                       }),
//                       if (_testCompleted) ...[
//                         const Divider(),
//                         Row(
//                           children: [
//                             Icon(
//                               _userAnswers[index] == question['correctAnswer']
//                                   ? Icons.check_circle
//                                   : Icons.cancel,
//                               color: _userAnswers[index] ==
//                                       question['correctAnswer']
//                                   ? Colors.green
//                                   : Colors.red,
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 'Respuesta correcta: ${question['correctAnswer']}',
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Explicación: ${question['explanation']}',
//                           style: const TextStyle(fontStyle: FontStyle.italic),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               if (_testCompleted)
//                 Text(
//                   'Puntuación: ${_score.toStringAsFixed(1)}%',
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               const SizedBox(height: 8),
//               ElevatedButton(
//                 onPressed: _testCompleted ? _startNewTest : _submitTest,
//                 child: Text(_testCompleted ? 'Nuevo Test' : 'Enviar Respuestas'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }