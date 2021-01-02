import 'dart:async';
import 'dart:convert';
import 'package:barika_web/helper.dart';
import 'package:barika_web/menu/fruitunit.dart';
import 'package:barika_web/menu/unitConvert.dart';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/models/DbDailyDiet.dart';
import 'package:barika_web/models/diets.dart';
import 'package:barika_web/models/store.dart';
import 'package:barika_web/regims/bchart.dart';
import 'package:barika_web/regims/pregchart.dart';
import 'package:barika_web/regims/swapDiet.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/test_state_builder/diet_store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'adviceChilds.dart';

class dailyRegim extends StatefulWidget {

  final DbAllDiets _DbAllDiets;
  String today;

  dailyRegim(this._DbAllDiets, this.today);

  @override
  State<StatefulWidget> createState() => dailyRegimState();
}

class dailyRegimState extends State<dailyRegim> {
  bool _isLoading = false;

  Widget loadingView() {
    return  Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
  }
  ScrollController controller = new ScrollController();
  ScrollController controller2 = new ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyExpandedList> _MyExpandedList = [];
  List<DbDailyDiet> _DbDailyDiett=[];
  DbAllDiets _DbAllDiet;
  List<DbDailyDiet> _DbDailyDietList = [];
  var _breakfast;
  var _lunch;
  var _dinner;
  var _snack;
  bool expires=false;
  int day = 1;
  bool _show = true;
  String _user;
  String type = "";
  String advertise;
  List<PersianDateTime> arrayDays = [
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian()
  ];

  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();

