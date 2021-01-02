import 'dart:convert';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/models/DbDailyDiet.dart';
import 'package:barika_web/models/DietChild.dart';
import 'package:barika_web/models/diets.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/regims/regimList.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:barika_web/utils/date.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class questionnaire extends StatefulWidget {
  String uid;
  User id;
  String type;
  String type2;
  String name;
  String metype;
  int logId;
  String  dietId;

  questionnaire(
      {Key key,
        this.uid,
        this.type,
        this.type2,
        this.name,
        this.id,
        this.logId,
        this.dietId,
        this.metype})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => questionnaireState();
}

class questionnaireState extends State<questionnaire> {
  User _user;
  bool _isLoading = true;
  bool _isError = false;
  bool _isCondError = false;

  Widget loadingView() {
    return new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCircle(
              color: MyColors.vazn,
            ),
            Text("درحال دریافت اطلاعات لطفا منتظر بمانید")
          ],
        ));
  }

  List<diets> allDiets = [];
  DbDailyDiet _DbDailyDiett;
  DbAllDiets _DbAllDiet;
  List<DbDailyDiet> _DbDailyDietList = [];
  var _breakfast;
  var _lunch;
  var _dinner;
  var _snack;
  int day = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String uid;
  String type;
  String type2;

  void initState() {
    print("prrrrrint"
        "");
    super.initState();
    print(
      widget.metype,
    ); print(
      widget.dietId,
    );
    _user = widget.id;
    print(_user.toMap());
    print("inquestiaoner");
    uid = widget.uid;
    type = widget.type;
    type2 = widget.type2;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.dietId == null ? await getProductss2() : await getProductss();
    });

  }

  Future<bool> _willPopCallback() async {
    Navigator.popUntil(
      context,
      ModalRoute.withName(
        '/main',
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: regimList(
              type: widget.metype,
              resume: true,
              user: _user.gender,
            )),
      ),
    );
  }

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return  WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xffF5FAF2),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 85,
            title: Text(
              'دریافت رژیم ',
              style: TextStyle(
                  fontSize: 14*fontvar,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            actions: <Widget>[
//            IconButton(
//              icon: Icon(
//                Icons.chevron_right,
//                size: 32,
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              alignment: Alignment.topLeft,
//              color: Colors.white,
//              splashColor: Colors.amber,
//              padding: EdgeInsets.all(7),
//            ),
            ],
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: MyColors.green
              ),
            ),
          ),
          body: _isLoading
              ? loadingView()
              : _isError
              ?_isCondError
              ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,

                    size:  132*(screenSize.width)/375,
                    color: Colors.red,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 15),
                      child: Text(
                        'خطای دریافت',
                        style: TextStyle(
                            fontSize: 16*fontvar, fontWeight: FontWeight.w500),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//            Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//              child:SizedBox(
//              height: 40,
//              width: 110,
//              child: RaisedButton(
//                onPressed: () {
//
//                  Navigator.of(context)
//                      .popUntil(ModalRoute.withName("/Page1",));
//                },
//                color: Color(0xffF15A23),
//                shape: RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(8.0),
//                ),
//                child: Text(
//                  'مشاهده رژیم ها',
//                  style:
//                  TextStyle(color: Colors.white, fontSize: 12),
//                ),
//                padding: EdgeInsets.all(0),
//                elevation: 10,
//              ),
//            ),),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: SizedBox(
                          height: 40*(screenSize.width)/375,
                          width: 110*(screenSize.width)/375,
                          child: RaisedButton(
                            onPressed: () {
//                              type2 == null
//                                  ? getProductss()
//                                  : getProductss2();
                            },
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'با پشتیبانی تماس بگیرید.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12*fontvar),
                            ),
                            padding: EdgeInsets.all(1),
                            elevation: 10,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))
              : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    size:  132*(screenSize.width)/375,
                    color: Colors.red,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 15),
                      child: Text(
                        'خطای دسترسی',
                        style: TextStyle(
                            fontSize: 16*fontvar, fontWeight: FontWeight.w500),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//            Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//              child:SizedBox(
//              height: 40,
//              width: 110,
//              child: RaisedButton(
//                onPressed: () {
//
//                  Navigator.of(context)
//                      .popUntil(ModalRoute.withName("/Page1",));
//                },
//                color: Color(0xffF15A23),
//                shape: RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(8.0),
//                ),
//                child: Text(
//                  'مشاهده رژیم ها',
//                  style:
//                  TextStyle(color: Colors.white, fontSize: 12),
//                ),
//                padding: EdgeInsets.all(0),
//                elevation: 10,
//              ),
//            ),),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: SizedBox(
                          height: 40*(screenSize.width)/375,
                          width: 110*(screenSize.width)/375,
                          child: RaisedButton(
                            onPressed: () async {
                              type2 == null
                                  ? await getProductss()
                                  : await getProductss2();
                            },
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'تلاش مجدد',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12*fontvar),
                            ),
                            padding: EdgeInsets.all(1),
                            elevation: 10,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))

              : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size:  132*(screenSize.width)/375,
                    color: Color(0xff6DC07B),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 15),
                    child: Text(
                      'جهت مشاهده رژیم به بخش رژیم های من در قسمت منو مراجعه کنید.',
                      style: TextStyle(
                          fontSize: 16*fontvar, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//            Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//              child:SizedBox(
//              height: 40,
//              width: 110,
//              child: RaisedButton(
//                onPressed: () {
//
//                  Navigator.of(context)
//                      .popUntil(ModalRoute.withName("/Page1",));
//                },
//                color: Color(0xffF15A23),
//                shape: RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(8.0),
//                ),
//                child: Text(
//                  'مشاهده رژیم ها',
//                  style:
//                  TextStyle(color: Colors.white, fontSize: 12),
//                ),
//                padding: EdgeInsets.all(0),
//                elevation: 10,
//              ),
//            ),),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: SizedBox(
                          height: 40*(screenSize.width)/375,
                          width: 110*(screenSize.width)/375,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName("/main"));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: regimList(
                                        type: widget.metype,
                                        resume: true,
                                        user: _user.gender,
                                      )),
                                ),
                              );
                            },
                            color: Color(0xff6DC07B),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'مشاهده رژیم ها',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12*fontvar),
                            ),
                            padding: EdgeInsets.all(1),
                            elevation: 10,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
        onWillPop: _willPopCallback);
  }

