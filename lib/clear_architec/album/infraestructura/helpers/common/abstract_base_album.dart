/// Interfaz abstracta que define un mapeador genérico de datos JSON a objetos.
abstract class BaseAlbumMapper<T> {
  /// Mapea un mapa JSON a un objeto del tipo genérico [T].
  T mapJson(Map<String, dynamic> json);
}