  @override
  void initState() {

    _DbAllDiet = widget._DbAllDiets;
    advertise = _DbAllDiet.advertice;
    type=_DbAllDiet.type;
    final difference = DateTime.parse(widget.today).difference(DateTime.parse(_DbAllDiet.created_at)).inDays;
    day = int.parse(difference.toString()) + 1;
    setDailyInfo();
    if (day > _DbAllDiet.day) {
      expires=true;
      day = 1;
      getRegims(1);
    } else getRegims(day);

    // initTargets();
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    // TODO: implement initState
    super.initState();
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

    controller = ScrollController(
        initialScrollOffset:
            ((screenSize.width - 76) / 5 * (day - 1)).toDouble());
    return Scaffold(
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
                    size: 32 * (screenSize.width) / 375,
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
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: _isLoading
            ?loadingView()
            :Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                height: ((screenSize.width - 76) / 5) / 1.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
//                        controller = ScrollController(initialScrollOffset: ((screenSize.width-76)/5* (day-1)).toDouble());

//                            print((controller.position.pixels.toString()+"pixel"));
//                            print((((_MyExpandedList.length*screenSize.width-76)/5).toString()+"width"));

                          if (controller.position.pixels != 0)
                            controller.jumpTo(controller.position.pixels -
                                ((screenSize.width - 76)).toDouble());
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8, left: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Icon(
                          Icons.chevron_left,
                          color: Color(0xffD5D5D5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: new ListView.builder(
                        controller: controller,
                        itemCount: _DbAllDiet.day,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            child: Container(
                              width: (screenSize.width - 76) / 5,
                              height: ((screenSize.width - 76) / 5) / 1.7,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: day == i + 1
                                      ? MyColors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color: day == i + 1
                                          ? MyColors.green
                                          : Color(0xffE8E8E8),
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                " روز " + (i + 1).toString(),
                                style: TextStyle(
                                    color: day == i + 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16 * fontvar,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                day = i + 1;
                              });
                             await getRegims(i + 1);
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
                          print(((_DbAllDiet.day * (screenSize.width - 76) / 5)
                                  .toString() +
                              "pixel"));
                          print((screenSize.width.toString() + "pixel"));
                          print(((controller.position.pixels.toString() +
                              "pixel")));
                          if (controller.position.pixels < screenSize.width)
                            controller.jumpTo(controller.position.pixels +
                                ((screenSize.width - 76)).toDouble());
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
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
                  (type.contains("children") || type.contains("pregnancy"))
                      ? Expanded(
                    key: keyButton4,
                          child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Image.asset(
                                  "assets/icons/business.png",
                                  height: (screenSize.width * (60 / 375)) - 30,
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
                                  color: Color(0xff44EF94).withOpacity(0.43),
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
                                      type.contains("children") ?
                                      bchart(
                                        user: _DbAllDiet.userInfo,
                                        type: _DbAllDiet.type,
                                            )
                                          :
                                      pregchart(
                                              user: _DbAllDiet.userInfo,
                                              date:_DbAllDiet.created_at,
                                              ghol: _DbAllDiet.ghol)

                                  )),
                            );
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      key: keyButton2,
                      child: GestureDetector(
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
                                  height: (screenSize.width * (60 / 375)) - 30,
                                  width: (screenSize.width * (60 / 375)) - 30,
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
                                  color: Color(0xff8244EF).withOpacity(0.38),
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
                      key: keyButton3,
                      child: GestureDetector(
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
                                  height: (screenSize.width * (60 / 375)) - 40,
                                  width: (screenSize.width * (60 / 375)) - 40,
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
                                  color: Color(0xffEE44D8).withOpacity(0.38),
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
              child: ListView.builder(
                controller: controller2,
                itemCount: _MyExpandedList.length,
                itemBuilder: (context, i) {
                  return deals(_MyExpandedList[i]);
                },
              ),
            ),
          ],
        ));
  }

  showDays(PersianDateTime date, int i) {
    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);


    var dateNow = PersianDateTime.fromGregorian();

    bool enable =
        (date.isBefore(dateNow)) || (date.difference(dateNow).inDays == 0);

    return Column(
      children: <Widget>[
        Text(
          "",
          style: TextStyle(
            color: Color(0xff242424),
            fontSize: 10 * fontvar,
            fontWeight: FontWeight.w400,
            fontFamily: "iransansDN",
          ),
        ),
        GestureDetector(
          onTap: enable
              ? () {
                  setState(() {});
                }
              : null,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 3),
            height: (screenSize.width - 85) / 8,
            width: (screenSize.width - 85) / 8,
            decoration: BoxDecoration(
//              color:enable? arrayDaysEnable[i] ? Color(0XFF62BC72) : Colors.white:Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  width: 1,
//                  color:arrayDaysEnable[i]
//                      ? Color(0xff62BC72)
//                      : Color(0xffE8E8E8)),
                )),
            child: Text(
              date.jalaaliDay.toString(),
              style: TextStyle(
//                color: arrayDaysEnable[i] ? Colors.white : Color(0XFF242424),
                fontSize: 19 * fontvar,
                fontWeight: FontWeight.w400,
                fontFamily: "iransansDN",
              ),
            ),
          ),
        )
      ],
    );
  }

  getActivities()  {
    var titlee = [
      "صبحانه ساعت : (6 تا 9)",
      "میان وعده صبح",
      "نهار ساعت : (12 تا 14)",
      "میان وعده عصر",
      "شام ساعت : (19 تا 21)",
      "میان وعده آخر شب",
    ];
    List<String> imaage = [
      "assets/images/breakfast.png",
      'assets/images/break.png',
      'assets/images/lunch.png',
      'assets/images/break.png',
      'assets/images/dinner.png',
      'assets/images/break.png',
    ];
    List<MyExpandedList> MyList = [];
//    var _snak1,_snak2,snak3;
//    List value=_snack["value"];
//    value.forEach((item){
//      _snak1={
//        "name": _snack["name"],
//        "value":
//      }
//    });

//    allBreakFast.add(jsonEncode({"name": breakFast[i]["title"]["name"],
//      "value": values}));
//

    for (int i = 0; i < 6; i++) {
      switch (i) {
        case 0:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _breakfast));
          break;
        case 1:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _snack));
          break;
        case 2:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _lunch));
          break;
        case 3:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _snack));
          break;
        case 4:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _dinner));
          break;
        case 5:
          MyList.add(new MyExpandedList(titlee[i], imaage[i], _snack));
          break;
        default:
          return "";
      }
    }
    setState(() {
      _MyExpandedList = MyList;
    });
  }

  getSnackValue(var value, int i) {
    var t = jsonDecode(value)["value"];

    if (i == 1) {
      return jsonDecode(t)["snack1"].toString() +
          " " +
          jsonDecode(value)["units"];
    } else if (i == 2) {
      return jsonDecode(t)["snack2"].toString() +
          " " +
          jsonDecode(value)["units"];
    } else {
      return jsonDecode(t)["snack3"].toString() +
          " " +
          jsonDecode(value)["units"];
    }
  }

  validation(var value, int i) {
    var t = jsonDecode(value)["value"];

    if (i == 1) {
      if (jsonDecode(t)["snack1"] == null ||
          jsonDecode(t)["snack1"] == "" ||
          jsonDecode(t)["snack1"] == "null" ||
          jsonDecode(t)["snack1"] == "0" ||
          jsonDecode(t)["snack1"] == 0) _show = false;
    } else if (i == 2) {
      if (jsonDecode(t)["snack2"] == null ||
          jsonDecode(t)["snack2"] == "" ||
          jsonDecode(t)["snack2"] == "null" ||
          jsonDecode(t)["snack2"] == "0" ||
          jsonDecode(t)["snack2"] == 0) _show = false;
    } else {
      if (jsonDecode(t)["snack3"] == null ||
          jsonDecode(t)["snack3"] == "" ||
          jsonDecode(t)["snack3"] == "null" ||
          jsonDecode(t)["snack3"] == "0" ||
          jsonDecode(t)["snack3"] == 0) _show = false;
    }
  }

  Widget deals(MyExpandedList expandedList) {

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
    return Card(
        margin: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10),
                width:  MediaQuery.of(context).size.width,
                height: screenSize.width * (62 / 375),
                decoration: BoxDecoration(
                  color: Color(0xffEF6844),
                  borderRadius: new BorderRadius.vertical(
                      bottom: Radius.circular(0), top: Radius.circular(10)),
                ),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Icon(
                          //   Icons.schedule,
                          //   size: screenSize.width * (22 / 375),
                          //   color: Colors.white,
                          // ),
                          Image.asset(
                            expandedList.image,
                            width: screenSize.width * (62 / 375) - 6,
                            height: screenSize.width * (62 / 375) - 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              expandedList.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14 * fontvar,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      expires
                          ?Container(height: 0,width: 0,)
                          :   GestureDetector(
                      onTap: () async {
                        if (await checkConnectionInternet()){
                        String returnVal=await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child:
                                      swapDiet(
                                        url:   expandedList.title.contains("صبحانه")
                                            ?   "https://api2.barikaapp.com/api/v3/user/diet/meals?dietId=${_DbAllDiet.id}&type=breakfast&day=${day}&mealId=${ expandedList.contents["id"]}"
                                            : expandedList.title.contains("میان")
                                            ?   "https://api2.barikaapp.com/api/v3/user/diet/meals?dietId=${_DbAllDiet.id}&type=snack&day=${day}&mealId=${expandedList.contents["id"]}"
                                            :expandedList.title.contains("نهار")
                                            ?   "https://api2.barikaapp.com/api/v3/user/diet/meals?dietId=${_DbAllDiet.id}&type=launch&day=${day}&mealId=${expandedList.contents["id"]}"
                                            :   "https://api2.barikaapp.com/api/v3/user/diet/meals?dietId=${_DbAllDiet.id}&type=dinner&day=${day}&mealId=${expandedList.contents["id"]}",


                                      ))));

                        print(returnVal+"okayyyyy");
                        if(returnVal!=null)
                         await updataRegim();


                        }
                        else  showSnakBar('اتصال به اینترنت را بررسی کنید.');

                      },
                      child:   Container(
                        padding:  EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/swap.png",
                              width: screenSize.width * (21 / 375) - 6,
                              height: screenSize.width * (25 / 375) - 6,
                            ),

                          Padding(
                            padding:  EdgeInsets.only(right: 3),
                            child:   Text(
                                expandedList.title.contains("صبحانه")
                                    ?"جابجایی صبحانه"
                                    : expandedList.title.contains("میان")
                                    ?"جابجایی کل میان وعده ها"
                                    :expandedList.title.contains("نهار")
                                    ?"جابجایی نهار"
                                    :"جابجایی شام"

                                ,style:TextStyle(
                                color: Color(0xff5C5C5C),
                                fontWeight: FontWeight.w500,
                                fontSize: 12*fontvar
                            )),
                          )
                          ],
                        ),
                      ),
                    )

                    ],
                  ),
                )),
            Column(
              children: makeTypeList(expandedList),
            ),
          ],
        ));
  }

  makeTypeList(MyExpandedList expandedList) {
    List<Widget> columnContent = [];
    var content = expandedList.contents;

    List value = content["value"];

    for (int i = 0; i < value.length; i++) {
      _show = true;
      if (expandedList.title == "میان وعده صبح")
        validation(content["value"][i], 1);
      else if (expandedList.title == "میان وعده عصر")
        validation(content["value"][i], 2);
      else if (expandedList.title == "میان وعده آخر شب")
        validation(content["value"][i], 3);
      else if (expandedList.title == "صبحانه ساعت : (6 تا 9)" ||
          expandedList.title == "نهار ساعت : (12 تا 14)" ||
          expandedList.title == "شام ساعت : (19 تا 21)") {
        if ((content["value"][i]["value"] == null) ||
            (content["value"][i]["value"] == "") ||
            (content["value"][i]["value"] == "null") ||
            content["value"][i]["value"] == "0" ||
            content["value"][i]["value"] == 0) _show = false;
      }
      if (_show)
        columnContent.add(Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      expandedList.title == "میان وعده صبح" ||
                              expandedList.title == "میان وعده عصر" ||
                              expandedList.title == "میان وعده آخر شب"
                          ? jsonDecode(_snack["value"][i])['name']
                          : content["value"][i]["name"],
                      style:  TextStyle(
                          fontSize: 12.0 * fontvar,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5c5c5c)),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      expandedList.title == "میان وعده صبح"
                          ? getSnackValue(content["value"][i], 1)
                          : expandedList.title == "میان وعده عصر"
                              ? getSnackValue(content["value"][i], 2)
                              : expandedList.title == "میان وعده آخر شب"
                                  ? getSnackValue(content["value"][i], 3)
                                  : content["value"][i]["value"] +
                                      " " +
                                      content["value"][i]["units"],
                      style:  TextStyle(
                          fontSize: 12.0 * fontvar,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5c5c5c)),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Divider(
                  color: Color(0xffF5FAF2),
                  height: 1,
                  thickness: 2,
                ),
              )
            ],
          ),
        ));
    }
    return columnContent;
  }

  setDailyInfo(){

    List allamount =_DbAllDiet.detail['breakfasts'];
    _DbDailyDiett=[];
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


      List breakFast = _DbAllDiet.detail['breakfasts'];
      values = [];
      units = (breakFast[i]["detail"]);
         print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add(
            {"value": breakFast[i]["detail"][y]["value"],
          "name": breakFast[i]["detail"][y]["name"],
          "units": breakFast[i]["detail"][y]["unit"]
        });


      allBreakFast.add(jsonEncode({"id":breakFast[i]["id"],"name": breakFast[i]["title_name"], "value": values}));



      List Lunch =_DbAllDiet.detail['launches'];

      values = [];
      nameb.add(Lunch[i]["title_name"]);
      units = (Lunch[i]["detail"]);

      for (int y = 0; y < units.length; y++)
        values.add({
          "value": Lunch[i]["detail"][y]["value"],
          "name": Lunch[i]["detail"][y]["name"],
          "units": Lunch[i]["detail"][y]["unit"]
        });


      alllunch.add(jsonEncode({"id":Lunch[i]["id"],"name": Lunch[i]["title_name"],
        "value": values
      }));




      List dinners = _DbAllDiet.detail['dinners'];
      values = [];
      nameb.add(dinners[i]["title_name"]);
      units = (dinners[i]["detail"]);
//          print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add({"value": dinners[i]["detail"][y]["value"],
          "name": dinners[i]["detail"][y]["name"],
          "units": dinners[i]["detail"][y]["unit"]
        });


      alldinner.add(jsonEncode({"id":dinners[i]["id"],"name": dinners[i]["title_name"],
        "value": values}
      ));




      List smacks = _DbAllDiet.detail['snacks'];

      values = [];
      nameb.add(smacks[i]["title_name"]);
      units = (smacks[i]["detail"]);
         print("${units.length}${"kkk"}");
      for (int y = 0; y < units.length; y++)
        values.add(jsonEncode({"value": smacks[i]["detail"][y]["value"],
          "name": smacks[i]["detail"][y]["name"],
          "units": smacks[i]["detail"][y]["unit"]
        }));

      allsnacks.add(jsonEncode({"id":smacks[i]["id"],"name": smacks[i]["title_name"],
        "value": values
      }));

      var dietdaily = {

        'breakfast': allBreakFast[0],
        'lunch': alllunch[0],
        'dinner': alldinner[0],
        'snack': allsnacks[0],
        'day': i + 1,
      };


      DbDailyDiet dailyDiet = DbDailyDiet.fromJson(dietdaily);
      _DbDailyDiett.add(dailyDiet);

    }


  }

  getRegims(int day) async {


    _breakfast = jsonDecode(_DbDailyDiett[day-1].breakfast);
    _lunch = jsonDecode(_DbDailyDiett[day-1].lunch);
    _dinner = jsonDecode(_DbDailyDiett[day-1].dinner);
    _snack = jsonDecode(_DbDailyDiett[day-1].snack);
    getActivities();

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



void initTargets() {
    if(type.contains("children"))
      targets.add(TargetFocus(
        identify: "Target 4",
        keyTarget: keyButton4,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                  child:
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                        "برای اطلاع از وضعیت رشد کودکتون حتما این بخش رو ببینید و توضیحات زیر نمودار رو بخونین.",
                        style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl
                    ),
                  )
              ))
        ],
        shape: ShapeLightFocus.Circle,

      ));
    if(type.contains("pregnancy"))
      targets.add(TargetFocus(
        identify: "Target 4",
        keyTarget: keyButton4,
        contents: [
          ContentTarget(
              align: AlignContent.bottom,
              child: Container(
                  child:
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                        "برای اطلاع از روند وزن گیری در طی بارداری، حتما نمودار رو ببینید و توضیحات زیرشو بخونید.",
                        style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl
                    ),
                  )
              ))
        ],
        shape: ShapeLightFocus.Circle,

      ));
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton1,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                      "حتما قبل از شروع رژیم این توصیه ها رو بخون، خیلی مهمن.",
                      style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                      "برای اطلاع از مقدار واحد هر میوه از این دکمه استفاده کنید.",
                      style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton3,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                      "اینجا خیلی راحت می تونی انواع نون ها و غلات رو به هم تبدیل کنی.",
                      style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl
                  ),
                )
            ))
      ],
      shape: ShapeLightFocus.Circle,

    ));


  }

  void showTutorial() {
    TutorialCoachMark(context,
      targets: targets,
      colorShadow:MyColors.green,
      textSkip: "بستن",
      paddingFocus: 10,
      opacityShadow: 0.9,
    )
      ..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 400), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringCoach=prefs.getString('coach');
      if(stringCoach!=null) {
        List<String> arrayCoach = stringCoach.split("#");
        if (arrayCoach[3] == "0") {
          showTutorial();
          arrayCoach[3] = "1";
          String stringCoachSave = "";
          for (int i = 0; i < arrayCoach.length; i++) {
            if (i != 0)
              stringCoachSave = stringCoachSave + ("#");
            stringCoachSave = stringCoachSave + arrayCoach[i];
          }
          await prefs.setString('coach', stringCoachSave);
        }
      }
    });
  }

  updataRegim() {



    setState(() {
      _isLoading=true;
    });
    final reactiveModel = Injector.getAsReactive<dietStore>();
    reactiveModel.setState(
          (store) => store.getDiet(context),

      onData: (context,store){
        store.DbAllDietsList.forEach((element) {
          print("okayyyyyy"+_DbAllDiet.id.toString());
          print("okayyyyyy"+element.id.toString());
          if(element.id==_DbAllDiet.id)
            setState(() {
              _DbAllDiet=element;
              print(_DbAllDiet.detail.toString());
              setDailyInfo();
              getRegims(day);
              _isLoading=false;
              print("okayyyyyy");
            });
            
        });
      },
      onError: (context, error) {
        if (error) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Couldn't fetch weather. Is the device online?"),
            ),
          );
        } else {
          throw error;
        }
      },
    );
    

    
  }
}
class MyExpandedList {
  final String title;
  final String image;
  var contents;

  MyExpandedList(this.title, this.image, this.contents);
}
