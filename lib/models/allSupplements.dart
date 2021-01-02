class allSupplements {
  String id;
  String name;
  String type;
  String cover;

  allSupplements.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    type = parsedJson['type']??"";
    cover = parsedJson['cover']??"";
  }
}