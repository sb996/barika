class DbDailyDiet {

  int id;
  int id_allDiet;
  var breakfast;
  String lunch;
  String dinner;
  String snack;
  int day;

  DbDailyDiet.fromJson(Map<String , dynamic> parsedJson) {


    id = parsedJson['id'];
    id_allDiet = parsedJson['id_allDiet'];
    breakfast = parsedJson['breakfast']??"";
    lunch = parsedJson['lunch']??"";
    dinner = parsedJson['dinner']??"";
    snack = parsedJson['snack']??"";
    day = parsedJson['day']??0;


  }

  Map<String, dynamic> toMap() {

    return <String , dynamic>{
      'id' : id,
      'id_allDiet':id_allDiet,
      'breakfast':breakfast??'',
      'lunch' : lunch??"",
      'dinner' : dinner??"",
      'snack' : snack??"",
      'day' : day??0,

    };
  }
  Map<String, dynamic> toMap2() {

    return <String , dynamic>{

      'id_allDiet':id_allDiet,
      'breakfast':breakfast??'',
      'lunch' : lunch??"",
      'dinner' : dinner??"",
      'snack' : snack??"",
      'day' : day??0,

    };
  }
}