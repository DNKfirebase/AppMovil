import 'package:firebase_auth/firebase_auth.dart';

class Login {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Función para autenticar usuario con Firebase Authentication
  Future<bool> authenticate(String email, String password) async {
    try {
      // Intentar iniciar sesión con el correo y la contraseña
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Inicio de sesión exitoso para: $email');
      return true;
    } on FirebaseAuthException catch (e) {
      // Manejo de errores específicos de Firebase
      print('Error al iniciar sesión: ${e.code}');
      switch (e.code) {
        case 'user-not-found':
          print('Usuario no encontrado para $email');
          break;
        case 'wrong-password':
          print('Contraseña incorrecta para $email');
          break;
        default:
          print('Error desconocido: ${e.message}');
      }
      return false;
    } catch (e) {
      // Manejo de otros errores
      print('Error general: $e');
      return false;
    }
  }
}

