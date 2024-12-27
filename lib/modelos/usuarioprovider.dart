import 'package:flutter/material.dart';
import 'usuario.dart'; // Ruta del modelo Usuario

class UsuarioProvider with ChangeNotifier {
  Usuario? _usuario;

  // Getter
  Usuario? get usuario => _usuario;

  // Setter
  set usuario(Usuario? usuario) {
    _usuario = usuario;
    notifyListeners(); // Notifica a los widgets dependientes cuando el usuario cambia
  }
}
