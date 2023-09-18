import 'package:clear_architec/clear_architec/album/widgets/homescrem.dart';
import 'package:clear_architec/clear_architec/privider/bigdata/bigdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ListarAlbum());
}

class ListarAlbum extends StatelessWidget {
  const ListarAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListarAlbumProvider>(
      create: (context) => ListarAlbumProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crear lista de lbunes !',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2a324b),
          ),
        ),
        home: const HomeScrem(),
      ),
    );
  }
}
