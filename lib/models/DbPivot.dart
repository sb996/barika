

class DbPivot {

  int food_id;
  int unit_id;
  String factor;



  DbPivot.fromJson(Map<String , dynamic> parsedJson) {

    food_id = parsedJson['food_id'];
    unit_id = parsedJson['unit_id'];
    factor = parsedJson['factor']??'0';
//    activityCategories = parsedJson['activityCategories'];
//    activities = parsedJson['activities'];

  }
}