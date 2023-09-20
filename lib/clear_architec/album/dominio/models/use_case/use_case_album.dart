import 'package:clear_architec/clear_architec/album/dominio/gateway/abstrac_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';

/// Clase que proporciona métodos para obtener álbumes a través de un repositorio.
class GetAlbum {
  /// Repositorio de álbumes utilizado para acceder a los datos.
  late AlbumRepository abstractGetAlbum;
  GetAlbum(this.abstractGetAlbum);
  Future<Album> getByID(String id) {
    return abstractGetAlbum.fetchByID(id);
  }

  Future<List<Album>> getAll() {
    return abstractGetAlbum.fetchAll();
  }
}
