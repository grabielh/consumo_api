import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';

/// Interfaz abstracta que define métodos para acceder a la información de los álbumes.
abstract class AlbumRepository {
  Future<Album> fetchByID(String id);
  Future<List<Album>> fetchAll();
}

