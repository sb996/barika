

class subAlbumSingle {
  String id;
  String name;
  String cover;
  String description;
  String nuts;
  List units;

  subAlbumSingle.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??'';
    cover = parsedJson['cover']??'';
    description = parsedJson['description']??'';
    nuts = parsedJson['nuts']??'';
    units = parsedJson['units']??'';

  }
}