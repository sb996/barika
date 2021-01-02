import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:barika_web/exercise/exerciseDetail.dart';
import 'package:barika_web/menu/goalWeight.dart';
import 'package:barika_web/models/DbAllDiets.dart';
import 'package:barika_web/models/DbDailyInfo.dart';
import 'package:barika_web/models/notices.dart';
import 'package:barika_web/models/start.dart';
import 'package:barika_web/models/subAlbums.dart';
import 'package:barika_web/models/subExercises.dart';
import 'package:barika_web/models/subRecipes.dart';
import 'package:barika_web/models/subSupplement.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/mokamel/mokamelDetail.dart';
import 'package:barika_web/regimiFood/regimiFoodDetail.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/store/storeScreen.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/MyDadaPicker.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:barika_web/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_progress/gradient_progress.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../helper.dart';


class HomeScreen extends StatefulWidget {



  final keyButton;

  HomeScreen({Key key,this.keyButton})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => false;

  bool deleteGoalb=false;

  notices _nots;
  bool _justRegims = false;
  User _user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String diifff;
  start _start;
  String _serverDate;
  List<subRecipes> _recipes = [];
  List<subSupplement> _supplemen = [];
  List<subExercise> _exercise = [];
  List<subAbum> _albums = [];
  int _totlaCal = 240000;

  List<DbAllDiets> _DbAllDietsList = [];
  int etebar = -1;
  int etebarr = -1;
  String _water = "0";
  String gregorianDate;
  DbDailyInfo _dailyInfo;
  double _totalFoodCal = 0;
  double _totalCal = 0;
  double _totalActshow = 0;
  double _totalfoodshow = 0;
  Color textColor = Color(0xff555555);

