class allRecipes {
  String id;
  String name;
  String cover;
  List recipes;


  allRecipes.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    cover = parsedJson['cover']??"";
    recipes = parsedJson['recipes']??"";
  }
  allRecipes.fromJson2(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name']??"";
    cover = parsedJson['cover']??"";

  }
}