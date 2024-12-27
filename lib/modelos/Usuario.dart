import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  final String uid;
  final String email;
  final String nombre;

  Usuario({
    required this.uid,
    required this.email,
    required this.nombre,
  });

  // Constructor de fábrica para crear un Usuario desde UserCredential
  factory Usuario.fromFirebase(UserCredential userCredential) {
    final user = userCredential.user; // Obtén el usuario autenticado
    if (user == null) {
      throw Exception('El UserCredential no contiene un usuario válido.');
    }

    return Usuario(
      uid: user.uid,
      email: user.email ?? 'correo no disponible',
      nombre: 'nombre por defecto', // Puedes cambiar esto según sea necesario
    );
  }
}
