import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 300) {
              Navigator.of(context).pop();
            }
          },
          child: Stack(
            children: [
              // Imagen con InteractiveViewer para zoom
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                boundaryMargin: const EdgeInsets.all(double.infinity), // Permite el desplazamiento infinito
                child: Hero(
                  tag: imagePath,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain, // Asegura que la imagen se ajuste inicialmente
                    ),
                  ),
                ),
              ),
              // Botón para cerrar
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ));
  }
}