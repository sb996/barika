//import 'dart:async';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'package:gradient_progress/gradient_progress.dart';
//import 'package:barika/exercise/Exercise.dart';
//import 'package:barika/exercise/exerciseDetail.dart';
//import 'package:barika/foodAlbum/foodAlbum.dart';
//import 'package:barika/foodAlbum/foodAlbumDetail.dart';
//import 'package:barika/home/rizmoghazi.dart';
//import 'package:barika/models/DbAllDiets.dart';
//import 'package:barika/models/DbDailyInfo.dart';
//import 'package:barika/models/start.dart';
//import 'package:barika/models/user.dart';
//import 'package:barika/models/subAlbums.dart';
//import 'package:barika/models/subExercises.dart';
//import 'package:barika/models/subRecipes.dart';
//import 'package:barika/models/subSupplement.dart';
//import 'package:barika/mokamel/mokamel.dart';
//import 'package:barika/mokamel/mokamelDetail.dart';
//import 'package:barika/regimiFood/regimiFoodDetail.dart';
//import 'package:barika/regimiFood/regimiFoodList.dart';
//import 'package:barika/regims/regimList.dart';
//import 'package:barika/sqliteProvider/allDietProvider.dart';
//import 'package:barika/sqliteProvider/dailyInfoProvider.dart';
//import 'package:barika/sqliteProvider/noticsProvider.dart';
//import 'package:barika/sqliteProvider/provider.dart';
//import 'package:barika/sqliteProvider/userProvider.dart';
//import 'package:barika/utils/colors.dart';
//import 'package:barika/utils/date.dart';
//import 'package:persian_datepicker/persian_datepicker.dart';
//import 'package:persian_datepicker/persian_datetime.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import '../helper.dart';
//import 'daily_info.dart';
//import 'package:jalali_calendar/jalali_calendar.dart';
//import 'package:persian_date/persian_date.dart';
//
//class HomeScreen extends StatefulWidget {
//  var contextt;
//  final reload;
//  final  start;
//
//  HomeScreen({Key key, this.reload, this.contextt,this.start}) : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() => new HomeScreenState();
//}
//class HomeScreenState extends State<HomeScreen>
//    with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin<HomeScreen> {
//  @override
//  bool get wantKeepAlive => true;
//  bool _etebarbool=false;
//  AnimationController _controller;
//
//  bool _justRegims = false;
//  bool first = true;
//  ProviderDb dbHelper;
//  Animation animation;
//  User _user;
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//String  diifff;
//  final double size = 25;
//  final Color backgroundColor = Colors.amber;
//  final Color color = Colors.green;
//  bool has = false;
//  start _start;
//  String _serverDate;
//  List<subRecipes> _recipes = [];
//  List<subSupplement> _supplemen = [];
//  List<subExercise> _exercise = [];
//  List<subAbum> _albums = [];
//  int _totlaCal = 240000;
//  List<String> _tags = [
//    'آلبوم غذایی',
//    'مکمل های غذایی',
//    'دستور پخت غذا های رژیمی',
//    'حرکات ورزشی',
//  ];
//  List<String> _tagsRouts = [
//    '/album',
//    '/mokamel',
//    '/regimi',
//    '/exercise',
//  ];
//  List<DbAllDiets> _DbAllDietsList = [];
//  int etebar=-1;
//  String gregorianDate;
//  DbDailyInfo _dailyInfo;
//  double _totalFoodCal = 0;
//  double _totalCal = 0;
//  double _totalActshow = 0;
//  double _totalfoodshow = 0;
//  Color textColor = Color(0xff555555);
//  String reload = "no";
//  AnimationController _animationController;
//  List<String> _weekDay = [
//    'دوشنبه',
//    'سه شنبه',
//    'چهارشنبه',
//    'پنجشنبه',
//    'جمعه',
//    'شنبه',
//    'یکشنبه',
//  ];
//  static PersianDateTime persianDate1;
//  StreamSubscription<int> _subscription;
//  String _stepCountValue = 'unknown';
//  PersianDatePickerWidget persianDatePicker;
//  final TextEditingController textEditingController = TextEditingController();
//  String _selecteddate;
//
//  @override
//  void dispose() {
//    _controller.dispose();
//    super.dispose();
//  }
////  startTime() {
////    var _duration = new Duration(seconds: 2);
////    return new Timer(_duration,  (){
////
////        setAlbums();
////        setRegims();
////        setExercise();
////        setSupp();
////
////    });
////  }
////  startTime1() {
////    var _duration = new Duration(seconds: 2);
////    return new Timer(_duration,getProducts());
////  }
//  @override
//  void initState() {
//
//
//    _controller = AnimationController(vsync: this);
//    print((DateTime.parse("2020-01-21").difference(DateTime.now())).inDays.toString()+"sedfsrgs");
////    getWeekDay();
//    persianDate1 = dateCall.getDate() == null
//        ? PersianDateTime.fromGregorian()
//        : PersianDateTime.fromGregorian(
//            gregorianDateTime: dateCall.getDate()); //
//    gregorianDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//
//    if (dateCall.getDate() == null) {
//      dateCall.saveDate(persianDate1);
//    }
//    persianDatePicker = PersianDatePicker(
//      controller: textEditingController,
//      farsiDigits: false,
//      onChange: (String oldText, String newText) {
//        _selecteddate = newText;
//        print(_selecteddate);
//        persianDate1 = PersianDateTime(jalaaliDateTime: _selecteddate);
//        gregorianDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//        print(gregorianDate + "ll" + getDateToday());
//        _getDailyInfo();
//        dateCall.saveDate(persianDate1);
//        Navigator.pop(context);
//      },
//      maxDatetime:getDateToday(),
//
//      // datetime: '1397/06/09',
//      // finishDatetime: '1397/06/15',
//    ).init();
//
////    startTime1();
////    _albums.clear(
////    );
////    _recipes.clear();
////    _exercise.clear();
////    _supplemen.clear();
//
//
//    super.initState();
//  }
//  Future getmain() async {
//    _DbAllDietsList = widget.reload ?? [];
//    print(_DbAllDietsList.length.toString() + "fdfdfd");
//  }
//  Future getmain2() async {
//    _start = widget.start ?? null;
//    if (_start != null && _user != null) {
//      _serverDate = _start.server_date;
//      getEtebar();
//      print("homestart+" + _start.toString());
//
//      _recipes = [];
//      _supplemen = [];
//      _exercise = [];
//      _albums = [];
//
//      setAlbums();
//      setRegims();
//      setExercise();
//      setSupp();
//    }
//
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    Size screenSize = MediaQuery.of(context).size;
//    if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//    return new Scaffold(
//    key: _scaffoldKey,
//        body: CustomScrollView(slivers: <Widget>[
//      SliverAppBar(
//        automaticallyImplyLeading: false,
//        elevation: 85,
//        centerTitle: true,
//        flexibleSpace: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//
//              colors: <Color>[
//                Color(0xff4C932B),
//                Color(0xff56AB2F),
//                Color(0xffA8E063)
//              ],
//            ),
//          ),
//          child: Row(
//            children: <Widget>[
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
//                alignment: Alignment.center,
//                margin: EdgeInsets.symmetric(vertical: 5),
//
//                child: GestureDetector(
//                  child: Stack(textDirection: TextDirection.rtl, children: <
//                      Widget>[
//                    Center(
//                      child: Container(
//                        alignment: Alignment.center,
//                        width: 150.0,
//                        height: 70.0,
//                        decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.all(Radius.circular(10)),
//                        ),
//                        child: Text(
//                          (getWeekDay() - 1) >= 7
//                              ? _weekDay[(getWeekDay() - 1) - 7] +
//                                  ' ' +
//                                  persianDate1.toString()
//                              : _weekDay[getWeekDay() - 1] +
//                                  ' ' +
//                                  persianDate1.toString(),
//                          style: TextStyle(fontSize: 13, color: Colors.green),
//                        ),
//                        margin: EdgeInsets.symmetric(horizontal: 20),
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(right: 5),
//                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                      decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          color: Colors.green,
//                          border: Border.all(color: Colors.white, width: 1)),
//                      child: SvgPicture.asset(
//                        'assets/icons/calendar.svg',
//                        width: 26,
//                        height: 26,
//                        color: Colors.white,
//                      ),
//                    ),
//                  ]),
//                  onTap: () {
////
//                    FocusScope.of(context).requestFocus(
//                        new FocusNode()); // to prevent opening default keyboard
//                    showModalBottomSheet(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return persianDatePicker;
//                        });
//                  },
//                ),
////
//              ),
//              Expanded(
//                  child: Container(
//                child: SvgPicture.asset(
//                  'assets/icons/logo.svg',
//                  alignment: Alignment.centerLeft,
//                  width: 38,
//                  height: 43,
//                ),
//                margin: EdgeInsets.only(left: 20),
//              ))
//            ],
//          ),
//        ),
//      ),
//      SliverList(
//          delegate: SliverChildListDelegate(<Widget>[
//        FutureBuilder(
//            builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.done) {
//                print(snapshot.toString());
//                return Container(
//                  margin: EdgeInsets.only(top: 8),
//                  padding: EdgeInsets.only(bottom: 5, top: 5),
//                  color: Colors.white,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(right: 5),
//                        alignment: Alignment.topRight,
//                        child: Text(
//                          'رژیم درمانی آنلاین',
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w500,
//                              color: textColor),
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                      Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          textDirection: TextDirection.rtl,
//                          children: <Widget>[
//                            Regims(
//                                'کاهش وزن',
//                                'assets/icons/Rkahesh.svg',
//                                Color(0xffFABE06),
//                                "weight_loss",
//                                _DbAllDietsList),
//                            Regims(
//                                'افزایش وزن',
//                                'assets/icons/Rafzayesh.svg',
//                                Color(0xffEA8B1D),
//                                "weight_gain",
//                                _DbAllDietsList),
//                            Regims('حفظ وزن', 'assets/icons/kg.svg',
//                                Color(0xffE73334), "weight_fix", _DbAllDietsList),
//                            Regims(
//                                'بارداری ',
//                                'assets/icons/Rbardar.svg',
//                                Color(0xff0ABAB8),
//                                "pregnancy",
//                                _DbAllDietsList),
//                          ]),
//                      Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          textDirection: TextDirection.rtl,
//                          children: <Widget>[
//                            Regims(
//                                'شیردهی',
//                                'assets/icons/Rshir.svg',
//                                Color(0xff158BCB),
//                                "lactation",
//                                _DbAllDietsList),
//                            Regims(
//                                'کودکان و نوزادان',
//                                'assets/icons/Rkoodak.svg',
//                                Color(0xff7054BA),
//                                "children",
//                                _DbAllDietsList),
//                            Regims('ورزشکاری', 'assets/icons/Rvarzeshkar.svg',
//                                Color(0xffA418B9), "athletes", _DbAllDietsList),
//                            Regims(
//                                'گیاه خواری',
//                                'assets/icons/Rgiahkhar.svg',
//                                Color(0xff6BBE4A),
//                                "vegetarian",
//                                _DbAllDietsList),
//                          ]),
//                    ],
//                  ),
//                );
//              } else {
//                return Container(
//                  margin: EdgeInsets.only(top: 8),
//                  padding: EdgeInsets.only(bottom: 5, top: 5),
//                  color: Colors.white,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(right: 5),
//                        alignment: Alignment.topRight,
//                        child: Text(
//                          'رژیم درمانی آنلاین',
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w500,
//                              color: textColor),
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                      Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          textDirection: TextDirection.rtl,
//                          children: <Widget>[
//                            Regims('کاهش وزن', 'assets/icons/Rkahesh.svg',
//                                Color(0xffFABE06), "weight_loss", []),
//                            Regims('افزایش وزن', 'assets/icons/Rafzayesh.svg',
//                                Color(0xffEA8B1D), "weight_gain", []),
//                            Regims('حفظ وزن', 'assets/icons/Rgensiat.svg',
//                                Color(0xffE73334), "weight_fix", []),
//                            Regims('بارداری ', 'assets/icons/Rbardar.svg',
//                                Color(0xff0ABAB8), "pregnancy", []),
//                          ]),
//                      Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          textDirection: TextDirection.rtl,
//                          children: <Widget>[
//                            Regims('شیردهی', 'assets/icons/Rshir.svg',
//                                Color(0xff158BCB), "lactation", []),
//                            Regims(
//                                'کودکان و نوزادان',
//                                'assets/icons/Rkoodak.svg',
//                                Color(0xff7054BA),
//                                "children", []),
//                            Regims('ورزشکاری', 'assets/icons/Rvarzeshkar.svg',
//                                Color(0xffA418B9), "athletes", []),
//                            Regims('گیاه خواری', 'assets/icons/Rgiahkhar.svg',
//                                Color(0xff6BBE4A), "vegetarian", []),
//                          ]),
//                    ],
//                  ),
//                );
//              }
//            },
//            future: getmain()),
//        FutureBuilder(
//            builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.done) {
//                print(snapshot.error.toString() + "pp");
//                return Container(
//                    margin: EdgeInsets.only(top: 10),
//                    padding: EdgeInsets.only(bottom: 5, right: 5, top: 5),
//                    color: Colors.white,
//                    child: Column(
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(right: 5),
//                              child: Text(
//                                'کالری شمار',
//                                style: TextStyle(
//                                    color: Color(0xff5A5A5A),
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.w500),
//                              ),
//                            ),
//                            FlatButton(
//                                onPressed: () async {
//                                  PersianDateTime returnVal =
//                                      await Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => Directionality(
//                                          textDirection: TextDirection.rtl,
//                                          child: dailyInfo(
//                                            date: persianDate1,
//                                          )),
//                                    ),
//                                  );
//
//                                  persianDate1 = PersianDateTime.fromGregorian(
//                                      gregorianDateTime: dateCall.getDate());
//                                  gregorianDate = persianDate1.toGregorian(
//                                      format: 'YYYY-MM-DD');
//                                  print(gregorianDate + "ll" + getDateToday());
//                                  _getDailyInfo();
//                                },
//                                child: Container(
//                                  width: 80,
//                                  height: 35,
//                                  decoration: BoxDecoration(
//                                      color: Colors.black26,
//                                      borderRadius:
//                                          BorderRadius.all(Radius.circular(8))),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.edit,
//                                        color: Colors.white,
//                                        size: 20,
//                                      ),
//                                      Padding(
//                                        padding: EdgeInsets.only(right: 5),
//                                        child: Text(
//                                          "ویرایش",
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color: Colors.white),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ))
//                          ],
//                        ),
//                        Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  Progressbar(
//                                      _dailyInfo == null
//                                          ? "0"
//                                          : _dailyInfo.total_protein,
//                                      'پروتئین'),
//                                  Progressbar(
//                                      _dailyInfo == null
//                                          ? "0"
//                                          : _dailyInfo.total_fat,
//                                      'چربی'),
//                                  Progressbar(
//                                      _dailyInfo == null
//                                          ? "0"
//                                          : _dailyInfo.total_carb,
//                                      'کربوهیدرات'),
//                                ]),
//                            Expanded(
//                                child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.end,
//                              children: <Widget>[
//                                GestureDetector(
//                                    child: Container(
//                                        decoration: new BoxDecoration(
//                                          color: Colors.white,
//                                          boxShadow:
//                                          (_dailyInfo != null && _user!=null && _user.calorie!=null)
//                                              ? (double.parse(_dailyInfo
//                                              .total_calorie) /
//                                              _user.calorie??_totlaCal)>1
//                                              ?
//                                          [
//                                            BoxShadow(
//                                              color:       Color(0xffF19623),
//                                              blurRadius: 10.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 2.0,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                0.0,
//                                                // horizontal, move right 10
//                                                0.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ]
//
//                                              :
//                                          [
//                                            BoxShadow(
//                                              color: Color(0xae6CBD45),
//                                              blurRadius: 10.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 2.0,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                0.0,
//                                                // horizontal, move right 10
//                                                0.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ]
//                                              :
//                                          [
//                                            BoxShadow(
//                                              color: Color(0xae6CBD45),
//                                              blurRadius: 10.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 2.0,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                0.0,
//                                                // horizontal, move right 10
//                                                0.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ],
//
//
//                                          border: Border.all(
//                                            width: 10,
//                                            color: Color(0xaaE8FFDD),
//                                          ),
//                                          shape: BoxShape.circle,
//                                        ),
//                                        margin:
//                                            EdgeInsets.only(top: 15, left: 15),
//                                        alignment: Alignment.center,
//                                        width: 130,
//                                        height: 130,
//                                        child: Center(
//                                          child: Stack(
//                                            alignment:
//                                                AlignmentDirectional.topCenter,
//                                            children: <Widget>[
//                                              GradientCircularProgressIndicator(
//                                                gradientColors:
//                                                (_dailyInfo != null && _user!=null && _user.calorie!=null)
//                                                    ? (double.parse(_dailyInfo
//                                                    .total_calorie) /
//                                                    _user.calorie??_totlaCal)>1
//                                                    ?  [
//                                                  Color(0xffF19623),
//                                                  Color(0xffDB2A2A),
//                                                ]
//                                                    :
//                                                [
//                                                  Color(0xff03B8CB),
//                                                  Color(0xffBDFF3F)
//                                                ]
//                                                    :
//                                                [
//                                                  Color(0xff03B8CB),
//                                                  Color(0xffBDFF3F)
//                                                ],
//                                                radius: 55,
//                                                strokeWidth: 11.0,
//                                                value: (_dailyInfo != null && _user!=null && _user.calorie!=null)
//                                                    ? double.parse(_dailyInfo
//                                                            .total_calorie) /
//                                                        _user.calorie??_totlaCal
//                                                    : 0,
//                                                backgroundColor:
//                                                    Color(0xffDEE6EE),
//                                                strokeRound: true,
//                                              ),
//                                              Center(
//                                                child: Column(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.center,
//                                                  crossAxisAlignment:
//                                                      CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                     Text(
//                                                        _totalCal.toStringAsFixed(0),  textDirection: TextDirection.ltr,
//                                                        style: TextStyle(
//                                                            fontSize: 15.0,
//                                                            fontWeight:
//                                                            FontWeight
//                                                                .w400),
//                                                      ),
//
//                                                    Text(
//                                                      'از',
//                                                      style: TextStyle(
//                                                          fontSize: 15.0,
//                                                          fontWeight:
//                                                              FontWeight.w400),
//                                                    ),
//
//                                                    _user!=null?  _user.calorie==null?   Icon(Icons.all_inclusive,size: 19,)
//                                                        :  Row(
//                                                      mainAxisAlignment: MainAxisAlignment.center,
//
//                                                      children: <Widget>[
//                                                        Text(
//                                                          _user.calorie.toStringAsFixed(0),  textDirection: TextDirection.ltr,
//                                                          style: TextStyle(
//                                                              fontSize: 15,
//                                                              fontWeight: FontWeight.w400),
//                                                        ),
//                                                        Text(" کالری ",style: TextStyle(fontSize: 12),)
//
//                                                      ],
//                                                    )
//                                                        :Icon(Icons.all_inclusive,size: 19,),
//
//                                                  ],
//                                                ),
//                                              ),
//                                              Container(
//                                                width: 12,
//                                                height: 12,
//                                                margin:
//                                                    EdgeInsets.only(right: 5),
//                                                decoration: new BoxDecoration(
//                                                  color: Color(0xff6ADF7D),
//                                                  shape: BoxShape.circle,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        )),
//                                    onTap: () async {
//                                      PersianDateTime returnVal =
//                                          await Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => Directionality(
//                                              textDirection: TextDirection.rtl,
//                                              child: dailyInfo(
//                                                date: persianDate1,
//                                              )),
//                                        ),
//                                      );
//                                      persianDate1 = returnVal;
//                                      gregorianDate = persianDate1.toGregorian(
//                                          format: 'YYYY-MM-DD');
//                                      print(gregorianDate +
//                                          "ll" +
//                                          getDateToday());
//                                      _getDailyInfo();
//                                    }),
//                                Container(
//                                  margin: EdgeInsets.only(top: 18, left: 8),
//                                  child: Row(
//                                    textDirection: TextDirection.ltr,
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    children: <Widget>[
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                        Text(
////                                          '1550',
////                                          style: TextStyle(
////                                              color: textColor,
////                                              fontSize: 15,
////                                              fontWeight: FontWeight.w400),
////                                        ),
//                                          _user!=null?  _user.calorie==null?   Icon(Icons.all_inclusive,size: 19,)
//                                              :    Text(
//                                            _user.calorie.toStringAsFixed(0),  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          )
//                                              :Icon(Icons.all_inclusive,size: 19,),
//                                          Text(
//                                            'کالری مجاز',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '-',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w700),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(
//                                            _dailyInfo != null
//                                                ? (double.parse(_dailyInfo
//                                                                .total_act ??
//                                                            "0") +
//                                                        double.parse(_dailyInfo
//                                                                .total_calorie ??
//                                                            "0"))
//                                                    .toStringAsFixed(0)
//                                                : "0",  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                          Text(
//                                            'غذا',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '+',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(
//                                            _dailyInfo != null
//                                                ? (double.parse(_dailyInfo.total_act).toStringAsFixed(0) ?? "0")
//
//                                                : "0",  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                          Text(
//                                            'فعالیت',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '=',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                        Text(
////                                          '155',
////                                          style: TextStyle(
////                                              color: textColor,
////                                              fontSize: 15,
////                                              fontWeight: FontWeight.w400),
////                                        ),
//                                          _user!=null&&_dailyInfo!=null?
//                                          _user.calorie==null?
//                                          Icon(Icons.all_inclusive,size: 19,)
//                                              :Text(((_user.calorie-_totalCal).toStringAsFixed(0)),  textDirection: TextDirection.ltr,)
//                                              :Text(("0"),  textDirection: TextDirection.ltr,),
//                                          Text(
//                                            'باقی مانده',  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                    ],
//                                  ),
//                                )
//                              ],
//                            ))
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            guide(Color(0xffFCFC24), 'کم'),
//                            guide(Color(0xff9EFC24), 'مناسب'),
//                            guide(Color(0xffF19623), 'زیاد'),
//                            guide(Color(0xffDB2A2A), 'خیلی زیاد'),
//                          ],
//                        )
//                      ],
//                    ));
//              } else {
//                return Container(
//                    margin: EdgeInsets.only(top: 10),
//                    padding: EdgeInsets.only(bottom: 5, right: 5, top: 5),
//                    color: Colors.white,
//                    child: Column(
//                      children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(right: 5),
//                              child: Text(
//                                'کالری شمار',
//                                style: TextStyle(
//                                    color: Color(0xff5A5A5A),
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.w500),
//                              ),
//                            ),
//                            FlatButton(
//                                onPressed: () async {
//                                  PersianDateTime returnVal =
//                                      await Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => Directionality(
//                                          textDirection: TextDirection.rtl,
//                                          child: dailyInfo(
//                                            date: persianDate1,
//                                          )),
//                                    ),
//                                  );
//                                  persianDate1 = returnVal;
//                                  gregorianDate = persianDate1.toGregorian(
//                                      format: 'YYYY-MM-DD');
//                                  print(gregorianDate + "ll" + getDateToday());
//                                  _getDailyInfo();
//                                },
//                                child: Container(
//                                  width: 80,
//                                  height: 35,
//                                  decoration: BoxDecoration(
//                                      color: Colors.black26,
//                                      borderRadius:
//                                          BorderRadius.all(Radius.circular(8))),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.edit,
//                                        color: Colors.white,
//                                        size: 20,
//                                      ),
//                                      Padding(
//                                        padding: EdgeInsets.only(right: 5),
//                                        child: Text(
//                                          "ویرایش",
//                                          style: TextStyle(
//                                              fontSize: 12,
//                                              color: Colors.white),
//                                        ),
//                                      )
//                                    ],
//                                  ),
//                                ))
//                          ],
//                        ),
//                        Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  Progressbar('0', 'پروتئین'),
//                                  Progressbar('0', 'چربی'),
//                                  Progressbar('0', 'کربوهیدرات'),
//                                ]),
//                            Expanded(
//                                child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.end,
//                              children: <Widget>[
//                                GestureDetector(
//                                    child: Container(
//                                        decoration: new BoxDecoration(
//                                          color: Colors.white,
//                                          boxShadow:
//
//                                          (_dailyInfo != null && _user!=null && _user.calorie!=null)
//                                              ? (double.parse(_dailyInfo
//                                              .total_calorie) /
//                                              _user.calorie??_totlaCal)>1
//                                              ?
//                                          [
//                                            BoxShadow(
//                                              color:       Color(0xffF19623),
//                                              blurRadius: 10.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 2.0,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                0.0,
//                                                // horizontal, move right 10
//                                                0.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ]
//
//                                              :
//                                          [
//                                            BoxShadow(
//                                              color: Color(0xae6CBD45),
//                                              blurRadius: 10.0,
//                                              // has the effect of softening the shadow
//                                              spreadRadius: 2.0,
//                                              // has the effect of extending the shadow
//                                              offset: Offset(
//                                                0.0,
//                                                // horizontal, move right 10
//                                                0.0, // vertical, move down 10
//                                              ),
//                                            )
//                                          ]
//                                              :
//                                    [
//                                    BoxShadow(
//                                    color: Color(0xae6CBD45),
//                              blurRadius: 10.0,
//                              // has the effect of softening the shadow
//                              spreadRadius: 2.0,
//                              // has the effect of extending the shadow
//                              offset: Offset(
//                                0.0,
//                                // horizontal, move right 10
//                                0.0, // vertical, move down 10
//                              ),
//                            )
//                          ],
//
//
//
//                                          border: Border.all(
//                                            width: 10,
//                                            color: Color(0xaaE8FFDD),
//                                          ),
//                                          shape: BoxShape.circle,
//                                        ),
//                                        margin:
//                                            EdgeInsets.only(top: 15, left: 15),
//                                        alignment: Alignment.center,
//                                        width: 130,
//                                        height: 130,
//                                        child: Center(
//                                          child: Stack(
//                                            alignment:
//                                                AlignmentDirectional.topCenter,
//                                            children: <Widget>[
//                                              GradientCircularProgressIndicator(
//                                                gradientColors:  (_dailyInfo != null && _user!=null && _user.calorie!=null)
//                                                    ? (double.parse(_dailyInfo
//                                                    .total_calorie) /
//                                                    _user.calorie??_totlaCal)>1
//                                                    ?  [
//                                                  Color(0xffF19623),
//                                                  Color(0xffDB2A2A),
//                                                ]
//                                                    :
//                                                [
//                                                  Color(0xff03B8CB),
//                                                  Color(0xffBDFF3F)
//                                                ]
//                                                    :
//                                                [
//                                                  Color(0xff03B8CB),
//                                                  Color(0xffBDFF3F)
//                                                ],
//                                                radius: 55,
//                                                strokeWidth: 11.0,
//                                                value: 0,
//                                                backgroundColor:
//                                                    Color(0xffDEE6EE),
//                                                strokeRound: true,
//                                              ),
//                                              Center(
//                                                child: Column(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.center,
//                                                  crossAxisAlignment:
//                                                      CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Text(
//                                                      '0',
//                                                      style: TextStyle(
//                                                          fontSize: 14.0,
//                                                          fontWeight:
//                                                              FontWeight.w400),
//                                                    ),     Text(
//                                                      'از',
//                                                      style: TextStyle(
//                                                          fontSize: 11.0,
//                                                          fontWeight:
//                                                              FontWeight.w400),
//                                                    ),
//                                                    Padding(
//                                                      padding: EdgeInsets.only(
//                                                          top: 8),
//                                                      child: Text(
//                                                        '0.0',
//                                                        style: TextStyle(
//                                                            fontSize: 17.0,
//                                                            fontWeight:
//                                                                FontWeight
//                                                                    .w400),
//                                                      ),
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                              Container(
//                                                width: 12,
//                                                height: 12,
//                                                margin:
//                                                    EdgeInsets.only(right: 5),
//                                                decoration: new BoxDecoration(
//                                                  color: Color(0xff6ADF7D),
//                                                  shape: BoxShape.circle,
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        )),
//                                    onTap: () async {
//                                      PersianDateTime returnVal =
//                                          await Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => Directionality(
//                                              textDirection: TextDirection.rtl,
//                                              child: dailyInfo(
//                                                date: persianDate1,
//                                              )),
//                                        ),
//                                      );
//                                      persianDate1 = returnVal;
//                                      gregorianDate = persianDate1.toGregorian(
//                                          format: 'YYYY-MM-DD');
//                                      print(persianDate1.toString() +
//                                          "ll" +
//                                          getDateToday());
//                                      _getDailyInfo();
//                                    }),
//                                Container(
//                                  margin: EdgeInsets.only(top: 18, left: 8),
//                                  child: Row(
//                                    textDirection: TextDirection.ltr,
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    children: <Widget>[
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                        Text(
////                                          '1550',
////                                          style: TextStyle(
////                                              color: textColor,
////                                              fontSize: 15,
////                                              fontWeight: FontWeight.w400),
////                                        ),
//                                          _user!=null?  _user.calorie==null?   Icon(Icons.all_inclusive,size: 19,)
//                                              :    Text(
//                                            _user.calorie.toStringAsFixed(0),  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          )
//                                              :Icon(Icons.all_inclusive,size: 19,),
//                                          Text(
//                                            'کالری مجاز',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '-',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w700),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(
//                                            _dailyInfo != null
//                                                ? (double.parse(_dailyInfo
//                                                                .total_act ??
//                                                            "0") +
//                                                        double.parse(_dailyInfo
//                                                                .total_calorie ??
//                                                            "0"))
//                                                    .toStringAsFixed(0)
//                                                : "0",  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                          Text(
//                                            'غذا',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '+',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Text(
//                                            _dailyInfo != null
//                                                ? (double.parse(_dailyInfo.total_act).toStringAsFixed(0)?? "0")
//
//                                                : "0",  textDirection: TextDirection.ltr,
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 15,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                          Text(
//                                            'فعالیت',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding:
//                                            EdgeInsets.symmetric(horizontal: 5),
//                                        child: Text(
//                                          '=',
//                                          style: TextStyle(
//                                              color: textColor,
//                                              fontSize: 15,
//                                              fontWeight: FontWeight.w400),
//                                        ),
//                                      ),
//                                      Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.center,
//                                        children: <Widget>[
////                                        Text(
////                                          '155',
////                                          style: TextStyle(
////                                              color: textColor,
////                                              fontSize: 15,
////                                              fontWeight: FontWeight.w400),
////                                        ),
//                                          _user!=null&&_dailyInfo!=null?
//                                          _user.calorie==null?
//                                          Icon(Icons.all_inclusive,size: 19,)
//                                              :Text(((_user.calorie-_totalCal).toStringAsFixed(0)),  textDirection: TextDirection.ltr,)
//                                              :Text(("0"),  textDirection: TextDirection.ltr,),
//                                          Text(
//                                            'باقی مانده',
//                                            style: TextStyle(
//                                                color: textColor,
//                                                fontSize: 11,
//                                                fontWeight: FontWeight.w400),
//                                          ),
//                                        ],
//                                      ),
//                                    ],
//                                  ),
//                                )
//                              ],
//                            ))
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            guide(Color(0xffFCFC24), 'کم'),
//                            guide(Color(0xff9EFC24), 'مناسب'),
//                            guide(Color(0xffF19623), 'زیاد'),
//                            guide(Color(0xffDB2A2A), 'خیلی زیاد'),
//                          ],
//                        )
//                      ],
//                    ));
//              }
//            },
//            future: _getDailyInfo()),
//
//          (_user!=null&&calculateAge(_user.birthdate)>=3)
//              ? _user.gcalorie == null
//              ? Container(
//                margin: EdgeInsets.only(top: 12, bottom: 12),
//                alignment: Alignment.center,
//                width: MediaQuery.of(context).size.width,
//                color: Color(0xffF15A23),
//                height: 42,
//                child: Text(
//                  'شما هنوز هدف خود را تعيين نكرده ايد وزن ايده ال شما ${_user.ideal_weight} كيلو مي باشد',
//                  style: TextStyle(
//                      fontWeight: FontWeight.w400,
//                      fontSize: 12,
//                      color: Colors.white),
//                  textAlign: TextAlign.center,
//                ),
//              )
//              : Container(
//                margin: EdgeInsets.only(top: 12, bottom: 12),
//                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
//                alignment: Alignment.center,
//                width: MediaQuery.of(context).size.width,
//                color: Colors.green,
//
//                child: Column(
//                  children: <Widget>[
//                    Text(
//                getIdeall()+ "  و وزن هدف شما " + _user.gweight.toString()+" کیلو می باشد ",
//                      style: TextStyle(
//                          fontWeight: FontWeight.w400,
//                          fontSize: 13,
//                          color: Colors.white),
//
//                      textAlign: TextAlign.center,
//                    ),
//                    Text(  getDiff(),style: TextStyle(
//                        fontWeight: FontWeight.w400,
//                        fontSize: 14,
//                        color: Colors.brown),)
//
//
//
//
//                  ],
//                )
//              )
//              :Container(height: 0,width: 0,),
//        Container(
//          height: 125,
//          margin: EdgeInsets.symmetric(horizontal: 8),
//          child: Row(
//            children: <Widget>[
//              Expanded(
//                  child: Container(
//                height: 125,
//                margin: EdgeInsets.symmetric(horizontal: 4),
//                child: RaisedButton(
//                    elevation: 5,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(10),
//                    ),
//                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//                    color: Color(0xff23AEF1),
//                    onPressed: () async {
//                      getUserall();
////                      DatePicker.showDatePicker(
////                          context,
////
////                          minYear: 1300,
////                          maxYear: 1450,
////                          confirm: Text(
////                            'Confirm',
////                            style: TextStyle(color: Colors.red),
////                          ),
////                          cancel: Text(
////                            'Cancel',
////                            style: TextStyle(color: Colors.cyan),
////                          ),
////
////                      );
//
//
////                      getProducts();
////                                  var databasesPath = await getDatabasesPath();
////                                 var _path = Path.join(databasesPath, 'king.db');
////                                  print("deleteDatdg");
////                                  print(_path);
////                                  if (await databaseExists(_path)) {
////                                    await deleteDatabase(_path);
////                                    print("deleteDatabase");
////                                  }
//
////                               print(  calculateAge(_user.birthdate)) ;
//////                                  getUserall();
////                      usrt();
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                          builder: (context) => Directionality(
////                              textDirection: TextDirection.rtl,
////                              child:LoginScreen(url: "http://api.kingdiet.net/api/testfoods",),
////                        ),
////                      ));
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                          builder: (context) => Directionality(
////                              textDirection: TextDirection.rtl,
////                              child:MyApp(),
////                        ),
////                      ));
////                                  _del();
//
////                                    SharedPreferences prefs = await SharedPreferences.getInstance();
////                                    String apiToken = prefs.getString('user_token');
////                                    final response = await Provider.of<apiServices>(context, listen: false)
////                                        .getTokenActvation(
////                                        apiToken,);
////
////                                    print('dfer');
////                                    print(response.statusCode);
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//
////
////    Lottie.asset('assets/progress.json',
////                          repeat: true,
////                          controller: _controller,
//////                          height: 125,
//////                          width: 80,
////                          onLoaded: (composition) {
////
//////                             Configure the AnimationController with the duration of the
//////                             Lottie file and start the animation.
////                            if(composition.duration.inSeconds==5)
////                            _controller
////                              ..duration = composition.duration..stop();
////                          },
////
////
////                        ),
//
//
//                        new SvgPicture.asset(
//                          'assets/icons/foots.svg',
//                          width: 55,
//                          height: 55,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(
//                            top: 8,
//                          ),
//                          child: Text(
//                            'قدم ',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.w500,
//                                fontSize: 14),
//                          ),
//                        )
//                      ],
//                    )),
//              )),
//              Expanded(
//                  child: Container(
//                height: 125,
//                margin: EdgeInsets.symmetric(horizontal: 4),
//                child: RaisedButton(
//                    elevation: 5,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(10),
//                    ),
//                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//                    color: Color(0xffF15A23),
//                    onPressed: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => Directionality(
//                              textDirection: TextDirection.rtl,
//                              child: rizMoghazi(
//                                  riz: riz(calculateAge(_user.birthdate),
//                                      _user.gender, _user.birthdate),calorie: _user.calorie,)),
//
//                        ),
//                      );
//                    },
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        new SvgPicture.asset(
//                          'assets/icons/rizmoghazi.svg',
//                          width: 55,
//                          height: 55,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(
//                            top: 8,
//                          ),
//                          child: Text(
//                            'وضعیت ویتامین ها و مواد معدنی',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.w500,
//                                fontSize: 14),
//                            textAlign: TextAlign.center,
//                          ),
//                        )
//                      ],
//                    )),
//              )),
//            ],
//          ),
//        ),
//        Container(
//            height: 40,
//            margin: EdgeInsets.only(top: 12, bottom: 15, right: 10),
//            child: new ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: _tags.length,
//                itemBuilder: (context, index) {
//                  return GestureDetector(
//                    child: Container(
//                      alignment: Alignment.center,
//                      decoration: BoxDecoration(
//                          color: MyColors.green,
//                          borderRadius: BorderRadius.all(Radius.circular(18))),
//                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
//                      margin: EdgeInsets.symmetric(horizontal: 3),
//                      child: Text(
//                        _tags[index],
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 12,
//                            fontWeight: FontWeight.w400),
//                      ),
//                    ),
//                    onTap: () {
//
//                      switch (_tagsRouts[index]){
//                        case "/album":
//                          Navigator.push(context, new MaterialPageRoute<Null>(
//                        builder: (BuildContext context) {
//                          return  new Directionality(
//                              textDirection: TextDirection.rtl, child: foodAlbum(acountDate: _user.account,));
//                        },));
//                        break;
//                        case "/regimi":
//                          Navigator.push(context, new MaterialPageRoute<Null>(
//                            builder: (BuildContext context) {
//                              return  new Directionality(
//                                  textDirection: TextDirection.rtl, child: regimiFoodList(acountDate: _user.account,));
//                            },));
//                          break;
//                        case "/mokamel":
//                          Navigator.push(context, new MaterialPageRoute<Null>(
//                            builder: (BuildContext context) {
//                              return   new Directionality(
//                                  textDirection: TextDirection.rtl, child:mokamel(acountDate: _user.account,));
//                            },));
//                          break;
//                        case "/exercise":
//                          Navigator.push(context, new MaterialPageRoute<Null>(
//                            builder: (BuildContext context) {
//                              return   new Directionality(
//                                  textDirection: TextDirection.rtl, child:ExerciseScreen(acountDate: _user.account,));
//                            },));
//
//
//                      }
//
//                    },
//                  );
//                })),
//        FutureBuilder( builder: (context, snapshot) {
//    if (snapshot.connectionState == ConnectionState.done)
//      return Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.start,
//        mainAxisSize: MainAxisSize.max,
//
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(top: 10, bottom: 5),
//            color: Colors.white,
//            height: 215,
//
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(right: 12, bottom: 8),
//                  child: Text(
//                    'دستور پخت غذاهای رژیمی',
//                    style: TextStyle(
//                        color: Color(0xff51565F),
//                        fontSize: 14,
//                        fontWeight: FontWeight.w500),
//                    textAlign: TextAlign.start,
//                  ),
//                ),
//                new Expanded(
//                    child: new ListView.builder(
//                        padding: EdgeInsets.only(right: 5),
//                        scrollDirection: Axis.horizontal,
//                        itemCount: _recipes.length,
//                        itemBuilder: (context, index) {
//                          return GestureDetector(
//                            child: Container(
//                                height: 170,
//                                width: 135,
//                                margin:
//                                EdgeInsets.only(right: 3, left: 3, bottom: 8),
//                                child: Card(
//                                  elevation: 3,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(15.0),
//                                  ),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      new ClipRRect(
//                                        borderRadius: new BorderRadius.vertical(
//                                            top: Radius.circular(15),
//                                            bottom: Radius.circular(0)),
//                                        child:  _recipes[index].free==0 &&  etebar<0
//                                            ?Container(
//                                          color: Colors.green.withOpacity(0.6),
//                                          child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
//                                          height: 90,
//                                          width: 135,
//                                        )
//                                            :FadeInImage(
//                                          placeholder: AssetImage(
//                                              'assets/images/placeholder.png'),
//                                          image:
//                                          NetworkImage(_recipes[index].cover),
//                                          fit: BoxFit.cover,
//                                          height: 90,
//                                          width: 135,
//                                        ),
//                                      ),
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 8),
//                                        child: Text(
//                                          _recipes[index].name,
//                                          style: TextStyle(
//                                              color: Color(0xff334856),
//                                              fontSize: 13,
//                                              fontWeight: FontWeight.w400),
//                                          maxLines: 1,
//                                          textAlign: TextAlign.center,
//                                        ),
//                                      ),
//                                      Text(
//                                        '${_recipes[index].total_calorie} کالری ',
//                                        style: TextStyle(
//                                            color: Color(0xffA8A8A8),
//                                            fontSize: 10,
//                                            fontWeight: FontWeight.w400),
//                                        maxLines: 1,
//                                      ),
//                                    ],
//                                  ),
//                                )),
//                            onTap: () {_recipes[index].free==0 &&  etebar<0
//                                ?showSnakBar("شما اکانت فعالی ندارید. برای خرید اکانت به فروشگاه بروید.")
//                                :
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => Directionality(
//                                      textDirection: TextDirection.rtl,
//                                      child: regimiFoodDetail(
//                                          catId: _recipes[index].id)),
//                                ),
//                              );
//                            },
//                          );
//                        })),
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.only(top: 5),
//            padding: EdgeInsets.only(top: 5, bottom: 5),
//            color: Colors.white,
//            height: 130,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(right: 12, bottom: 8),
//                  child: Text(
//                    'ورزش ها و حرکات ورزشی',
//                    style: TextStyle(
//                        color: Color(0xff51565F),
//                        fontSize: 14,
//                        fontWeight: FontWeight.w500),
//                    textAlign: TextAlign.start,
//                  ),
//                ),
//                new Expanded(
//                    child: new ListView.builder(
//                        padding: EdgeInsets.only(right: 12),
//                        scrollDirection: Axis.horizontal,
//                        itemCount: _exercise.length,
//                        itemBuilder: (context, index) {
//                          return GestureDetector(
//                            child: Container(
//                              margin: EdgeInsets.symmetric(horizontal: 2),
//                              child: Stack(
//                                children: <Widget>[
//                                  new ClipRRect(
//                                    borderRadius: new BorderRadius.vertical(
//                                        top: Radius.circular(10),
//                                        bottom: Radius.circular(10)),
//                                    child:  _exercise[index].free==0 &&  etebar<0
//                                        ?Container(
//                                      color: Colors.green.withOpacity(0.6),
//                                      child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
//
//                                      height: 100,
//                                      width: 125,
//                                    )
//                                        :FadeInImage(
//                                      placeholder: AssetImage(
//                                          'assets/images/placeholder.png'),
//                                      image: NetworkImage(_exercise[index].cover),
//                                      fit: BoxFit.cover,
//
//                                      height: 100,
//                                      width: 125,
//                                    ),
//                                  ),
//                                  Container(
//                                    decoration: BoxDecoration(
//                                      borderRadius:
//                                      BorderRadius.all(Radius.circular(10)),
//                                      color: Color(0xB3363636),
//                                    ),
//                                    height: 100,
//                                    width: 125,
//                                  ),
//                                  Container(
//                                    width: 125,
//                                    margin: EdgeInsets.only(top: 35, right: 5),
//                                    child: Column(
//                                      mainAxisAlignment: MainAxisAlignment.end,
//                                      crossAxisAlignment:
//                                      CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Text(
//                                          _exercise[index].name,
//                                          style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 11,
//                                              fontWeight: FontWeight.w400),
//                                          maxLines: 1,
//                                        ),
//                                        Text(
//                                          _exercise[index].description,
//                                          style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 9,
//                                              fontWeight: FontWeight.w300),
//                                          maxLines: 1,
//                                        ),
//                                      ],
//                                    ),
//                                  )
//                                ],
//                              ),
//                            ),
//                            onTap:() { _exercise[index].free==0 &&  etebar<0?showSnakBar("شما اکانت فعالی ندارید. برای خرید اکانت به فروشگاه بروید."):
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => Directionality(
//                                      textDirection: TextDirection.rtl,
//                                      child: exerciseDetail(
//                                          singleId: _exercise[index].id)),
//                                ),
//                              );
//                            },
//                          );
//                        })),
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.only(top: 8),
//            padding: EdgeInsets.only(top: 5, bottom: 5),
//            color: Colors.white,
//            height: 178,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: EdgeInsets.only(right: 12, bottom: 5),
//                  child: Text(
//                    'آلبوم غذایی',
//                    style: TextStyle(
//                        color: Color(0xff51565F),
//                        fontSize: 14,
//                        fontWeight: FontWeight.w500),
//                    textAlign: TextAlign.start,
//                  ),
//                ),
//                new Expanded(
//                    child: new ListView.builder(
//                        scrollDirection: Axis.horizontal,
//                        itemCount: _albums.length,
//                        padding: EdgeInsets.only(right: 12),
//                        itemBuilder: (context, index) {
//                          return GestureDetector(
//                            child: Container(
//                                height: 110,
//                                width: 120,
//                                margin:
//                                EdgeInsets.only(right: 2, left: 2, bottom: 5),
//                                child: Card(
//                                  elevation: 3,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(15.0),
//                                  ),
//                                  child: Column(
//                                    children: <Widget>[
//                                      Stack(
//                                        alignment:
//                                        AlignmentDirectional.bottomCenter,
//                                        children: <Widget>[
//                                          new ClipRRect(
//                                            borderRadius:
//                                            new BorderRadius.vertical(
//                                                bottom: new Radius.elliptical(
//                                                  110,
//                                                  20.0,
//                                                ),
//                                                top: new Radius.circular(15)),
//                                            child:  _albums[index].free==0 &&  etebar<0
//                                                ?Container(
//                                              color: Colors.green.withOpacity(0.6),
//                                              child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
//
//                                              height: 76,
//                                              width: 120,
//                                            )
//                                                :FadeInImage(
//                                              placeholder: AssetImage(
//                                                  'assets/images/placeholder.png'),
//                                              image: NetworkImage(
//                                                  _albums[index].cover),
//                                              fit: BoxFit.fill,
//                                              height: 76,
//                                              width: 120,
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      Padding(
//                                        padding: EdgeInsets.only(top: 4),
//                                        child: Text(
//                                          _albums[index].name,
//                                          style: TextStyle(
//                                              color: Color(0xff334856),
//                                              fontSize: 12,
//                                              fontWeight: FontWeight.w400),
//                                          maxLines: 1,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                )),
//                            onTap: () {_albums[index].free==0 &&  etebar<0?showSnakBar("شما اکانت فعالی ندارید. برای خرید اکانت به فروشگاه بروید."):
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => Directionality(
//                                      textDirection: TextDirection.rtl,
//                                      child: foodAlbumDetail(
//                                          Catid: _albums[index].id)),
//                                ),
//                              );
//                            },
//                          );
//                        })),
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.only(top: 5),
//            padding: EdgeInsets.only(top: 10, bottom: 5),
//            color: Colors.white,
//            height: 185,
//            child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(right: 10, bottom: 5),
//                    child: Text(
//                      'مکمل ها غذایی',
//                      style: TextStyle(
//                          color: Color(0xff51565F),
//                          fontSize: 14,
//                          fontWeight: FontWeight.w500),
//                      textAlign: TextAlign.start,
//                    ),
//                  ),
//                  new Expanded(
//                    child: new ListView.builder(
//                        scrollDirection: Axis.horizontal,
//                        itemCount: _supplemen.length,
//                        itemBuilder: (context, index) {
//                          return GestureDetector(
//                            child: Container(
//                              margin:
//                              EdgeInsets.only(right: 8, left: 8, bottom: 10),
//                              child: Stack(
//                                alignment: AlignmentDirectional.topCenter,
//                                children: <Widget>[
//                                  Container(
//                                    margin: EdgeInsets.only(top: 45),
//                                    alignment: Alignment.bottomCenter,
//                                    decoration: new BoxDecoration(
//                                      borderRadius: BorderRadius.circular(15.0),
//                                      color: Colors.white,
//                                      boxShadow: [
//                                        BoxShadow(
//                                          color: Colors.black26,
//                                          blurRadius: 5.0,
//                                          // has the effect of softening the shadow
//                                          spreadRadius: 1.0,
//                                          // has the effect of extending the shadow
//                                          offset: Offset(
//                                            0.0,
//                                            // horizontal, move right 10
//                                            0.0, // vertical, move down 10
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                    width: 120,
//                                    height: 80,
//                                    child: new Padding(
//                                      padding: EdgeInsets.only(bottom: 5),
//                                      child: Text(
//                                        _supplemen[index].name,
//                                        style: TextStyle(
//                                          color: Color(0xff334856),
//                                          fontSize: 12,
//                                          fontWeight: FontWeight.w400,
//                                        ),
//                                        maxLines: 1,
//                                        textAlign: TextAlign.center,
//                                      ),
//                                    ),
//                                  ),
//                                  new Container(
//                                      alignment: Alignment.center,
//                                      width: 75,
//                                      height: 75,
//                                      margin: EdgeInsets.only(top: 10),
//                                      decoration: new BoxDecoration(
//                                        color: Colors.white,
//                                        shape: BoxShape.circle,
//                                        boxShadow: [
//                                          BoxShadow(
//                                            color: Colors.black26,
//                                            blurRadius: 5.0,
//                                            // has the effect of softening the shadow
//                                            spreadRadius: 1.0,
//                                            // has the effect of extending the shadow
//                                            offset: Offset(
//                                              0.0,
//                                              // horizontal, move right 10
//                                              0.0, // vertical, move down 10
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                      child: _supplemen[index].free==0 &&  etebar<0
//                                          ?Container(
//                                        decoration: new BoxDecoration(
//                                            shape: BoxShape.circle,
//                                            color: Colors.green.withOpacity(0.6)),
//                                        child: Icon(Icons.lock_outline,color: Colors.white,size: 50,),
//                                        height: 75,
//                                        width: 75,
//                                      )
//                                          :CircleAvatar(
//                                        radius: 36,
//                                        backgroundImage:
//                                        NetworkImage(_supplemen[index].cover),
//                                        backgroundColor: Colors.transparent,
//                                      )),
//                                ],
//                              ),
//                            ),
//                            onTap:() {_supplemen[index].free==0 &&  etebar<0?showSnakBar("شما اکانت فعالی ندارید. برای خرید اکانت به فروشگاه بروید."):
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => Directionality(
//                                      textDirection: TextDirection.rtl,
//                                      child: mokamelDetail(
//                                          singleId: _supplemen[index].id)),
//                                ),
//                              );
//                            },
//                          );
//                        }),
//                  ),
//                ]),
//          )
//        ],
//      );
//   else return Center(
//      child: CircularProgressIndicator(),
//    );
//        },future:   getmain2()  ,),
//
//      ]))
//    ]));
//  }
//
//  Widget Regims(String name, String image, Color color, String type,
//      List<DbAllDiets> list) {
//    has = false;
//    list.forEach((item) {
//      if (item.type .contains( type)) has = true;
//    });
//    return Column(
//      children: <Widget>[
//        Container(
//            margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//            child: Container(
//                child: RawMaterialButton(
//                  onPressed: () async {
////                    _delAllDiets();
////                    Navigator.pushAndRemoveUntil(
////                        context,
////                        MaterialPageRoute(
////                          builder: (BuildContext context) =>
////                        ),
////                        ModalRoute.withName('/'));
//
////                    Navigator.of(context).push(new MaterialPageRoute<Null>(
////                        builder: (BuildContext context) {
////                          return regimList(type:type,);
////                        },
////                        fullscreenDialog: true
////                    ));
//
////                    Navigator.of(context).pushNamed("/widgett");
////
////                    Navigator.of(context).push(PageRouteBuilder(
////                        opaque: false,
////                        pageBuilder: (BuildContext context, _, __) =>
////                            regimList(type:type,)));
////                    _DbAllDietsList
//
//                    ////////////////////////////*********
//                    String returnVal = _user != null
//                        ? await Navigator.push(
//                            context,
//                            MaterialPageRoute(
//
//                              builder: (context) => Directionality(
//                                  textDirection: TextDirection.rtl,
//                                  child: regimList(
//                                      type: type, user: _user.gender,)),
//                            ),
//                          )
//                        : "";
//
//                    if (returnVal == "ff") {
//    if (mounted) { setState(() {
//                        _justRegims = true;
//                      });}
//                      print("injasssx");
//                      await widget.contextt();
//    if (mounted) { setState(() {
//      _justRegims = false;
//    });}
//                    }
//                    else
//                    if (mounted) { setState(() {
//                      _justRegims = true;
//                    });}
//                    print("injasssx");
//                    await widget.contextt();
//                    if (mounted) { setState(() {
//                      _justRegims = false;
//                    });}
//                  },
//                  child: new SvgPicture.asset(
//                    image,
//                    height: 23,
//                    width: 22,
//                  ),
//                  shape: new CircleBorder(
//                      side: BorderSide(color: color, width: 7)),
//                  elevation: 0,
//                  fillColor: Colors.white,
//                  padding: const EdgeInsets.all(10.0),
//                ),
//                padding: EdgeInsets.all(2),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(32.0),
//                  color: Colors.white,
//                )),
//            width: 50,
//            padding: EdgeInsets.all(2),
//            height: 50,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(32.0),
//                // Box decoration takes a gradient
//                gradient: LinearGradient(
//                  // Where the linear gradient begins and ends
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  // Add one stop for each color. Stops should increase from 0 to 1
//                  stops: [0.1, 0.6, 0.8, 0.9],
//                  colors: has
//                      ? [
//                          // Colors are easy thanks to Flutter's Colors class.
//                          Color(0xffFF957C),
//                          Color(0xffFFBF7D),
//                          Color(0xffFFD97D),
//                          Color(0xffFFE17D),
//                        ]
//                      : [
//                          // Colors are easy thanks to Flutter's Colors class.
//                          Color(0xFF957C),
//                          Color(0xFFBF7D),
//                          Color(0xFFD97D),
//                          Color(0xFFE17D),
//                        ],
//                ))),
//        Text(
//          name,
//          style: TextStyle(
//              color: textColor, fontWeight: FontWeight.w500, fontSize: 9),
//        )
//      ],
//    );
//  }
//
//  Widget Progressbar(String amount, String name) {
//    double value = double.parse(amount);
//    int cal=_user!=null?_user.calorie??_totlaCal:24000;
//
//    Map rizMap = {"protein": 1};
//    if (_user != null)
//      rizMap = getRiz(int.parse(
//          riz(calculateAge(_user.birthdate), _user.gender, _user.birthdate)));
//    if (name == "پروتئین") value = value / rizMap["protein"];
//    if (name == "چربی")
//      value = value /
//          double.parse(
//              double.parse((.3 *cal / 9).toString()).toStringAsFixed(1));
//    if (name == "کربوهیدرات")
//      value = value /
//          double.parse(
//              double.parse((.5 * cal/ 4).toString()).toStringAsFixed(1));
//
//    return Container(
//        margin: EdgeInsets.only(top: 5),
//        width: 55,
//        height: 55,
//        child: Stack(
//          children: <Widget>[
//            GradientCircularProgressIndicator(
//              gradientColors: value > 0.75
//                  ? [
//                      Color(0xffFCFC24),
//                      Color(0xff9EFC24),
//                      Color(0xffF19623),
//                      Color(0xffDB2A2A),
//                    ]
//                  : value < 0.75 && value > 0.50
//                      ? [
//                          Color(0xffFCFC24),
//                          Color(0xff9EFC24),
//                          Color(0xffF19623)
//                        ]
//                      : [Color(0xffFCFC24), Color(0xff9EFC24)],
//              radius: 28,
//              strokeWidth: 6.0,
//              value: value,
//              backgroundColor: Color(0xffDEE6EE),
//              strokeRound: true,
//            ),
//            Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    amount,
//                    style:
//                        TextStyle(fontSize: 9.0, fontWeight: FontWeight.w400),  textDirection: TextDirection.ltr,
//                  ),
//                  Text(
//                    name,
//                    style:
//                        TextStyle(fontSize: 9.0, fontWeight: FontWeight.w400),
//                  ),
//                ],
//              ),
//            )
//          ],
//        ));
//  }
//
//  Widget guide(Color color, String name) {
//    return Container(
//        margin: EdgeInsets.only(top: 8, right: 12),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            new Container(
//              width: 8,
//              height: 8,
//              margin: EdgeInsets.only(left: 5),
//              decoration: new BoxDecoration(
//                color: color,
//                shape: BoxShape.circle,
//              ),
//            ),
//            Text(
//              name,
//              style: TextStyle(
//                  fontWeight: FontWeight.w400, fontSize: 11, color: textColor),
//            ),
//          ],
//        ));
//  }
//
//
//
////  Future getProducts() async {
////    Future.delayed(const Duration(  seconds: 3), () async {
////    print('exersize');
////    String date = getDateToday();
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    String apiToken = prefs.getString('user_token');
////
////    try {
////
////      final response = await Provider.of<apiServices>(context, listen: false)
////          .getStart("0", 'Bearer ' + apiToken);
////      print("home"+response.bodyString);
////
////      if (response.statusCode == 200) {
////        final post = json.decode(response.bodyString);
//////      print(response.bodyString);
//////      print(response.body);
////        start starts;
////        starts = start.fromJson(post);
////
////        _getAlbums(starts);
////      } else {
//////      print(response.statusCode.toString());
////        _getAlbums(null);
////      }
////    } catch (e) {
////      print(e.toString() + "catttttch");
//////      getProducts(context);
////    }
////  });}
//
////  _getAlbums(start starts) async {
//////    var response = await getProducts(context);
//////    print('${response.toString()}111111111111111');
////
////    var response = starts;
////    if( response != null ){
////    if (mounted) {
////      setState(() {
////        response == null ? () {} : _start = starts;
////        _serverDate=_start.server_date;
////        startTime();
////
////      });
////    }}
////  }
//
//  setAlbums() {
//    _start.albums.forEach((item) {
//      _albums.add(subAbum.fromJson(item));
//    });
//  }
//
//  setExercise() {
//    _start.exercises.forEach((item) {
//      _exercise.add(subExercise.fromJson(item));
//    });
//  }
//
//  setSupp() {
//    _start.supplements.forEach((item) {
//      _supplemen.add(subSupplement.fromJson(item));
//    });
//  }
//
//  setRegims() {
//    _start.recipes.forEach((item) {
//      _recipes.add(subRecipes.fromJson(item));
//    });
//  }
//
//  Future getRegims() async {
//    List<DbAllDiets> alldiet = await _getAllDiets();
//    print(alldiet.length.toString() + "hhhhh");
//    _DbAllDietsList = alldiet ?? [];
//    return _DbAllDietsList;
//  }
//
//  Future<List<DbAllDiets>> _getAllDiets() async {
//    List<DbAllDiets> alldiet = [];
//    try {
//      var db = new allDietProvider();
//      await db.open();
//      alldiet = await db.paginate();
//      await db.close();
//      return alldiet;
//    } catch (e) {
//      return [];
//    }
//  }
//
//  Future<List<DbAllDiets>> _delAllDiets() async {
//    List<DbAllDiets> alldiet = [];
//    try {
//      var db = new allDietProvider();
//      await db.open();
//      await db.delete();
//      await db.close();
//      return alldiet;
//    } catch (e) {
//      return [];
//    }
//  }
//
//  Future _getDailyInfo({bool refresh: false}) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
////
////    etebar = prefs.getInt('etebar');
//    if (!_justRegims) {
//      var db = new DailyInfoProvider();
//      await db.open();
//      DbDailyInfo products = await db.getByDate(gregorianDate);
//
//      await db.close();
//      _dailyInfo = null;
//      _totalCal = 0;
//      _totalActshow = 0;
//
//      if (!(products == null)) {
//        _dailyInfo = products;
//        if (_dailyInfo != null) {
//          _totalCal = double.parse(_dailyInfo.total_calorie.toString());
//          if (_dailyInfo.total_act != null)
//            _totalActshow = double.parse(_dailyInfo.total_act.toString());
//          else
//            _totalActshow = 0;
//        }
//      }
//
//      print("xxxxxxxxxxxx");
//      User user = await _getUser();
//
//      Map map = {
//        "_dailyInfo": _dailyInfo,
//        "user": user,
//      };
//
//      return map;
//    }
//
//
//
//  }
//
//  _getUser() async {
//    var response = await getUser();
//    if (this.mounted) {
//
//      _user = response;
//    }
//
//    return _user;
//  }
//
//  static Future<User> getUser() async {
//    User user;
//    try {
//      var db = new userProvider();
//      await db.open();
//      user = await db.paginate();
//      await db.close();
//      return user;
//    } catch (e) {
//      print(e.toString() + "errrrrorrrrr");
//      return null;
//    }
//  }
//
//
//    //    gregorianDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
////    print(gregorianDate + "ll" + getDateToday());
//
//
//
//
//
//  Widget loadingView() {
//    return new Center(
//        child: SpinKitCircle(
//      color: MyColors.vazn,
//    ));
//  }
//
//  test() async {
//    return {"": ""};
//  }
//
//  static int getWeekDay() {
//    String gregorianDateParse = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//    var parsedDate = DateTime.parse(gregorianDateParse);
//    var now = new DateTime.now();
//    return parsedDate.weekday;
//  }
//
//  Future _del() async {
//    try {
//      var db = new DailyInfoProvider();
//      await db.open();
//      await db.delete();
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  String getDiff() {
//
//    int diifff=DateTime.parse(_user.gdate.split("*")[1]).
//        difference(DateTime.parse(getDateToday())).inDays;
//    if(diifff<=0)
//      return "زمان هدف شما به پایان رسیده ";
//  else
//    return diifff.toString() +" روز مانده تا وزن هدف ";
//  }
//  String getIdeall() {
//
//       if( _user.ideal_weight.toString()!=null)
//         return " وزن ایده آل شما " +_user.ideal_weight.toString()+" کیلو";
//        else return "";
//
//  }
//  Future<bool> _deleteAllNotic() async {
//    try {
//      var db = new noticsProvider();
//      await db.open();
//      await db.paginate();
//      await db.close();
//      return true;
//    } catch (e) {
//      return false;
//    }
//  }
//
//  Future<User> usrt() async {
//    User user;
//    try {
//      await dbHelper.paginatealll();
////      print(user);
//      return user;
//    } catch (e) {
//      print(e.toString() + "errrrrorrrrr");
//      return null;
//    }
//  }
//
//  void getEtebar() {
//
//    if(_user!=null && _serverDate !=null && _user.account !=null &&_user.account !=""){
//      var persianDateee = PersianDateTime(jalaaliDateTime: _user.account);
//      var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
//      DateTime datetoday = DateTime.parse(_serverDate);
//      DateTime dateacount= DateTime.parse(dateEtebarstr);
//      print(dateacount
//          .difference(datetoday)
//          .inDays
//          .toString()+"fffffffffffffffffff");
//
//
//      etebar =dateacount.difference(datetoday).inDays;
//
//    }
//    _etebarbool=true;
//
//  }
//
//
//  showSnakBar(String s) {
//    _scaffoldKey.currentState.showSnackBar( SnackBar(
//      duration:  Duration(seconds: 2),
//      content: Text(
//        s,
//        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
//        textDirection: TextDirection.rtl,
//      ),
//    ));
//  }
//
//
//  static Future<List<User>> getUserall() async {
//    List user;
//    try {
//      var db = new userProvider();
//      await db.open();
//      user= await db.paginateall();
//      await db.close();
//     user.forEach((item){
//       print(item);
//     });
//    } catch (e) {
//      print(e.toString()+"errrrrorrrrr");
//      return null;
//    }
//  }
//}
