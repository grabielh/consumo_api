import 'dart:convert';

import 'package:clear_architec/clear_architec/album/dominio/gateway/abstrac_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:clear_architec/clear_architec/album/infraestructura/helpers/album/map_album.dart';
import 'package:http/http.dart' as http;

class ApiAlbumAdapter extends AbstractGetAlbum {
  final MapAlbum _album = MapAlbum();
  @override
  Future<List<Album>> getAll() async {
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

  @override
  Future<Album> getByID(String id) async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return _album.mapJson(jsonDecode(response.body));
    }
    throw UnimplementedError('Error no hay respuesta del servidor !');
  }
}
