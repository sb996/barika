class store {
  String id;
  String name;
  String description;
  String cover;
  String price_euro;
  String sku;
  int pricetoman;
  List price;

  store.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'] ??'';
    description = parsedJson['description']??'';
    cover = parsedJson['cover']??'';
    price = parsedJson['price']??'';
    sku = parsedJson['sku']??'';
    pricetoman = parsedJson['price_toman']??'0';
    price_euro = parsedJson['price_euro']==null?'0':parsedJson['price_euro'].toString();
  }
}