import 'dart:ffi';

abstract class AlbumRepositoryInterface {
  Void getAlbum();
  Void deleteAlbum(int albumId);
}

class AlbumRepository implements AlbumRepositoryInterface {
  @override
  Void getAlbum() {
    throw UnimplementedError();
  }

  @override
  Void deleteAlbum(int albumId) {
    throw UnimplementedError();
  }
}
