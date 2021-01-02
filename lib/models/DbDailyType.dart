class DbDailyType {

  int id;
  int info_id;
  String vade;
  int food_id;
  int myfood_id;
  int unit_id;
  int act_id;
  String amount;
  String total_cal;
  String name;
  String date;
  String total_protein;
  String total_carb;
  String total_fat;

  DbDailyType.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    info_id = parsedJson['info_id'];
    vade = parsedJson['vade'];
    food_id = parsedJson['food_id'];
    myfood_id=parsedJson['myfood_id'];
    unit_id = parsedJson['unit_id'];
    act_id = parsedJson['act_id'];
    amount = parsedJson['amount'];
    total_cal = parsedJson['total_cal'];
    name = parsedJson['name'];
    date = parsedJson['date'];
    total_protein = parsedJson['total_protein'];
    total_carb = parsedJson['total_carb'];
    total_fat = parsedJson['total_fat'];
  }

  Map<String, dynamic> toMap() {
    return <String , dynamic>{
    'id' : id,
    'info_id' : info_id,
    'vade' : vade,
    'food_id' : food_id,
    'myfood_id':myfood_id,
    'unit_id' : unit_id,
    'act_id' : act_id,
    'amount' : amount,
    'total_cal' : total_cal,
      'name' : name,
      'date' : date,
      'total_protein' : total_protein,
      'total_carb' : total_carb,
      'total_fat' : total_fat,

    };
  }}