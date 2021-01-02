class DbActivities {

  int id;
  String met;
  String name_fa;
  String name_ar;
  String name_en;
  int category_id;
  String created_at;
  String updated_at;
  String deleted_at;

  DbActivities.fromJson(Map<String , dynamic> parsedJson) {


    id = parsedJson['id'];
    met = parsedJson['met']??"0";
    name_fa = parsedJson['name_fa']??"";
    name_ar = parsedJson['name_ar']??"";
    name_en = parsedJson['name_en']??"";
    category_id= parsedJson['category_id'];
    created_at= parsedJson['created_at']??"";
    updated_at= parsedJson['updated_at']??"";
    deleted_at= parsedJson['deleted_at']??"";


  }

  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'met':met??"0",
      'category_id':category_id,
      'name_fa' : name_fa??"",
      'name_ar'  : name_ar??"",
      'name_en' : name_en??"",
      'created_at' : created_at??"",
      'updated_at' : updated_at??"",
      'deleted_at' : deleted_at??"",
    };
  }
  Map<String, dynamic> toMap2() {

    return <String , dynamic>{
      'id' : id,
      'met':met??"0",
      'category_id':category_id,
      'name_fa' : name_fa??"",
      'name_ar'  : name_ar??"",
      'name_en' : name_en??"sdd",
      'created_at' : created_at??"",
      'updated_at' : updated_at??"",
      'deleted_at' : "yes",
    };
  }
  Map<String, dynamic> toMap3() {

    return <String , dynamic>{
      'id' : id,
      'updated_at' : "yes",
    };
  }

  Map<String, dynamic> toMap4() {

    return <String , dynamic>{
      'id' : id+6000,
      'met':met??"0",
      'category_id':category_id,
      'name_fa' : name_fa??"",
      'name_ar'  : name_ar??"",
      'name_en' : name_en??"",
      'created_at' : created_at??"",
      'updated_at' : updated_at??"",
      'deleted_at' : deleted_at??"",
    };
  }
}