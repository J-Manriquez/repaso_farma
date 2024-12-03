import 'package:repaso_farma/content/test_content.dart';

class TestManager {
  // Obtener preguntas para un test
  static List<Map<String, dynamic>> getTestQuestions(String className, int questionCount) {
    return TestContent.getRandomQuestions(className, questionCount);
  }

  // Verificar una respuesta
  static bool checkAnswer(Map<String, dynamic> question, String userAnswer) {
    return question['correctAnswer'] == userAnswer;
  }

  // Calcular puntuación del test
  static double calculateScore(List<Map<String, dynamic>> questions, List<String> userAnswers) {
    if (questions.length != userAnswers.length) return 0.0;

    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (checkAnswer(questions[i], userAnswers[i])) {
        correctAnswers++;
      }
    }

    return (correctAnswers / questions.length) * 100;
  }

  // Obtener explicación de una pregunta
  static String getExplanation(Map<String, dynamic> question) {
    return question['explanation'] ?? 'No hay explicación disponible';
  }

  // Verificar si una pregunta es compleja
  static bool isComplexQuestion(Map<String, dynamic> question) {
    return question['type'] == 'complex';
  }

  // Obtener las soluciones de una pregunta compleja
  static List<String> getComplexSolutions(Map<String, dynamic> question) {
    if (!isComplexQuestion(question)) return [];
    return List<String>.from(question['solutions'] ?? []);
  }
}