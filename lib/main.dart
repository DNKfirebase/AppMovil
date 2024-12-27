import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/home_screen.dart'; // HomeScreen agregado.
import 'modelos/usuarioprovider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Pantalla de carga
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Manejo de errores
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error al inicializar Firebase'),
              ),
            ),
          );
        } else {
          // Firebase inicializado correctamente
          final user = FirebaseAuth.instance.currentUser;
          final initialRoute = user == null ? '/login' : '/home';

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UsuarioProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Recetas Diarias',
              theme: ThemeData.light(),
              initialRoute: initialRoute,
              routes: {
                '/login': (context) => LoginPage(),
                '/register': (context) => const RegisterScreen(),
                '/recipes': (context) => const RecipesScreen(),
                '/home': (context) => HomeScreen(
                      updateTheme: (theme) {
                        print("Tema cambiado a: $theme");
                      },
                    ), // Aquí HomeScreen.
              },
            ),
          );
        }
      },
    );
  }
}
