
import 'package:persian_datepicker/persian_datetime.dart';

class dateCall {
  static var date;
  static String me;
  static String update;
  static String updatRegim;

  static saveDate(PersianDateTime da){
  print("saveData"+da.toString());
    date =da;
  }
  static getDate(){
    print("getData"+date.toString());
    return date==null? null
        : date.toGregorian(format: 'YYYY-MM-DD');
  }

  static saveMe(String Nme){
    print("saveme"+Nme);
    me =Nme;
  }
  static getMe(){
    print("getme"+me.toString());
    return me==null? "other"
        : me;
  }

  static saveUpdate(String updatenew){
    print("saveupdate"+updatenew);
    update =updatenew;
  }
  static getUpdate(){
    return update;
  }

  static saveUpdateRegim(String updatnew){
    print("saveupdat"+updatnew);
    updatRegim =updatnew;
  }
  static getUpdateRegim(){
    return updatRegim;
  }
}
//
//  static Future getDbInfo(BuildContext context) async {
//    print('exersize');
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String apiToken = prefs.getString('user_token');
//    start starts;
//    final response = await Provider.of<apiServices>(context, listen: false)
//        .getStart(
//            'Bearer '+apiToken );
//    if (response.statusCode == 200) {
//      final post = json.decode(response.bodyString);
//
//
//      starts = start.fromJson(post);
//      DbType dbType;
//      dbType = DbType.fromJson(starts.created);
//
//
//      List<DbFoodCat> foodCat = [];
//      dbType.foodCategories.forEach((item) {
//        foodCat.add(DbFoodCat.fromJson(item));
//      });
//     await _saveAllPFoodCatIntoSqlite(foodCat);
//
//      List<DbFood> foods = [];
//      dbType.foods.forEach((item) {
//        foods.add(DbFood.fromJson(item));
//      });
//     await _saveAllFoodIntoSqlite(foods);
//
//
//     getUser(context);
//      List<DbActivityCat> ActCat = [];
//      dbType.activityCategories.forEach((item) {
//        ActCat.add(DbActivityCat.fromJson(item));
//      });
//      bool b=await _saveAllActCatIntoSqlite(ActCat);
//      print(b.toString());
//
////      bool b3 =await _deleteAllActsIntoSqlite();
////      print(b3.toString());
//
//      List<DbActivities> Act = [];
//      dbType.activities.forEach((item) {
//        Act.add(DbActivities.fromJson(item));
//      });
//     bool b2= await _saveAllActIntoSqlite(Act);
//     print(b2.toString());
//
//
//         List <DbUnitsPviot> list=setUtils(foods);
//         print(list.toString());
//         bool b3= await _saveAllunits(list);
//         print(b3.toString());
//
//
//
////        var e= await _unitSearch();
////        print('soeefeg${e.toString()}');
//
//      return true;
//    } else {
//      false;
//    }
//
//  }
//
////
////  static Future<Map> _getAllProductsFromNetwork(int page) async {
////      final response = await http.get('http://roocket.org/api/products?page=${page}');
////
////
////      if(response.statusCode == 200) {
////          var responseBody = json.decode(response.body)['data'];
////
////          List<Product> products =[];
////          responseBody['data'].forEach((item) {
////            products.add(Product.fromJson(item));
////          });
////
////
////
////          return {
////            "current_page" : responseBody['current_page'],
////            "products" : products
////          };
////      }
////
////      return null;
////  }
//  static Future<Map> _getAllFoodsFromSqlite(int page) async {
//    await _getAllFoodCatsFromSqlite(1);
//    var db = new foodProvider();
//    await db.open();
//
//    List<DbFood> DbFoodlist = await db.paginate();
//    print('reeeeeeed${DbFoodlist.toString()}');
//
//    await db.close();
//
//    return {"current_page": page, "products": DbFoodlist};
//  }
//
//  static Future<Map> _getAllFoodCatsFromSqlite(int page) async {
//    var db = new foodCatProvider();
//    await db.open();
//    List<DbFoodCat> products = await db.paginate();
//    print('reeeeeeed${products.toString()}');
//
//    await db.close();
//
//    return {"current_page": page, "products": products};
//  }
//
//  static Future<bool> _saveAllPFoodCatIntoSqlite(
//      List<DbFoodCat> products) async {
//    try {
//      var db = new foodCatProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  static Future<bool> _saveAllFoodIntoSqlite(List<DbFood> products) async {
//    try {
//      var db = new foodProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  static Future<bool> _saveAllActCatIntoSqlite(
//      List<DbActivityCat> products) async {
//    try {
//      var db = new ActCatProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  static Future<bool> _saveAllActIntoSqlite(List<DbActivities> products) async {
//    try {
//
//      var db = new ActivityProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  static Future<bool> _deleteAllActsIntoSqlite() async {
//    try {
//      var db = new ActivityProvider();
//    await db.open();
//    await db.delete();
//    await db.close(); } catch (e) {
//      return false;
//    }
//  }
//
//  static Future<Map> _getAllFoodscat() async {
//    var db = new foodProvider();
//    await db.open();
//
//    List<DbFood> DbFoodlist = await db.getCat(12);
//    print('rssssssssd${DbFoodlist.toString()}');
//
//    await db.close();
//
//    return {"products": DbFoodlist};
//  }
//
//  static List<DbUnitsPviot> setUtils(List<DbFood> foods) {
//    List<DbUnit> _units = [];
//    DbUnit f;
//    for (int i = 0; i < foods.length; i++) {
//      foods[i].units.forEach((item) {
//        _units.add(DbUnit.fromJson(item));
//      });
//    }
//    print('lengghtyyyyyyy${_units.length.toString()}');
//
//    List<DbUnitsPviot> _unitpiotList = [];
//    _units.forEach((item) {
//      var map = {
//        'name_fa': item.name_fa,
//        'name_ar': item.name_ar,
//        'name_en': item.name_en,
//        'food_id': item.pivot['food_id'],
//        'factor': item.pivot['factor'],
//      };
//
//      _unitpiotList.add(DbUnitsPviot.fromJson(map));
//    });
//    print('lengghtyyyyyyy${_unitpiotList.length.toString()}');
//    return _unitpiotList;
//  }
//
//  static Future<Map> _unitSearch() async {
//    var db = new unitsProvider();
//    await db.open();
//    List<DbUnitsPviot> DbFoodlist = await db.search(57);
//    print('rssssUHUHssssd${DbFoodlist.length.toString()}');
//    await db.close();
//    return {"products": DbFoodlist};
//  }
//
//  static Future<bool> _saveAllunits(List<DbUnitsPviot> products) async {
//    try {
//      var db = new unitsProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//
//  static Future<Map> getUser(BuildContext context) async {
//    print('USErrR');
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String apiToken = prefs.getString('user_token');
//    final response = await Provider.of<apiServices>(context, listen: false)
//        .getUserInfo(
//        'Bearer '+apiToken );
//    if (response.statusCode == 200) {
//      print('${response.bodyString}SSSSSSSSSSSSSSSSSSSSSSSS');
//      final post = json.decode(response.bodyString);
//      List<User> users=[];
//      users.add(User.fromJson(post['success']));
//      print(await _saveAllUser(users)+"kkkkkkkkkkkkkkkkk");
//      print("mappppppppppppppp");
//      print(users[0].toMap());
//      return {'users': users};
//
//    } else {
//      print(response.statusCode.toString());
//    }
//  }
//
//  static Future _saveAllUser(List<User> products) async {
//    print(products[0].toMap());
//
//    try {
//      var db = new userProvider();
//      await db.open();
//      await db.insertAll(products);
//      await db.close();
//      return true;
//    } catch (e) {
//      return e.toString();
//    }
//  }
//
//
//}