  List<PersianDateTime> arrayDays = [
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian(),
    PersianDateTime.fromGregorian()
  ];
  List<bool> arrayDaysEnable = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int arrayIndex;
  List<String> arrayDaysName = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه شنبه',
    'چهارشنبه',
    'پنجشنبه',
    'جمعه',
  ];
  static PersianDateTime persianDate1;
  PersianDatePickerWidget persianDatePicker;
  String _selecteddate;

  List<TargetFocus> targets = List();
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();

  @override
  void initState() {
    persianDate1 = dateCall.getDate() == null
        ? PersianDateTime.fromGregorian()
        : PersianDateTime.fromGregorian(
        gregorianDateTime: dateCall.getDate()); //
    gregorianDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
    calculateDays();
    if (dateCall.getDate() == null) {
      dateCall.saveDate(persianDate1);
    }

    // initTargets();

    super.initState();
  }


  var fontvar = 1.0;
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;

    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);


    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffF7F7FB),
        body: CustomScrollView(controller: scrollController, slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Card(
                  margin: EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  elevation: 11,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              persianDate1.jalaaliMonthName,
                              style: TextStyle(
                                color: Color(0xff242424),
                                fontSize: 10 * fontvar,
                                fontWeight: FontWeight.w600,
                                fontFamily: "iransansDN",
                              ),
                            ),
                            GestureDetector(
                              key: keyButton,
                              onTap: () {
                                MyDatePicker.showDatePicker(
                                  context,
                                  onConfirm: (int year, int month, int day) async {
                                    print(year);
                                    print(month);
                                    print(day);
                                    String datenew = year.toString() +
                                        "/" +
                                        month.toString() +
                                        "/" +
                                        day.toString();
                                    var datenew2 =
                                    PersianDateTime(jalaaliDateTime: datenew);
                                    PersianDateTime datenow = PersianDateTime();
                                    if ((datenew2.isBefore(datenow)) ||
                                        (datenew2.difference(datenow).inDays ==
                                            0)) {
                                      _selecteddate = datenew;
                                      print(_selecteddate);
                                      persianDate1 = PersianDateTime(
                                          jalaaliDateTime: _selecteddate);
                                      gregorianDate = persianDate1.toGregorian(
                                          format: 'YYYY-MM-DD');
                                      calculateDays();
                                      print(gregorianDate + "ll" + getDateToday());
                                      await _getDailyInfo2();
                                      dateCall.saveDate(persianDate1);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "امکان انتخاب این تاریخ وجود ندارد.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0 * fontvar,
                                      );
                                    }
                                  },
                                  minYear: 1300,
                                  maxYear: 1450,
                                  confirm: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                        color: Colors.green),
                                    child: Text(
                                      'تایید',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18 * fontvar,
                                          fontFamily: "iransansDN",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  cancel: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                          color: Colors.red),
                                      child: Text(
                                        ' لغو ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18 * fontvar,
                                            fontFamily: "iransansDN",
                                            fontWeight: FontWeight.w400),
                                      )),
                                );
                              },
                              child: Image.asset(
                                'assets/icons/calendar.png',
                                width: (screenSize.width - 85) / 8,
                                height: (screenSize.width - 85) / 8,
                                color: Color(0xff6DC07B),
                              ),
                            ),
                          ],
                        ),
                        showDays(arrayDays[0], 0),
                        showDays(arrayDays[1], 1),
                        showDays(arrayDays[2], 2),
                        showDays(arrayDays[3], 3),
                        showDays(arrayDays[4], 4),
                        showDays(arrayDays[5], 5),
                        showDays(arrayDays[6], 6)
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.error.toString() + "snapshot.error");
                        return Column(
                          children: <Widget>[
                            Card(
                              margin:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              elevation: 11,
                              child: Container(
                                padding: EdgeInsets.only(top: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffE8FFDD),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                margin: EdgeInsets.only(right: 12),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "کالری مصرف شده",
                                                      style: TextStyle(
                                                          color: Color(0xff62BC72),
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15 * fontvar),
                                                    ),
                                                    Text(
                                                      _dailyInfo != null
                                                          ? (double.parse(_dailyInfo
                                                          .total_act ??
                                                          "0") +
                                                          double.parse(
                                                              _dailyInfo
                                                                  .total_calorie ??
                                                                  "0"))
                                                          .toStringAsFixed(
                                                          0) +
                                                          " کالری"
                                                          : "0" + " کالری",
                                                      textDirection:
                                                      TextDirection.rtl,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18 * fontvar,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    right: 12, top: 10),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7),
                                                decoration: BoxDecoration(
                                                  color: Color(0xffFFF0DD),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "کالری باقیمانده",
                                                      style: TextStyle(
                                                          color: Color(0xffEF6844),
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 15 * fontvar),
                                                    ),
                                                    _user != null
                                                        ? _user.calorie == null
                                                        ? Icon(
                                                      Icons.all_inclusive,
                                                      size: 20 *
                                                          (screenSize
                                                              .width /
                                                              375),
                                                    )
                                                        : Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: <Widget>[
                                                        Text(
                                                            ((_user.calorie -
                                                                _totalCal)
                                                                .toStringAsFixed(
                                                                0)),
                                                            textDirection:
                                                            TextDirection
                                                                .ltr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18 *
                                                                    fontvar,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                        Text(" کالری ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18 *
                                                                    fontvar,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                      ],
                                                    )
                                                        : Text(("0") + " کالری",
                                                        textDirection:
                                                        TextDirection.rtl,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                            18 * fontvar,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                              key: keyButton2,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 0.0476 *
                                                            0.672 *
                                                            (screenSize.width / 2),
                                                        color: (_dailyInfo != null &&
                                                            _user != null &&
                                                            _user.calorie !=
                                                                null)
                                                            ? (double.parse(_dailyInfo.total_calorie) / _user.calorie ??
                                                            _totlaCal) >
                                                            2
                                                            ? Colors.red
                                                            .withOpacity(
                                                            0.4)
                                                            : (((double.parse(_dailyInfo.total_calorie) / _user.calorie ?? _totlaCal) >
                                                            1) &&
                                                            ((double.parse(_dailyInfo.total_calorie) / _user.calorie ?? _totlaCal) <
                                                                2))
                                                            ? MyColors.vazn
                                                            .withOpacity(0.12)
                                                            : Color(0xffE8FFDD)
                                                            : Color(0xffE8FFDD)),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  alignment: Alignment.center,
                                                  width:
                                                  (screenSize.width / 2) - 44,
                                                  height:
                                                  (screenSize.width / 2) - 44,
                                                  child: Center(
                                                    child: Stack(
                                                      alignment:
                                                      AlignmentDirectional
                                                          .topCenter,
                                                      children: <Widget>[
                                                        GradientCircularProgressIndicator(
//
                                                          gradientColors: (_dailyInfo !=
                                                              null &&
                                                              _user != null &&
                                                              _user.calorie !=
                                                                  null)
                                                              ? (double.parse(_dailyInfo
                                                              .total_calorie) /
                                                              _user
                                                                  .calorie ??
                                                              _totlaCal) >
                                                              2
                                                              ? [
                                                            Colors.red
                                                                .withOpacity(
                                                                0.9),
                                                            Colors.red
                                                                .withOpacity(
                                                                0.9),
                                                          ]
                                                              : (((double.parse(_dailyInfo.total_calorie) / _user.calorie ??
                                                              _totlaCal) >
                                                              1) &&
                                                              ((double.parse(_dailyInfo.total_calorie) / _user.calorie ??
                                                                  _totlaCal) <
                                                                  2))
                                                              ? [
                                                            MyColors
                                                                .vazn
                                                                .withOpacity(
                                                                0.7),
                                                            MyColors
                                                                .vazn
                                                                .withOpacity(
                                                                0.7),
                                                          ]
                                                              : [
                                                            Color(
                                                                0xff62BC72),
                                                            Color(
                                                                0xff62BC72)
                                                          ]
                                                              : [
                                                            Color(0xff62BC72),
                                                            Color(0xff62BC72)
                                                          ],

                                                          radius:
                                                          (((screenSize.width /
                                                              2) -
                                                              44) /
                                                              2) -
                                                              (0.0476 *
                                                                  0.672 *
                                                                  (screenSize
                                                                      .width /
                                                                      2)),
//                                              radius: 0.672*(screenSize.width/2)/2,
                                                          strokeWidth:
                                                          (((screenSize.width /
                                                              2) -
                                                              30) /
                                                              12.73),
                                                          value: (_dailyInfo !=
                                                              null &&
                                                              _user != null &&
                                                              _user.calorie !=
                                                                  null)
                                                              ? double.parse(_dailyInfo
                                                              .total_calorie) /
                                                              _user
                                                                  .calorie ??
                                                              _totlaCal
                                                              : 0,
                                                          backgroundColor:
                                                          Color(0xffDEE6EE),
                                                          strokeRound: true,
                                                        ),
                                                        Center(
                                                            child: (_dailyInfo !=
                                                                null &&
                                                                _user != null &&
                                                                _user.calorie !=
                                                                    null)
                                                                ? ((double.parse(_dailyInfo.total_calorie)) >1.3*(( _user.calorie ?? _totlaCal)+(_dailyInfo.total_act==null?0:double.parse(_dailyInfo.total_act))))
                                                                ? Image
                                                                .asset(
                                                              'assets/icons/vsad.png',
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              width: ((screenSize.width /
                                                                  2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                              height: ((screenSize.width /
                                                                  2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                            )
                                                                : (((double.parse(_dailyInfo.total_calorie) / _user.calorie ?? _totlaCal) >
                                                                1) && ((double.parse(_dailyInfo.total_calorie) / _user.calorie ?? _totlaCal) < 2))
                                                                ? Image
                                                                .asset(
                                                              'assets/icons/sad.png',
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              width: ((screenSize.width / 2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                              height: ((screenSize.width / 2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                            )
                                                                :Image
                                                                .asset(
                                                              'assets/icons/emoji.png',
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              width: ((screenSize.width / 2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                              height: ((screenSize.width / 2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize.width)) -
                                                                  30,
                                                            )
                                                                : Image
                                                                .asset(
                                                              'assets/icons/emoji.png',
                                                              color: Color(
                                                                  0xffD4D4D4),
                                                              width: ((screenSize.width /
                                                                  2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize
                                                                          .width)) -
                                                                  30,
                                                              height: ((screenSize.width /
                                                                  2) -
                                                                  44) -
                                                                  (0.0476 *
                                                                      0.672 *
                                                                      (screenSize
                                                                          .width)) -
                                                                  30,
                                                            )),
                                                        Container(
                                                          width:
                                                          (((screenSize.width /
                                                              2) -
                                                              30) /
                                                              12.73),
                                                          height:
                                                          (((screenSize.width /
                                                              2) -
                                                              30) /
                                                              12.73),
                                                          margin: EdgeInsets.only(
                                                              right: 5),
                                                          decoration:
                                                          new BoxDecoration(
                                                            color:
                                                            Color(0xff6ADF7D),
                                                            shape: BoxShape.circle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              onTap: () async {
                                                // PersianDateTime returnVal =
                                                // await Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         Directionality(
                                                //             textDirection:
                                                //             TextDirection.rtl,
                                                //             child: dailyInfo(
                                                //               date: persianDate1,
                                                //             )),
                                                //   ),
                                                // );
                                                // persianDate1 = returnVal;
                                                // gregorianDate =
                                                //     persianDate1.toGregorian(
                                                //         format: 'YYYY-MM-DD');
                                                // calculateDays();
                                                // print(gregorianDate +
                                                //     "ll" +
                                                //     getDateToday());
                                                // await _getDailyInfo();
                                              }),
                                        )
                                      ],
                                    ),
                                    Container(
                                      key: keyButton3,
                                      margin: EdgeInsets.only(
                                          top: 8, left: 12, right: 12, bottom: 10),
                                      padding: EdgeInsets.symmetric(vertical: 7),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFBFFDD),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        textDirection: TextDirection.ltr,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
//                                        Text(
//                                          '1550',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
                                              _user != null
                                                  ? _user.calorie == null
                                                  ? Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 2),
                                                child: Icon(
                                                  Icons.all_inclusive,
                                                  size: 26 *
                                                      (screenSize.width /
                                                          375),
                                                ),
                                              )
                                                  : Text(
                                                _user.calorie
                                                    .toStringAsFixed(0),
                                                textDirection:
                                                TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                    18 * fontvar,
                                                    fontFamily:
                                                    "iransansDN",
                                                    fontWeight:
                                                    FontWeight.w400),
                                              )
                                                  : Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 2),
                                                child: Icon(
                                                  Icons.all_inclusive,
                                                  size: 26 *
                                                      (screenSize.width /
                                                          375),
                                                ),
                                              ),
                                              Text(
                                                'کالری مجاز',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5,
                                                  left: 5,
                                                  top:
                                                  7 * (screenSize.width / 375)),
                                              child: Icon(
                                                Icons.remove,
                                                size: 20 * (screenSize.width / 375),
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                _dailyInfo != null
                                                    ? (double.parse(_dailyInfo
                                                    .total_act ??
                                                    "0") +
                                                    double.parse(_dailyInfo
                                                        .total_calorie ??
                                                        "0"))
                                                    .toStringAsFixed(0)
                                                    : "0",
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                '   غذا   ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5,
                                                  left: 5,
                                                  top:
                                                  7 * (screenSize.width / 375)),
                                              child: Icon(
                                                Icons.add,
                                                size: 20 * (screenSize.width / 375),
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                _dailyInfo != null
                                                    ? (double.parse(_dailyInfo
                                                    .total_act)
                                                    .toStringAsFixed(0) ??
                                                    "0")
                                                    : "0",
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              Text(
                                                '  فعالیت  ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5,
                                                  left: 5,
                                                  top:
                                                  7 * (screenSize.width / 375)),
                                              child: Icon(
                                                Icons.drag_handle,
                                                size: 20 * (screenSize.width / 375),
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
//                                        Text(
//                                          '155',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
                                              _user != null
                                                  ? _user.calorie == null
                                                  ? Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 2),
                                                child: Icon(
                                                  Icons.all_inclusive,
                                                  size: 26 *
                                                      (screenSize.width /
                                                          375),
                                                ),
                                              )
                                                  : Text(
                                                  ((_user.calorie -
                                                      _totalCal)
                                                      .toStringAsFixed(0)),
                                                  textDirection:
                                                  TextDirection.ltr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                      18 * fontvar,
                                                      fontFamily:
                                                      "iransansDN",
                                                      fontWeight:
                                                      FontWeight.w400))
                                                  : Text(("0"),
                                                  textDirection:
                                                  TextDirection.ltr,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18 * fontvar,
                                                      fontFamily: "iransansDN",
                                                      fontWeight:
                                                      FontWeight.w400)),
                                              Text(
                                                'باقی مانده',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    (_user != null)
                                        ? (calculateAge(_user.birthdate) >= 3)
                                        ? _user.gcalorie == null
                                        ?etebarr < 0
                                        ? Container(
                                        margin: EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            bottom: 12),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF15A23),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    10))),
                                        alignment: Alignment.center,
                                        width: screenSize.width,
                                        child: Stack(
                                          children: [
                                            Text(
                                              'تا پیش از تعیین هدف، کالری مجاز شما کالری حفظ وزن است. برای تعیین هدف ابتدا اشتراک تهیه کنید.',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize: 15 * fontvar,
                                                  color: Colors.white),
                                              textAlign: TextAlign.right,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child:    GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5, vertical: 7),
                                                  margin: EdgeInsets.only(top: 50,),
                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(.8), borderRadius: BorderRadius.all(Radius.circular(8))),

                                                  child:  Text(
                                                    "اشتراک تهیه کنید",
                                                    style: TextStyle(fontSize: 12 * fontvar, fontWeight: FontWeight.w500, color: Colors.black),
                                                  ),

                                                ),
                                                onTap: () async {
                                                  User d = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Directionality(
                                                                textDirection: TextDirection.rtl,
                                                                child: storeScreen(menu: true,user: _user,))),
                                                  );
                                                  if(d!=null){
                                                    setState(() {
                                                      _user.account=d.account;

                                                      getEtebar();

                                                    });
                                                  }

                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                        :Container(
                                        margin: EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            bottom: 12),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF15A23),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    10))),
                                        alignment: Alignment.center,
                                        width: screenSize.width,
                                        child: Stack(
                                          children: [
                                            Text(
                                              'تا پیش از تعیین هدف، کالری مجاز شما کالری حفظ وزن است.',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize: 15 * fontvar,
                                                  color: Colors.white),
                                              textAlign: TextAlign.right,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child:    GestureDetector(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5, vertical: 7),
                                                  margin: EdgeInsets.only(top: 30 ,),
                                                  decoration: BoxDecoration(color: Colors.white.withOpacity(.8), borderRadius: BorderRadius.all(Radius.circular(8))),

                                                  child:  Text(
                                                    "هدف تعیین کنید",
                                                    style: TextStyle(fontSize: 12 * fontvar, fontWeight: FontWeight.w500, color: Colors.black),


                                                  ),
                                                ),
                                                onTap: () async {
                                                  if(_user != null){
                                                    if ( calculateAge(_user.birthdate) < 3)
                                                      showSnakBar(
                                                          "برای زیر سه سال غیر فعال است.");
                                                    else {
                                                      var d = await  Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Directionality(
                                                                    textDirection: TextDirection.rtl,
                                                                    child: goalWeight(
                                                                      acountDate: _user.account,

                                                                    ))),
                                                      );
                                                      print("we come back");
                                                      User p=  await getUserFromState();
                                                      setState(() {
                                                        _user=p;
                                                      });
                                                    }
                                                    setState(() {

                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                        : Container(
                                        margin: EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            bottom: 12),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Color(0xffD9F0FF),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    10))),
                                        alignment: Alignment.center,
                                        width: screenSize.width,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              getIdeall() +
                                                  "  و وزن هدف شما " +
                                                  _user.gweight
                                                      .toString() +
                                                  " کیلو می باشد ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize:
                                                  16 * fontvar,
                                                  color: Colors.black),
                                              textAlign:
                                              TextAlign.center,
                                            ),
                                            Text(
                                              getDiff(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontSize:
                                                  14 * fontvar,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ))
                                        : Container(width: 0.0, height: 0.0)
                                        : Container(width: 0.0, height: 0.0)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: <Widget>[
                                  Progressbar(
                                      _dailyInfo == null
                                          ? "0"
                                          : _dailyInfo.total_protein,
                                      'پروتئین'),
                                  Progressbar(
                                      _dailyInfo == null
                                          ? "0"
                                          : _dailyInfo.total_carb,
                                      'کربوهیدرات'),
                                  Progressbar(
                                      _dailyInfo == null
                                          ? "0"
                                          : _dailyInfo.total_fat,
                                      'چربی'),
                                ],
                              ),
                            ),
                            _nots != null
                                ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 13),
                              decoration: BoxDecoration(
                                  color: Color(0xffF15A23),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(7),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.info,
                                    size: 20 * (screenSize.width / 375),
                                    color: Colors.white,
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          _nots.message,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 * fontvar,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            )
                                : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                            ),
                            Container(
                              height: ((screenSize.width - 55) / 2) * (127 / 160),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.5, vertical: 13),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        height:
                                        ((screenSize.width - 55) / 2) * (127 / 160),
                                        margin: EdgeInsets.symmetric(horizontal: 7.5),
                                        child: RaisedButton(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            color: Color(0xff23AEF1),
                                            onPressed: () async {
//                                               String returnvsl = await showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) {
//                                                     return Padding(
//                                                         padding: EdgeInsets.all(0),
//                                                         child: Dialog(
//                                                             elevation: 15,
//                                                             shape:
//                                                             RoundedRectangleBorder(
//                                                               borderRadius:
//                                                               BorderRadius.circular(
//                                                                   10),
//                                                             ),
//                                                             backgroundColor:
//                                                             Colors.transparent,
//                                                             child: waterDialog()));
//                                                   });
//                                               print(returnvsl);
//                                               if (returnvsl == "yes") {
//                                                 setState(() {});
// //                                        print(
// //                                            "ddddddddddddddddddddddddddddddddddddddddddddddddd");
// //                                        print(_dailyInfo.water);
//                                               }
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Image.asset(
                                                  'assets/icons/water.png',
                                                  width: 40 /
                                                      114 *
                                                      ((screenSize.width - 55) / 2) *
                                                      (127 / 160),
                                                  height: 40 /
                                                      114 *
                                                      ((screenSize.width - 55) / 2) *
                                                      (127 / 160),
                                                  color: Colors.white,
                                                ),
//                            if(imageString!=null)  Utility.imageFromBase64String(imageString),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 8,
                                                  ),
                                                  child: Text(
                                                    _water + ' لیوان آب',
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16 * fontvar),
                                                  ),
                                                )
                                              ],
                                            )),
                                      )),
                                  Expanded(
                                      child: Container(
                                        height:
                                        ((screenSize.width - 55) / 2) * (127 / 160),
                                        margin: EdgeInsets.symmetric(horizontal: 7.5),
                                        child: RaisedButton(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            color: Color(0xffF15A23),
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) => Directionality(
                                              //         textDirection: TextDirection.rtl,
                                              //         child: rizMoghazi(
                                              //           riz: riz(
                                              //               calculateAge(
                                              //                   _user.birthdate),
                                              //               _user.gender,
                                              //               _user.birthdate),
                                              //           calorie: _user.calorie,
                                              //         )),
                                              //   ),
                                              // );
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/icons/rizmoghazi.png',
                                                  width: 40 /
                                                      114 *
                                                      ((screenSize.width - 55) / 2) *
                                                      (127 / 160),
                                                  height: 40 /
                                                      114 *
                                                      ((screenSize.width - 55) / 2) *
                                                      (127 / 160),
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 8,
                                                  ),
                                                  child: Text(
                                                    'وضعیت ویتامین ها و مواد معدنی',
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15 * fontvar),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            )),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(children: <Widget>[
                          Card(
                            margin:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            elevation: 11,
                            child: Container(
                              padding: EdgeInsets.only(top: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topCenter,
                                              decoration: BoxDecoration(
                                                color: Color(0xffE8FFDD),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              margin: EdgeInsets.only(right: 12),
                                              padding:
                                              EdgeInsets.symmetric(vertical: 7),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    "کالری مصرف شده",
                                                    style: TextStyle(
                                                        color: Color(0xff62BC72),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15 * fontvar),
                                                  ),
                                                  Text(
                                                    "0" + " کالری",
                                                    textDirection:
                                                    TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18 * fontvar,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: 12, top: 10),
                                              padding:
                                              EdgeInsets.symmetric(vertical: 7),
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFF0DD),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    "کالری باقیمانده",
                                                    style: TextStyle(
                                                        color: Color(0xffEF6844),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15 * fontvar),
                                                  ),
                                                  Text(("0") + " کالری",
                                                      textDirection:
                                                      TextDirection.rtl,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18 * fontvar,
                                                          fontWeight:
                                                          FontWeight.w400)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: 0.0476 *
                                                        0.672 *
                                                        (screenSize.width / 2),
                                                    color: Color(0xffE8FFDD),
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                alignment: Alignment.center,
                                                width: (screenSize.width / 2) - 44,
                                                height: (screenSize.width / 2) - 44,
                                                child: Center(
                                                  child: Stack(
                                                    alignment: AlignmentDirectional
                                                        .topCenter,
                                                    children: <Widget>[
                                                      GradientCircularProgressIndicator(
//
                                                        gradientColors: [
                                                          Color(0xff62BC72),
                                                          Color(0xff62BC72)
                                                        ],
                                                        radius: (((screenSize
                                                            .width /
                                                            2) -
                                                            44) /
                                                            2) -
                                                            (0.0476 *
                                                                0.672 *
                                                                (screenSize.width /
                                                                    2)),
//                                              radius: 0.672*(screenSize.width/2)/2,
                                                        strokeWidth:
                                                        (((screenSize.width /
                                                            2) -
                                                            30) /
                                                            12.73),
                                                        value: 0,
                                                        backgroundColor:
                                                        Color(0xffDEE6EE),
                                                        strokeRound: true,
                                                      ),
                                                      Center(
                                                        child:        Image.asset(
                                                          'assets/icons/emoji.png',
                                                          width:
                                                          ((screenSize.width /
                                                              2) -
                                                              44) -
                                                              (0.0476 *
                                                                  0.672 *
                                                                  (screenSize
                                                                      .width)) -
                                                              30,
                                                          height:
                                                          ((screenSize.width /
                                                              2) -
                                                              44) -
                                                              (0.0476 *
                                                                  0.672 *
                                                                  (screenSize
                                                                      .width)) -
                                                              30,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (((screenSize.width /
                                                            2) -
                                                            30) /
                                                            12.73),
                                                        height:
                                                        (((screenSize.width /
                                                            2) -
                                                            30) /
                                                            12.73),
                                                        margin: EdgeInsets.only(
                                                            right: 5),
                                                        decoration:
                                                        new BoxDecoration(
                                                          color: Color(0xff6ADF7D),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            onTap: () async {
                                              // PersianDateTime returnVal =
                                              // await Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         Directionality(
                                              //             textDirection:
                                              //             TextDirection.rtl,
                                              //             child: dailyInfo(
                                              //               date: persianDate1,
                                              //             )),
                                              //   ),
                                              // );
                                              // persianDate1 = returnVal;
                                              // gregorianDate =
                                              //     persianDate1.toGregorian(
                                              //         format: 'YYYY-MM-DD');
                                              // calculateDays();
                                              // print(gregorianDate +
                                              //     "ll" +
                                              //     getDateToday());
                                              // await _getDailyInfo();
                                            }),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 8, left: 12, right: 12, bottom: 10),
                                    padding: EdgeInsets.symmetric(vertical: 7),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFBFFDD),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
//                                        Text(
//                                          '1550',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
                                            Text(
                                              "0",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              'کالری مجاز',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                right: 5,
                                                left: 5,
                                                top: 7 * (screenSize.width / 375)),
                                            child: Icon(
                                              Icons.remove,
                                              size: 20 * (screenSize.width / 375),
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "0",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '   غذا   ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                right: 5,
                                                left: 5,
                                                top: 7 * (screenSize.width / 375)),
                                            child: Icon(
                                              Icons.add,
                                              size: 20 * (screenSize.width / 375),
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "0",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              '  فعالیت  ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                right: 5,
                                                left: 5,
                                                top: 7 * (screenSize.width / 375)),
                                            child: Icon(
                                              Icons.drag_handle,
                                              size: 20 * (screenSize.width / 375),
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
//                                        Text(
//                                          '155',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
                                            Text(("0"),
                                                textDirection: TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18 * fontvar,
                                                    fontFamily: "iransansDN",
                                                    fontWeight: FontWeight.w400)),
                                            Text(
                                              'باقی مانده',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12 * fontvar,
                                                  fontFamily: "iransansDN",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  (_user != null)
                                      ? (calculateAge(_user.birthdate) >= 3)
                                      ? _user.gcalorie == null
                                      ?etebarr < 0
                                      ? Container(
                                      margin: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          bottom: 12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF15A23),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10))),
                                      alignment: Alignment.center,
                                      width: screenSize.width,
                                      child: Stack(
                                        children: [
                                          Text(
                                            'تا پیش از تعیین هدف، کالری مجاز شما کالری حفظ وزن است. برای تعیین هدف ابتدا اشتراک تهیه کنید.',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 15 * fontvar,
                                                color: Colors.white),
                                            textAlign: TextAlign.right,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:    GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 7),
                                                margin: EdgeInsets.only(top: 50,),
                                                decoration: BoxDecoration(color: Colors.white.withOpacity(.8), borderRadius: BorderRadius.all(Radius.circular(8))),

                                                child:  Text(
                                                  "اشتراک تهیه کنید",
                                                  style: TextStyle(fontSize: 12 * fontvar, fontWeight: FontWeight.w500, color: Colors.black),
                                                ),

                                              ),
                                              onTap: () async {
                                                User d = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: storeScreen(menu: true,user: _user,))),
                                                );
                                                if(d!=null){
                                                  setState(() {
                                                    _user.account=d.account;
                                                    getEtebar();

                                                  });
                                                }

                                              },
                                            ),
                                          )
                                        ],
                                      )
                                  )
                                      :Container(
                                      margin: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          bottom: 12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF15A23),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10))),
                                      alignment: Alignment.center,
                                      width: screenSize.width,
                                      child: Stack(
                                        children: [
                                          Text(
                                            'تا پیش از تعیین هدف، کالری مجاز شما کالری حفظ وزن است.',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 15 * fontvar,
                                                color: Colors.white),
                                            textAlign: TextAlign.right,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:    GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 7),
                                                margin: EdgeInsets.only(top: 20 ,),
                                                decoration: BoxDecoration(color: Colors.white.withOpacity(.8), borderRadius: BorderRadius.all(Radius.circular(8))),

                                                child:  Text(
                                                  "هدف تعیین کنید",
                                                  style: TextStyle(fontSize: 12 * fontvar, fontWeight: FontWeight.w500, color: Colors.black),


                                                ),
                                              ),
                                              onTap: () async {
                                                if(_user != null){
                                                  if ( calculateAge(_user.birthdate) < 3)
                                                    showSnakBar(
                                                        "برای زیر سه سال غیر فعال است.");
                                                  else {
                                                    var d = await  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Directionality(
                                                                  textDirection: TextDirection.rtl,
                                                                  child: goalWeight(
                                                                    acountDate: _user.account,
                                                                  ))),
                                                    );
                                                    print("we come back");
                                                    User p=  await getUserFromState();
                                                    setState(() {
                                                      _user=p;
                                                    });
                                                  }
                                                  setState(() {

                                                  });
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                  )
                                      : Container(
                                      margin: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          bottom: 12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffD9F0FF),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(10))),
                                      alignment: Alignment.center,
                                      width: screenSize.width,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            getIdeall() +
                                                "  و وزن هدف شما " +
                                                _user.gweight
                                                    .toString() +
                                                " کیلو می باشد ",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 16 * fontvar,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            getDiff(),
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontSize: 14 * fontvar,
                                                color: Colors.black),
                                          )
                                        ],
                                      ))
                                      : Container(width: 0.0, height: 0.0)
                                      : Container(width: 0.0, height: 0.0)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: <Widget>[
                                Progressbar("0", 'پروتئین'),
                                Progressbar("0", 'کربوهیدرات'),
                                Progressbar("0", 'چربی'),
                              ],
                            ),
                          ),
                          _nots != null
                              ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 13),
                            decoration: BoxDecoration(
                                color: Color(0xffF15A23),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.info,
                                  size: 20 * (screenSize.width / 375),
                                  color: Colors.white,
                                ),
                                Flexible(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Text(
                                        _nots.message,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fontvar,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          )
                              : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                          ),
                          Container(
                            height: ((screenSize.width - 55) / 2) * (127 / 160),
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.5, vertical: 13),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                      height:
                                      ((screenSize.width - 55) / 2) * (127 / 160),
                                      margin: EdgeInsets.symmetric(horizontal: 7.5),
                                      child: RaisedButton(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 2),
                                          color: Color(0xff23AEF1),
                                          onPressed: () async {
                                            // String returnvsl = await showDialog(
                                            //     context: context,
                                            //     builder: (BuildContext context) {
                                            //       return Padding(
                                            //           padding: EdgeInsets.all(0),
                                            //           child: Dialog(
                                            //               elevation: 15,
                                            //               shape: RoundedRectangleBorder(
                                            //                 borderRadius:
                                            //                 BorderRadius.circular(
                                            //                     10),
                                            //               ),
                                            //               backgroundColor:
                                            //               Colors.transparent,
                                            //               child: waterDialog()));
                                            //     });
                                            // print(returnvsl);
                                            // if (returnvsl == "yes") {
                                            //   setState(() {});
                                            //   print(
                                            //       "ddddddddddddddddddddddddddddddddddddddddddddddddd");
                                            //   print(_dailyInfo.water);
                                            // }
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/icons/water.png',
                                                width: 40 /
                                                    114 *
                                                    ((screenSize.width - 55) / 2) *
                                                    (127 / 160),
                                                height: 40 /
                                                    114 *
                                                    ((screenSize.width - 55) / 2) *
                                                    (127 / 160),
                                                color: Colors.white,
                                              ),
