class DbAllDiets {

  int id;
  int user_id;
  int day;
  var detail;
  var  userInfo;
  String type;
  String created_at;
  String finished_at;
  String name;
  String advertice;
  String  ghol;
  String  extended_id;
  String alarm;


  DbAllDiets.fromJson(Map<String , dynamic> parsedJson) {


    id = parsedJson['id'];
    user_id = parsedJson['user_id'];
    day = parsedJson['day']??1;
    detail = parsedJson['detail']??"";
    userInfo = parsedJson['userInfo']??"";
    type = parsedJson['type']??"";
    created_at = parsedJson['created_at']??"";
    finished_at = parsedJson['finished_at']??"";
    name = parsedJson['name']??"";
    advertice = parsedJson['advertice']??"";
    ghol = parsedJson['ghol'].toString()??"0";
    extended_id = parsedJson['extended_id'].toString();
    alarm = parsedJson['alarm'];


  }

  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'user_id' : user_id,
      'day' : day??"",
      'detail' : detail??"",
      'userInfo' : userInfo??"",
      'type':type??"",
      'created_at':created_at??"",
      'finished_at':finished_at??"",
      'name' : name??"",
      'advertice' : advertice??"",
      'ghol' : ghol??"0",
      'extended_id' : extended_id,
      'alarm' : alarm,

    };
  }
}