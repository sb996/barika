

class version {
  int id;
  String newversion;
  String description;
  String link;
  int frc;

  version.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    newversion = parsedJson['version'];
    description = parsedJson['description'];
    link = parsedJson['link'];
    frc = parsedJson['frc'];

  }
}

//
//"version": {
//"id": 1,
//"version": "1.1",
//"description": "سلام نسخه جدید آماده است. نصب کنید!",
//"link": "https://api.kingdiet.net/v1/login",
//"frc": 0,
//"created_at": "2020-07-06 19:30:00",
//"updated_at": null
//}