import 'dart:convert';

import 'package:clear_architec/clear_architec/album/dominio/gateway/abstrac_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:clear_architec/clear_architec/album/infraestructura/helpers/album/map_album.dart';
import 'package:http/http.dart' as http;

/// Clase que adapta la API para acceder a información de álbumes.

///   /// Obtiene todos los álbumes disponibles desde la API.
class ApiAlbumAdapter extends AlbumRepository {
  final MapAlbum _album = MapAlbum();
  @override
  Future<List<Album>> fetchAll() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      final List<Album> album = json
          .map((value) => Album(
              albumId: value['albumId'],
              id: value['id'],
              title: value['title'],
              url: value['url'],
              thumbnailUrl: value['thumbnailUrl']))
          .toList();
      return album;
    }
    throw UnimplementedError('Error no hay respuesta del servidor !');
  }

  /// Obtiene un álbum por su ID desde la API.

  ///   - [id]: El ID del álbum que se va a buscar.
  @override
  Future<Album> fetchByID(String id) async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return _album.mapJson(jsonDecode(response.body));
    }
    throw UnimplementedError('Error no hay respuesta del servidor !');
  }
}
