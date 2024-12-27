import 'package:flutter/material.dart';
import 'contact_screen.dart';
import 'recipes_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(ThemeMode) updateTheme;

  const HomeScreen({Key? key, required this.updateTheme}) : super(key: key);

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // Cierra el Drawer
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Diarias'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // Encabezado del Drawer
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
            // Opción: Inicio
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blueAccent),
              title: const Text('Inicio'),
              onTap: () {
                _navigateTo(context, const RecipesScreen());
              },
            ),
            // Opción: Contacto
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.blueAccent),
              title: const Text('Contacto'),
              onTap: () {
                _navigateTo(context, const ContactScreen());
              },
            ),
            // Separador
            const Divider(),
            // Opción: Configuración
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blueAccent),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Configuración de Tema'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.light_mode, color: Colors.orange),
                          title: const Text('Modo Claro'),
                          onTap: () {
                            updateTheme(ThemeMode.light);
                            Navigator.pop(context); // Cierra el diálogo
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.dark_mode, color: Colors.blueGrey),
                          title: const Text('Modo Oscuro'),
                          onTap: () {
                            updateTheme(ThemeMode.dark);
                            Navigator.pop(context); // Cierra el diálogo
                          },
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
