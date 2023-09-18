import 'package:clear_architec/clear_architec/album/dominio/models/use_case/use_case_album.dart';
import 'package:clear_architec/clear_architec/album/infraestructura/api_adapter/api_album_adapter.dart';

class ConfigureAlbum {
  late GetAlbum album;
  late ApiAlbumAdapter adapter;
  ConfigureAlbum() {
    adapter = ApiAlbumAdapter();
    album = GetAlbum(adapter);
  }
}
