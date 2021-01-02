class subExercisesSingle {
  String id;
  String name;
  String energy;
  String cover;
  String description;
  String link;
  List tags;
  String hardness;
  String met;
  String type;

  subExercisesSingle.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    energy = parsedJson['energy']??"0";
    cover = parsedJson['cover']??"";
    description = parsedJson['description']??"";
    link = parsedJson['link']??"";
    tags = parsedJson['tags']??[];
    hardness = parsedJson['hardness']??"0";
    met = parsedJson['met']??"0";
    type = parsedJson['type']??"";
  }
}