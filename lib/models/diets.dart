class diets {
  int id;
  int user_id;
  int days;
  String ghol;
  var detail;
  var  userInfo;
  String regimName;
  String advertises;
  String used;
  String created_at;
  String finished_at;
  String extended_id;

  diets.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    user_id = parsedJson['user_id'];
    days = parsedJson['days'];
    ghol = parsedJson['ghol'].toString();
    detail = parsedJson['details'] ??'';
    userInfo = parsedJson['user_information']??'';
    regimName = parsedJson['type']??'';
    advertises = parsedJson['advertises']??'';
    used = parsedJson['used'].toString()??'';
    created_at = parsedJson['created_at']??'';
    finished_at = parsedJson['finished_at']??'';
    extended_id = parsedJson['extended_id'].toString()??'';
  }
  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id':id,
      'user_id':user_id,
      'days':days,
      'ghol':ghol,
      'detail' : detail,
      'userInfo' : userInfo,
      'regimName'  : regimName,
      'advertises'  : advertises,
      'used' : used,
      'created_at' : created_at,
      'finished_at' : finished_at,
      'extended_id' : extended_id,

//      'avatar' : avatar,
//      'dateChnge' : dateChnge,
    };

  }}