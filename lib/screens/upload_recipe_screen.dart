import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import 'dart:typed_data'; // Para manejar imágenes en Flutter Web
import 'dart:html' as html; // Para Flutter Web

class UploadRecipeScreen extends StatefulWidget {
  final Function(Map<String, String>) onRecipeAdded;

  const UploadRecipeScreen({Key? key, required this.onRecipeAdded}) : super(key: key);

  @override
  State<UploadRecipeScreen> createState() => _UploadRecipeScreenState();
}

class _UploadRecipeScreenState extends State<UploadRecipeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  String selectedCategory = 'Vegetariana';
  final List<String> categories = [
    'Vegetariana',
    'Postres',
    'Almuerzos',
    'Comida Nacional (Chilena)',
    'Internacional',
    'Bajo en Calorías',
    'Veganas',
    'Sin Gluten',
  ];

  File? selectedImage; // Para dispositivos móviles
  Uint8List? webImage; // Para Flutter Web

  // Función para seleccionar imagen
  Future<void> _pickImage() async {
    // Verifica si estás en Web o en otra plataforma
    if (kIsWeb) {
      // Flutter Web: Usa un selector de archivos
      final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();
      uploadInput.onChange.listen((event) {
        final file = uploadInput.files?.first;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file!);
        reader.onLoadEnd.listen((event) {
          setState(() {
            webImage = reader.result as Uint8List;
          });
        });
      });
    } else {
      // Flutter móvil: Usa ImagePicker
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    }
  }

  // Función para subir la receta
  void _uploadRecipe() {
    if (nameController.text.isEmpty ||
        ingredientsController.text.isEmpty ||
        instructionsController.text.isEmpty ||
        (selectedImage == null && webImage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
      return;
    }

    widget.onRecipeAdded({
      'name': nameController.text,
      'category': selectedCategory,
      'image': selectedImage?.path ?? '', // Solo para móviles
      'ingredients': ingredientsController.text,
      'instructions': instructionsController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Receta subida exitosamente!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Receta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Receta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Seleccionar Imagen'),
            ),
            if (selectedImage != null) // Para móviles
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.file(
                  selectedImage!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            if (webImage != null) // Para Web
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.memory(
                  webImage!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ingredientes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: instructionsController,
              decoration: const InputDecoration(
                labelText: 'Instrucciones',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _uploadRecipe,
                child: const Text('Subir Receta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
