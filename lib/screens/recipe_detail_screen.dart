import 'package:flutter/material.dart';

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
        content: Text('¡Has calificado esta receta con ${rating.toStringAsFixed(1)} estrellas!'),
      ),
    );
  }

  bool _isAssetImage(String path) {
    return path.startsWith('assets/');
  }

  Widget _buildImage(String imagePath) {
    if (_isAssetImage(imagePath)) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholderImage();
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholderImage();
        },
      );
    }
  }

  Widget _placeholderImage() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.broken_image,
          size: 100,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.isNotEmpty ? widget.name : 'Receta sin título'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Imagen de la receta
            _buildImage(widget.image),

            const SizedBox(height: 20),

            // 📛 Nombre de la receta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.name.isNotEmpty ? widget.name : 'Sin título',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📝 Instrucciones
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
                widget.instructions.isNotEmpty
                    ? widget.instructions
                    : 'No se proporcionaron instrucciones para esta receta.',
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // ⭐ Sistema de calificación
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                '⭐ Califica esta receta:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  // Visualización de estrellas
                  Row(
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
                  // Puntuación actual
                  Text(
                    'Calificación actual: ${_rating.toStringAsFixed(1)} estrellas',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
