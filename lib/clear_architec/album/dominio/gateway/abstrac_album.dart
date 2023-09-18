import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';

abstract class AbstractGetAlbum {
  Future<Album> getByID(String id);
  Future<List<Album>> getAll();
}
