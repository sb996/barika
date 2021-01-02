
class fruits {
  int id;
  String name;
  String size;
  String weight;
  String weight2;
  String cover;

  fruits.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'] ??'';
    size = parsedJson['size']??'';
    weight = parsedJson['weight']??'';
    weight2 = parsedJson['weight2']==null ?'': parsedJson['weight2'].toString();

    cover = parsedJson['cover']??'';

  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'name' : name,
      'size' : size,
      'weight'  : weight,
      'weight2'  : weight2,
      'cover'  : cover,

    };

  }}