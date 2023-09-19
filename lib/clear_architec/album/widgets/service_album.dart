import 'package:clear_architec/clear_architec/album/config/config_album.dart';
import 'package:clear_architec/clear_architec/album/dominio/models/album/album.dart';
import 'package:clear_architec/clear_architec/privider/bigdata/bigdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesAlbum extends StatefulWidget {
  const ServicesAlbum({super.key});

  @override
  State<ServicesAlbum> createState() => _ServicesAlbumState();
}

class _ServicesAlbumState extends State<ServicesAlbum> {
  final ConfigureAlbum _configureAlbum = ConfigureAlbum();
  final TextEditingController _idAlbum = TextEditingController();

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  color: const Color(0xFFf5fff5),
                  child: FutureBuilder<Album>(
                    future: _configureAlbum.album.getByID(_idAlbum.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text(
                            'Error al obtener Albun Ingrese ID !');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('No exiten Albunes');
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
                                Album nuevoAlbum = Album(
                                    albumId: listAlbum.albumId,
                                    id: listAlbum.id,
                                    title: listAlbum.title,
                                    url: listAlbum.url,
                                    thumbnailUrl: listAlbum.url);
                                setlisAlbum.agregarAlbum(nuevoAlbum);
                              },
                              icon: const Icon(Icons.save_alt),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
