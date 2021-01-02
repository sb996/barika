class DbFood {
  int id;
  String name_fa;
  String name_ar;
  String name_en;
  String total_calorie;
  String moisture;
  String total_carb;
  String total_fat;
  String total_protein;
  String saturated_fat;
  String trans_fat;
  String cholesterol;
  String sugar;
  String fructose;
  String fiber;
  String sodium;
  String potassium;
  String phosphorus;
  String iron;
  String calcium;
  String magnesium;
  String copper;
  String zinc;
  String selenium;
  String vitamin_c;
  String biotin;
  String folic_acid;
  String pantothenic_acid;
  String b1;
  String b2;
  String b3;
  String b6;
  String b12;
  String vitamin_a;
  String beta_carotene;
  String vitamin_d;
  String vitamin_e;
  String vitamin_k;
  int category_id;
  String created_at;
  String updated_at;
  String deleted_at;
  List units;
  int favorite;

  DbFood.fromJson(Map<String , dynamic> parsedJson) {


    id = parsedJson['id'];
    name_fa = parsedJson['name_fa']??"";
    name_ar = parsedJson['name_ar']??"";
    name_en = parsedJson['name_en']??"";
    total_calorie = parsedJson['total_calorie']??'0';
    moisture = parsedJson['moisture']??'0';
    total_carb = parsedJson['total_carb']??'0';
    total_fat = parsedJson['total_fat']??'0';
    total_protein = parsedJson['total_protein']??'0';
    saturated_fat = parsedJson['saturated_fat']??'0';
    trans_fat = parsedJson['trans_fat']??'0';
    cholesterol = parsedJson['cholesterol']??'0';
    sugar = parsedJson['sugar']??'0';
    fructose = parsedJson['fructose']??'0';
    fiber = parsedJson['fiber']??'0';
    sodium = parsedJson['sodium']??'0';
    potassium = parsedJson['potassium']??'0';
    phosphorus = parsedJson['phosphorus']??'0';
    iron = parsedJson['iron']??'0';
    calcium = parsedJson['calcium']??'0';
    magnesium = parsedJson['magnesium']??'0';
    copper = parsedJson['copper']??'0';
    zinc = parsedJson['zinc']??'0';
    selenium = parsedJson['selenium']??'0';
    vitamin_c = parsedJson['vitamin_c']??'0';
    biotin = parsedJson['biotin']??'0';
    folic_acid = parsedJson['folic_acid']??'0';
    pantothenic_acid= parsedJson['pantothenic_acid']??'0';
    b1= parsedJson['b1']??'0';
    b2= parsedJson['b2']??'0';
    b3= parsedJson['b3']??'0';
    b6= parsedJson['b6']??'0';
    b12= parsedJson['b12']??'0';
    vitamin_a= parsedJson['vitamin_a']??'0';
    beta_carotene= parsedJson['beta_carotene']??'0';
    vitamin_d= parsedJson['vitamin_d']??'0';
    vitamin_e= parsedJson['vitamin_e']??'0';
    vitamin_k= parsedJson['vitamin_k']??'0';
    category_id= parsedJson['category_id'];
    created_at= parsedJson['created_at']??'';
    updated_at= parsedJson['updated_at']??'';
    deleted_at= parsedJson['deleted_at']??'';
    units= parsedJson['units'];
  {  favorite= parsedJson['favorite'];}
  }

  Map<String, dynamic> toMap() {
    return <String , dynamic>{
    'id' : id,
    'name_fa' : name_fa??"",
    'name_ar' : name_ar??"",
    'name_en' : name_en??"",
    'total_calorie' : total_calorie??"0",
    'moisture' : moisture??"0",
    'total_carb' : total_carb??"0",
    'total_fat' : total_fat??"0",
    'total_protein' : total_protein??"0",
    'saturated_fat' : saturated_fat??"0",
    'trans_fat' : trans_fat??"0",
    'cholesterol' : cholesterol??"0",
    'sugar' : sugar??"0",
    'fructose' : fructose??"0",
    'fiber' : fiber??"0",
    'sodium' : sodium??"0",
    'potassium' : potassium??"0",
    'phosphorus' : phosphorus??"0",
    'iron' : iron??"0",
    'calcium' : calcium??"0",
    'magnesium' : magnesium??"0",
    'copper' : copper??"0",
    'zinc' : zinc??"0",
    'selenium' : selenium??"0",
    'vitamin_c' : vitamin_c??"0",
    'biotin' : biotin??"0",
    'folic_acid' : folic_acid??"0",
    'pantothenic_acid' : pantothenic_acid??"0",
    'b1' : b1??"0",
    'b2' : b2??"0",
    'b3' : b3??"0",
    'b6' : b6??"0",
    'b12' : b12??"0",
    'vitamin_a' : vitamin_a??"0",
    'beta_carotene' : beta_carotene??"0",
    'vitamin_d' : vitamin_d??"0",
    'vitamin_e' : vitamin_e??"0",
    'vitamin_k' : vitamin_k??"0",
    'category_id' : category_id,
    'created_at' : created_at??"0",
    'updated_at' : updated_at??"0",
    'deleted_at' : deleted_at??"0",
    'favorite':favorite

    };
  }
  Map<String, dynamic> toMap4() {
    return <String , dynamic>{
    'id' : id+5000,
    'name_fa' : name_fa??"",
    'name_ar' : name_ar??"",
    'name_en' : name_en??"",
    'total_calorie' : total_calorie??"0",
    'moisture' : moisture??"0",
    'total_carb' : total_carb??"0",
    'total_fat' : total_fat??"0",
    'total_protein' : total_protein??"0",
    'saturated_fat' : saturated_fat??"0",
    'trans_fat' : trans_fat??"0",
    'cholesterol' : cholesterol??"0",
    'sugar' : sugar??"0",
    'fructose' : fructose??"0",
    'fiber' : fiber??"0",
    'sodium' : sodium??"0",
    'potassium' : potassium??"0",
    'phosphorus' : phosphorus??"0",
    'iron' : iron??"0",
    'calcium' : calcium??"0",
    'magnesium' : magnesium??"0",
    'copper' : copper??"0",
    'zinc' : zinc??"0",
    'selenium' : selenium??"0",
    'vitamin_c' : vitamin_c??"0",
    'biotin' : biotin??"0",
    'folic_acid' : folic_acid??"0",
    'pantothenic_acid' : pantothenic_acid??"0",
    'b1' : b1??"0",
    'b2' : b2??"0",
    'b3' : b3??"0",
    'b6' : b6??"0",
    'b12' : b12??"0",
    'vitamin_a' : vitamin_a??"0",
    'beta_carotene' : beta_carotene??"0",
    'vitamin_d' : vitamin_d??"0",
    'vitamin_e' : vitamin_e??"0",
    'vitamin_k' : vitamin_k??"0",
    'category_id' : category_id,
    'created_at' : created_at??"0",
    'updated_at' : updated_at??"0",
    'deleted_at' : deleted_at??"0",
    'favorite':favorite

    };
  }
  Map<String, dynamic> toMap2() {
    return <String , dynamic>{
    'id' : id,
    'name_fa' : name_fa??"",
    'name_ar' : name_ar??"",
    'name_en' : name_en??"",
    'total_calorie' : total_calorie??"0",
    'moisture' : moisture??"0",
    'total_carb' : total_carb??"0",
    'total_fat' : total_fat??"0",
    'total_protein' : total_protein??"0",
    'saturated_fat' : saturated_fat??"0",
    'trans_fat' : trans_fat??"0",
    'cholesterol' : cholesterol??"0",
    'sugar' : sugar??"0",
    'fructose' : fructose??"0",
    'fiber' : fiber??"0",
    'sodium' : sodium??"0",
    'potassium' : potassium??"0",
    'phosphorus' : phosphorus??"0",
    'iron' : iron??"0",
    'calcium' : calcium??"0",
    'magnesium' : magnesium??"0",
    'copper' : copper??"0",
    'zinc' : zinc??"0",
    'selenium' : selenium??"0",
    'vitamin_c' : vitamin_c??"0",
    'biotin' : biotin??"0",
    'folic_acid' : folic_acid??"0",
    'pantothenic_acid' : pantothenic_acid??"0",
    'b1' : b1??"0",
    'b2' : b2??"0",
    'b3' : b3??"0",
    'b6' : b6??"0",
    'b12' : b12??"0",
    'vitamin_a' : vitamin_a??"0",
    'beta_carotene' : beta_carotene??"0",
    'vitamin_d' : vitamin_d??"0",
    'vitamin_e' : vitamin_e??"0",
    'vitamin_k' : vitamin_k??"0",
    'category_id' : category_id,
    'created_at' : created_at??"0",
    'updated_at' : updated_at??"0",
    'deleted_at' : "yes",

    };
  }
  Map<String, dynamic> toMap3() {
    return <String , dynamic>{
    'id' : id,
    'updated_at' : "yes",


    };
  }


}