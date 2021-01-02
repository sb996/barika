
class DbType {
  List foodCategories;
  List foods;
  List activityCategories;
  List activities;
  List notices;
  List fruits;
  List cereals;


  DbType.fromJson(Map<String , dynamic> parsedJson) {
    foodCategories = parsedJson['foodCategories'];
    foods = parsedJson['foods'];
    activityCategories = parsedJson['activityCategories'];
    activities = parsedJson['activities'];
    notices = parsedJson['notices'];
    fruits = parsedJson['fruits'];
    cereals = parsedJson['cereals'];

  }
}