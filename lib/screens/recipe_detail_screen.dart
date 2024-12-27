import 'package:flutter/material.dart';
import 'dart:io';

class RecipeDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String instructions;

  const RecipeDetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.instructions,
  }) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  double _rating = 0.0; // Puntuación inicial

  void _rateRecipe(double rating) {
    setState(() {
      _rating = rating;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Has calificado esta receta con ${rating.toString()} estrellas!'),
      ),
    );
  }

  bool _isAssetImage(String path) {
    return path.startsWith('assets/');
  }

  Widget _buildImage(String imagePath) {
    if (_isAssetImage(imagePath)) {
      // Imágenes cargadas desde assets
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      // Imágenes cargadas como URL o base64 (Flutter Web compatible)
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.broken_image,
            size: 250,
            color: Colors.grey,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 **Imagen de la Receta**
            _buildImage(widget.image),

            const SizedBox(height: 20),

            // 📛 **Nombre de la Receta**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📝 **Instrucciones**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                '📝 Instrucciones:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.instructions,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // ⭐ **Sistema de Puntuación**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                '⭐ Califica esta receta:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () {
                      _rateRecipe(index + 1.0);
                    },
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
