import 'package:flutter/material.dart';
import 'home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon/app_icon.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Esta aplicación ha sido desarrollada con fines exclusivamente educativos \n'
                      'Se distribuye de manera gratuita para beneficio de la comunidad. \n'
                      'Queda estrictamente prohibida su comercialización o uso con fines lucrativos. \n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClassesScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(197, 240, 101, 91),
                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '<>',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(197, 240, 101, 91),
                  ),
                ),
                SizedBox(width: 8),
                Text('Made With Love by Ando Devs'),
                SizedBox(width: 8),
                Text(
                  '</>',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(197, 240, 101, 91),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
