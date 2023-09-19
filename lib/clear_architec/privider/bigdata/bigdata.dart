import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:flutter/material.dart';

class ListarAlbumProvider extends ChangeNotifier {
  List<Album> albumList = [];

  get listar => albumList;

  void agregarAlbum(Album album) {
    albumList.add(album);
    notifyListeners();
  }
}
