import 'dart:convert';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListarAlbumProvider extends ChangeNotifier {
  List<Album> albumList = [];

  get listar => albumList;

  void agregarAlbum(Album album) {
    albumList.add(album);
    notifyListeners();
  }

  void guardarListanueva(List<Album> listaNueva) async {
    try {
      final preferencias = await SharedPreferences.getInstance();

      final listaSerializada = listaNueva.map((album) {
        return {
          'albumId': album.albumId,
          'id': album.id,
          'title': album.title,
          'url': album.url,
          'thumbnailUrl': album.thumbnailUrl,
        };
      }).toList();

      await preferencias.setStringList('listaNueva',
          listaSerializada.map((map) => json.encode(map)).toList());
      print('Lista guardada en SharedPreferences.');
    } catch (e) {
      print('Error al guardar la lista en SharedPreferences: $e');
    }
  }

  void mostrarLista() async {
    try {
      final preferencias = await SharedPreferences.getInstance();
      final listaSerializada = preferencias.getStringList('listaNueva');

      if (listaSerializada != null) {
        final listaDeserializada = listaSerializada.map((str) {
          final mapa = json.decode(str);
          return Album(
            albumId: mapa['albumId'],
            id: mapa['id'],
            title: mapa['title'],
            url: mapa['url'],
            thumbnailUrl: mapa['thumbnailUrl'],
          );
        }).toList();

        for (var album in listaDeserializada) {
          print('ID: ${album.id}, Título: ${album.title}');
        }
      } else {
        print('No se encontraron datos guardados en SharedPreferences.');
      }
    } catch (e) {
      print('Error al leer la lista desde SharedPreferences: $e');
    }
  }
}
