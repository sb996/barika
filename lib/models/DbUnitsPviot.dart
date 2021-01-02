
class DbUnitsPviot {
  int id;
  String name_fa;
  String name_ar;
  String name_en;
  int food_id;
  int unit_id;
  String factor;



  DbUnitsPviot.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name_fa = parsedJson['name_fa']??'';
    name_ar = parsedJson['name_ar']??'';
    name_en = parsedJson['name_en']??'';
    food_id = parsedJson['food_id'];
    factor = parsedJson['factor'];
//    activityCategories = parsedJson['activityCategories'];
//    activities = parsedJson['activities'];

  }


  DbUnitsPviot.fromJson2(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name_fa = parsedJson['name_fa']??'';
    name_ar = parsedJson['name_ar']??'';
    name_en = parsedJson['name_en']??'';
    food_id = parsedJson['food_id'];
    factor = parsedJson['factor'];
    unit_id = parsedJson['unit_id'];
//    activityCategories = parsedJson['activityCategories'];
//    activities = parsedJson['activities'];

  }


  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'name_fa' : name_fa??'',
      'name_ar'  : name_ar??'',
      'name_en' : name_en??'',
      'food_id' : food_id,
      'factor' : factor,
    };

  }
  Map<String, dynamic> toMap2() {

    return <String , dynamic>{
      'name_fa' : name_fa??'',
      'name_ar'  : name_ar??'',
      'name_en' : name_en??'',
      'food_id' : food_id,
      'factor' : factor,
      'unit_id' : 1,
    };

  }

  Map<String, dynamic> toMapall() {

    return <String , dynamic>{
      'id' : id,
      'name_fa' : name_fa??'',
      'name_ar'  : name_ar??'',
      'name_en' : name_en??'',
      'food_id' : food_id,
      'factor' : factor,
      'unit_id' : unit_id,
    };

  }

  Map<String, dynamic> toMapUpdate() {

    return <String , dynamic>{

      'name_fa' : name_fa??'',
      'name_ar'  : name_ar??'',
      'name_en' : name_en??'',
      'food_id' : food_id,
      'factor' : factor,
    };

  }
}