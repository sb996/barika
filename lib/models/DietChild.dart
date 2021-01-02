

class DietChild {
  int id;
  String advertise;
  String days;
  String details;
  String type;
  String type2;
  String created_at;


  DietChild.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    advertise = parsedJson['advertise'];
    details = parsedJson['details'];
    days = parsedJson['days']==null?"0": parsedJson['days'].toString();
    type = parsedJson['type'];
    type2 = parsedJson['type2'];
    created_at = parsedJson['created_at'];

    print(id);

  }
}