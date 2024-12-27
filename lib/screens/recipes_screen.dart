import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart';
import 'upload_recipe_screen.dart';
import 'dart:io' show File;
import 'dart:typed_data'; // Para manejar imágenes en Web
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart';
import 'upload_recipe_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String selectedCategory = 'Todos';

  final List<Map<String, String>> recipes = [
    {
      'name': 'Ensalada César',
      'category': 'Vegetariana',
      'image': 'assets/images/ensalada_cesar.jpg',
      'ingredients': 'Lechuga, Queso parmesano, Aderezo César',
      'instructions': 'Lava la lechuga...\nAgrega el aderezo...\nSirve fresco.'
    },
  ];

  void _addRecipe(Map<String, String> newRecipe) {
    setState(() {
      recipes.add(newRecipe);
    });
  }

  bool _isAssetImage(String path) {
    return path.startsWith('assets/');
  }

  Widget _buildImage(String imagePath) {
    if (_isAssetImage(imagePath)) {
      // Carga de imagen desde assets
      return Image.asset(
        imagePath,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    } else {
      // Carga de imagen como URL (útil para Flutter Web)
      return Image.network(
        imagePath,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 60);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = selectedCategory == 'Todos'
        ? recipes
        : recipes.where((recipe) => recipe['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Recetas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadRecipeScreen(onRecipeAdded: _addRecipe),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: [
                'Todos',
                'Vegetariana',
                'Postres',
                'Almuerzos',
                'Comida Nacional (Chilena)',
                'Internacional',
                'Bajo en Calorías',
                'Veganas',
                'Sin Gluten'
              ].map((category) {
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
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _buildImage(filteredRecipes[index]['image']!),
                    ),
                    title: Text(filteredRecipes[index]['name']!),
                    subtitle: Text(filteredRecipes[index]['category']!),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            name: filteredRecipes[index]['name']!,
                            image: filteredRecipes[index]['image']!,
                            instructions: filteredRecipes[index]['instructions']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
