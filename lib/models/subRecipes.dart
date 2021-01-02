class subRecipes {
  String id;
  String name;
  String description;
  int consumer ;
  int free ;
  String time;
  String cover;
  String total_calorie;

  subRecipes.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    description = parsedJson['description']??"";
    consumer = parsedJson['consumer']??0;
    time = parsedJson['time']??"0";
    cover = parsedJson['cover']??"";
    free = parsedJson['free']??"";
    total_calorie = parsedJson['total_calorie']??"0";

  }
}