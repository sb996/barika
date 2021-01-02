class cereals {
  int id;
  String name;
  String calorie;
  String weight;

  cereals.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'] ??'';
    calorie = parsedJson['calorie']??'';
    weight = parsedJson['weight']==null ?'': parsedJson['weight'].toString();

  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'name' : name,
      'calorie' : calorie,
      'weight' : weight,

    };

  }}