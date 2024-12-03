// Archivo: evaluacion_general_screen.dart

import 'package:flutter/material.dart';
import 'package:repaso_farma/content/test_content.dart';
import 'package:repaso_farma/managers/test_clase_manager.dart';

class EvaluacionGeneralScreen extends StatefulWidget {
  const EvaluacionGeneralScreen({super.key});

  @override
  State<EvaluacionGeneralScreen> createState() => _EvaluacionGeneralScreenState();
}

class _EvaluacionGeneralScreenState extends State<EvaluacionGeneralScreen> {
  List<Map<String, dynamic>> _questions = [];
  List<String?> _userAnswers = [];
  bool _testCompleted = false;
  final List<String> _classNames = ['Clase 1', 'Clase 3', 'Clase 4', 'Clase Repaso'];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    List<Map<String, dynamic>> allQuestions = [];

    // Obtener preguntas de cada clase
    for (String className in _classNames) {
      // Obtener preguntas simples
      final simpleQuestions = TestContent.questions[className]!
          .where((q) => q['type'] == 'simple')
          .toList()
        ..shuffle();

      // Obtener preguntas complejas
      final complexQuestions = TestContent.questions[className]!
          .where((q) => q['type'] == 'complex')
          .toList()
        ..shuffle();

      // Agregar 5 preguntas simples y 5 complejas de cada clase
      allQuestions.addAll(simpleQuestions.take(5));
      allQuestions.addAll(complexQuestions.take(5));
    }

    // Mezclar todas las preguntas
    allQuestions.shuffle();

    setState(() {
      _questions = allQuestions;
      _userAnswers = List.filled(allQuestions.length, null);
    });
  }

  void _submitTest() {
    if (_userAnswers.contains(null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor responde todas las preguntas antes de enviar'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _testCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación General'),
      ),
      body: _testCompleted ? _buildResultsScreen() : _buildQuestionsScreen(),
    );
  }

  Widget _buildQuestionsScreen() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              final question = _questions[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pregunta ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(question['question']),
                      if (question['type'] == 'complex') ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Soluciones:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...TestManager.getComplexSolutions(question)
                            .map((solution) => Text('• $solution')),
                      ],
                      const SizedBox(height: 16),
                      ...question['options'].map<Widget>((option) {
                        return RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: _userAnswers[index],
                          onChanged: (String? value) {
                            setState(() {
                              _userAnswers[index] = value;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _submitTest,
            child: const Text('Enviar Evaluación'),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsScreen() {
    int correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i]['correctAnswer']) {
        correctAnswers++;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    '$correctAnswers/${_questions.length}',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: correctAnswers >= (_questions.length / 2)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    '${(correctAnswers / _questions.length * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ...List.generate(_questions.length, (index) {
              final question = _questions[index];
              final bool isCorrect = _userAnswers[index] == question['correctAnswer'];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

                      const Text(
                        'Pregunta:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(question['question']),
                      const SizedBox(height: 12),

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
                                      color: isCorrect ? Colors.green : Colors.red,
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
                              style: const TextStyle(fontSize: 14),
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
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _testCompleted = false;
                    _loadQuestions();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Nueva Evaluación'),
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
}