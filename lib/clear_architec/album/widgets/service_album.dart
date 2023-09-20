import 'dart:convert';

import 'package:clear_architec/clear_architec/album/config/config_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:clear_architec/clear_architec/privider/bigdata/bigdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesAlbum extends StatefulWidget {
  const ServicesAlbum({super.key});

  @override
  State<ServicesAlbum> createState() => _ServicesAlbumState();
}

class _ServicesAlbumState extends State<ServicesAlbum> {
  final AlbumConfiguration _configureAlbum = AlbumConfiguration();
  final TextEditingController _idAlbum = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cargarListaDesdeSharedPreferences();
  }

  Future<void> cargarListaDesdeSharedPreferences() async {
    try {
      final setlisAlbum = Provider.of<ListarAlbumProvider>(context);
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

        setState(() {
          setlisAlbum.albumList.clear();
          setlisAlbum.albumList.addAll(listaDeserializada);
        });
      } else {
        print('No se encontraron datos guardados en SharedPreferences.');
      }
    } catch (e) {
      print('Error al leer la lista desde SharedPreferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final setlisAlbum = Provider.of<ListarAlbumProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _idAlbum,
            decoration: const InputDecoration(labelText: 'Igresar ID'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Card(
                  color: const Color(0xFFf5fff5),
                  child: FutureBuilder<Album>(
                    future: _configureAlbum.albumService.getByID(_idAlbum.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error al obtener Álbum. Ingrese ID !'),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('No existen Álbumes');
                      } else {
                        Album? listAlbum = snapshot.data;
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(listAlbum!.title),
                                subtitle: Text(listAlbum.thumbnailUrl),
                                leading: Image.network(
                                  listAlbum.url,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                setState(() {
                                  Album nuevoAlbum = Album(
                                    albumId: listAlbum.albumId,
                                    id: listAlbum.id,
                                    title: listAlbum.title,
                                    url: listAlbum.url,
                                    thumbnailUrl: listAlbum.thumbnailUrl,
                                  );
                                  setlisAlbum.agregarAlbum(nuevoAlbum);
                                  setlisAlbum
                                      .guardarListanueva(setlisAlbum.albumList);
                                });
                              },
                              icon: const Icon(Icons.save_alt),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: setlisAlbum.albumList.length,
                itemBuilder: (context, index) {
                  Album? albumLit = setlisAlbum.albumList[index];
                  return Card(
                    child: ListTile(
                      title: Text(albumLit.title),
                      subtitle: Text(albumLit.thumbnailUrl),
                      leading: Image.network(
                        albumLit.url,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
