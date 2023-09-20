/// Clase que representa un álbum.
class Album {
  Album({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
}
