class unitSubAlbums {
  String factor;
  String name;
  String description;
  String cover;

  unitSubAlbums.fromJson(Map<String , dynamic> parsedJson) {
    factor = parsedJson['id'];
    name = parsedJson['name']??"";
    description = parsedJson['description']??"";
    cover = parsedJson['cover']??"";
  }
}