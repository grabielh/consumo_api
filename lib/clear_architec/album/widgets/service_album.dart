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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final setlisAlbum = Provider.of<ListarAlbumProvider>(context);
    setlisAlbum.cargarListaDesdeSharedPreferences(); // Mueve esta llamada aquí
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
                    future: _configureAlbum.album.getByID(_idAlbum.text),
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
                  print(setlisAlbum.albumList.length);
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
