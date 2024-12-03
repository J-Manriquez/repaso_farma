import 'package:flutter/material.dart';
import 'package:repaso_farma/screens/clase_screen.dart';
import 'package:repaso_farma/screens/evaluacion_general_screen.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clases'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ClassDetailScreen(className: 'Clase 1'),
                    ),
                  );
                },
                child: const Text(
                  'Clase 1',
                  style: TextStyle(fontSize: 18, color: Colors.black, ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ClassDetailScreen(className: 'Clase 3'),
                    ),
                  );
                },
                child: const Text(
                  'Clase 3',
                  style: TextStyle(fontSize: 18, color: Colors.black, ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ClassDetailScreen(className: 'Clase 4'),
                    ),
                  );
                },
                child: const Text(
                  'Clase 4',
                  style: TextStyle(fontSize: 18, color: Colors.black, ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ClassDetailScreen(className: 'Clase Repaso'),
                    ),
                  );
                },
                child: const Text(
                  'Clase Repaso',
                  style: TextStyle(fontSize: 18, color: Colors.black, ),
                ),
              ),
              const SizedBox(height: 60), // Espacio adicional para separar
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EvaluacionGeneralScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(230, 218, 105, 105), // Color diferente para destacar
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text(
                  'Evaluación General',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
