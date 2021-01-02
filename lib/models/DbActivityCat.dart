class DbActivityCat {

  int id;
  int weight;
  String name_fa;
  String name_ar;
  String name_en;
  String created_at;
  String updated_at;
  String deleted_at;

  DbActivityCat.fromJson(Map<String , dynamic> parsedJson) {


    id = parsedJson['id'];
    weight = parsedJson['weight']??1;
    name_fa = parsedJson['name_fa']??"";
    name_ar = parsedJson['name_ar']??"";
    name_en = parsedJson['name_en']??"";
    created_at= parsedJson['created_at']??"";
    updated_at= parsedJson['updated_at']??"";
    deleted_at= parsedJson['deleted_at']??"";


  }

  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'weight' : weight??1,
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
      'weight' : weight??1,
      'name_fa' : name_fa??"",
      'name_ar'  : name_ar??"",
      'name_en' : name_en??"",
      'created_at' : created_at??"",
      'updated_at' : updated_at??"",
      'deleted_at' :"yes",
    };
  }

}