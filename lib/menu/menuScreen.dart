import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:ui';

import 'package:barika_web/dada.dart';
import 'package:barika_web/exercise/Exercise.dart';
import 'package:barika_web/menu/expiredDiet.dart';
import 'package:barika_web/menu/goalWeight.dart';
import 'package:barika_web/menu/inviteFreinds.dart';
import 'package:barika_web/menu/questions.dart';
import 'package:barika_web/menu/unitConvert.dart';
import 'package:barika_web/models/contact.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/mokamel/mokamel.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/regimiFood/regimiFoodList.dart';
import 'package:barika_web/regims/regimList.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/store/storeScreen.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as Path;
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper.dart';
import 'PeymentHistory.dart';

import 'connectus.dart';
import 'fruitunit.dart';
import 'reminder.dart';

class menuScreen extends StatefulWidget {
  @override
  final contextt;

  menuScreen({Key key, this.contextt}) : super(key: key);

  State<StatefulWidget> createState() => menuScreenState();
}

class menuScreenState extends State<menuScreen>
    with AutomaticKeepAliveClientMixin<menuScreen> {
  @override
  bool get wantKeepAlive => true;
  User _user;
  String date = "";
  bool com = true;
  Color textColor = Color(0xff5C5C5C);
  List<TargetFocus> targets = List();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  bool _isLoading = true;
  String _version = "";
  String telegram = "";
  String rubika = "";
  String _country = "";
  String instagram = "";
  String website = "";
  String description = "";
  int etebar = 1;

  Widget loadingView() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            "منو",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20 * fontvar),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: SpinKitCircle(
          color: MyColors.vazn,
        )));
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  var fontvar = 1.0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh = SizeConfig.safeBlockHorizontal;
    var bv = SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if (fontvar > 2) fontvar = 1.7;

    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) screenSize = Size(600, screenSize.height);

    return Container(
        width: screenSize.width - 50,
        color: Colors.white,
        child: StateBuilder<userStore>(
            observe: () => RM.get<userStore>(),
            builder: (_, reactiveModel) {
              return reactiveModel.whenConnectionState(onIdle: () {
                print("onIdle reactiveModel");
              }, onWaiting: () {
                return loadingView();
              }, onData: (store) {


                getEtebar(store);
                return Drawer(
                    child: Scaffold(
                  backgroundColor: Colors.white,
                  key: _scaffoldKey,
                  appBar: PreferredSize(
                    child: Container(
                      color: Colors.green,
                    ),
                    preferredSize: Size.fromHeight(0),
                  ),
                  body: ListView(
                    children: <Widget>[
                      Container(
                          // height: (((screenSize.width * 180) / 375)),
                          color: MyColors.green,
                          padding:
                              EdgeInsets.only(right: 10, top: 20, bottom: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _user != null ? _user.name : "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14 * fontvar),
                              ),
                              Text(
                                _user != null
                                    ? _country + _user.phone + "+"
                                    : "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14 * fontvar),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Color(0xffE8FFDD).withOpacity(0.3),
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 20, right: 10),
                              ),
                              Container(
                                child:
                                _user != null?(_user.account == null || _user.account == "" || etebar<0)
                                      ?Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Image.asset(
                                                'assets/icons/supermarket.png',
                                                width: 27 * (screenSize.width) / 375,
                                                height: 24 * (screenSize.width) / 375,
                                              ),
                                            ),
                                            Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(
                                                 "فروشگاه",
                                                 style: TextStyle(
                                                     color: Colors.white, fontSize: 15 * fontvar,fontWeight: FontWeight.w500),
                                               ),
                                               Text(
                                                 "شما اشتراک فعالی ندراید",
                                                 style: TextStyle(
                                                     color: Colors.white, fontSize: 12 * fontvar,fontWeight: FontWeight.w400),
                                               ),
                                             ],
                                           ),
                                          ],
                                        ),
                                        FlatButton(

                                          child:Text(
                                            "خرید اشتراک",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13*fontvar
                                            ),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.ltr,
                                          ) ,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onPressed: () async {
                                              User user =await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Directionality(
                                                            textDirection: TextDirection.rtl,
                                                            child: storeScreen(menu: true,user: _user,))),
                                              );

                                              setState(() {
                                                print("menuuuuuuuuesr");
                                                print(user.toMap());
                                                user.name="54";
                                                user.name="54";
                                                _user=user;
                                              });

                                            },
                                          color:Color(0xffF15A23) ,
                                          padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
                                          shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(4.0)),
                                        )

                                      ],
                                    )
                                      : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Image.asset(
                                            'assets/icons/accept.png',
                                            fit: BoxFit.contain,
                                            width:
                                                27 * (screenSize.width) / 375,
                                            height:
                                                24 * (screenSize.width) / 375,
                                          ),
                                        ),
                                        Text(
                                          "تاریخ اعتبار اشتراک",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15 * fontvar,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      _user.account??
                                      "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18 * fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                                :Container(),
                                margin: EdgeInsets.only(left: 10, top: 15),
                              ),
                              // Container(
                              //   margin: EdgeInsets.symmetric(vertical: 5),
                              //   padding:
                              //   EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius:
                              //       BorderRadius.all(Radius.circular(10))),
                              //   child: Text(
                              //
                              //     (_user.account == null || _user.account == "")
                              //         ?  "تاریخ اعتبار اشتراک : " +"اشتراک فعالی ندارید."
                              //         : "تاریخ اعتبار اشتراک : " + _user.account.toString(),
                              //     style: TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 12 * fontvar),
                              //   ),
                              // ),
                            ],
                          )),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  'assets/icons/instagram.png',
                                  fit: BoxFit.contain,
                                  width: 35 * (screenSize.width) / 375,
                                  height: 35 * (screenSize.width) / 375,
                                ),
                              ),
                              onTap: () async {
                                await openApp(instagram);
                              },
                            ),
                            GestureDetector(
                              // child: Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/images/wh.png',
                                width: 45 * (screenSize.width) / 375,
                                height: 45 * (screenSize.width) / 375,
                              ),
                              // ),
                              onTap: () async {
                                await openApp(rubika);
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  'assets/icons/telegram.png',
                                  fit: BoxFit.contain,
                                  width: 35 * (screenSize.width) / 375,
                                  height: 35 * (screenSize.width) / 375,
                                ),
                              ),
                              onTap: () async {
                                await openApp(telegram);
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  'assets/icons/site.png',
                                  fit: BoxFit.contain,
                                  width: 35 * (screenSize.width) / 375,
                                  height: 35 * (screenSize.width) / 375,
                                ),
                              ),
                              onTap: () async {
                                await openApp(website);
                              },
                            ),
                          ],
                        ),
                      ),

                      ListTile(
                        key: keyButton1,
                        onTap: () {
                          if (_user != null) {
                            if (calculateAge(_user.birthdate) < 3)
                              showSnakBar("برای زیر سه سال غیر فعال است.");
                            else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: goalWeight(
                                          acountDate: _user.account,
                                        ))),
                              );
                            }
                          }
                        },
                        title: Text(
                          'تعیین  هدف ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_goal.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Directionality(
                          //               textDirection: TextDirection.rtl,
                          //               child: dailyInfo())),
                          // );
                        },
                        title: Text(
                          'گزارش روزانه',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_report.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: regimList())),
                          );
                        },
                        title: Text(
                          'رژیم های غذایی من',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_regims.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          //               html.window.location.href = "https://api2.barikaapp.com/api/v3/diets/weightFix/5cd71d997a0c6?user_name=fhs&user_height=162&user_weight=80&user_birthdate=1996-02-02&user_sex=female&user_appetite=1&user_activity=1";
                          //               html.window.addEventListener("message", (event) async {
                          //                 html.MessageEvent messageEvent = event;
                          //                 print("flutter got ${messageEvent.data.toString()}");
                          //               }, false);
                          //                     html.window.onMessage.forEach((element) {
                          //   print('Event Received in callback: ${element.data}');
                          //   if(element.data=='MODAL_CLOSED'){
                          //     Navigator.pop(context);
                          //   }else if(element.data=='SUCCESS'){
                          //     print('PAYMENT SUCCESSFULL!!!!!!!');
                          //   }
                          // });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: expiredDiet())),
                          );
                        },
                        title: Text(
                          'رژیم های غذایی منقضی شده',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_regims.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        key: keyButton2,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: unitConvert())),
                          );
                        },
                        title: Text(
                          'تبدیل واحد مواد نشاسته ای به یکدیگر',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_reminder.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: fruitUnit())),
                          );
                        },
                        title: Text(
                          'اندازه واحد هر کدام از میوه ها ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_reminder.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: mokamel(
                                      acountDate: _user.account,
                                      // acountDate: "1398/02/02",
                                    ))),
                          );
                        },
                        title: Text(
                          ' مکمل های غذایی ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_mokamel.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ExerciseScreen(
                                      acountDate: _user.account,
                                      // acountDate: "1398/02/02",
                                    ))),
                          );
                        },
                        title: Text(
                          'ورزشها و حرکات ورزشی ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_sport.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: regimiFoodList(
                                      acountDate: _user.account,
                                      // acountDate: "1398/02/02",
                                    ))),
                          );
                        },
                        title: Text(
                          'دستور پخت غذاهای رژیمی',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_foods.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Directionality(
                          //               textDirection: TextDirection.rtl,
                          //               child: chart())),
                          // );
                        },
                        title: Text(
                          ' نمودارها ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_chart.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           Directionality(
                          //               textDirection: TextDirection.rtl,
                          //               child: reportCahrt()
                          //             // child: LineChartSample6()
                          //
                          //
                          //           )),
                          // );
                        },
                        title: Text(
                          ' گزارش گیری ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_chart.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: PeymentHistory())),
                          );
                        },
                        title: Text(
                          'لیست تراکنش ها',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_report.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: questionScreen())),
                          );
                        },
                        title: Text(
                          'سولات متداول ',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_question.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: inviteFriends(_user.referral_code))),
                          );
                        },
                        title: Text(
                          'دعوت از دوستان',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/share.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: connectUs())),
                          );
                        },
                        title: Text(
                          'ارتباط با ما',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/contactus.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text(
                          'تنظیمات',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      ListTile(
                        onTap: () async {
                          User user = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: profileScreen(
                                      menu: true,
                                    ))),
                          );

                          setState(() {
                            _user = user;
                          });
                        },
                        title: Text(
                          'پروفایل',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding:
                              EdgeInsets.only(right: 15, top: 15, bottom: 15),
                          child: Image.asset(
                            'assets/icons/menu_user.png',
                            fit: BoxFit.contain,
                            width: 20 * (screenSize.width) / 375,
                            height: 20 * (screenSize.width) / 375,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   onTap: () async {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //       builder: (context) =>
                      //     //           Directionality(
                      //     //               textDirection: TextDirection.rtl,
                      //     //               child: reminder())),
                      //     // );
                      //   },
                      //   title: Text(
                      //     'یادآور',
                      //     style: TextStyle(
                      //         color: textColor,
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 15 * fontvar),
                      //     textAlign: TextAlign.start,
                      //   ),
                      //   contentPadding: EdgeInsets.all(0),
                      //   leading: Padding(
                      //     padding:
                      //         EdgeInsets.only(right: 15, top: 15, bottom: 15),
                      //     child: Image.asset(
                      //       'assets/icons/menu_reminder.png',
                      //       fit: BoxFit.contain,
                      //       width: 20 * (screenSize.width) / 375,
                      //       height: 20 * (screenSize.width) / 375,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        onTap: () async {
//                     String returnVal = await showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Padding(
//                               padding: EdgeInsets.all(0),
//                               child: Dialog(
//                                   elevation: 15,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   backgroundColor: Colors.transparent,
//                                   child: exitDialog()));
//                         });
//                     if (returnVal == 'yes') {
// //                        Database db;
// //                        String _path;
// //                        var databasesPath = await getDatabasesPath();
// //                        _path = Path.join(databasesPath, 'king.db');
// //                        if (await databaseExists(_path)) {
// //                          await deleteDatabase(_path);
// //                          print("deleteDatabase");
// //                        }
//                       try{
//                         String phoneSave;
//                         if(_user!=null)
//                           phoneSave=_user.phone;
//                         else{
//                           User user=await getUsersq();
//                           phoneSave=user.phone;
//                         }
//                         if(phoneSave!=null){
//
//                           await deleteUser();
//
//                           await deleteDailyDiet();
//
//                           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                           String date=await sharedPreferences.getString("apiDate");
//
//                           await sharedPreferences.clear();
//
//                           await sharedPreferences.setString('user_phone', phoneSave);
//                           await sharedPreferences.setString('apiDate', date);
//                           await sharedPreferences.setString('date', date);
//
//                          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
//                           // exit(0);
//                         }
//                         else(showSnakBar("مجددا تلاش کنید."));
//                       }
//                       catch(e){
//                         print(e.toString()+"خرجی از خستی");
//                         showSnakBar("مجددا تلاش کنید.");
//                       }
//
//                     } else
//                           () {};
                        },
                        title: Text(
                          'خروج از حساب',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15 * fontvar),
                          textAlign: TextAlign.start,
                        ),
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                            padding:
                                EdgeInsets.only(right: 15, top: 15, bottom: 15),
                            child: Icon(Icons.exit_to_app)),
                      ),