//  Future<Map> getProductss() async {
//    print("isGetProductss");
//    setState(() {
//      _isLoading = true;
//      _isError = false;
//    });
//    print('diet');
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String apiToken = prefs.getString('user_token');
////    try {
//      final response = await Provider.of<apiServices>(context, listen: false)
//        .getUserInfoDiet("0", 'Bearer ' + apiToken);
//
//
//      if (response.statusCode == 200) {
//        final post = json.decode(response.bodyString);
//        print(post.toString() + "pooooooooost");
//        List ListPost = post;
//        print(ListPost.isEmpty);
//        print(ListPost);
//        if (ListPost == null || ListPost.isEmpty) {
//          print('sf');
//          showSnackBar();
//        } else {
//          ListPost.forEach((item) {
//            print(item.runtimeType.toString() + "ruuuuuuuuuuuuuuuuuuun");
//            allDiets.add(diets.fromJson(item));
//          });
//
//          List nameb = [];
//          List units = [];
//          List values = [];
//          List allBreakFast = [];
//          List alldinner = [];
//          List alllunch = [];
//          List allsnacks = [];
//
//          if (widget.name == "pregnancy") {
//            print(allDiets[0].userInfo["prev_weight"] + "f,lsedfsef");
//            print(allDiets[0].userInfo["week"]);
//            _user.prev_weight = allDiets[0].userInfo["prev_weight"];
//            _user.week = allDiets[0].userInfo["week"];
//            await updateDb(_user);
//          }
//
//          for (int index = 0; index < allDiets.length; index++) {
//            bool _condi = true;
//            print(allDiets[index].detail);
//            print(allDiets[index].detail.runtimeType);
//            if (allDiets[index].detail.runtimeType.toString() ==
//                "List<dynamic>") {
//              List<dynamic> _ll = allDiets[index].detail;
//              if (_ll.isEmpty){ _condi = false;_isCondError=true;}
//            }
//            if(allDiets[index].detail.toString()=="")      _condi=false;
//            if(allDiets[index].detail.toString()==null)      _condi=false;
//
//            if (_condi) {
//              print("allDietsindex" + index.toString());
//              List allamount = allDiets[index].detail['breakfasts'];
//              int id = 0;
//
//              var diet = {
//                'id':allDiets[index].id,
//                'day': allamount.length,
//                'type': allDiets[index].regimName.toString(),
//                'Date': intl.DateFormat('yyyy-MM-dd')
//                    .format((DateTime.parse(allDiets[index].created_at))),
//                'user_id': allDiets[index].userInfo["uid"].toString(),
//                'name': allDiets[index].userInfo["name"].toString(),
//                'advertice': ListPost[index]["advertise"],
//              };
////        print(diet.runtimeType.toString());
//              DbAllDiets allDiet = DbAllDiets.fromJson(diet);
//              id = await _saveAllDiets(allDiet);
////        print(id.toString()+"iddddddddddddddadddddddddd");
//
//              for (int i = 0; i < allamount.length; i++) {
//                allBreakFast = [];
//                alldinner = [];
//                alllunch = [];
//                allsnacks = [];
//
//                List breakFast = allDiets[index].detail['breakfasts'];
//                values = [];
//                units = (breakFast[i]["details"]);
////          print("${units.length}${"kkk"}");
//                for (int y = 0; y < units.length; y++)
//                  values.add({
//                    "value": breakFast[i]["details"][y]["value"],
//                    "name": breakFast[i]["details"][y]["detail"]["name"],
//                    "units": breakFast[i]["details"][y]["detail"]["unit"]
//                  });
//
//                allBreakFast.add(jsonEncode(
//                    {"name": breakFast[i]["title"]["name"], "value": values}));
//                print(
//                    allBreakFast[0].runtimeType.toString() + "000000000000000");
//
//                List Lunch = allDiets[index].detail['launches'];
//
//                values = [];
//                nameb.add(Lunch[i]["title"]["name"]);
//                units = (Lunch[i]["details"]);
//                print("${units.length}${"kkk"}");
//                for (int y = 0; y < units.length; y++)
//                  values.add({
//                    "value": Lunch[i]["details"][y]["value"],
//                    "name": Lunch[i]["details"][y]["detail"]["name"],
//                    "units": Lunch[i]["details"][y]["detail"]["unit"]
//                  });
//
//                alllunch.add(jsonEncode(
//                    {"name": Lunch[i]["title"]["name"], "value": values}));
//
//                List dinners = allDiets[index].detail['dinners'];
//                values = [];
//                nameb.add(dinners[i]["title"]["name"]);
//                units = (dinners[i]["details"]);
////          print("${units.length}${"kkk"}");
//                for (int y = 0; y < units.length; y++)
//                  values.add({
//                    "value": dinners[i]["details"][y]["value"],
//                    "name": dinners[i]["details"][y]["detail"]["name"],
//                    "units": dinners[i]["details"][y]["detail"]["unit"]
//                  });
//
//                alldinner.add(jsonEncode(
//                    {"name": dinners[i]["title"]["name"], "value": values}));
//
//                List smacks = allDiets[index].detail['snacks'];
//
//                values = [];
//                nameb.add(smacks[i]["title"]["name"]);
//                units = (smacks[i]["details"]);
////          print("${units.length}${"kkk"}");
//                for (int y = 0; y < units.length; y++)
//                  values.add(jsonEncode({
//                    "value": smacks[i]["details"][y]["value"],
//                    "name": smacks[i]["details"][y]["detail"]["name"],
//                    "units": smacks[i]["details"][y]["detail"]["unit"]
//                  }));
//
//                allsnacks.add(jsonEncode(
//                    {"name": smacks[i]["title"]["name"], "value": values}));
//
//                var dietdaily = {
//                  'id_allDiet': id,
//                  'breakfast': allBreakFast[0],
//                  'lunch': alllunch[0],
//                  'dinner': alldinner[0],
//                  'snack': allsnacks[0],
//                  'day': i + 1,
//                };
//
//                DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
//                print(dietdaily);
//                print(await _saveDilyDiets(dailyDiet));
//              }
//            } else {
//              showSnackBar();
//              print("isGetProductssCatcheeee");
//              print(response.statusCode.toString());
//            }
//          }
//        }
//        if (mounted) {
//          setState(() {
//            _isLoading = false;
//          });
//        }
//        return {"albums": diets};
//      } else {
//        showSnackBar();
//        print("isGetProductssCatcheeee");
//        print(response.statusCode.toString());
//      }
////    } catch (e) {
////      print("isGetProductssCatch$e");
////      showSnackBar();
////    }
//  }
  Future<Map> getProductss() async {
    print("isGetProductss");
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    print('diet');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
//    try {
    final response = await Provider.of<apiServices>(context, listen: false)
        .getDietFind(widget.dietId, 'Bearer ' + apiToken);

    if (response.statusCode == 200) {
      final post = json.decode(response.bodyString);

//        List ListPost = post;
//        print(ListPost.isEmpty);
//        print(ListPost);
//        if (ListPost == null || ListPost.isEmpty) {
      if (post==""||post=="{}") {
        print('sf');
        showSnackBar();
      } else {
//          ListPost.forEach((item) {
//            print(item.runtimeType.toString() + "ruuuuuuuuuuuuuuuuuuun");
//            allDiets.add(diets.fromJson(item));
//          });

        allDiets.add(diets.fromJson(post));



//          if (widget.name == "pregnancy") {
//
//            setState(() {
//              _isLoading = false;
//          _user.prev_weight = allDiets[0].userInfo["prev_weight"];
//            _user.week = allDiets[0].userInfo["week"];
//            });
//            _user.id==null
//               ?await updateDbByUid(_user)
//               : await updateDb(_user);
//          }
//

        for (int index = 0; index < allDiets.length; index++) {
          bool _condi = true;
          print(allDiets[index].detail);
          print(allDiets[index].detail.runtimeType);
          if (allDiets[index].detail.runtimeType.toString() ==
              "List<dynamic>") {
            List<dynamic> _ll = allDiets[index].detail;
            if (_ll.isEmpty){ _condi = false;_isCondError=true;}
          }
          if(allDiets[index].detail.toString()=="")      _condi=false;
          if(allDiets[index].detail.toString()==null)      _condi=false;

          if (_condi) {


            if(allDiets[index].regimName=="pregnancy"){
              // User user=await searchuser(allDiets[index].userInfo["uid"]);
              // user.prev_weight=allDiets[index].userInfo["prev_weight"];
              // user.week=allDiets[index].userInfo["week"];
              // user.id==null
              //     ?await updateDbByUid(user)
              //     : await updateDb(user);

            }

            print(post["extended_id"]);
            print("allDiets[index].extended_id");

            print("allDietsindex" + index.toString());
            List allamount = allDiets[index].detail['breakfasts'];

            String daysStr=allDiets[index].detail['days']==null?allamount.length.toString():allDiets[index].detail['days'].toString();
            int id = 0;

            var diet = {
              'id':allDiets[index].id,
              'day':int.parse(daysStr),
              'type': allDiets[index].regimName.toString(),
              'Date': intl.DateFormat('yyyy-MM-dd')
                  .format((DateTime.parse(allDiets[index].created_at))),
              'user_id': allDiets[index].userInfo["uid"].toString(),
              'name': allDiets[index].userInfo["name"].toString(),
              'advertice': post["advertise"],
              'extended_id': post["extended_id"],
              'ghol': post["ghol"].toString(),
              'me': dateCall.getMe(),
            };
//        print(diet.runtimeType.toString());
            DbAllDiets allDiet = DbAllDiets.fromJson(diet);
            // id = await _saveAllDiets(allDiet);

//        print(id.toString()+"iddddddddddddddadddddddddd");


            List<DbDailyDiet> DbDailyDietList=[];
            DbDailyDietList=  await addtoDailyList(allamount,index,id);
            print("DbDailyDietList"+DbDailyDietList.length.toString());
           // print(await _saveAllDilyDiets(DbDailyDietList)) ;



            await clicksave(dietNameSelector(allDiets[index].regimName.toString())+"%"+allDiets[index].userInfo["name"].toString(),int.parse(daysStr));

          } else {
            showSnackBar();
            print("isGetProductssCatcheeee");
            print(response.statusCode.toString());
          }
        }
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      return {"albums": diets};
    } else {
      showSnackBar();
      print("isGetProductssCatcheeee");
      print(response.statusCode.toString());
    }
//    } catch (e) {
//      print("isGetProductssCatch$e");
//      showSnackBar();
//    }
  }

//   Future<int> _saveAllDiets(DbAllDiets diets) async {
//     try {
//       var db = new allDietProvider();
//       await db.open();
//       DbAllDiets id = await db.insert(diets);
// //      await db.close();
//       return id.id;
//     } catch (e) {
//       return 0;
//     }
//   }
//
//   Future<bool> _saveDilyDiets(DbDailyDiet diets) async {
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
//   Future<bool> _saveAllDilyDiets(List<DbDailyDiet> diets) async {
//     try {
//       var db = new DailyDietProvider();
//       await db.open();
//       await db.insertAll2(diets);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

  showSnackBar() {
    if(mounted) { setState(() {
      print("show_isError");
      _isLoading = false;
      _isError = true;
    });}

  }

  Future<void> getProductss2() async {
    print("isGetProductss2");
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    print(uid);
    print(type);
    print(type2);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try { final response = await Provider.of<apiServices>(context, listen: false)
        .getChildrenDiet(uid, type, type2,widget.logId ,'Bearer ' + apiToken);


    if (response.statusCode == 200) {
      final post = json.decode(response.bodyString);
      print(post.runtimeType.toString());
      List<dynamic> ListPost = post['diet'];
      var ListUser = post['user'];
      DietChild dietChild;
      User user;
      if (ListPost.isNotEmpty) {
        ListPost.forEach((item) {
          dietChild = DietChild.fromJson(item);
        });
        user = User.fromJson(ListUser);
        print(post);
        print(user);

        if (post == null || post.isEmpty) {
          print('sf');
          showSnackBar();
        }

        var diet = {
          'id':widget.logId,
          'day':  int.parse(dietChild.days),
          'type': "children",
          'type': dietChild.type,
          'Date': intl.DateFormat('yyyy-MM-dd')
              .format((DateTime.parse(post['date']['date']))),
          'user_id': uid,
          'name': user.name,
          'me': dateCall.getMe(),
          'extended_id':  post['extended_id'],
        };
        print(diet.runtimeType.toString());
        DbAllDiets allDiet = DbAllDiets.fromJson(diet);
        // int id = await _saveAllDiets(allDiet);

        await clicksave(dietNameSelector(dietChild.type.toString())+"%"+user.name.toString(), int.parse(dietChild.days));

        var dietdaily = {
          // 'id_allDiet': id,
          'id_allDiet': 5,
          'breakfast': dietChild.advertise,
          'lunch': dietChild.details,
          'dinner': dietChild.type,
          'snack': dietChild.type2,
          'day': 0,

        };

        DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
        print(dietdaily);
        // print(await _saveDilyDiets(dailyDiet));

        if (mounted) {
          setState(() {
            print(_isError.toString()+"_isError");
            _isLoading = false;
          });
        }
      }
      else{
        setState(() {
          _isCondError=true;
        });

        print("20_isError");
        showSnackBar();}
    }
    else{
      print("10_isError");
      showSnackBar();
      print(response.statusCode.toString());
      print(response.error.toString());}
    } catch (e) {
      print(e);
      showSnackBar();
    }
  }

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

//   Future<User> updateDbByUid(User user) async {
//
//     try {
//       var db = new userProvider();
//       await db.open();
//       print(await db.updateByUid2(user));
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }

  Future<List<DbDailyDiet>> addtoDailyList(List allamount,int index,int id) async{

    List<DbDailyDiet> DbDailyDietList=[];
    List nameb = [];
    List units = [];
    List values = [];
    List allBreakFast = [];
    List alldinner = [];
    List alllunch = [];
    List allsnacks = [];

    for (int i = 0; i < allamount.length; i++) {
      allBreakFast = [];
      alldinner = [];
      alllunch = [];
      allsnacks = [];

      List breakFast = allDiets[index].detail['breakfasts'];
      values = [];
      units = (breakFast[i]["details"]);
//          print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add({
          "value": breakFast[i]["details"][y]["value"],
          "name": breakFast[i]["details"][y]["detail"]["name"],
          "units": breakFast[i]["details"][y]["detail"]["unit"]
        });

      allBreakFast.add(jsonEncode(
          {"id":breakFast[i]["id"],"name": breakFast[i]["title"]["name"], "value": values}));


      List Lunch = allDiets[index].detail['launches'];

      values = [];
      nameb.add(Lunch[i]["title"]["name"]);
      units = (Lunch[i]["details"]);

      for (int y = 0; y < units.length; y++)
        values.add({
          "value": Lunch[i]["details"][y]["value"],
          "name": Lunch[i]["details"][y]["detail"]["name"],
          "units": Lunch[i]["details"][y]["detail"]["unit"]
        });

      alllunch.add(jsonEncode(
          {"id":Lunch[i]["id"],"name": Lunch[i]["title"]["name"], "value": values}));

      List dinners = allDiets[index].detail['dinners'];
      values = [];
      nameb.add(dinners[i]["title"]["name"]);
      units = (dinners[i]["details"]);
