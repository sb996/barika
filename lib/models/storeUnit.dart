class storeUnit {
  int id;
  int value;
  String unit;

  storeUnit.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    value = parsedJson['value'] ??'';
    unit = parsedJson['unit']??'';

  }
}