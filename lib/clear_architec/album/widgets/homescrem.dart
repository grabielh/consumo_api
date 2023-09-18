import 'package:clear_architec/clear_architec/album/widgets/listar_nuevo_album.dart';
import 'package:clear_architec/clear_architec/album/widgets/service_album.dart';
import 'package:flutter/material.dart';

class HomeScrem extends StatefulWidget {
  const HomeScrem({super.key});

  @override
  State<HomeScrem> createState() => _HomeScremState();
}

class _HomeScremState extends State<HomeScrem> {
  int index = 0;
  List<Widget> listPage = const [ServicesAlbum(), ListarNuevoAlbum()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[index],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.http), label: 'Servicios'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Lista nueva'),
        ],
        onDestinationSelected: (index) {
          setState(
            () {
              this.index = index;
            },
          );
        },
        selectedIndex: index,
      ),
    );
  }
}
