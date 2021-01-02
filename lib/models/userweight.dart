class UserWeight {
  int id;
  String weight;
  String date;
  String type;
  String uid;

  UserWeight.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    weight = parsedJson['weight']??"0";
    date = parsedJson['date']??"";
    type = parsedJson['type']??"";
    uid = parsedJson['uid']??"";

  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'weight' : weight??"0",
      'date' : date??"",
      'type' : type??"",
      'uid' : uid??"",



  };}}