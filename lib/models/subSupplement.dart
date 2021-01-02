class subSupplement {
  String id;
  String name;
  String cover;
  String description;
  int free;

  subSupplement.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    free = parsedJson['free']??"";
    name = parsedJson['name']??"";
    cover = parsedJson['cover']??"";
    description = parsedJson['description']??"";
  }
}