class subSupplementSingle {
  String id;
  String name;
  String materials;
  String company;
  String usage;
  String warning;
  String interactions;
  String operation;
  String prohibited;
  String cover;

  subSupplementSingle.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??'-';
    materials = parsedJson['materials']??'-';
    company = parsedJson['company']??'-';
    usage = parsedJson['usage']??'-';
    warning = parsedJson['warning']??'-';
    interactions = parsedJson['interactions']??'-';
    operation = parsedJson['operation']??'-';
    prohibited = parsedJson['prohibited']??'-';
    cover = parsedJson['cover']??' ';

  }
}