import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class GalleryScreen extends StatefulWidget {
  final String className;

  const GalleryScreen({
    super.key,
    required this.className,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}
class _GalleryScreenState extends State<GalleryScreen> {
  List<String> _imagePaths = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

   String _formatClassName(String className) {
    // Reemplaza espacios con guiones bajos y elimina caracteres especiales
    return className.replaceAll(' ', '_').replaceAll(RegExp(r'[^\w\s]'), '');
  }

  Future<void> _loadImages() async {
    try {
      // Cargar imágenes desde los assets
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      
      // Formatear el nombre de la clase para la ruta
      final formattedClassName = _formatClassName(widget.className);
      
      // Filtrar las imágenes de la clase específica
      final imagePaths = manifestMap.keys
          .where((String key) => key.contains('assets/${formattedClassName}/'))
          .where((String key) => key.contains('.jpg') || 
                                key.contains('.png') || 
                                key.contains('.jpeg'))
          .toList();

      print('Buscando imágenes en: assets/${formattedClassName}/');
      print('Imágenes encontradas: $imagePaths');

      setState(() {
        _imagePaths = imagePaths;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading images: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_imagePaths.isEmpty) {
      return const Center(
        child: Text('No hay imágenes disponibles para esta clase'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _imagePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showImageDialog(_imagePaths[index]),
          child: Hero(
            tag: _imagePaths[index],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(_imagePaths[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: const Text('Imagen'),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Flexible(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Hero(
                    tag: imagePath,
                    child: Image.asset(imagePath),
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