import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      debugShowCheckedModeBanner: false, // Esto quita el banner de debug
      theme: ThemeData(
        // Configuración del tema principal
        primarySwatch: Colors.blue,
        // Puedes personalizar más el tema aquí
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            minimumSize: const Size(200, 50), // Ancho mínimo para los botones
          ),
        ),
      ),
      home: const HomeScreen(), // Pantalla inicial
    );
  }
}