//                            if(imageString!=null)  Utility.imageFromBase64String(imageString),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                ),
                                                child: Text(
                                                  _water + ' لیوان آب',
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16 * fontvar),
                                                ),
                                              )
                                            ],
                                          )),
                                    )),
                                Expanded(
                                    child: Container(
                                      height:
                                      ((screenSize.width - 55) / 2) * (127 / 160),
                                      margin: EdgeInsets.symmetric(horizontal: 7.5),
                                      child: RaisedButton(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 2),
                                          color: Color(0xffF15A23),
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => Directionality(
                                            //         textDirection: TextDirection.rtl,
                                            //         child: rizMoghazi(
                                            //           riz: riz(
                                            //               calculateAge(_user.birthdate),
                                            //               _user.gender,
                                            //               _user.birthdate),
                                            //           calorie: _user.calorie,
                                            //         )),
                                            //   ),
                                            // );
                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/icons/rizmoghazi.png',
                                                width: 40 /
                                                    114 *
                                                    ((screenSize.width - 55) / 2) *
                                                    (127 / 160),
                                                height: 40 /
                                                    114 *
                                                    ((screenSize.width - 55) / 2) *
                                                    (127 / 160),
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                ),
                                                child: Text(
                                                  'وضعیت ویتامین ها و مواد معدنی',
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15 * fontvar),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        ]);
                      }
                    },
                    future: _getDailyInfo()),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return snapshot.data != null
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            height: (194 / 166) *
                                (screenSize.width / (375 / 166)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.only(bottom: 8, right: 30),
                                  child: Text(
                                    'دستور پخت غذاهای رژیمی',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "IRANSansDN",
                                      fontSize: 14 * fontvar,
                                      fontWeight: FontWeight.w600,

                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                    child: new ListView.builder(
                                        padding: EdgeInsets.only(right: 20),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _recipes.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              height: (162 / 166) *
                                                  (screenSize.width /
                                                      (375 / 166)),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10)),
                                                  color: Colors.white),
                                              width: screenSize.width /
                                                  (375 / 166),
                                              margin: EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new ClipRRect(
                                                    borderRadius:
                                                    new BorderRadius
                                                        .vertical(
                                                        top:
                                                        Radius
                                                            .circular(
                                                            10),
                                                        bottom: Radius
                                                            .circular(0)),
                                                    child: _recipes[index]
                                                        .free ==
                                                        0 &&
                                                        etebar < 0
                                                        ? Stack(
                                                      children: <
                                                          Widget>[
                                                        FadeInImage.assetNetwork(
                                                          placeholder:'assets/images/placeholder.png',
                                                          image:_recipes[index].cover,
                                                          fit: BoxFit
                                                              .cover,
                                                          fadeInCurve:
                                                          Curves
                                                              .easeIn,
                                                          fadeInDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),
                                                          fadeOutCurve:
                                                          Curves
                                                              .easeOut,
                                                          fadeOutDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),


                                                          height: (107 /
                                                              166) *
                                                              screenSize
                                                                  .width /
                                                              (375 /
                                                                  166),
                                                          width: screenSize
                                                              .width /
                                                              (375 /
                                                                  166),
                                                        ),

                                                        FadeInImage.assetNetwork(
                                                          placeholder:'assets/images/placeholder.png',
                                                          image: _recipes[
                                                          index]
                                                              .cover,
                                                          fit: BoxFit
                                                              .cover,
                                                          fadeInCurve:
                                                          Curves
                                                              .easeIn,
                                                          fadeInDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),
                                                          fadeOutCurve:
                                                          Curves
                                                              .easeOut,
                                                          fadeOutDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),

                                                          height: (107 /
                                                              166) *
                                                              screenSize
                                                                  .width /
                                                              (375 /
                                                                  166),
                                                          width: screenSize
                                                              .width /
                                                              (375 /
                                                                  166),
                                                        ),
                                                        Container(
                                                          color: Colors
                                                              .green
                                                              .withOpacity(
                                                              0.6),
                                                          child: Icon(
                                                            Icons
                                                                .lock_outline,
                                                            color: Colors
                                                                .white,
                                                            size: 50 *
                                                                (screenSize.width /
                                                                    375),
                                                          ),
                                                          height: (107 /
                                                              166) *
                                                              screenSize
                                                                  .width /
                                                              (375 /
                                                                  166),
                                                          width: screenSize
                                                              .width /
                                                              (375 /
                                                                  166),
                                                        ),
                                                      ],
                                                    )
                                                        :
                                                    FadeInImage.assetNetwork(
                                                      placeholder:'assets/images/placeholder.png',
                                                      fit: BoxFit.cover,
                                                      fadeInCurve:
                                                      Curves.easeIn,
                                                      fadeInDuration:
                                                      Duration(
                                                          milliseconds:
                                                          200),
                                                      fadeOutCurve:
                                                      Curves
                                                          .easeOut,
                                                      fadeOutDuration:
                                                      Duration(
                                                          milliseconds:
                                                          200),

                                                      image:
                                                      _recipes[
                                                      index]
                                                          .cover,
                                                      height: (107 /
                                                          166) *
                                                          screenSize
                                                              .width /
                                                          (375 / 166),
                                                      width: screenSize
                                                          .width /
                                                          (375 / 166),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8, right: 5),
                                                    child: Text(
                                                      _recipes[index].name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                          13 * fontvar,
                                                          fontFamily: "IRANSansDN",
                                                          fontWeight:
                                                          FontWeight
                                                              .w400),
                                                      maxLines: 1,
                                                      textAlign:
                                                      TextAlign.center,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                right: 5),
                                                            child: Text(
                                                              '${_recipes[index].total_calorie}' +
                                                                  " کالری برای یک نفر",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffA2A2A2),
                                                                  fontSize: 10 *
                                                                      fontvar,
                                                                  fontFamily: "IRANSansDN",
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                              maxLines: 1,
                                                              textDirection:
                                                              TextDirection
                                                                  .rtl,
                                                            )),
                                                        flex: 2,
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .only(
                                                                  right: 5,
                                                                ),
                                                                child:
                                                                Image.asset(
                                                                  'assets/icons/btm_profile.png',
                                                                  fit: BoxFit.fill,
                                                                  height: 13 *
                                                                      (screenSize
                                                                          .width) /
                                                                      375,
                                                                  width: 13 *
                                                                      (screenSize
                                                                          .width) /
                                                                      375,
                                                                )),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    5,
                                                                    left:
                                                                    10,
                                                                    top:
                                                                    2),
                                                                child: Text(
                                                                  '${_recipes[index].consumer} نفر',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffA2A2A2),
                                                                      fontSize: 9 *
                                                                          fontvar,
                                                                      fontWeight:
                                                                      FontWeight.w500),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        flex: 1,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              _recipes[index].free == 0 &&
                                                  etebar < 0
                                                  ? showSnakBar(
                                                  "شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید.")
                                                  : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Directionality(
                                                      textDirection:
                                                      TextDirection
                                                          .rtl,
                                                      child: regimiFoodDetail(
                                                          catId: _recipes[
                                                          index]
                                                              .id)),
                                                ),
                                              );
                                            },
                                          );
                                        })),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height:
                            (165 / 206) * screenSize.width * (206 / 375),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                  EdgeInsets.only(right: 30, bottom: 8),
                                  child: Text(
                                    'ورزش ها و حرکات ورزشی',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14 * fontvar,
                                        fontFamily: "IRANSansDN",
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                new Expanded(
                                    child: new ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(right: 22),
                                        itemCount: _exercise.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Stack(
                                                children: <Widget>[
                                                  new ClipRRect(
                                                    borderRadius:
                                                    new BorderRadius
                                                        .vertical(
                                                        top:
                                                        Radius
                                                            .circular(
                                                            10),
                                                        bottom: Radius
                                                            .circular(
                                                            10)),
                                                    child: _exercise[index]
                                                        .free ==
                                                        0 &&
                                                        etebar < 0
                                                        ? Stack(
                                                      children: <
                                                          Widget>[

                                                        FadeInImage.assetNetwork(
                                                          placeholder:'assets/images/placeholder.png',
                                                          fadeInCurve:
                                                          Curves
                                                              .easeIn,
                                                          fadeInDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),
                                                          fadeOutCurve:
                                                          Curves
                                                              .easeOut,
                                                          fadeOutDuration:
                                                          Duration(
                                                              milliseconds:
                                                              200),

                                                          image:
                                                          _exercise[
                                                          index]
                                                              .cover,
                                                          height: (135 /
                                                              206) *
                                                              screenSize
                                                                  .width *
                                                              (206 /
                                                                  375),
                                                          width: screenSize
                                                              .width *
                                                              (206 /
                                                                  375),
                                                        ),
                                                        Container(
                                                          color: Colors
                                                              .green
                                                              .withOpacity(
                                                              0.6),
                                                          child: Icon(
                                                            Icons
                                                                .lock_outline,
                                                            color: Colors
                                                                .white,
                                                            size: 50 *
                                                                (screenSize.width /
                                                                    375),
                                                          ),
                                                          height: (135 /
                                                              206) *
                                                              screenSize
                                                                  .width *
                                                              (206 /
                                                                  375),
                                                          width: screenSize
                                                              .width *
                                                              (206 /
                                                                  375),
                                                        )
                                                      ],
                                                    )
                                                        :
                                                    FadeInImage.assetNetwork(
                                                      placeholder:'assets/images/placeholder.png',
                                                      fadeInCurve:
                                                      Curves.easeIn,
                                                      fadeInDuration:
                                                      Duration(
                                                          milliseconds:
                                                          200),
                                                      fadeOutCurve:
                                                      Curves
                                                          .easeOut,
                                                      fadeOutDuration:
                                                      Duration(
                                                          milliseconds:
                                                          200),

                                                      image:
                                                      _exercise[
                                                      index]
                                                          .cover,
                                                      fit: BoxFit.cover,
                                                      height: (135 /
                                                          206) *
                                                          screenSize
                                                              .width *
                                                          (206 / 375),
                                                      width: screenSize
                                                          .width *
                                                          (206 / 375),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)),
                                                      color:
                                                      Color(0xB3363636),
                                                    ),
                                                    height: (135 / 206) *
                                                        screenSize.width *
                                                        (206 / 375),
                                                    width: screenSize.width *
                                                        (206 / 375),
                                                  ),
                                                  Container(
                                                    width: screenSize.width *
                                                        (206 / 375),
                                                    margin: EdgeInsets.only(
                                                        top: 35, right: 5),
                                                    padding: EdgeInsets.only(
                                                        right: 10, bottom: 8),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                          _exercise[index]
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 13 *
                                                                  fontvar,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          _exercise[index]
                                                              .description,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 10 *
                                                                  fontvar,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              _exercise[index].free == 0 &&
                                                  etebar < 0
                                                  ? showSnakBar(
                                                  "شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید.")
                                                  : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Directionality(
                                                      textDirection:
                                                      TextDirection
                                                          .rtl,
                                                      child: exerciseDetail(
                                                          singleId:
                                                          _exercise[
                                                          index]
                                                              .id)),
                                                ),
                                              );
                                            },
                                          );
                                        })),
                              ],
                            ),
                          ),
