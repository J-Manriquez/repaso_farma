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
    final simpleQuestions = TestContent.questions[widget.className]!
        .where((q) => q['type'] == 'simple')
        .toList()
      ..shuffle();

    // Obtener 4 preguntas complejas
    final complexQuestions = TestContent.questions[widget.className]!
        .where((q) => q['type'] == 'complex')
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
      child: SingleChildScrollView(
        // Agregamos SingleChildScrollView aquí
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Agregamos esto para optimizar el espacio
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
            // Título y resultado final
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    'Resultado Final',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$correctAnswers/${_questions!.length}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: correctAnswers >= (_questions!.length / 2)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    '${(correctAnswers / _questions!.length * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Revisión detallada de cada pregunta
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
                      // Encabezado de la pregunta
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isCorrect ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              question['type'] == 'complex'
                                  ? 'Pregunta Compleja'
                                  : 'Pregunta Simple',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Contenido de la pregunta
                      const Text(
                        'Pregunta:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(question['question']),
                      const SizedBox(height: 12),

                      // Si es una pregunta compleja, mostrar las soluciones
                      if (question['type'] == 'complex') ...[
                        const Text(
                          'Soluciones:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        ...TestManager.getComplexSolutions(question)
                            .map((solution) => Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('• $solution'),
                                )),
                        const SizedBox(height: 12),
                      ],

                      // Respuestas
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Tu respuesta: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    _userAnswers[index] ?? 'Sin respuesta',
                                    style: TextStyle(
                                      color:
                                          isCorrect ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Respuesta correcta: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    question['correctAnswer'],
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Explicación
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.lightbulb, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Explicación:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              question['explanation'],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),

            // Botón para nuevo test
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _testCompleted = false;
                    _showExplanation = false;
                    _loadQuestions();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Comenzar Nuevo Test'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
    return SingleChildScrollView(
      // Agregamos un ScrollView adicional aquí
      child: _testCompleted
          ? _buildResultsScreen()
          : _buildQuestionCard(_questions![_currentQuestionIndex]),
    );
  }
}
