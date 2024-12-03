import 'package:flutter/material.dart';
import 'package:repaso_farma/screens/clase_screen.dart';
import 'package:repaso_farma/widgets/color_picker.dart';
import '../managers/note_manager.dart';

class NotesScreen extends StatefulWidget {
  final String className;

  const NotesScreen({
    super.key,
    required this.className,
  });

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteManager _noteManager = NoteManager();
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final allNotes = await _noteManager.getNotes();
    setState(() {
      notes = allNotes
          .where((note) => note['className'] == widget.className)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas - ${widget.className}'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo: ${note['isTranscription'] ? 'Transcripción' : 'Repaso'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Texto resaltado:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(note['highlightedText']),
                  const SizedBox(height: 8),
                  const Text(
                    'Nota:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(note['note']),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Botón eliminar
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          await _noteManager.deleteNote(
                            widget.className,
                            note['highlightedText'],
                            note['isTranscription'],
                          );
                          _loadNotes();
                        },
                        tooltip: 'Eliminar',
                      ),
                      // Botón editar
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () => _editNote(note),
                        tooltip: 'Editar',
                      ),
                      // Botón resaltar
                      IconButton(
                        icon: const Icon(Icons.highlight),
                        color: Colors.orange,
                        onPressed: () => _addHighlightToNote(note),
                        tooltip: 'Resaltar',
                      ),
                      // Botón ver en texto
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        color: Colors.green,
                        onPressed: () => _viewNoteInText(note),
                        tooltip: 'Ver en texto',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _addHighlightToNote(Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar color'),
          content: ColorPicker(
            onColorSelected: (color) async {
              await _noteManager.saveHighlight(
                widget.className,
                note['isTranscription'],
                note['highlightedText'],
                color,
              );
              if (!mounted) return;
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resaltado aplicado')),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _viewNoteInText(Map<String, dynamic> note) {
    Navigator.pop(context); // Cierra la pantalla de notas
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ClassDetailScreen(
          className: widget.className,
          highlightedTextToShow: note['highlightedText'],
        ),
      ),
    );
  }

  void _editNote(Map<String, dynamic> note) {
    final textController = TextEditingController(text: note['note']);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: const Text('Editar nota'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Texto seleccionado:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: Text(note['highlightedText']),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tu nota:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Escribe tu nota aquí',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          if (textController.text.isNotEmpty) {
                            await _noteManager.updateNote(
                              widget.className,
                              note['highlightedText'],
                              textController.text,
                              note['isTranscription'],
                            );
                            if (!mounted) return;
                            Navigator.pop(context);
                            _loadNotes();
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