//                      Container(
//                        margin: EdgeInsets.only(top: 20),
//                        height: (180 / 110) * screenSize.width * (110 / 375),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(right: 30, bottom: 8),
//                              child: Text(
//                                'آلبوم غذایی',
//                                style: TextStyle(
//                                    color: Colors.black,
//                                    ,
//                                    fontSize: 14 * fontvar,
//                                    fontWeight: FontWeight.w600),
//                                textAlign: TextAlign.start,
//                              ),
//                            ),
//                            new Expanded(
//                                child: new ListView.builder(
//                                    scrollDirection: Axis.horizontal,
//                                    itemCount: _albums.length,
//                                    padding: EdgeInsets.only(right: 24),
//                                    itemBuilder: (context, index) {
//                                      return GestureDetector(
//                                        child: Container(
//                                          height: (145 / 110) *
//                                              screenSize.width *
//                                              (110 / 375),
//                                          width: screenSize.width * (110 / 375),
//                                          margin: EdgeInsets.only(
//                                              right: 6, left: 6, bottom: 5),
//                                          child: Column(
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              new ClipRRect(
//                                                borderRadius: new BorderRadius
//                                                        .vertical(
//                                                    bottom:
//                                                        new Radius.circular(10),
//                                                    top: new Radius.circular(
//                                                        10)),
//                                                child: _albums[index].free ==
//                                                            0 &&
//                                                        etebar < 0
//                                                    ? Container(
//                                                        color: Colors.green
//                                                            .withOpacity(0.6),
//                                                        child: Icon(
//                                                          Icons.lock_outline,
//                                                          color: Colors.white,
//                                                          size: 50 *
//                                                              (screenSize
//                                                                      .width /
//                                                                  375),
//                                                        ),
//                                                        height: (106 / 110) *
//                                                            screenSize.width *
//                                                            (110 / 375),
//                                                        width:
//                                                            screenSize.width *
//                                                                (110 / 375),
//                                                      )
//                                                    : FadeInImage(
//                                                        placeholder: AssetImage(
//                                                            'assets/images/placeholder.png'),
//                                                        image: NetworkImage(
//                                                            _albums[index]
//                                                                .cover),
//                                                        fit: BoxFit.fill,
//                                                        height: (106 / 110) *
//                                                            screenSize.width *
//                                                            (110 / 375),
//                                                        width:
//                                                            screenSize.width *
//                                                                (110 / 375),
//                                                      ),
//                                              ),
//                                              Padding(
//                                                padding: EdgeInsets.only(
//                                                    top: 10, right: 3),
//                                                child: Text(
//                                                  _albums[index].name,
//                                                  style: TextStyle(
//                                                      color: Colors.black,
//                                                      fontSize: 13 * fontvar,
//                                                      fontWeight:
//                                                          FontWeight.w500),
//                                                  maxLines: 1,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                        onTap: () {
//                                          _albums[index].free == 0 && etebar < 0
//                                              ? showSnakBar(
//                                                  "شما اشتراک فعالی ندارید. برای دریافت دریافت به فروشگاه بروید.")
//                                              : Navigator.push(
//                                                  context,
//                                                  MaterialPageRoute(
//                                                    builder: (context) =>
//                                                        Directionality(
//                                                            textDirection:
//                                                                TextDirection
//                                                                    .rtl,
//                                                            child: foodAlbumDetail(
//                                                                Catid: _albums[
//                                                                        index]
//                                                                    .id)),
//                                                  ),
//                                                );
//                                        },
//                                      );
//                                    })),
//                          ],
//                        ),
//                      ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 25),
                            height:
                            (220 / 100) * screenSize.width * (100 / 375),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    EdgeInsets.only(right: 30, bottom: 8),
                                    child: Text(
                                      'مکمل های غذایی',
                                      style: TextStyle(
                                          color: Colors.black,

                                          fontSize: 14 * fontvar,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  new Expanded(
                                    child: new ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _supplemen.length,
                                        padding: EdgeInsets.only(right: 25),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 5, left: 5),
                                              width: screenSize.width *
                                                  (110 / 375),
                                              height: (170 / 100) *
                                                  screenSize.width *
                                                  (100 / 375),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  new Container(
                                                    alignment:
                                                    Alignment.center,
                                                    width: screenSize.width *
                                                        (110 / 375),
                                                    height: (120 / 100) *
                                                        screenSize.width *
                                                        (100 / 375),
                                                    decoration: new BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius
                                                                .circular(
                                                                10))),
                                                    child: new ClipRRect(
                                                      borderRadius: new BorderRadius
                                                          .vertical(
                                                          bottom: new Radius
                                                              .circular(10),
                                                          top: new Radius
                                                              .circular(10)),
                                                      child: _supplemen[index]
                                                          .free ==
                                                          0 &&
                                                          etebar < 0
                                                          ? Stack(
                                                        children: <
                                                            Widget>[
                                                          FadeInImage.assetNetwork(
                                                            placeholder:'assets/images/placeholder.png',
                                                            fit: BoxFit
                                                                .cover,
                                                            fadeInCurve:
                                                            Curves
                                                                .easeIn,
                                                            fadeInDuration:
                                                            Duration(
                                                                milliseconds:
                                                                200),
                                                            fadeOutCurve:
                                                            Curves
                                                                .easeOut,
                                                            fadeOutDuration:
                                                            Duration(
                                                                milliseconds:
                                                                200),

                                                            image: _supplemen[
                                                            index]
                                                                .cover,
                                                            width: screenSize
                                                                .width *
                                                                (110 /
                                                                    375),
                                                            height: (120 /
                                                                100) *
                                                                screenSize
                                                                    .width *
                                                                (100 /
                                                                    375),
                                                          ),
                                                          Container(
                                                            color: Colors
                                                                .green
                                                                .withOpacity(
                                                                0.6),
                                                            child: Icon(
                                                              Icons
                                                                  .lock_outline,
                                                              color: Colors
                                                                  .white,
                                                              size: 50 *
                                                                  (screenSize.width /
                                                                      375),
                                                            ),
                                                            width: screenSize
                                                                .width *
                                                                (110 /
                                                                    375),
                                                            height: (120 /
                                                                100) *
                                                                screenSize
                                                                    .width *
                                                                (100 /
                                                                    375),
                                                          )
                                                        ],
                                                      )
                                                          :   FadeInImage.assetNetwork(
                                                        placeholder:'assets/images/placeholder.png',
                                                        fit: BoxFit
                                                            .cover,
                                                        fadeInCurve:
                                                        Curves
                                                            .easeIn,
                                                        fadeInDuration:
                                                        Duration(
                                                            milliseconds:
                                                            200),
                                                        fadeOutCurve:
                                                        Curves
                                                            .easeOut,
                                                        fadeOutDuration:
                                                        Duration(
                                                            milliseconds:
                                                            200),

                                                        image:
                                                        _supplemen[
                                                        index]
                                                            .cover,
                                                        width: screenSize
                                                            .width *
                                                            (110 / 375),
                                                        height: (120 /
                                                            100) *
                                                            screenSize
                                                                .width *
                                                            (100 / 375),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          top: 10,
                                                          right: 3),
                                                      child: Text(
                                                        _supplemen[index]
                                                            .name,
                                                        style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                            fontSize:
                                                            13 * fontvar,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  )
//                                              Container(
//                                                margin:
//                                                EdgeInsets.only(top: 45),
//                                                alignment:
//                                                Alignment.bottomCenter,
//                                                decoration: new BoxDecoration(
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      10.0),
//                                                  color: Colors.white,
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Colors.black26,
//                                                      blurRadius: 5.0,
//                                                      // has the effect of softening the shadow
//                                                      spreadRadius: 1.0,
//                                                      // has the effect of extending the shadow
//                                                      offset: Offset(
//                                                        0.0,
//                                                        // horizontal, move right 10
//                                                        0.0, // vertical, move down 10
//                                                      ),
//                                                    )
//                                                  ],
//                                                ),
//                                                width: 120,
//                                                height: 80,
//                                                child: new Padding(
//                                                  padding: EdgeInsets.only(
//                                                      bottom: 5),
//                                                  child: Text(
//                                                    _supplemen[index].name,
//                                                    style: TextStyle(
//                                                      color: Color(0xff334856),
//                                                      fontSize: 12,
//                                                      fontWeight:
//                                                      FontWeight.w400,
//                                                    ),
//                                                    maxLines: 1,
//                                                    textAlign: TextAlign.center,
//                                                  ),
//                                                ),
//                                              ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              _supplemen[index].free == 0 &&
                                                  etebar < 0
                                                  ? showSnakBar(
                                                  "شما اشتراک فعالی ندارید. برای دریافت اشتراک به فروشگاه بروید.")
                                                  : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Directionality(
                                                      textDirection:
                                                      TextDirection
                                                          .rtl,
                                                      child: mokamelDetail(
                                                          singleId:
                                                          _supplemen[
                                                          index]
                                                              .id)),
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                ]),
                          )
                        ],
                      )
                          : Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 50, right: 8, left: 8),
                          child: Text(
                            "خطا در اتصال به اینترنت",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13 * fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                  future: getmain2(),
                ),
              ]))
        ]));
  }

  Widget Progressbar(String amount, String name) {
    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);
    double value = double.parse(amount);
    String amountText = amount + " گرم ";
    Color colorP;
    int cal =1;
    String actTotal="0.0";
    (_dailyInfo==null)
        ?actTotal="0.0"
        :actTotal=_dailyInfo.total_act??"0";

    if(_user!=null){
      if(_user.calorie!=null)
        if(_dailyInfo!=null)
          cal=_user.calorie+double.parse(actTotal).round();
        else   cal=_user.calorie+double.parse(actTotal??"0").round();
      else cal=_totlaCal+double.parse(actTotal).round();
    }
    else cal=24000;

    // Map rizMap = {"protein": 1};
    // if (_user != null)
    // rizMap = getRiz(int.parse(
    //     riz(calculateAge(_user.birthdate), _user.gender, _user.birthdate)));
    if (name == "پروتئین") {
      value = value / double.parse(
          double.parse((.17 * cal / 4).toString()).toStringAsFixed(1));
      colorP = Color(0xffEF6844);
    }
    if (name == "چربی") {
      value = value /
          double.parse(
              double.parse((.28 * cal / 9).toString()).toStringAsFixed(1));
      colorP = Color(0xffFBD026);
    }
    if (name == "کربوهیدرات") {
      value = value /
          double.parse(
              double.parse((.55 * cal / 4).toString()).toStringAsFixed(1));

      colorP = Color(0xff44BCEF);
    }

    return Expanded(
        child: Card(
            elevation: 11,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 5, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 2, left: 2, top: 7),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14 * fontvar,
                        fontFamily: "iransansDN",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 2, left: 2, bottom: 12),
                  child: Text(
                    amountText,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Color(0xff818181),
                        fontSize: 12 * fontvar,
                        fontFamily: "iransansDN",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      GradientCircularProgressIndicator(
                        gradientColors: [colorP, colorP],
                        radius: (screenSize.width - 158) / 6,
                        strokeWidth: (screenSize.width - 158) / 6 * (8 / 36),
                        value: value,
                        backgroundColor: Color(0xffDEE6EE),
                        strokeRound: true,
                      ),
                      Center(
                        child: Text(
                          (value * 100).toStringAsFixed(1) + "%",
                          style: TextStyle(
                            fontSize: 14.0 * fontvar,
                            fontWeight: FontWeight.w400,
                            fontFamily: "iransansDN",
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  setAlbums() {
    _start.albums.forEach((item) {
      _albums.add(subAbum.fromJson(item));
    });
  }

  setExercise() {
    _start.exercises.forEach((item) {
      _exercise.add(subExercise.fromJson(item));
    });
  }

  setSupp() {
    _start.supplements.forEach((item) {
      _supplemen.add(subSupplement.fromJson(item));
    });
  }

  setRegims() {
    _start.recipes.forEach((item) {
      _recipes.add(subRecipes.fromJson(item));
    });
  }

  Future _getDailyInfo({bool refresh: false}) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    etebar = prefs.getInt('etebar');
//     if (!_justRegims) {
//       var db = new DailyInfoProvider();
//       await db.open();
//       DbDailyInfo products = await db.getByDate(gregorianDate);
// //      await db.close();
//       _dailyInfo = null;
//       _totalCal = 0;
//       _totalActshow = 0;
//
//       if (!(products == null)) {
//         _dailyInfo = products;
//         if (_dailyInfo != null) {
//           print("xxxxxxxxxxxx");
//           print(_dailyInfo.water);
//           _water = _dailyInfo.water;
//           _totalCal = double.parse(_dailyInfo.total_calorie.toString());
//           if (_dailyInfo.total_act != null)
//             _totalActshow = double.parse(_dailyInfo.total_act.toString());
//           else
//             _totalActshow = 0;
//         }
//       }

      User user = await _getUser();
      // if (_nots == null) _nots = await getnotic();

      Map map = {
        "_dailyInfo": _dailyInfo,
        "user": user,
      };

      return map;
    }


  Future _getDailyInfo2({bool refresh: false}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
// //
// //    etebar = prefs.getInt('etebar');
//     if (!_justRegims) {
//       var db = new DailyInfoProvider();
//       await db.open();
//       DbDailyInfo products = await db.getByDate(gregorianDate);
//
// //      await db.close();
//       _dailyInfo = null;
//       _totalCal = 0;
//       _totalActshow = 0;
//
//       if (!(products == null)) {
//         _dailyInfo = products;
//         if (_dailyInfo != null) {
//           _totalCal = double.parse(_dailyInfo.total_calorie.toString());
//           if (_dailyInfo.total_act != null)
//             _totalActshow = double.parse(_dailyInfo.total_act.toString());
//           else
//             _totalActshow = 0;
//         }
//       }
//
//       Map map = {
//         "_dailyInfo": _dailyInfo,
//       };
//
//       return map;
//     }
  }

  _getUser() async {
    var response;
    int etebar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reactiveModel = Injector.getAsReactive<userStore>();
   await reactiveModel.setState(
            (store) => store.getNotNull(context),
        onData:  (context, store)  {

               response=store.user;
              _user=store.user;


              String serverDate = prefs.getString("date") ?? getDateToday();

              String acountDate = response.account;

               etebar = 1;
              if (serverDate != null && acountDate != null && acountDate != "") {
                var persianDateee = PersianDateTime(jalaaliDateTime: acountDate);
                var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
                DateTime datetoday = DateTime.parse(serverDate);
                DateTime dateacount = DateTime.parse(dateEtebarstr);
                etebar = dateacount
                    .difference(datetoday)
                    .inDays;


              }

          // }


        });

    if (etebar < 0 && response.gcalorie!=null){
      response = await deleteGoal(response);
      await updateUserServer(response).then((value) => deleteGoalb=true);}


    etebarr=etebar;




  }


  Future<User> updateUserServer(User user) async {
    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store)  =>
     store.updateUser(context, user.toMap6()),
      onData: (context, userSt) {
        print(userSt.user);
        print("user after update");

      },

      onError: (context, error) {
        print("خطا در برقراری ارتباط");
        // showSnakBar("خطا در برقراری ارتباط");
      },
    );
  }

  Future<User> getUserFromState() async {


    final reactiveModel = Injector.getAsReactive<userStore>();
    reactiveModel.setState(
            (store) => store.getNotNull(context),
        onData:  (context, store){
          return store.user;
        }
    );


  }


  Future<User> deleteGoal(User _user) async {

    print("deleteGoal");

    int res = _user.calorie - _user.gcalorie;
    if (res < 600) res = 600;
    _user.calorie = res;
    _user.gcalorie = null;
    _user.gweight = null;
    _user.gdate = null;
    print(_user.toMap());
    if (await checkConnectionInternet()) updateUserServer(_user);
    return _user;
  }



  static Future<notices> getnotic() async {
//     notices nots;
//     try {
//       var db = new noticsProvider();
//       await db.open();
//       nots = await db.paginate();
// //      await db.close();
//       return nots;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
  }

  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
  }


  String getDiff() {
    int diifff = DateTime.parse(_user.gdate.split("*")[1])
        .difference(DateTime.parse(getDateToday()))
        .inDays;
    if (diifff <= 0)
      return "زمان هدف شما به پایان رسیده ";
    else
      return diifff.toString() + " روز مانده تا وزن هدف ";
  }

  String getIdeall() {
    if (_user.ideal_weight.toString() != null)
      return " وزن ایده آل شما " + _user.ideal_weight.toString() + " کیلو";
    else
      return "";
  }

  void getEtebar() {

    if (_user != null &&
        _serverDate != null &&
        _user.account != null &&
        _user.account != "") {
      var persianDateee = PersianDateTime(jalaaliDateTime: _user.account);
      var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
      DateTime datetoday = DateTime.parse(_serverDate);
      DateTime dateacount = DateTime.parse(dateEtebarstr);
      print(dateacount.difference(datetoday).inDays.toString() +
          "fffffffffffffffffff");

      etebar = dateacount.difference(datetoday).inDays;
      etebarr=etebar;
    }

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

  showDays(PersianDateTime date, int i) {
    var dateNow = PersianDateTime.fromGregorian();
    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);
    bool enable =
        (date.isBefore(dateNow)) || (date.difference(dateNow).inDays == 0);

    return Column(
      children: <Widget>[
        Text(
          arrayDaysName[i],
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
            setState(() {
              print(arrayDaysEnable[i]);
              arrayDaysEnable = [
                false,
                false,
                false,
                false,
                false,
                false,
                false
              ];
              arrayDaysEnable[i] = true;

              persianDate1 =
                  PersianDateTime(jalaaliDateTime: date.toString());
              gregorianDate =
                  persianDate1.toGregorian(format: 'YYYY-MM-DD');
//           calculateDays();
              print(gregorianDate + "ll" + getDateToday());
              _getDailyInfo2();
              dateCall.saveDate(persianDate1);
            });
          }
              : null,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 3),
            height: (screenSize.width - 85) / 8,
            width: (screenSize.width - 85) / 8,
            decoration: BoxDecoration(
              color: enable
                  ? arrayDaysEnable[i] ? Color(0XFF62BC72) : Colors.white
                  : Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(
                  width: 1,
                  color: arrayDaysEnable[i]
                      ? Color(0xff62BC72)
                      : Color(0xffE8E8E8)),
            ),
            child: Text(
              date.jalaaliDay.toString(),
              style: TextStyle(
                color: arrayDaysEnable[i] ? Colors.white : Color(0XFF242424),
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

  calculateDays() async{


    int todayDay = persianDate1.jalaaliDay;
    int dayOfWeek = DateTime.parse(gregorianDate).weekday;

    switch (dayOfWeek) {
      case 1:
        {
          arrayIndex = 2;
          break;
        }

      case 2:
        {
          arrayIndex = 3;
          break;
        }

      case 3:
        {
          arrayIndex = 4;
          break;
        }

      case 4:
        {
          arrayIndex = 5;
          break;
        }

      case 5:
        {
          arrayIndex = 6;
          break;
        }

      case 6:
        {
          arrayIndex = 0;
          break;
        }

      case 7:
        {
          arrayIndex = 1;
          break;
        }
    }

    setState(() {
      arrayDaysEnable = [false, false, false, false, false, false, false];
      arrayDaysEnable[arrayIndex] = true;
      print(arrayIndex.toString() + "kjkjkjkjkj");

      for (int i = 0; i < 7; i++) {
        var persianDateee = PersianDateTime.fromGregorian(
            gregorianDateTime:
            getCustomDate2(i - arrayIndex, DateTime.parse(gregorianDate)));
        arrayDays[i] = (persianDateee);
      }
    });
  }

  getEmoji() {
    (_dailyInfo != null && _user != null && _user.calorie != null)
        ? double.parse(_dailyInfo.total_calorie) / _user.calorie ?? _totlaCal
        : 0;
  }



  Future getmain2() async {
    print("getmain2222222222");

    if (_recipes.isEmpty) {
      _start = await getProducts();
      if (_start != null && _user != null) {
        _serverDate = _start.server_date;
        // _serverDate = "2021-06-11 00:00:00";
        getEtebar();
        print("homestart+" + _start.toString());

        _recipes = [];
        _supplemen = [];
        _exercise = [];
        _albums = [];

        setAlbums();
        setRegims();
        setExercise();
        setSupp();
      }
    }

    return _start;
  }

  Future<start> getProducts() async {
    if (await checkConnectionInternet()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String apiToken = prefs.getString('user_token');

      try {
        final response = await Provider.of<apiServices>(context, listen: false)
            .getStart2(getDateTodayServer(), "0", 'Bearer ' + apiToken);



        if (response.statusCode == 200) {
          final post = json.decode(response.bodyString);

          deleteGoalb=false;
          await _getUser();
          start starts;
          starts = start.fromJson(post);
          prefs.setString("date", starts.server_date);
          return starts;
        } else {
          return null;
        }
      } catch (e) {
        print(e.toString() + "catttttch");
        return null;
      }
    } else
      return null;
  }


}
