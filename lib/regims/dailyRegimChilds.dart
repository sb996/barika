import 'dart:async';
import 'package:barika_web/menu/fruitunit.dart';
import 'package:barika_web/menu/unitConvert.dart';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/models/DbDailyDiet.dart';
import 'package:barika_web/regims/adviceChilds.dart';
import 'package:barika_web/regims/bchart.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class dailyRegimChild extends StatefulWidget {

  final DbAllDiets _DbAllDiets;

  dailyRegimChild(this._DbAllDiets,);

  @override
  State<StatefulWidget> createState() => dailyRegimChildState();
}

class dailyRegimChildState extends State<dailyRegimChild> {
  ScrollController controller = new ScrollController();
  ScrollController controller2 = new ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyExpandedList> _MyExpandedList = [];
  DbAllDiets _DbAllDiet;
  List<DbDailyDiet> _DbDailyDietList = [];
  String advertise;
  String details;

  // String type2;
  // String type;
  int day = 1;
  String typee = "";
  List<List<String>> allList = [];
  List<String> titlesList;
  List<String> detailsList;
  int _index = 0;
  bool _isLoading = true;
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  @override
  void initState() {
    super.initState();
    _DbAllDiet = widget._DbAllDiets;
    getTitle();

  }

  var fontvar = 1.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return Scaffold(
        backgroundColor: Color(0xffF5FAF2),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: MyColors.green,
          centerTitle: true,
          title: Text(
            "برنامه غذایی",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16 * fontvar,
                fontWeight: FontWeight.w700),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 4),
                child: IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    size: 32 ,
                    textDirection: TextDirection.rtl,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  splashColor: Colors.amber,
                  padding: EdgeInsets.all(7),
                )),
          ],
          automaticallyImplyLeading: false,
        ),
        body: _isLoading
            ? Container()
            : Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      height: ((screenSize.width - 76) / 5) / 1.7,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
//                        controller = ScrollController(initialScrollOffset: ((screenSize.width-76)/5* (day-1)).toDouble());

                                controller.jumpTo(controller.position.pixels -
                                    ((screenSize.width - 76) / 5).toDouble());
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 8, left: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Icon(
                                Icons.chevron_left,
                                color: Color(0xffD5D5D5),
                              ),
                            ),
                          ),
                          Expanded(
                            child: new ListView.builder(
                              controller: controller,
                              itemCount: allList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  child: Container(
                                    height: ((screenSize.width - 76) / 5) / 1.7,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: _index == i
                                            ? MyColors.green
                                            : Colors.white,
                                        border: Border.all(
                                            color: _index == i
                                                ? MyColors.green
                                                : Color(0xffE8E8E8),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 6),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    child: Text(
                                      allList[i][0],
                                      style: TextStyle(
                                          color: _index == i
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16 * fontvar,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      print(i.toString() + "iii");
                                      _index = i;
                                    });

                                    controller2.jumpTo(0);
                                  },
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
//                        controller = ScrollController(initialScrollOffset: ((screenSize.width-76)/5* (day-1)).toDouble());

                                controller.jumpTo(controller.position.pixels +
                                    ((screenSize.width - 76) / 5).toDouble());
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 8, right: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Icon(
                                Icons.chevron_right,
                                color: Color(0xffD5D5D5),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        (_DbAllDiet.type.contains("children") ||
                            _DbAllDiet.type.contains("pregnancy"))
                            ? Expanded(
                                child: GestureDetector(
                                  key: keyButton4,
                                child: Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Image.asset( "assets/icons/business.png",
                                      height: (screenSize.width * (60 / 375)) - 30 ,
                                      width: (screenSize.width * (60 / 375)) - 30,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Text(
                                            "نمودار ها",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10 * fontvar,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xff44EF94),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff44EF94).withOpacity(0.43),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Directionality(
                                            textDirection: TextDirection.rtl,
                                            child:
                                            // _DbAllDiet.type.contains("children")
                                            //     ?
                                            bchart(
                                                    user: _DbAllDiet.userInfo,
                                                    type: _DbAllDiet.type,
                                                  )
                                            //     :
                                            // pregchart(
                                            //         user: _user,
                                            //         date: _DbAllDiet.Date))),
                                  )));
                                },
                              ))
                            : Container(),
                        Expanded(
                            child: GestureDetector(
                              key: keyButton1,
                          child: Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                "assets/icons/info.png",
                                  height: (screenSize.width * (60 / 375)) - 30,
                                  width: (screenSize.width * (60 / 375)) - 30,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "توصیه ها",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10 * fontvar,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            margin: EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Color(0xff44BCEF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff0989EB).withOpacity(0.38),
                                  blurRadius: 20.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: adviceChilds(advertise)),
                                ));
                          },
                        )),
                        Expanded(
                            child: GestureDetector(
                              key: keyButton2,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: fruitUnit())),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                      "assets/icons/fruit.png",
                                        height:
                                            (screenSize.width * (60 / 375)) -
                                                30,
                                        width: (screenSize.width * (60 / 375)) -
                                            30,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Text(
                                            "واحد میوه ها",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10 * fontvar,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xff8244EF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff8244EF).withOpacity(0.38),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                        Expanded(
                            child: GestureDetector(
                                key: keyButton3,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: unitConvert())),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                      "assets/icons/bread.png",
                                        height:
                                            (screenSize.width * (60 / 375)) -
                                                40,
                                        width: (screenSize.width * (60 / 375)) -
                                            40,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "تبدیل نان ها",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11 * fontvar,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffEF44D8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xffEE44D8).withOpacity(0.38),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                      child: new ListView.builder(
                        controller: controller2,
                          itemCount: allList[_index].length-1,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              elevation: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      padding: EdgeInsets.only(top: 3),
                                      alignment: Alignment.center,
                                      width: 22* (screenSize.width) / 375,
                                      height: 22* (screenSize.width) / 375,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF15A23),
                                          shape: BoxShape.circle),
                                      child: Text(
                                        (index +1).toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14 * fontvar),
                                      ),
                                    ),
                                    Container(
                                        child: Flexible(
                                      child: Text(
                                        allList[_index][index + 1],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 12 * fontvar,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff777777),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ));
  }

  getTitle() async {

    setState(() {
      advertise = _DbAllDiet.detail["advertise"];
      details = _DbAllDiet.detail["details"];


      titlesList = details.toString().split("#");
      for (int i = 0; i < titlesList.length; i++) {
        print(titlesList[i]);
        if (titlesList[i] == "") titlesList.removeAt(i);
      }
      print(titlesList.length);
      titlesList.forEach((item) {
        print(allList.length);
        allList.add(item.split("-"));
        print(allList.length);
        _isLoading = false;
      });
    });
  }



}

class MyExpandedList {
  final String title;
  var contents;

  MyExpandedList(this.title, this.contents);
}
