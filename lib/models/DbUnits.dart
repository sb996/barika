
class DbUnit {
  int id;
  String name_fa;
  String name_ar;
  String name_en;
  Map pivot;


  DbUnit.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name_fa = parsedJson['name_fa']??'';
    name_ar = parsedJson['name_ar']??'';
    name_en = parsedJson['name_en']??'';
    pivot = parsedJson['pivot'];
//    activityCategories = parsedJson['activityCategories'];
//    activities = parsedJson['activities'];

  }
}