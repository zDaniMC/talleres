import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'universidades';

  // 🔹 Stream para listar universidades en tiempo real
  Stream<List<Universidad>> getUniversidades() {
    return _firestore
        .collection(_collection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Convertimos explícitamente a Map<String, dynamic>
        final data = Map<String, dynamic>.from(doc.data());
        return Universidad.fromFirestore(doc.id, data);
      }).toList();
    });
  }

  // 🔹 Crear universidad
  Future<void> crearUniversidad(Universidad universidad) async {
    try {
      await _firestore
          .collection(_collection)
          .add(Map<String, dynamic>.from(universidad.toMap()));
    } catch (e) {
      throw Exception('Error al crear universidad: $e');
    }
  }

  // 🔹 Actualizar universidad
  Future<void> actualizarUniversidad(Universidad universidad) async {
    if (universidad.id == null) return;
    try {
      await _firestore
          .collection(_collection)
          .doc(universidad.id)
          .update(Map<String, dynamic>.from(universidad.toMap()));
    } catch (e) {
      throw Exception('Error al actualizar universidad: $e');
    }
  }

  // 🔹 Eliminar universidad
  Future<void> eliminarUniversidad(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar universidad: $e');
    }
  }
}
