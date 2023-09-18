import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:flutter/material.dart';

class ListarAlbumProvider extends ChangeNotifier {
  final List<Album> albums = [];

  List<Album> get albumList => albums;

  void agregarAlbum(Album nuevoAlbum) {
    albums.add(nuevoAlbum);
    notifyListeners();
  }

}
