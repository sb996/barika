

class start {
  var created;
  var updated;
  var deleted;
  var server_date;
  var version;
  List albums;
  List recipes;
  List exercises;
  List supplements;

  start.fromJson(Map<String , dynamic> parsedJson) {
    created = parsedJson['created'];
    updated = parsedJson['updated'];
    deleted = parsedJson['deleted'];
    albums = parsedJson['albums'];
    recipes = parsedJson['recipes'];
    exercises = parsedJson['exercises'];
    supplements = parsedJson['supplements'];
    server_date = parsedJson['server_date'];
    version = parsedJson['version'];
  }
}