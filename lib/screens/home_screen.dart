import 'package:flutter/material.dart';
import 'contact_screen.dart';
import 'recipes_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(ThemeMode) updateTheme;

  const HomeScreen({Key? key, required this.updateTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Diarias'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: const Center(
                child: Text(
                  'Menú Principal',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipesScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Contacto'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Configuración'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            updateTheme(ThemeMode.light);
                            Navigator.pop(context); // Cierra el diálogo
                          },
                          child: const Text('Modo Claro'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateTheme(ThemeMode.dark);
                            Navigator.pop(context); // Cierra el diálogo
                          },
                          child: const Text('Modo Oscuro'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const RecipesScreen(),
    );
  }
}
