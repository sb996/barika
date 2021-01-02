class subExercise {
  String id;
  String name;
  String energy;
  String cover;
  String description;
  int free;

  subExercise.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    energy = parsedJson['energy']??"";
    cover = parsedJson['cover']??"";
    description = parsedJson['description']??"";
    free = parsedJson['free']??"";
  }
}