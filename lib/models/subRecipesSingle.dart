class subRecipesSingle {
  String id;
  String name;
  String description;
  int consumer ;
  String time;
  String cover;
  String order;
  List data;
  String total_calorie;
  String total_carb;
  String total_fat;
  String total_protein;

  subRecipesSingle.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    description = parsedJson['description']??"";
    consumer = parsedJson['consumer']??0;
    time = parsedJson['time']??"";
    order = parsedJson['order']??"";
    cover = parsedJson['cover']??"";
    data = parsedJson['data']??"";
    total_calorie = parsedJson['total_calorie']??"0";
    total_carb = parsedJson['total_carb']??"0";
    total_fat = parsedJson['total_fat']??"0";
    total_protein = parsedJson['total_protein']??"0";

  }


}