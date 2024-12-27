// lib/receta.dart

class Receta {
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final String tipo; // Agregar tipo de receta

  Receta({
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.tipo, // Incluir tipo en el constructor
  });
}