class DbFoodMaterial {
  int id;
  int myfood_id;
  int food_id;
  int unit_id;
  String factor;
  String amount;

  DbFoodMaterial.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    food_id = parsedJson['food_id'];
    myfood_id = parsedJson['myfood_id'];
    unit_id = parsedJson['unit_id'];
    factor = parsedJson['factor'] ?? '0';
    amount = parsedJson['amount'] ?? '0';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'myfood_id': myfood_id,
      'food_id': food_id,
      'unit_id': unit_id,
      'factor': factor??'0',
      'amount': amount??'0',
    };
  }
}
