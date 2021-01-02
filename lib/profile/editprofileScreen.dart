import 'dart:async';
import 'dart:convert';
import 'package:barika_web/home/logiin.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/regims/bchart3_12.dart';
import 'package:barika_web/regims/bchart6_3.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'dart:math' as math;
import '../helper.dart';

class editprofileScreen extends StatefulWidget {
  @override

  String regim;
  String selfId;
  String dietId;
  User userSend;
  editprofileScreen({Key key,this.regim,this.selfId,this.dietId,this.userSend,}) : super(key: key);

  State<StatefulWidget> createState() => new editprofileScreenState();
}

class editprofileScreenState extends State<editprofileScreen>
    with AutomaticKeepAliveClientMixin<editprofileScreen> {
  @override
  bool get wantKeepAlive => false;
  bool _validate = false;
  bool _validate2 = false;
  PersianDatePickerWidget persianDatePicker1;
  TextEditingController textEditingController = TextEditingController();
  final Color backgroundColor = Colors.amber;
  final Color orange = Color(0xffF15A23);
  final Color gray = Color(0xffB5B6B5);
  final Color green = Color(0xff6DC07B);
  bool _showLoading = false;
  User _user;
  double _weightValue = 2;
  double _weightValueup = 2;
  double _heightValue = 2;
  String gender;
  String appetite;
  String activity;
  String _bdate = "";
  bool _isLoading = true;
  String regim;
  String bdateText = "";
  int i = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User userSend;
  TextEditingController _heightC = new TextEditingController();
  TextEditingController _weightC = new TextEditingController();

  Widget loadingView() {
    return  Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }

  String birthDate ;

  setDatePicker1() {
    persianDatePicker1 = PersianDatePicker(
      controller: textEditingController,
      farsiDigits: false,
      onChange: (String oldText, String newText) {
        setState(() {
          var persianDate1 = PersianDateTime(jalaaliDateTime: newText);
          birthDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
          print(birthDate);
        });

        Navigator.pop(context);
      },
      maxDatetime: PersianDateTime().toString(),
    ).init();
  }


  String selfId;
  @override
  void initState() {
    regim=widget.regim??"";
    selfId = widget.selfId;
    _getInfo();
    super.initState();
  }

  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return  Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                  height: 85*(screenSize.width)/375,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: 6,
                        child: Image.asset(
                          'assets/images/bg_intro.png',
                          color: MyColors.green,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fitWidth,
                          width:  MediaQuery.of(context).size.width,
                          height:85*(screenSize.width)/375,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20*(screenSize.width)/375, right: 15),
                        child:    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _user == null ? "" : _user.name ?? " ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15*fontvar,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.chevron_right,
                                size:32*(screenSize.width)/375,
                              ),
                              onPressed: () {
                                Navigator.pop(context, 'yes');
                              },
                              alignment: Alignment.topLeft,
                              color: Colors.white,
                              splashColor: Colors.amber,
                              padding: EdgeInsets.all(7),
                            ),
                          ],
                        ),
                      )],
                  ),
                ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              alignment: Alignment.centerRight,
              height: 45*(screenSize.width)/375,
              margin: EdgeInsets.only(right: 15, left: 15, top: 7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: MyColors.green, width: 1)),


              child: Row(
                children: <Widget>[
    Container(
    height: 30*(screenSize.width)/375,
    width: 30*(screenSize.width)/375,
    alignment: Alignment.center,
    child:  Image.asset(
    'assets/icons/calendar.png',
    height: 30*(screenSize.width)/375,
    width: 30*(screenSize.width)/375,
    ),
    ),
                  Padding(
                    padding: EdgeInsets.only(right: 5, left: 5, top: 3),
                    child: Text(
                      'تاریخ تولد',
                      style: TextStyle(
                          color: Color(0xff5C5C5C),
                          fontWeight: FontWeight.w400,
                          fontSize: 13*fontvar),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5, left: 5, top: 3),
                    child: Text(
                      bdateText,
                      style: TextStyle(
                          color: Color(0xff5C5C5C),
                          fontWeight: FontWeight.w400,
                          fontSize: 13*fontvar),
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin:
                    EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                 'assets/icons/profile_weight.png', height: 20*(screenSize.width)/375,
                              width: 20*(screenSize.width)/375,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 5, left: 5, top: 5),
                                child: Text(
                                  'وزن(کیلوگرم)',
                                  style: TextStyle(
                                      color: Color(0xff5C5C5C),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13*fontvar),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height:  72*(screenSize.width)/375,
                            padding: EdgeInsets.only(right: 5, left: 5, top: 5),
                            child: new TextFormField(
                              controller: _weightC,
                              onTap: () {
                                _weightC.selection = TextSelection.fromPosition(
                                    TextPosition(offset: _weightC.text.length));
                              },
                              textAlign: TextAlign.right,
                              inputFormatters: [
                                DecimalTextInputFormatter(decimalRange: 3)
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              style:  TextStyle(
                                  color: Color(0xff5c5c5c),
                                  fontSize: 14*fontvar,
                                  fontWeight: FontWeight.w500),
                              onChanged: (text) {
                                text= changeDigit( text);
                                print(text);
                                _weightValue = double.parse(text);
                                print(_weightValue);
                              },
                              decoration:  InputDecoration(
                                  errorText: _validate
                                      ? "وزن خود را وارد کنید "
                                      : null,
                                  border: new OutlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  focusedBorder:  OutlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'وزن',
                                  hintStyle:  TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14*fontvar,
                                      fontWeight: FontWeight.w500),
                                  contentPadding:  EdgeInsets.only(
                                      top: 10, right: 8, bottom: 10, left: 8)),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/profile_height.png', height: 20*(screenSize.width)/375,
    width: 20*(screenSize.width)/375,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 2, left: 5, top: 3),
                                child: Text(
                                  'قد(سانتی متر)',
                                  style: TextStyle(
                                      color: Color(0xff5C5C5C),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13*fontvar),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 72*(screenSize.width)/375,
                            padding: EdgeInsets.only(right: 5, left: 5, top: 5),
                            child: new TextFormField(
                              controller: _heightC,
                              onTap: () {
                                _heightC.selection = TextSelection.fromPosition(
                                    TextPosition(offset: _heightC.text.length));
                              },
                              textAlign: TextAlign.right,
                              inputFormatters: [
                                DecimalTextInputFormatter(decimalRange: 1)
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              style:  TextStyle(
                                  color: Color(0xff5c5c5c),
                                  fontSize: 14*fontvar,
                                  fontWeight: FontWeight.w500),
                              onChanged: (text) {
                                text= changeDigit( text);
                                print(text);
                                _heightValue = double.parse(text);
                              },
                              decoration: new InputDecoration(
                                  errorText: _validate2
                                      ? 'قد خود را وارد کنید '
                                      : null,
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  focusedBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: MyColors.green, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'قد',
                                  hintStyle:  TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14*fontvar,
                                      fontWeight: FontWeight.w500),
                                  contentPadding:  EdgeInsets.only(
                                      top: 10, right: 8, bottom: 10, left: 8)),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                )),

            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 3),
                  child: Text(
                    'جنسیت',
                    style: TextStyle(
                        color: Color(0xff5C5C5C),
                        fontWeight: FontWeight.w400,
                        fontSize: 13*fontvar),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 5, top: 3),
                  child: Text(
    (birthDate!=null&&calculateAge(birthDate) <= 12)
                        ? gender == "female" ? "دختر" : "پسر"
                        : gender == "female" ? "زن" : "مرد",
                    style: TextStyle(
                        color: Color(0xff5C5C5C),
                        fontWeight: FontWeight.w400,
                        fontSize: 14*fontvar),
                  ),
                )
              ],
            ),
              (birthDate!=null&& calculateAge(birthDate) >= 3)
                ? (birthDate!=null&&calculateAge(birthDate) <= 12)
                    ? Container(

                        margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              ' فعالیت',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff3D3D3D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14*fontvar),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/icons/active1.png',height: 20*(screenSize.width)/375,
                                          width: 20*(screenSize.width)/375,
                                          color: activity == '5' ? green : gray,
                                        ),
                                        Text(
                                          'خیلی پر جنب و جوش',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: activity == '5'
                                                  ? green
                                                  : gray,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9*fontvar),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      activity = '5';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active2.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '4' ? green : gray,
                                          ),
                                          Text(
                                            'پر جنب و جوش',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '4'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '4';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active3.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '3' ? green : gray,
                                          ),
                                          Text(
                                            'معمولی',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '3'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '3';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active4.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '2' ? green : gray,
                                          ),
                                          Text(
                                            'کم فعالیت',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '2'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '2';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active5.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '1' ? green : gray,
                                          ),
                                          Text(
                                            'بی فعالیت',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '1'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '1';
                                    });
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                      )
                    : Container(

                        margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              ' فعالیت',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff3D3D3D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14*fontvar),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/icons/active1.png',height: 20*(screenSize.width)/375,
                                          width: 20*(screenSize.width)/375,
                                          color: activity == '5' ? green : gray,
                                        ),
                                        Text(
                                          'خیلی زیاد',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: activity == '5'
                                                  ? green
                                                  : gray,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10*fontvar),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      activity = '5';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active2.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '4' ? green : gray,
                                          ),
                                          Text(
                                            'زیاد',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '4'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '4';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active3.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '3' ? green : gray,
                                          ),
                                          Text(
                                            'متوسط',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '3'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '3';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active4.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '2' ? green : gray,
                                          ),
                                          Text(
                                            'کم',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '2'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '2';
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/active5.png',height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color:
                                                activity == '1' ? green : gray,
                                          ),
                                          Text(
                                            'بی فعالیت',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: activity == '1'
                                                    ? green
                                                    : gray,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10*fontvar),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    setState(() {
                                      activity = '1';
                                    });
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                      )
                : Container(),
                (birthDate!=null&&calculateAge(birthDate) >= 3)?
              Container(

                margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      'اشتها',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff3D3D3D),
                          fontWeight: FontWeight.w400,
                          fontSize: 14*fontvar),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                appetite == '5' ?
                                Image.asset(
                                  'assets/icons/fastfoodd.png',
                                  height: 28*(screenSize.width)/375,
                                  width: 28*(screenSize.width)/375,
                                ):  Image.asset(
                                  'assets/icons/fastfood.png',
                                  height: 28*(screenSize.width)/375,
                                  width: 28*(screenSize.width)/375,
                                  color: gray,
                                ),
                                Text(
                                  'خیلی زیاد',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: appetite == '5' ? green : gray,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10*fontvar),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              appetite = '5';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  appetite == '4' ? Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                  child: Image.asset(
                                    'assets/icons/chicken.png',
                                    height: 25 * (screenSize.width) / 375,
                                    width: 25 * (screenSize.width) / 375,
                                  ),
                                  ): Image.asset(
                                    'assets/icons/burger.png',
                                    height: 25 * (screenSize.width) / 375,
                                    width: 25 * (screenSize.width) / 375,
                                    color: gray,
                                  ),
                                  Text(
                                    'زیاد',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appetite == '4' ? green : gray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10*fontvar),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              appetite = '4';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  appetite == '3' ?   Image.asset(
                                    'assets/icons/lunch2.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,
                                  ):Image.asset(
                                    'assets/icons/fish.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,
                                    color:  gray,
                                  ),
                                  Text(
                                    'متوسط',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appetite == '3' ? green : gray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10*fontvar),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              appetite = '3';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  appetite == '2'
                                      ?Image.asset(
                                    'assets/icons/food2.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,
                                  )
                                      :
                                  Image.asset(
                                    'assets/icons/apple.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,

                                  ),

                                  Text(
                                    'کم',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appetite == '2' ? green : gray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10*fontvar),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              appetite = '2';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  appetite == '1' ? Image.asset(
                                    'assets/icons/cupcakee.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,
                                  ):Image.asset(
                                    'assets/icons/cupcake.png',height: 25*(screenSize.width)/375,
                                    width: 25*(screenSize.width)/375,
                                    color:  gray,
                                  ),
                                  Text(
                                    'بی اشتها',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: appetite == '1' ? green : gray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10*fontvar),
                                  ),
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              appetite = '1';
                            });
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              ):Container(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width:  MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          color: MyColors.green,
                          disabledColor: MyColors.green.withOpacity(0.5),
                          onPressed:  _showLoading ?null: () async {

                            setState(() {
                              _showLoading = true;
                            });
                            if (checkInput()) {

                                if (await checkConnectionInternet())
                                    await _update();

                            }   else {
                              setState(() {
                                _showLoading = false;
                              });
                              showSnakBar(
                                  'لطفا اطلاعات خود را تکمیل کنید.');
                            }

                          },
                          child: Text(
                            _showLoading ? '' : ' تایید اطلاعات',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          )),
                    ),
                     (_showLoading)?
                      SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20,
                      ):Container(width:0,height:0),
                  ],
                )),
            Container(
              height: 50*(screenSize.width)/375,
            ),
          ]))
        ]));
  }

  _getInfo() async {

      _user=widget.userSend;


    if (this.mounted) {
      setState(() {
        print(_user.toMap());
        _heightValue = double.tryParse(_user.height ?? '0');
        _weightValue = double.tryParse(_user.weight ?? '0');
        gender = _user.gender ?? 'male';
        activity = _user.activity ?? '0';
        appetite = _user.appetite ?? '0';
        birthDate = _user.birthdate != "0" ? _user.birthdate : '1996-09-17';
        DateTime date = DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(
            DateTime.parse(
                _user.birthdate != "0" ? _user.birthdate : '1996-09-17')));
        print(date);
        var persianDateee = PersianDateTime.fromGregorian(
            gregorianDateTime:
            _user.birthdate != "0" ? _user.birthdate : '1996-09-17');
        var pbirthDate = persianDateee.toJalaali(format: 'YYYY-MM-DD');
        textEditingController.text = pbirthDate.toString();
        _heightC.text = _heightValue.toString();
        _weightC.text = _weightValue.toString();
        bdateText = pbirthDate.toString();
        _isLoading = false;
      });
    }
  }

  Future _update() async {

    if (regim != "") {

      var mainUser =await getUser();

      final newPost = {
        'birthdate': birthDate,
        'weight': _weightValue.toStringAsFixed(3),
        'height': _heightValue.toStringAsFixed(1),
        'gender': gender,
        'activity': activity,
        'appetite': appetite,
        'name': _user.name,
      };

      User newUser=User.fromJsonNewDiet(newPost);
      if (await checkConnectionInternet()) {

        if (regim .contains("children") ) {
          if (birthDate != null && calculateAge(birthDate) < 12) {
            if (calculateAllMounth(birthDate) >= 5) {
              (birthDate != null && calculateAge(birthDate) < 3)
                  ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Directionality(
                      textDirection: TextDirection.ltr,
                      child: bchart6_3(user: newUser,uidDiet: mainUser.uid,selfId: widget.selfId,dietId:widget.dietId ,edit: true,),
//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
                    ),
                  ))
                  : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Directionality(
                      textDirection: TextDirection.ltr,
                      child: bchart3_12(user: newUser,uidDiet: mainUser.uid,selfId: widget.selfId,dietId:widget.dietId ,edit: true,
                      ),
//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
                    ),
                  ));
            } else
              showSnakBar("این رژیم برای کودکان بالای 5 ماه است.");
          } else {
            showSnakBar("این رژیم برای کودکان زیر 12 سال است.");
          }
        } else {
          if (birthDate != null && calculateAge(birthDate) < 12)
            showSnakBar(
                "این رژیم برای کودکان زیر 12 سال مناسب نمی باشد، لطفا از بخش رژیم های کودکان اقدام کنید.");
          else {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: LoginScreen(
                      type: regim,
                      uid: mainUser.uid,
                      user: newUser,
                      selfId: widget.selfId,
                      metype: regim,
                      counter: 0,
                      edit: true,
                      dietId: widget.dietId,
                    )),
//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
              ),
            );
          }
        }

      } else
        showSnakBar('اتصال به اینترنت را بررسی کنید.');
    }


  }
  Future<User> getUser() async {

    User us;
    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store) async => await store.getNotNull(context),
      onData: (context, userSt ) {
        print("userStuserStuserSt");
        print(userSt.user);
        print("userStuserStuserSt");

        if (userSt.user != null){
          us= userSt.user;
        }
        else
          showSnakBar("خطا در برقراری ارتباط");
      },

      onError: (context, error) {
        showSnakBar("خطا در برقراری ارتباط");
      },
    );
    print("us");
    print(us);
    return us;

  }

  showSnakBar(String s) {
    if(_showLoading)
      setState(() {
        _showLoading = false;
      });
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 2),
      backgroundColor: MyColors.vazn,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),

      content: Text(
        s,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15*fontvar,fontFamily: "iransansDN"),
        textDirection: TextDirection.rtl,
      ),
    ));
  }

  bool checkInput() {
    setState(() {
      _weightC.text.isEmpty ? _validate = true : _validate = false;
      _heightC.text.isEmpty ? _validate2 = true : _validate2 = false;
    });
    if (birthDate == "" ||
        birthDate == "0" ||
        birthDate == null)
      return false;
    if (birthDate!=null&&calculateAge(birthDate) >= 3) {
      if (_weightC.text.isNotEmpty &&
          _heightC.text.isNotEmpty &&
          appetite != null &&
          appetite != "0" &&
          gender != null &&
          gender != "0" &&
          activity != null &&
          activity != "0")
        return true;
      else
        return false;
    } else {
      if (_weightC.text.isNotEmpty &&
          _heightC.text.isNotEmpty &&
          gender != null &&
          gender != "0")
        return true;
      else
        return false;
    }
  }




}
