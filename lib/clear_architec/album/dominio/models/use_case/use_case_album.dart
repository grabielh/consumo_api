import 'package:clear_architec/clear_architec/album/dominio/gateway/abstrac_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';

class GetAlbum {
  late AbstractGetAlbum abstractGetAlbum;
  GetAlbum(this.abstractGetAlbum);
  Future<Album> getByID(String id) {
    return abstractGetAlbum.getByID(id);
  }

  Future<List<Album>> getAll() {
    return abstractGetAlbum.getAll();
  }
}
