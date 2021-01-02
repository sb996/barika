import 'dart:convert';

import 'package:barika_web/services/apiServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';
class expiredDiet extends StatefulWidget {

  State<StatefulWidget> createState() => expiredDietState();
}

class expiredDietState extends State<expiredDiet> with WidgetsBindingObserver {




  // int day = 1;
  Color textColor = Color(0xff555555);
  List<DbAllDiets> _DbAllDietsList = [];
  bool _isLoading = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // String serverDate;

  Widget loadingView() {
    return  Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void initState() {
    getRegims();
    super.initState();
  }

  var fontvar = 1.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);


    return WillPopScope(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
              "رژیم های منقضی شده",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16 * fontvar,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: 32 ,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("ff");
                  },
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  splashColor: Colors.amber,
                  padding: EdgeInsets.all(7),
                ),
              ],
            ),
            body:  _isLoading
                        ? loadingView()
                        : Container(
                        child:
                        NotificationListener<
                            OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowGlow();
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                (_DbAllDietsList.length != 0)
                                    ? Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                        _DbAllDietsList.length,
                                        itemBuilder: (BuildContextcontext,
                                            int index) {


                                          return GestureDetector(
                                            child: Container(height: 110 *
                                                (screenSize.width) / 375,
                                                margin: EdgeInsets.only(
                                                    right: 10, left: 10),
                                                alignment: Alignment.center,
                                                child: Stack(children: <Widget>[
                                                  Card(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                    ),
                                                    child:
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Regims(
                                                            dietNameSelector(
                                                                _DbAllDietsList[index]
                                                                    .type),
                                                            dietIconSelector(
                                                                _DbAllDietsList[index]
                                                                    .type),
                                                            dietColorSelector(
                                                                _DbAllDietsList[index]
                                                                    .type), true),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: <Widget>[
                                                            Text(
                                                              "رژیم " +
                                                                  _DbAllDietsList[index]
                                                                      .name,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight
                                                                      .w500,
                                                                  fontSize: 13 *
                                                                      fontvar,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: new BorderRadius
                                                                    .circular(
                                                                    5.0),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 5),
                                                              child: Text(
                                                                "تاریخ شروع " +
                                                                    dateToJalali(
                                                                        _DbAllDietsList[index]
                                                                            .created_at,
                                                                        1),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    fontSize: 10 *
                                                                        fontvar,
                                                                    color: Color(
                                                                        0xff5C5C5C)),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            _DbAllDietsList[index]
                                                                .day != 0
                                                                ? Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: new BorderRadius
                                                                    .circular(
                                                                    5.0),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 1),
                                                              child: Text(
                                                                "تاریخ انقضاء " +
                                                                    dateToJalali(
                                                                        _DbAllDietsList[index]
                                                                            .created_at,
                                                                        _DbAllDietsList[index]
                                                                            .day),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    fontSize: 10 *
                                                                        fontvar,
                                                                    color: Color(
                                                                        0xff5C5C5C)),
                                                                maxLines: 1,
                                                              ),
                                                            )
                                                                : Container(),
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .end,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .end,
                                                              children: <
                                                                  Widget>[

                                                                    FittedBox(
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        bottom: 8,
                                                                        left: 8),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        vertical: 4,
                                                                        horizontal: 10),
                                                                    decoration: BoxDecoration(
                                                                        color:Color(0xffE30026),
                                                                        borderRadius: BorderRadius
                                                                            .all(
                                                                            Radius
                                                                                .circular(
                                                                                8))),

                                                                    child: Text(
                                                                      "منقضی شده",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize: 11 *
                                                                              fontvar,
                                                                          color: Colors
                                                                              .white),
                                                                      textAlign: TextAlign
                                                                          .center,
                                                                      textDirection: TextDirection
                                                                          .rtl,
                                                                    ),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                    elevation:
                                                    7,
                                                  )])));

                                        }))
                                    : Center(
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                            "assets/icons/delivery.png",
                                        fit: BoxFit.fill,),
                                        Padding(
                                          padding: EdgeInsets
                                              .symmetric(
                                              vertical: 20,
                                              horizontal: 18),
                                          child: Text(
                                            "رژیم منقضی شده ای وجود ندارد.",
                                            style: TextStyle(
                                                color: Color(
                                                    0xff5c5c5c),
                                                fontWeight:
                                                FontWeight
                                                    .w400,
                                                fontSize:
                                                16 * fontvar),
                                            textAlign:
                                            TextAlign.center,
                                          ),
                                        )
                                      ],
                                    )),

                              ],
                            )))
    ),
        onWillPop: () {
          Navigator.pop(context, 'ff');
        });
  }

  showSnakBar(String s) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Text(
        s,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15 * fontvar,
            fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }

  Widget Regims(String name, String image, Color color, bool ex) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);
    // if (ex) color = Color(0xffB7B3B7);
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Container(
                child: RawMaterialButton(
                  onPressed: () {},
                  child: Image.network(
                    image,
                    height: 26 * (screenSize.width) / 375,
                    width: 25 * (screenSize.width) / 375,
                    fit: BoxFit.fill,
                  ),
                  shape: CircleBorder(
                      side: BorderSide(
                          color: color, width: 8 * (screenSize.width) / 375)),
                  elevation: 0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  color: Colors.white,
                )),
            width: 60 * (screenSize.width) / 375,
            padding: EdgeInsets.all(2),
            height: 60 * (screenSize.width) / 375,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 9 * fontvar),
          )
        ],
      ),
    );
  }

  Future<List<DbAllDiets>> _getAllDiets(String apiToken) async {

    try {
      final response = await Provider.of<apiServices>(context, listen: false)
          .getExpiredDiet( 'Bearer ' + apiToken);

      print("response" + response.bodyString);
      final post = json.decode(response.bodyString);
      if (response.statusCode == 200 && post["result"]=="done") {
        try {

          List<DbAllDiets> alldietdb = [];
          List responsList= post["diets"];
          responsList.forEach((element) {
            var diet = {
              'id':element["id"],
              'day':DateTime.parse(element["finished_at"].toString()).difference(DateTime.parse(element["created_at"].toString())).inDays,
              'type': element["type"],
              'created_at': intl.DateFormat('yyyy-MM-dd').format((DateTime.parse( element["created_at"]))),
              'name': element["user_information"]["name"].toString(),
            };

            alldietdb.add( DbAllDiets.fromJson(diet));
          });

          return alldietdb;

        }catch(e){
          print(e.toString());
        }
      } else {
        showSnakBar("حطا در اتصال به اینترنت");
        return null;

      }
    } catch (e) {
      print(e.toString() + "catttttch");
      showSnakBar("حطا در اتصال به اینترنت");
      return null;
    }
  }

  Future getRegims() async {
    List<DbAllDiets> alldietdb = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // serverDate = prefs.getString("date") ?? getDateToday();
    String apiToken = prefs.getString('user_token');
     apiToken ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjczMzFlZWQ5NDZkMWJmNDc5Y2ZmNTgyMTIzZDUzOGY2NzdhNThhNzA0ODI4NzhiMWYzNWRmZjI0ZWU3ZTNiMTY1NDlkNGIzMmIzMDU1MDQzIn0.eyJhdWQiOiIxIiwianRpIjoiNzMzMWVlZDk0NmQxYmY0NzljZmY1ODIxMjNkNTM4ZjY3N2E1OGE3MDQ4Mjg3OGIxZjM1ZGZmMjRlZTdlM2IxNjU0OWQ0YjMyYjMwNTUwNDMiLCJpYXQiOjE2MDA5Mjg3NjksIm5iZiI6MTYwMDkyODc2OSwiZXhwIjoxNjMyNDY0NzY5LCJzdWIiOiI5Njg5Iiwic2NvcGVzIjpbXX0.BSUunjz55baAVHCssILZzlLPS6sarxFxxHXY8riZ0RRTBWGCEK_iRmV-Jb9XJwfqvLCZIWCDZBrSaFr8TSNAUVYAUjicBz_nIsFKZhWPTxeuRr2mLnBOnOvBLQDU1lC7wZ-7QxlQbHXx540vf1ERkhpVuMI7Z3CKIXo4hMJj2kqW-LtEQAux_DEodYgP3W8xAmVddFS3aGdMY68Skn2exYQfp_6gZhXmqjX7fjVkEkEU3F68oE1bxp0G9kAivzUZHaWNxzOAGedCAPoA4y7XVBoyE1Nyy1owofbzapt9g6Od3XNLlJ8YnSikoM43DcBsz5qBcUfbH1ZY5vZAFJfCkmdCbxtxZoClQd5Htf83y6mQD5HGDGuUZ5IRFM3hqtfTpRkIhM_QR2MqxKpHOyqVh9m-FnX_VNZ2vJ8xP8kuwj6ZEpsNxp9MtoewsXDV-wFKQ5Gsakn4YYD8Ltt0HaeTPgSV7jvN0o_qLhRJHNr6A_nNxy3_4AyP8Bq869ubegLoEhmCB-xMBbtt57gy_NE01YGKeIRSYHpovv3IPx1CZ7XxgD2dlPOCmnAotPl9bR3PjK2gZ0fXDPs1YvmsqqpB1jNRLws5QKUSMc-vW0N3U_2yulc_9pDgysmQlTYtio2Zu7OkjWd8IUyhd7jEBlfF-VhZ1zghaV0Gb37MR-tBn80";

    alldietdb = await _getAllDiets(apiToken);
    if (alldietdb == null) {
      alldietdb = [];
    }


 setState(() {
   _DbAllDietsList = alldietdb;
   _isLoading=false;
 });

  }


  getName(String type) {
    if (type.contains("weight_loss"))
      return "weight_loss";
    else if (type.contains("keep"))
      return "keep";
    else if (type.contains("weight_gain"))
      return "weight_gain";
    else if (type.contains("vegetarian"))
      return "vegetarian";
    else if (type.contains("athletes"))
      return "athletes";
    else if (type.contains("lactation"))
      return "lactation";
    else if (type.contains("pregnancy"))
      return "pregnancy";
    else if (type.contains("children"))
      return "children";
    else
      return "";
  }

  String dateToJalali(String datestr, int day) {
    DateTime now = DateTime.parse(datestr);
    var custom = new DateTime(
      now.year,
      now.month,
      now.day + day - 1,
    );
    datestr = intl.DateFormat('yyyy-MM-dd').format(custom);
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';

    var persianDateee = PersianDateTime.fromGregorian(
        gregorianDateTime: datestr ?? '1996-09-17');
    return persianDateee.toJalaali(format: 'YYYY/MM/DD');
  }


}