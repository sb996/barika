// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
//
//
// import 'package:barika/models/DbType.dart';
// import 'package:barika/models/cereals.dart';
// import 'package:barika/models/fruits.dart';
// import 'package:barika/models/start.dart';
// import 'package:barika/sqliteProvider/cerealsProvider.dart';
// import 'package:barika/sqliteProvider/fruitsProvider.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:barika/utils/date.dart';
// import 'package:barika/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart'as intl;
// import 'package:barika/models/DbActivities.dart';
// import 'package:barika/models/DbActivityCat.dart';
// import 'package:barika/models/DbAllDiets.dart';
// import 'package:barika/models/DbDailyDiet.dart';
// import 'package:barika/models/DbFood.dart';
// import 'package:barika/models/DbFoodCat.dart';
// import 'package:barika/models/DbUnits.dart';
// import 'package:barika/models/DbUnitsPviot.dart';
// import 'package:barika/models/DietChild.dart';
// import 'package:barika/models/diets.dart';
// import 'package:barika/models/notices.dart';
// import 'package:barika/models/user.dart';
// import 'package:barika/services/apiServices.dart';
// import 'package:barika/sqliteProvider/DailyDietProvider.dart';
// import 'package:barika/sqliteProvider/activityCatProvider.dart';
// import 'package:barika/sqliteProvider/activityProvider.dart';
// import 'package:barika/sqliteProvider/allDietProvider.dart';
// import 'package:barika/sqliteProvider/foodCatProvider.dart';
// import 'package:barika/sqliteProvider/foodProvider.dart';
// import 'package:barika/sqliteProvider/noticsProvider.dart';
// import 'package:barika/sqliteProvider/unitsProvider.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:package_info/package_info.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' show get;
// import 'package:sqflite/sqflite.dart';
// import '../helper.dart';
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:path/path.dart' as Path;
//
// class getInfo extends StatefulWidget {
//   final String phone;
//   // In the constructor, require a Todo.
//   getInfo({Key key, @required this.phone}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => new getInfoState();
// }
// class getInfoState extends State<getInfo> {
//   static List<diets> allDiets=[];
//   bool _isLoading = true;
//   bool user=false;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   Widget loadingView() {
//     return new Center(
//         child:Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SpinKitCircle(
//               color: MyColors.vazn,
//             ),
//             Text("درحال دریافت اطلاعات لطفا منتظر بمانید",style: TextStyle(
//                 fontSize:12*fontvar
//             ),)
//           ],
//         )
//     );
//   }
//   String birthDate="";
//   bool snack=true;
//   User _usertest;
//   User _userSave;
//   String _version="";
//   var signupColor = Color(0xFF6DC07B);
//   @override
//   void initState() {
//
//     allDiets=[];
//     _isLoading = true;
//     user=false;
//     birthDate="";
//     snack=true;
//     snack=true;
//     signupColor = Color(0xFF6DC07B);
//     getVesion();
//
//
//     getProducts();
//     super.initState();
//   }
//   Database _db123;
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return WillPopScope(
//         onWillPop: (){},
//         child: Scaffold(
//             key: _scaffoldKey,
//             backgroundColor: signupColor,
//             body: new Stack(
//               alignment: AlignmentDirectional.bottomCenter,
//               fit: StackFit.expand,
//               children: <Widget>[
//                 Container(
//
//                   child:    Image.asset('assets/images/bg_intro.png',
//
//                     color: Colors.white,
//                     fit: BoxFit.contain,
//                     alignment: Alignment.bottomCenter,
//                     height: screenSize.height/3,
//
//                   ),
//                 ),
//                 Center(child:Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//
//                     Image.asset('assets/images/logoorange.png',
//                       fit: BoxFit.contain,
//                       width: 109*(screenSize.width)/375,
//                       height: 130*(screenSize.width)/375,),
//                     Padding(
//                         child:  Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("دکتر مجید محمدشاهی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w500
//                               ),),
//                             Text("دکتر فاطمه حیدری",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w500
//                               ),),
//                             Text("متخصصین تغذیه و رژیم درمانی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w400
//                               ),),
//                             Text("اساتید دانشگاه علوم پزشکی",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:15*fontvar,
//                                   fontWeight: FontWeight.w400
//                               ),),
//
//                             Padding(
//                               padding: EdgeInsets.only(top:15),
//                               child:Text(_version,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:15*fontvar,
//                                     fontWeight: FontWeight.w400
//                                 ),) ,
//                             )
//
//                           ],
//                         ),
//                         padding: EdgeInsets.only(bottom: 20,right: 15,left: 15,top:35)
//                     ),
//
//                   ],
//                 )),
//                 (_isLoading)?  Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SpinKitCircle(
//                       color: MyColors.vazn,
//                     ),
//                     Text("درحال دریافت اطلاعات لطفا منتظر بمانید",style: TextStyle(
//                         fontSize:12*fontvar
//                     ),)
//                   ],
//                 ):Container(),
//                 (!_isLoading)?  Container(alignment: Alignment.topRight,
//                     margin: EdgeInsets.only(top: 35,right: 10),
//                     child: GestureDetector(
//                       child: Row(
//                         children: <Widget>[
//                           Padding(padding: EdgeInsets.only(bottom: 3),child: Icon(Icons.arrow_back,color: Colors.white,size: 22,),),
//                           Text("ورود با حساب دیگر",style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),),
//                         ],
//                       ),
//                       onTap: (){
//                         Navigator.of(context).pushReplacementNamed('/language');
//                       },
//                     )
//
//                 ):Container(),
//
//
//               ],
//             )));
//   }
//   Future<Map> getProducts() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     if (await checkConnectionInternet()) {
//       try {
//         Map map = await getDbInfo();
//         bool b4 = map["b4"];
//         print(b4.toString() + "b44");
//         if (b4) {
//           await storeUserData("true");
//           push(context);
//         }
//         else {
//           setState(() {
//             _isLoading = false;
//           });
//
//           print("b4errroe");
//           shoeSnackBar();
// //       await _getAllFoodsFromSqlite(1);
//         }
//       }
//       catch (e) {
//         setState(() {
//           _isLoading = false;
//         });
//         print(e.toString());
//         shoeSnackBar();
//       }
//     }
//     else{
//       setState(() {
//         _isLoading = false;
//       });
//
//       print("intenteerrpe");
//       shoeSnackBar();
//     }
//   }
//
//   int compareTo(String newVer,String oldVer) {
//     if(newVer == null)
//       return 1;
//     List<String> oldParts = oldVer.split(".");
//     List<String> newParts = newVer.split(".");
//     int length = [newParts.length, oldParts.length].reduce(max);
//     for(int i = 0; i < length; i++) {
//       int oldPart = i < oldParts.length ?
//       int.parse(oldParts[i]) : 0;
//       int newPart = i < newParts.length ?
//       int.parse(newParts[i]) : 0;
//       if(oldPart < newPart)
//         return 1;
//       if(oldPart > newPart)
//         return -1;
//     }
//     return 0;
//   }
//   Future  getDbInfo() async {
//
//
//     String _path;
//
//
//
// //      var databasesPath = await sqflite.getDatabasesPath();
// //      var path = databasesPath + '/db.sqlite3';
// //      var exists = await sqflite.databaseExists(path);
// //      if (!exists) {
// //        ByteData data = await rootBundle.load('assets/db.sqlite3');
// //        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// //        await Directory(databasesPath).create(recursive: true);
// //        await File(path).writeAsBytes(bytes, flush: true);
// ////      }
// //      return await sqflite.openDatabase(path);
//
//     Database db;
//
// //                        }
// ///////////////////////////////////////////////////////////////////////
// ////
// //    PackageInfo packageInfo = await PackageInfo.fromPlatform();
// //    String versionName = packageInfo.version;
// //
// //    print(versionName+"versionName");
// //    print(compareTo("1.1.1",versionName));
// //
// //   if ( compareTo("1.1.1",versionName)==1){
// //
// //      var databasesPath = await getDatabasesPath();
// //      _path = Path.join(databasesPath, 'king.db');
// //      print("deleteDatdg");
// //      print(_path);
// //
// //      if (await databaseExists(_path)) {
// // //      await ((await openDatabase(_path)).close());
// //        await deleteDatabase(_path);
// //        print("deleteDatabase");
// //      }
// //      try {
// //        await Directory(databasesPath).create(recursive: true);
// //      } catch (_) {}
// //
// //      ByteData data = await rootBundle.load("assets/kingassets.db");
// //      List<int> bytes = data.buffer.asUint8List(
// //          data.offsetInBytes, data.lengthInBytes);
// //      await new File(_path).writeAsBytes(bytes, flush: true);
// //    };
//
//
//     //////////////////////////*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String phoneSave=await prefs.getString('user_phone')??"";
//
//     if(widget.phone!=phoneSave) {
//
// //
//       await prefs.setString('apiDate',null);
//       await prefs.setString('date', null);
//
//       print(widget.phone);
//       print("widget.phone");
//       var databasesPath = await getDatabasesPath();
//       _path = Path.join(databasesPath, 'king.db');
//
//       if (await databaseExists(_path)) {
// //      await ((await openDatabase(_path)).close());
//         await deleteDatabase(_path);
//         print("deleteDatabase");
//       }
//       try {
//         await Directory(databasesPath).create(recursive: true);
//       } catch (_) {}
//
//       ByteData data = await rootBundle.load("assets/kingassets.db");
//       List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//       await File(_path).writeAsBytes(bytes, flush: true);
//     }
//
//
//
//     /////////////////////////////*/*/*/*//////////*/*/*/*121212
//
// //
// //        SharedPreferences prefs = await SharedPreferences.getInstance();
// //
// //    String apiToken = prefs.getString('user_token');
// //    start starts;
// //     print(apiToken);
// //    final response = await Provider.of<apiServices>(context)
// //        .getStart2(
// //        "2010-07-16 00:00:00", "1",
// //        'Bearer '+ apiToken);
// //    if (response.statusCode == 200) {
// //      final post = json.decode(response.bodyString);
// //      starts = start.fromJson(post);
// //    }
// //
// //
// // //    String data = await DefaultAssetBundle.of(context).loadString("assets/start.json");
// // //    print(data.runtimeType.toString());
// // //    final jsonResult = json.decode(data);
// // //    print(jsonResult.runtimeType.toString());
// // //    starts = start.fromJson(jsonResult);
// // //
// //
// //
// //
// //
// //
// //
// //    DbType dbType;
// //    dbType = DbType.fromJson(starts.created);
// //
// //    List <notices> _notices=[];
// //    dbType.notices.forEach((item){
// //      _notices.add(notices.fromJson(item));
// //    });
// //    await _saveAllNoticsIntoSqlite(_notices);
// //
// //    List<DbFoodCat> foodCat = [];
// //    dbType.foodCategories.forEach((item) {
// //      foodCat.add(DbFoodCat.fromJson(item));
// //    });
// //    await _saveAllPFoodCatIntoSqlite(foodCat);
// //
// //    List<cereals> cerealsList = [];
// //    dbType.cereals.forEach((item) {
// //      cerealsList.add(cereals.fromJson(item));
// //    });
// //    await _saveAllcereals(cerealsList);
// //
// //    List<fruits> fruitsList = [];
// //    dbType.fruits.forEach((item) async {
// //      fruitsList.add(fruits.fromJson(item));
// //    });
// //    await _saveAllfruits(fruitsList);
// //
// // //    await _updateAllfruits(fruitsList);
// //
// //
// //
// //    List<DbFood> foods = [];
// //    dbType.foods.forEach((item) {
// //      foods.add(DbFood.fromJson(item));
// //    });
// //    await _saveAllFoodIntoSqlite(foods);
// //
// //    List<DbActivityCat> ActCat = [];
// //    dbType.activityCategories.forEach((item) {
// //      ActCat.add(DbActivityCat.fromJson(item));
// //    });
// //    bool b=await _saveAllActCatIntoSqlite(ActCat);
// // //      print(b.toString());
// //
// // //      bool b3 =await _deleteAllActsIntoSqlite();
// // //      print(b3.toString());
// //
// //    List<DbActivities> Act = [];
// //    dbType.activities.forEach((item) {
// //      Act.add(DbActivities.fromJson(item));
// //    });
// //    bool b2= await _saveAllActIntoSqlite(Act);
// // //      print(b2.toString());
// //
// //
// //    List <DbUnitsPviot> list=setUtils(foods);
// // //      print(list.toString());
// //    bool b3= await _saveAllunits(list);
// // //      print(b3.toString());
//
//
//
//     bool b4=await getUser(context);
//     bool b5=await getProductss(context);
//     bool b6=await getUsersq();
//     print(b4&&b5&&b6);
//     print("$b4"+"dsf"+"$b5"+"$b6");
//     return {
//       "b4":b4&&b5&&b6
//     };
//
//
//
//
// //        var e= await _unitSearch();
// //        print('soeefeg${e.toString()}');
//
//
// //    }
// //    else {
// //
// //    }
//
//   }
//
// //
// //  static Future<Map> _getAllProductsFromNetwork(int page) async {
// //      final response = await http.get('http://roocket.org/api/products?page=${page}');
// //
// //
// //      if(response.statusCode == 200) {
// //          var responseBody = json.decode(response.body)['data'];
// //
// //          List<Product> products =[];
// //          responseBody['data'].forEach((item) {
// //            products.add(Product.fromJson(item));
// //          });
// //
// //
// //
// //          return {
// //            "current_page" : responseBody['current_page'],
// //            "products" : products
// //          };
// //      }
// //
// //      return null;
// //  }
//   Future<Map> _getAllFoodsFromSqlite(int page) async {
//     await _getAllFoodCatsFromSqlite(1);
//     var db = new foodProvider();
//     await db.open();
//     List<DbFood> DbFoodlist = await db.paginate();
// //    await db.close();
//     return {"current_page": page, "products": DbFoodlist};
//   }
//   Future<Map> _getAllFoodCatsFromSqlite(int page) async {
//     var db = new foodCatProvider();
//     await db.open();
//     List<DbFoodCat> products = await db.paginate();
//
//
// //    await db.close();
//
//     return {"current_page": page, "products": products};
//   }
//
//   Future<bool> _saveAllunits(List<DbUnitsPviot> products) async {
//     try {
//       var db = new unitsProvider();
//       await db.open();
//       await db.insertAll(products);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<bool> _saveAllPFoodCatIntoSqlite(List<DbFoodCat> products) async {
//     try {
//       var db = new foodCatProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future<bool> _saveAllFoodIntoSqlite(List<DbFood> products) async {
//     try {
//       var db = new foodProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future<bool> _saveAllActCatIntoSqlite(List<DbActivityCat> products) async {
//     try {
//       var db = new ActCatProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future<bool> _saveAllNoticsIntoSqlite(List<notices> products) async {
//     try {
//       var db = new noticsProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future<bool> _saveAllActIntoSqlite(List<DbActivities> products) async {
//     try {
//
//       var db = new ActivityProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<bool> _saveAllcereals(List<cereals> products) async {
//     try {
//       var db = new cerealsProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future<bool> _saveAllfruits(List<fruits> products) async {
//     try {
//       var db = new fruitsProvider();
//       await db.open();
//       await db.insertAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   List<DbUnitsPviot> setUtils(List<DbFood> foods) {
//     List<DbUnit> _units = [];
//     DbUnit f;
//     for (int i = 0; i < foods.length; i++) {
//       foods[i].units.forEach((item) {
//         _units.add(DbUnit.fromJson(item));
//       });
//     }
//
//
//     List<DbUnitsPviot> _unitpiotList = [];
//     _units.forEach((item) {
//       var map = {
//         'name_fa': item.name_fa,
//         'name_ar': item.name_ar,
//         'name_en': item.name_en,
//         'food_id': item.pivot['food_id'],
//         'factor': item.pivot['factor'],
//       };
//
//       _unitpiotList.add(DbUnitsPviot.fromJson(map));
//     });
//
//     return _unitpiotList;
//   }
//
//
//   Future getUser(BuildContext context) async {
//     print('USErrR');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{
//       final response = await Provider.of<apiServices>(context, listen: false)
//           .getUserInfo(
//           'Bearer '+apiToken);
//       if (response.statusCode == 200) {
// //      print('${response.bodyString}SSSSSSSSSSSSSSSSSSSSSSSS');
//         final post = json.decode(response.bodyString);
//         print(post);
//         List<User> users=[];
//         users.add(User.fromJson(post['success']));
//         print(users[0].toMap().toString()+"fromjson");
//         setState(() {
//           users[0].birthdate=="0"?user=true:user=false;
//         });
//
//
// ///////////////////////////////////////////////
//         List usersList= post['children'];
//         usersList.forEach((item){
//           users.add(User.fromJson(item));
//           print(item.toString());
//         });
//
//         User userr;
//         if(  (users[0].birthdate!="0") && calculateAge(users[0].birthdate)>=3) {
//           print( calculateAge(users[0].birthdate).toString()+"birthdate");
//           userr=calculateCalory( users[0]);
//           users[0].calorie =  userr.calorie ;
//           users[0].ideal_weight = userr.ideal_weight;
//           users[0].period_weight = userr.period_weight;
//           users[0].recommended_weight = userr.recommended_weight;
//
//         }
//         print(await _saveAllUser(users));
//         _userSave=users[0];
//
// //////////////////////////////////////
//
// //      print("mappppppppppppppp");
//
//         return true;
//
//       } else {
//         print(response.statusCode.toString());
//         setState(() {
//           _isLoading = false;
//         });
//
//         shoeSnackBar();
//         return false;
//       }
//     }catch(e){
//       print(e.toString());
//       return false;
//
//     }
//   }
//   static Future _saveAllUser(List<User> products) async {
//     print(products[0].toMap().toString()+"fg");
//
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.insertAll(products));
// //      await db.close();
//       return true;
//     } catch (e) {
//
//       return e.toString();
//     }
//   }
//   push(context) {
//     user
//         ?  Navigator.pushReplacementNamed(context, '/userInfo')
//         : Navigator.pushReplacementNamed(context, '/main');
//
//   }
//   Future <bool> getProductss(BuildContext context) async {
//     print('diet');
//     print('allDiets'+allDiets.length.toString());
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken = prefs.getString('user_token');
//     try{final response = await Provider.of<apiServices>(context, listen: false)
//         .getUserInfoDiet(
//         "1",
//         'Bearer ' + apiToken);
//     print(response.bodyString);
//     if (response.statusCode == 200) {
//       final post = json.decode(response.bodyString);
//
//       List ListPost = post;
//
//       if (ListPost != null && !ListPost.isEmpty) {
//         print("vaaa");
//         print(allDiets.length);
//         ListPost.forEach((item) {
//           print(diets.fromJson(item).toMap());
//           print(allDiets.length);
//           allDiets.add(diets.fromJson(item));
//         });
//
//         List nameb = [];
//         List units = [];
//         List values = [];
//         List allBreakFast = [];
//         List alldinner = [];
//         List alllunch = [];
//         List allsnacks = [];
//
// //        _GrowableList<dynamic>
//         for (int index = 0; index < allDiets.length; index++) {
//
//
//           print("is detaile$index"+allDiets[index].detail.toString());
//           print(allDiets[index].detail.toString()=="");
//           print(allDiets[index].detail.runtimeType.toString());
//           bool _condi=true;
//           if(allDiets[index].detail.runtimeType.toString()=="List<dynamic>") {
//             List<dynamic> _ll=allDiets[index].detail;
//             if (_ll.isEmpty)
//               _condi=false;
//           }
//           if(allDiets[index].detail.toString()=="")      _condi=false;
//
//           if(allDiets[index].detail.toString()==null)      _condi=false;
//
//
//           if(_condi){
//
//             if(allDiets[index].regimName=="pregnancy"){
//               print(allDiets[index].regimName);
//               User _user=await searchuser(allDiets[index].userInfo["uid"]);
//               print(_user.toMap().toString()+"pregnancy");
//               _user.prev_weight=allDiets[index].userInfo["prev_weight"];
//               _user.week=allDiets[index].userInfo["week"];
//               print(_user.toMap().toString()+"pregnancy");
//               await updateDb(_user);
//
//             }
//
//
//             if(allDiets[index].regimName.contains("children")&&allDiets[index].regimName!="children2-3"&&allDiets[index].regimName!="children3-12") {
//
//               List <dynamic>ListPost =allDiets[index].detail;
//               var ListUser = allDiets[index].userInfo;
//               DietChild dietChild;
//               User user;
//
//               ListPost.forEach((item) {
//                 dietChild = DietChild.fromJson(item);
//               });
//               user = User.fromJson(ListUser);
//               print(post);
//               print(dietChild);
//               print(allDiets[index].regimName);
//               print(allDiets[index].detail);
// //            print(user);
//               print('sf');
//
//               if (post == null || post.isEmpty) {
//                 print('sf');
//               }
//
//
//               var diet = {
//                 'id':allDiets[index].id,
//                 'day': 0,
// //              'type': "children",
//                 'type': dietChild.type,
//                 'Date':  intl.DateFormat('yyyy-MM-dd').format(
//                     (DateTime.parse(allDiets[index].created_at))),
//                 'user_id':  allDiets[index].userInfo["uid"].toString(),
//                 'name': allDiets[index].userInfo["name"].toString(),
//                 'me': dateCall.getMe(),
//
//               };
//               print(diet.runtimeType.toString());
//               DbAllDiets allDiet = DbAllDiets.fromJson(diet);
//               int id = await _saveAllDiets(allDiet);
//
//
//               var dietdaily = {
//                 'id_allDiet': id,
//                 'breakfast': dietChild.advertise,
//                 'lunch': dietChild.details,
//                 'dinner': dietChild.type,
//                 'snack': dietChild.type2,
//                 'day': 0,
//               };
//
//
//               DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
//               print(dietdaily);
//               print(await _saveDilyDiets(dailyDiet));
//             }
//             else{
//               String name=allDiets[index].regimName;
// //            if(allDiets[index].regimName=="children2-3"||allDiets[index].regimName=="children3-12")
// //              name="children";
//               print(ListPost[index]["ghol"].toString()+"gooooooool");
//               print(ListPost[index]["ghol"].runtimeType.toString()+"gooooooool");
//               List allamount = allDiets[index].detail['breakfasts'];
//               int id = 0;
//               var diet = {
//                 'id':allDiets[index].id,
//                 'day': allamount.length,
//                 'type':name,
//                 'Date': intl.DateFormat('yyyy-MM-dd').format(
//                     (DateTime.parse(allDiets[index].created_at))),
//                 'user_id': allDiets[index].userInfo["uid"].toString(),
//                 'name': allDiets[index].userInfo["name"].toString(),
//                 'advertice': ListPost[index]["advertise"],
//                 'ghol': ListPost[index]["ghol"].toString(),
//                 'me': dateCall.getMe(),
//               };
//
// //        print(diet.runtimeType.toString());
//               DbAllDiets allDiet = DbAllDiets.fromJson(diet);
//               id = await _saveAllDiets(allDiet);
//
//               DateTime now=DateTime.now();
//               DateTime regimdate=DateTime.parse( intl.DateFormat('yyyy-MM-dd').format((DateTime.parse(allDiets[index].created_at))));
//               regimdate= new DateTime(regimdate.year,regimdate.month,regimdate.day+allamount.length,regimdate.hour,regimdate.minute,regimdate.second);
//
//               if(regimdate.difference(now).inSeconds>0)
//                 clicksave(dietNameSelector(allDiets[index].regimName.toString())+"%"+allDiets[index].userInfo["name"].toString(), allamount.length, intl.DateFormat('yyyy-MM-dd').format(
//                     (DateTime.parse(allDiets[index].created_at))));
// //        print(id.toString()+"iddddddddddddddadddddddddd");
//
//               for (int i = 0; i < allamount.length; i++) {
//                 allBreakFast = [];
//                 alldinner = [];
//                 alllunch = [];
//                 allsnacks = [];
//
//
//                 List breakFast = allDiets[index].detail['breakfasts'];
//                 values = [];
//                 units = (breakFast[i]["details"]);
// //          print("${units.length}${"kkk"}");
//                 for (int y = 0; y < units.length; y++)
//                   values.add({"value": breakFast[i]["details"][y]["value"],
//                     "name": breakFast[i]["details"][y]["detail"]["name"],
//                     "units": breakFast[i]["details"][y]["detail"]["unit"]
//                   });
//
//
//                 allBreakFast.add(jsonEncode({"id":breakFast[i]["id"],"name": breakFast[i]["title"]["name"], "value": values}));
//
//
//                 List Lunch = allDiets[index].detail['launches'];
//
//                 values = [];
//                 nameb.add(Lunch[i]["title"]["name"]);
//                 units = (Lunch[i]["details"]);
//
//                 for (int y = 0; y < units.length; y++)
//                   values.add({
//                     "value": Lunch[i]["details"][y]["value"],
//                     "name": Lunch[i]["details"][y]["detail"]["name"],
//                     "units": Lunch[i]["details"][y]["detail"]["unit"]
//                   });
//
//
//                 alllunch.add(jsonEncode({"id":Lunch[i]["id"],"name": Lunch[i]["title"]["name"],
//                   "value": values
//                 }));
//
//                 List dinners = allDiets[index].detail['dinners'];
//                 values = [];
//                 nameb.add(dinners[i]["title"]["name"]);
//                 units = (dinners[i]["details"]);
// //          print("${units.length}${"kkk"}");
//                 for (int y = 0; y < units.length; y++)
//                   values.add({"value": dinners[i]["details"][y]["value"],
//                     "name": dinners[i]["details"][y]["detail"]["name"],
//                     "units": dinners[i]["details"][y]["detail"]["unit"]
//                   });
//
//
//                 alldinner.add(jsonEncode({"id":dinners[i]["id"],"name": dinners[i]["title"]["name"],
//                   "value": values}
//                 ));
//
//
//                 List smacks = allDiets[index].detail['snacks'];
//
//                 values = [];
//                 nameb.add(smacks[i]["title"]["name"]);
//                 units = (smacks[i]["details"]);
// //          print("${units.length}${"kkk"}");
//                 for (int y = 0; y < units.length; y++)
//                   values.add(jsonEncode({"value": smacks[i]["details"][y]["value"],
//                     "name": smacks[i]["details"][y]["detail"]["name"],
//                     "units": smacks[i]["details"][y]["detail"]["unit"]
//                   }));
//
//                 allsnacks.add(jsonEncode({"id":smacks[i]["id"],"name": smacks[i]["title"]["name"],
//                   "value": values
//                 }));
//
//
//                 var dietdaily = {
//                   'id_allDiet': id,
//                   'breakfast': allBreakFast[0],
//                   'lunch': alllunch[0],
//                   'dinner': alldinner[0],
//                   'snack': allsnacks[0],
//                   'day': i + 1,
//                 };
//
//                 DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
// //            print(dietdaily);
//                 await _saveDilyDiets(dailyDiet);
//               }
//             }
//
//           }}}
//       return true;
//
//     }
//     else {
//
//       print(response.statusCode.toString() + "ddd");
//       return false;
//     }
//     }
//     catch(e){
//       setState(() {
//         _isLoading = false;
//       });
//       print(e);
//       shoeSnackBar();
//       return false;
//     }
//
//   }
//   static Future<User> updateDb(User user) async {
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.update(user));
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//   static Future<User> searchuser(String uid) async {
//     try {
//       User user;
//       var db = new userProvider();
//       await db.open();
//       user=await db.getbyid(uid);
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrruser");
//       return null;
//     }
//   }
//   static Future<int> _saveAllDiets(DbAllDiets diets) async {
//     try {
//       var db = new allDietProvider();
//       await db.open();
//       DbAllDiets id= await db.insert(diets);
// //      await db.close();
//       return id.id;
//     } catch (e) {
//       return 0;
//     }
//   }
//   static Future<bool> _saveDilyDiets(DbDailyDiet diets) async {
//     try {
//       var db = new DailyDietProvider();
//       await db.open();
//       await db.insert(diets);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   static storeUserData(String status) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('get_info', status);
//     await prefs.setString('coach', "0#0#0#0#0#0#0#0");
//
//     print('saved!');
//   }
//   shoeSnackBar() async {
//
//
//     if(snack){
//       setState(() {
//         snack=false;
//       });
//       _scaffoldKey.currentState.showSnackBar(
//           new SnackBar(
//               duration: new Duration(hours: 2),
//               backgroundColor: MyColors.vazn,
//               behavior: SnackBarBehavior.floating,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//
//               content: new GestureDetector(
//                 onTap: () async {
//                   if (await checkConnectionInternet()) {
//                     _scaffoldKey.currentState.hideCurrentSnackBar();
//                     setState(() {
//                       snack=true;
//                     });
//                     allDiets=[];
//                     getProducts();
//                   }
//                   else {
//                   }
//                 },
//                 child: new Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         new Icon(Icons.signal_wifi_off , color: Colors.white,size: 18,),
//                         Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:  new Text('خطا اتصال به اینترنت', style: TextStyle(
//                             fontSize:12*fontvar,fontFamily: "iransansDN"
//                         ),),)
//                       ],
//                     ),
//
//                     new Text('تلاش مجدد', style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         fontSize:12*fontvar
//                     )),
//
//                   ],
//                 ),
//               )
//           )
//       );}
//   }
//   User calculateCalory(User _user) {
//
//     int activity1 = int.parse(_user.activity);
//     int appetite1 = int.parse(_user.appetite);
//     String weight1 = _user.weight;
//     String height1 = _user.height;
//     int age1 = calculateAge(_user.birthdate);
//     String gender1 = _user.gender.toString();
//
//     double height_meter = double.parse(height1) / 100;
//     double BMR =
//         10 * double.parse(weight1) + 6.25 * double.parse(height1) - 5 * age1;
//     if (gender1 == 'male') {
//       BMR = BMR + 5;
//     } else {
//       BMR = BMR - 161;
//     }
//     double res = BMR;
//     if (activity1 == 1) {
//       res *= 1.2;
//     } else if (activity1 == 2) {
//       res *= 1.375;
//     } else if (activity1 == 3) {
//       res *= 1.55;
//     } else if (activity1 == 4) {
//       res *= 1.725;
//     } else if (activity1 == 5) {
//       res *= 1.9;
//     }
//
//     if (appetite1 == 1) {
//       res *= 0.95;
//     } else if (appetite1 == 2) {
//       res *= 0.975;
//     } else if (appetite1 == 3) {
//       res *= 1;
//     } else if (appetite1 == 4) {
//       res *= 1.025;
//     } else if (appetite1 == 5) {
//       res *= 1.05;
//     }
//
//     double ideal_weight = 22.5 * height_meter * height_meter;
//     String min_period = (20 * height_meter * height_meter).toStringAsFixed(1);
//     String max_period = (25 * height_meter * height_meter).toStringAsFixed(1);
//     double diff_weights = double.parse(weight1) - ideal_weight;
//     if (diff_weights < 0) {
//       diff_weights = diff_weights * -1;
//     }
//     double recommended_weight = ideal_weight + (0.2 * diff_weights);
//     if(_user.gcalorie!=null) res=res+_user.gcalorie;
//     if(res<600)res=600;
//
//     _user.calorie = res.floor();
//     _user.ideal_weight = ideal_weight.round();
//     _user.period_weight = "$min_period - $max_period";
//     _user.recommended_weight = recommended_weight.round();
//
//     return _user;
//
//   }
//   getUsersq() async {
//     var response = await _getUsersq();
//
//     if (this.mounted) {
//       _usertest = response;
//     }
//     return _usertest==null
//         ?false
//         :true;
//   }
//   static Future<User> _getUsersq() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user = await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr_getUsersq");
//       return null;
//     }
//   }
//
//   Future<bool> _updateAllfruits(List<fruits> products) async {
//
//
//     for(int i=0;i<products.length;i++) {
//       print(products[i].cover);
//       var response = await get(products[i].cover);
//       String imgString = Utility.base64String(response.bodyBytes);
//       products[i].cover = imgString;
//     }
//
//
//     try {
//
//       var db = new fruitsProvider();
//       await db.open();
//       await db.updateAll(products);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<void> clicksave(String title,int day, String formatdate) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     DateTime datenow=DateTime.parse(formatdate);
//     String stringTimesalarm=( prefs.getString('alarmtimeTamdid'));
//     List<DateTime> timealarmTamdid = new List<DateTime>();
//     print(stringTimesalarm);
//     if (stringTimesalarm != null && stringTimesalarm !="") {
//       List<String> timesSplit = stringTimesalarm.split("#");
//       timesSplit.forEach((item) {
//         print(item);
//         List<String> timesSplit2 = item.split(",");
//         timealarmTamdid.add(
//             new DateTime(int.parse(timesSplit2[0]),int.parse(timesSplit2[1]),int.parse(timesSplit2[2]),int.parse(timesSplit2[3]),int.parse(timesSplit2[4]),int.parse(timesSplit2[5])));
//       });
//     }
//     timealarmTamdid.add(new DateTime(datenow.year,datenow.month,datenow.day+day,datenow.hour,datenow.minute,datenow.second));
//
//     List<String> timesTamdid = [];
//     timesTamdid = new List<String>();
//     String stringTimes = await prefs.getString('alarmTamdid');
//     if (stringTimes != null && stringTimes!="") {
//       List<String> timesSplit = stringTimes.split(",");
//       timesTamdid.addAll(timesSplit);}
//     timesTamdid.add(title);
//     await prefs.setString("userName",_userSave.name);
//     await setAlarm(timesTamdid: timesTamdid,timealarmTamdid: timealarmTamdid,timealarm: null,times: null,nameUser: _userSave.name);}
//
//   Future<void> getVesion() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     _version = packageInfo.version;
//   }
//
// }
//
//
//
