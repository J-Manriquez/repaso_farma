import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  String _formatClassName(String className) {
    return className.replaceAll(' ', '_').replaceAll(RegExp(r'[^\w\s]'), '');
  }

  Future<void> _loadImages() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Cargar imágenes desde los assets
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      // Formatear el nombre de la clase para la ruta
      final formattedClassName = _formatClassName(widget.className);
      final basePath = 'assets/${formattedClassName.toLowerCase()}';

      // Filtrar las imágenes de la clase específica
      final imagePaths = manifestMap.keys
          .where((String key) => key.startsWith(basePath))
          .where((String key) =>
              key.toLowerCase().endsWith('.jpg') ||
              key.toLowerCase().endsWith('.png') ||
              key.toLowerCase().endsWith('.jpeg'))
          .toList();

      imagePaths.sort(); // Ordenar las imágenes alfabéticamente

      if (mounted) {
        setState(() {
          _imagePaths = imagePaths;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error al cargar las imágenes: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadImages,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_imagePaths.isEmpty) {
      return const Center(
        child: Text(
          'No hay imágenes disponibles para esta clase',
          style: TextStyle(fontSize: 16),
        ),
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
        return GalleryItem(
          imagePath: _imagePaths[index],
          onTap: () => _showImageDialog(context, _imagePaths[index], index),
        );
      },
    );
  }

  void _showImageDialog(
      BuildContext context, String imagePath, int currentIndex) {
    showDialog(
      context: context,
      builder: (context) => ImageDialog(
        imagePath: imagePath,
        allImages: _imagePaths,
        currentIndex: currentIndex,
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const GalleryItem({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imagePath,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageDialog extends StatefulWidget {
  final String imagePath;
  final List<String> allImages;
  final int currentIndex;

  const ImageDialog({
    super.key,
    required this.imagePath,
    required this.allImages,
    required this.currentIndex,
  });

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  late PageController _pageController;
  late int _currentIndex;
  bool _isZoomed = false;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
    setState(() {
      _isZoomed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Barra superior
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Imagen ${_currentIndex + 1} de ${widget.allImages.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Contenedor principal de la imagen
            Flexible(
              child: Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Visor de imágenes con PageView
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                          _resetZoom();
                        });
                      },
                      itemCount: widget.allImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onDoubleTap: () {
                            if (_isZoomed) {
                              _resetZoom();
                            } else {
                              _transformationController.value =
                                  Matrix4.identity()..scale(2.0);
                              setState(() {
                                _isZoomed = true;
                              });
                            }
                          },
                          child: InteractiveViewer(
                            transformationController: _transformationController,
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Hero(
                              tag: widget.allImages[index],
                              child: Image.asset(
                                widget.allImages[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Botones de navegación
                    if (!_isZoomed) ...[
                      Positioned(
                        left: 0,
                        child: _NavigationButton(
                          icon: Icons.chevron_left,
                          onPressed: _currentIndex > 0
                              ? () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: _NavigationButton(
                          icon: Icons.chevron_right,
                          onPressed: _currentIndex < widget.allImages.length - 1
                              ? () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavigationButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }
}
