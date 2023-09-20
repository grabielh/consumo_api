import 'package:clear_architec/clear_architec/album/dominio/models/use_case/use_case_album.dart';
import 'package:clear_architec/clear_architec/album/infraestructura/api_adapter/api_album_adapter.dart';

/// Clase que configura los servicios relacionados con los álbumes.
class AlbumConfiguration {
  late GetAlbum albumService;  // Servicio para obtener información de los álbumes.
  late ApiAlbumAdapter apiAdapter;  // Adaptador para la API de álbumes.

  /// Constructor de la clase AlbumConfiguration.
  AlbumConfiguration() {
    apiAdapter = ApiAlbumAdapter();  // Inicializa el adaptador de la API.
    albumService = GetAlbum(apiAdapter);  // Inicializa el servicio de álbumes.
  }
}