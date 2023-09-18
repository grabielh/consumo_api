import 'package:clear_architec/clear_architec/album/dominio/gateway/abstrac_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';

class GetAlbum {
  late AbstractGetAlbum _abstractGetAlbum;
  Future<Album> getByID(String id) {
    return _abstractGetAlbum.getByID(id);
  }

  Future<List<Album>> getAll() {
    return _abstractGetAlbum.getAll();
  }
}
