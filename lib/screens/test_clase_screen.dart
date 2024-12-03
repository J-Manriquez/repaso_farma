import 'package:flutter/material.dart';
import 'package:repaso_farma/content/test_content.dart';
import 'package:repaso_farma/managers/test_clase_manager.dart';

class TestScreen extends StatefulWidget {
  final String className;

  const TestScreen({
    super.key,
    required this.className,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Map<String, dynamic>>? _questions;
  List<String?> _userAnswers = [];
  int _currentQuestionIndex = 0;
  bool _showExplanation = false;
  bool _testCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    // Obtener 3 preguntas simples
    final simpleQuestions = TestContent.questions[widget.className]
        !.where((q) => q['type'] == 'simple')
        .toList()
        ..shuffle();

    // Obtener 4 preguntas complejas
    final complexQuestions = TestContent.questions[widget.className]
        !.where((q) => q['type'] == 'complex')
        .toList()
        ..shuffle();

    if (simpleQuestions == null || complexQuestions == null) {
      setState(() {
        _questions = [];
      });
      return;
    }

    // Combinar las preguntas seleccionadas
    setState(() {
      _questions = [
        ...simpleQuestions.take(3),
        ...complexQuestions.take(4),
      ]..shuffle(); // Mezclar el orden final

      _userAnswers = List.filled(_questions!.length, null);
    });
  }

  void _checkAnswer() {
    if (_currentQuestionIndex < _questions!.length) {
      setState(() {
        _showExplanation = true;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _showExplanation = false;
      if (_currentQuestionIndex < _questions!.length - 1) {
        _currentQuestionIndex++;
      } else {
        _testCompleted = true;
      }
    });
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pregunta ${_currentQuestionIndex + 1} de ${_questions!.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(question['question']),
            if (question['type'] == 'complex') ...[
              const SizedBox(height: 8),
              const Text(
                'Soluciones:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...TestManager.getComplexSolutions(question)
                  .map((solution) => Text('$solution')),
            ],
            const SizedBox(height: 16),
            ...question['options'].map<Widget>((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _userAnswers[_currentQuestionIndex],
                onChanged: _showExplanation
                    ? null
                    : (String? value) {
                        setState(() {
                          _userAnswers[_currentQuestionIndex] = value;
                        });
                      },
              );
            }),
            if (_showExplanation) ...[
              const Divider(),
              Row(
                children: [
                  Icon(
                    _userAnswers[_currentQuestionIndex] ==
                            question['correctAnswer']
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: _userAnswers[_currentQuestionIndex] ==
                            question['correctAnswer']
                        ? Colors.green
                        : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Respuesta correcta: ${question['correctAnswer']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Explicación: ${question['explanation']}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _userAnswers[_currentQuestionIndex] == null
                    ? null
                    : _showExplanation
                        ? _nextQuestion
                        : _checkAnswer,
                child: Text(_showExplanation ? 'Continuar' : 'Comprobar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    int correctAnswers = 0;
    for (int i = 0; i < _questions!.length; i++) {
      if (_userAnswers[i] == _questions![i]['correctAnswer']) {
        correctAnswers++;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resultado Final: $correctAnswers/${_questions!.length}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(_questions!.length, (index) {
              final question = _questions![index];
              final bool isCorrect =
                  _userAnswers[index] == question['correctAnswer'];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pregunta ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(question['question']),
                      const SizedBox(height: 8),
                      Text(
                        'Tu respuesta: ${_userAnswers[index]}',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        'Respuesta correcta: ${question['correctAnswer']}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _testCompleted = false;
                    _showExplanation = false;
                    _loadQuestions();
                  });
                },
                child: const Text('Comenzar Nuevo Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions == null || _questions!.isEmpty) {
      return const Center(
        child: Text('No hay preguntas disponibles para esta clase'),
      );
    }

    if (_testCompleted) {
      return _buildResultsScreen();
    }

    return _buildQuestionCard(_questions![_currentQuestionIndex]);
  }
}