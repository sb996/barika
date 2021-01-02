class allExercise {
  String id;
  String name;
  String type;
  String cover;

  allExercise.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    type = parsedJson['type']??"";
    cover = parsedJson['cover']??"";
  }
}