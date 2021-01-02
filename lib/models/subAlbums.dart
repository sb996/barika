class subAbum {
  String id;
  String name;
  String cover;
  int free;
  subAbum.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??'';
    cover = parsedJson['cover']??'';
    free = parsedJson['free']??'';
  }
}