//          print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add({
          "value": dinners[i]["details"][y]["value"],
          "name": dinners[i]["details"][y]["detail"]["name"],
          "units": dinners[i]["details"][y]["detail"]["unit"]
        });

      alldinner.add(jsonEncode(
          {"id":dinners[i]["id"],"name": dinners[i]["title"]["name"], "value": values}));

      List smacks = allDiets[index].detail['snacks'];

      values = [];
      nameb.add(smacks[i]["title"]["name"]);
      units = (smacks[i]["details"]);
//          print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add(jsonEncode({
          "value": smacks[i]["details"][y]["value"],
          "name": smacks[i]["details"][y]["detail"]["name"],
          "units": smacks[i]["details"][y]["detail"]["unit"]
        }));

      allsnacks.add(jsonEncode(
          {"id":smacks[i]["id"],"name": smacks[i]["title"]["name"], "value": values}));

      var dietdaily = {
        'id_allDiet': id,
        'breakfast': allBreakFast[0],
        'lunch': alllunch[0],
        'dinner': alldinner[0],
        'snack': allsnacks[0],
        'day': i + 1,
      };

      DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
      DbDailyDietList.add(dailyDiet);

  }

    return DbDailyDietList;



  }


}

Future<void> clicksave(String title,int day) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime datenow=DateTime.now();
  String stringTimesalarm=( prefs.getString('alarmtimeTamdid'));
  List<DateTime> timealarmTamdid = new List<DateTime>();
  print(stringTimesalarm);
  if (stringTimesalarm != null && stringTimesalarm !="") {
    List<String> timesSplit = stringTimesalarm.split("#");
    timesSplit.forEach((item) {
      print(item);
      List<String> timesSplit2 = item.split(",");
      timealarmTamdid.add(
          new DateTime(int.parse(timesSplit2[0]),int.parse(timesSplit2[1]),int.parse(timesSplit2[2]),int.parse(timesSplit2[3]),int.parse(timesSplit2[4]),int.parse(timesSplit2[5])));
    });
  }
  timealarmTamdid.add(new DateTime(datenow.year,datenow.month,datenow.day+day-1,datenow.hour,datenow.minute,datenow.second));

  List<String> timesTamdid = [];
  timesTamdid = new List<String>();
  String stringTimes = await prefs.getString('alarmTamdid');
  if (stringTimes != null && stringTimes!="") {
    List<String> timesSplit = stringTimes.split(",");
    timesTamdid.addAll(timesSplit);}
  timesTamdid.add(title);
}
// Future<User> searchuser(String uid) async {
//   try {
//     User user;
//     var db = new userProvider();
//     await db.open();
//     user=await db.getbyid(uid);
// //    await db.close();
//     return user;
//   } catch (e) {
//     print(e.toString() + "errrrrorrrrruser");
//     return null;
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////

//setAlarm( List<String> times,List<Time> timealarm) async {
//  List<Time> alarmTime;
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//  var android = AndroidInitializationSettings('gg');
//  var ios = IOSInitializationSettings();
//  var initSettings = new InitializationSettings(android, ios);
//  flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);
//
//  activeAllAlarm(flutterLocalNotificationsPlugin,"یادآور", "تمدید رژیم",1,DateTime.now());
//  activeAllAlarm(flutterLocalNotificationsPlugin,"یادآور", "تمدید رژیم",2,DateTime(2020,04,17));
//
//}
//activeAllAlarm(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,String title,String description,int id,DateTime dateTime) async {
//
//  print("yani mishe dobare????????????");
//  var androidd = new AndroidNotificationDetails('Channel ID', 'Channel name', 'Channel Description');
//  var ioss = new IOSNotificationDetails();
//  var platform = new NotificationDetails(androidd, ioss);
//  await flutterLocalNotificationsPlugin.schedule(id, title, description, DateTime.now(), platform);
//
//
//
//}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//  _getAlbums() async {
//
//    var response = await getProducts(context);
//    print('${response.toString()}111111111111111');
//
//
//  }
