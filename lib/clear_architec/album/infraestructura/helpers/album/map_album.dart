import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:clear_architec/clear_architec/album/infraestructura/helpers/common/abstract_base_album.dart';

/// Clase que mapea datos JSON a objetos de tipo [Album].
class MapAlbum implements BaseAlbumMapper<Album> {
  /// Mapea un mapa JSON a un objeto [//Album].
  @override
  mapJson(Map<String, dynamic> json) => Album(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
      );
}