//                 ListTile(
//                   onTap: () async {
//                     var databasesPath = await getDatabasesPath();
//                     String _path = Path.join(databasesPath, 'king.db');
//
//                     if (await databaseExists(_path)) {
// //      await ((await openDatabase(_path)).close());
//                       await deleteDatabase(_path);
//                       print("deleteDatabase");
//                     }
//                     try {
//                       await Directory(databasesPath).create(recursive: true);
//                     } catch (_) {}
//
//                     ByteData data = await rootBundle.load("assets/kingassets2.db");
//                     List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//                     await File(_path).writeAsBytes(bytes, flush: true);
//                   },
//                   title: Text(
//                     'خروج از حساب',
//                     style: TextStyle(
//                         color: textColor,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 15 * fontvar),
//                     textAlign: TextAlign.start,
//                   ),
//                   contentPadding:   EdgeInsets.all(0),
//                   leading:   Padding(
//                     padding:
//                     EdgeInsets.only(
//                         right: 15, top: 15,bottom: 15),
//                     child:Icon(Icons.exit_to_app)
//                   ) ,
//                 ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/icons/instagram.png',
                                fit: BoxFit.contain,
                                width: 35 * (screenSize.width) / 375,
                                height: 35 * (screenSize.width) / 375,
                              ),
                            ),
                            onTap: () async {
                              await openApp(instagram);
                            },
                          ),
                          GestureDetector(
                            // child: Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset(
                              'assets/images/wh.png',
                              width: 45 * (screenSize.width) / 375,
                              height: 45 * (screenSize.width) / 375,
                            ),
                            // ),
                            onTap: () async {
                              await openApp(rubika);
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/icons/telegram.png',
                                fit: BoxFit.contain,
                                width: 35 * (screenSize.width) / 375,
                                height: 35 * (screenSize.width) / 375,
                              ),
                            ),
                            onTap: () async {
                              await openApp(telegram);
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                'assets/icons/site.png',
                                fit: BoxFit.contain,
                                width: 35 * (screenSize.width) / 375,
                                height: 35 * (screenSize.width) / 375,
                              ),
                            ),
                            onTap: () async {
                              await openApp(website);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          _version + " نسخه",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff818181),
                              fontSize: 15 * fontvar,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ));
              }, onError: (_) {
                showSnakBar("لطفا مجددا تلاش کنید.");
              });
            }));
  }



  void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton1,
      contents: [
        ContentTarget(
            align: AlignContent.bottom,
            child: Container(
                child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "با زدن هدف، می تونی تعیین کنی که میخوای چاق بشی یا لاغر، حتی می تونی مقدار و سرعت چاق یا لاغر شدنت رو هم مشخص کنی ما برات کالریتو تعیین می کنیم.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * fontvar,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            )))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: keyButton2,
      contents: [
        ContentTarget(
            align: AlignContent.top,
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "این قسمت خیلی به درد بخوره هرچی غلات و مواد نشاسته ای هست رو به هم تبدیل می کنه، مثلا تو رژیمت نون لواش گذاشتن ولی میخوای نون سنگک بخوری، خیلی راحت اینجا می تونی مقدارشو تبدیل کنی.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14 * fontvar,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
  }

  void showTutorial() {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: MyColors.vazn,
      textSkip: "بستن",
      paddingFocus: 10,
      opacityShadow: 0.9,
    )..show();
  }

  void _afterLayout(_) {
    Future.delayed(Duration(milliseconds: 400), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringCoach = prefs.getString('coach');
      if (stringCoach != null) {
        List<String> arrayCoach = stringCoach.split("#");
        if (arrayCoach[1] == "0") {
          showTutorial();
          arrayCoach[1] = "1";
          String stringCoachSave = "";
          for (int i = 0; i < arrayCoach.length; i++) {
            if (i != 0) stringCoachSave = stringCoachSave + ("#");
            stringCoachSave = stringCoachSave + arrayCoach[i];
          }
          await prefs.setString('coach', stringCoachSave);
        }
      }
    });
  }

  showSnakBar(String name) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Text(
        name,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15 * fontvar,
            fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }

  openApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  Future<void> getEtebar(userStore store) async {
    _user = await store.getNotNull(context);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String serverDate= prefs.getString("date")??getDateToday();
    String acountDate=_user.account;

    print("serverDate"+serverDate);
    if(serverDate!=null && acountDate !=null  && acountDate !=""){
      var persianDateee = PersianDateTime(jalaaliDateTime: acountDate);
      var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
      DateTime datetoday = DateTime.parse(serverDate);
      DateTime dateacount= DateTime.parse(dateEtebarstr);
      print("serverDate"+dateacount.toString());
      print("acountDate"+datetoday.toString());
      print(dateacount
          .difference(datetoday)
          .inDays
          .toString()+"fffffffffffffffffff");
      etebar =dateacount.difference(datetoday).inDays;
    }

  }

  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String contactus = prefs.getString("contactus");
    contact contactitem;
    if (contactus != null) {
      setState(() {
        contactitem = contact.fromJson(jsonDecode(contactus));
        website = contactitem.website;
        description = contactitem.description;
        telegram = contactitem.telegram;
        instagram = contactitem.instagram;
        rubika = contactitem.rubika;
      });
    } else if (await checkConnectionInternet()) await getInfo();
  }

  Future<void> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString("user_token");

    final response = await Provider.of<apiServices>(context, listen: false)
        .contactUs('Bearer ' + apiToken);
    if (response.statusCode == 200) {
      final post = json.decode(response.bodyString);
      print(post);
      contact contactitem;
      contactitem = (contact.fromJson(post));
      prefs.setString("contactus", jsonEncode(contactitem.toMap()));

      if (description == "") {
        setState(() {
          website = contactitem.website;
          description = contactitem.description;
          telegram = contactitem.telegram;
          instagram = contactitem.instagram;
          rubika = contactitem.rubika;
        });
      }
    } else {
      print(response.statusCode.toString());
    }
  }
}
