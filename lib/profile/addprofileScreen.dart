import 'dart:async';
import 'dart:convert';
import 'package:barika_web/home/logiin.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/profile/profileScreen.dart';
import 'package:barika_web/regims/bchart3_12.dart';
import 'package:barika_web/regims/bchart6_3.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/MyDadaPicker.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:barika_web/utils/regimDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../helper.dart';

class addprofileScreen extends StatefulWidget {
  @override
  String regim;
  String userId;

  addprofileScreen({Key key, this.regim, this.userId}) : super(key: key);

  State<StatefulWidget> createState() => new addprofileScreenState();
}

class addprofileScreenState extends State<addprofileScreen> {
  PersianDatePickerWidget persianDatePicker1;
  TextEditingController textEditingController = TextEditingController();
  final Color backgroundColor = Colors.amber;
  final Color orange = Color(0xffF15A23);
  final Color gray = Color(0xffB5B6B5);
  final Color green = Color(0xff6DC07B);
  bool _showLoading = false;
  double _weightValue = 2;
  double _heightValue = 2;
  String gender = 'female';
  String appetite ;
  String activity ;
  TextEditingController _heightC = new TextEditingController();
  TextEditingController _weightC = new TextEditingController();
  String name="";

  String regim;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  bool _validate2 = false;
  bool _validate = false;
  bool _validate4= false;

  @override
  void initState() {
    regim = widget.regim;
    setDatePicker1();
//    textEditingController.text=pbirthDate.toString();
    super.initState();
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

    return new Scaffold(
      appBar:  new PreferredSize(preferredSize: Size.fromHeight( 100*(screenSize.width)/375,),
            child:  Container(

                height: 100*(screenSize.width)/375,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 6,
                      child: Image.asset(
                        'assets/images/bg_intro.png',
                        color: MyColors.green,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                        width:  MediaQuery.of(context).size.width,
                        height: 70*(screenSize.width)/375,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 32*(screenSize.width)/375,
                      ),
                      onPressed: () {
                        Navigator.pop(context, 'yes');
                      },
                      alignment: Alignment.topLeft,
                      color: Colors.white,
                      splashColor: Colors.amber,
                      padding: EdgeInsets.only(top: 17,left: 7,right: 7),
                    ),
                  ],
                ),
              ),),
        key: _scaffoldKey,
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    height: _validate4?75* (screenSize.width) / 375:45* (screenSize.width) / 375,
                    margin: EdgeInsets.only(right: 15, left: 15, top: 2),
                    child: TextFormField(
                      onChanged: (String text) {
                        setState(() {
                          name = text;
                        });
                      },

                      decoration: InputDecoration(
                          errorText:
                          _validate4 ? 'نام خود را وارد کنید ' : null,
contentPadding: EdgeInsets.only(top:8 ,right: 8),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 0.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 0.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 0.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: MyColors.green, width: 0.5),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),

                          hintText: 'نام خود را وارد کنید',
                          hintStyle:
                          TextStyle(color: Colors.black38, fontSize: 15*fontvar)),

                      style: TextStyle(
                        fontSize: 12.0 * fontvar,
                      ),
                      // *** this is important to prevent user interactive selection ***
                    )),

            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.centerRight,
                height: 45*(screenSize.width)/375,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: MyColors.green, width: 1)),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 7),
                      hintText: 'تاریخ تولد خود را وارد کنید.',
                      hintStyle: TextStyle(color: Colors.black38, fontSize: 15*fontvar),
                      border: InputBorder.none,
                      prefixIcon:    Container(
                        height: 30*(screenSize.width)/375,
                        width: 30*(screenSize.width)/375,
                        alignment: Alignment.center,
                        child:  Image.asset(
                          'assets/icons/calendar.png',
                          height: 30*(screenSize.width)/375,
                          width: 30*(screenSize.width)/375,
                        ),
                      ),),
                  enableInteractiveSelection: false,
                  readOnly: true,
                  cursorWidth: 0,
                  style: TextStyle(
                    fontSize: 12.0*fontvar,
                  ),
                  // *** this is important to prevent user interactive selection ***
                  onTap: () {
                    MyDatePicker.showDatePicker(
                      context,

                      onConfirm: (int year,int month,int day){
                        print(year);
                        print(month);
                        print(day);
                        String datenew=year.toString()+"/"+month.toString()+"/"+day.toString();
                        var datenew2 = PersianDateTime(jalaaliDateTime:datenew);
                        PersianDateTime datenow = PersianDateTime();
                        if((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0))
                        {


                          setState(() {
                            var persianDate1 = PersianDateTime(jalaaliDateTime: datenew);
                            birthDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
                            textEditingController.text=persianDate1.toString();
                            print(birthDate);

                          });

                        }
                        else{

                          Fluttertoast.showToast(
                            msg: "امکان انتخاب این تاریخ وجود ندارد.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,

                            fontSize: 16.0*fontvar,
                          );
                        }
                      },


                      minYear: 1300,

                      maxYear: 1450,
                      confirm: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.green
                        ),
                        child: Text(
                          'تایید',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18*fontvar,
                              fontFamily: "iransansDN",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      cancel:Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Colors.red
                          ),
                          child: Text(
                            ' لغو ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18*fontvar,
                                fontFamily: "iransansDN",
                                fontWeight: FontWeight.w400),
                          )),

                    );
                  },
                  controller: textEditingController,
                )

//          Row(
//        children: <Widget>[
//        Image.network(
//          'assets/icons/calendar.svg',
//        ),
//            Padding(
//              padding: EdgeInsets.only(right: 5, left: 5, top: 3),
//              child: Text(
//                'تاریخ تولد',
//                style: TextStyle(
//                    color: Color(0xff5C5C5C),
//                    fontWeight: FontWeight.w400,
//                    fontSize: 12),
//              ),
//            )
//          ],
//          ),

                ),
            Container(
                margin:
                    EdgeInsets.only(right: 15, left: 15, top: 10),
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
                            height: 72*(screenSize.width)/375,
                            padding: EdgeInsets.only(right: 5, left: 5, top: 5),
                            child: new TextFormField(
                              controller: _weightC,
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
                              },
                              decoration: new InputDecoration(
                                  errorText: _validate
                                      ? "وزن خود را وارد کنید "
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
                                  hintText: 'وزن',
                                  hintStyle:  TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14*fontvar,
                                      fontWeight: FontWeight.w500),
                                  contentPadding:  EdgeInsets.only(
                                      top: 10, right: 8, bottom: 10, left: 8)),
                            ),
                          ),
//                  Padding(
//                    padding: EdgeInsets.only(top: 2, left: 12),
//                    child: Text(
//                      '${_weightValue.toStringAsFixed(1)} کیلوگرم ',
//                      textAlign: TextAlign.end,
//                      style: TextStyle(
//                          fontWeight: FontWeight.w400,
//                          color: Color(0xff51565F),
//                          fontSize: 14),
//                    ),
//                  ),
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
//                  Padding(
//                    padding: EdgeInsets.only(top: 2, left: 12),
//                    child: Text(
//                      '${_weightValue.toStringAsFixed(1)} کیلوگرم ',
//                      textAlign: TextAlign.end,
//                      style: TextStyle(
//                          fontWeight: FontWeight.w400,
//                          color: Color(0xff51565F),
//                          fontSize: 14),
//                    ),
//                  ),
                        ],
                      ),
                    ),
                  ],
                )),
            Text(
              'جنسیت',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff51565F),
                  fontWeight: FontWeight.w500,
                  fontSize: 14*fontvar),
            ),
                (birthDate!=null&&calculateAge(birthDate) <= 12)
                    ?Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/woman.png',
                            height: 65*(screenSize.width)/375,
                        width: 30*(screenSize.width)/375,
                              color: gender == 'female' ? orange : gray,
                            ),
                            Text(
                              'دختر',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: gender == 'female' ? orange : gray,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14*fontvar),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            gender = 'female';
                          });
                        },
                      ),
                      regim == "pregnancy" || regim == "lactation"
                          ? Container()
                          : Container(
                        margin:
                        EdgeInsets.only(right: 25, left: 25, bottom: 5),
                        alignment: Alignment.center,
                        height: 50*(screenSize.width)/375,
                        width: 6*(screenSize.width)/375,
                        decoration: BoxDecoration(
                          color: Color(0xffC1E4AF),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      regim == "pregnancy" || regim == "lactation"
                          ? Container()
                          : GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/man.png',
                            height: 65*(screenSize.width)/375,
                        width: 30*(screenSize.width)/375,
                              color: gender == 'male' ? orange : gray,
                            ),
                            Text(
                              'پسر',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: gender == 'male' ? orange : gray,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14*fontvar),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            gender = 'male';
                          });
                        },
                      )
                    ],
                  ),
                )
                    :  Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/woman.png',
                          height: 65*(screenSize.width)/375,
                          width: 30*(screenSize.width)/375,
                          color: gender == 'female' ? orange : gray,
                        ),
                        Text(
                          'زن',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: gender == 'female' ? orange : gray,
                              fontWeight: FontWeight.w400,
                              fontSize: 14*fontvar),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        gender = 'female';
                      });
                    },
                  ),
                  regim == "pregnancy" || regim == "lactation"
                      ? Container()
                      : Container(
                          margin:
                              EdgeInsets.only(right: 25, left: 25, bottom: 5),
                          alignment: Alignment.center,
                          height: 50*(screenSize.width)/375,
                          width: 6*(screenSize.width)/375,
                          decoration: BoxDecoration(
                            color: Color(0xffC1E4AF),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                  regim == "pregnancy" || regim == "lactation"
                      ? Container()
                      : GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/man.png',
                                height: 65*(screenSize.width)/375,
                                width: 30*(screenSize.width)/375,
                                color: gender == 'male' ? orange : gray,
                              ),
                              Text(
                                'مرد',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: gender == 'male' ? orange : gray,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14*fontvar),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              gender = 'male';
                            });
                          },
                        )
                ],
              ),
            ),
                (birthDate!=null&&calculateAge(birthDate) >= 3)
                ? (birthDate!=null&&calculateAge(birthDate) <= 12)
                    ? Container(

              margin: EdgeInsets.only(right: 12, bottom: 4, top: 4),
              child: Row(
                children: <Widget>[
                  Text(
                    'فعالیت',
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
                                    'assets/icons/active1.png', height: 22*(screenSize.width)/375,
                                    width: 22*(screenSize.width)/375,
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
                                      'assets/icons/active2.png', height: 22*(screenSize.width)/375,
                                      width: 22*(screenSize.width)/375,
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
                                      'assets/icons/active3.png', height: 22*(screenSize.width)/375,
                                      width: 22*(screenSize.width)/375,
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
                                      'assets/icons/active4.png', height: 22*(screenSize.width)/375,
                                      width: 22*(screenSize.width)/375,
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
                            child: Padding(
                                padding:
    EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/icons/active5.png', height: 22*(screenSize.width)/375,
                                      width: 22*(screenSize.width)/375,
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

                        margin: EdgeInsets.only(right: 15, bottom: 4, top: 4),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'فعالیت',
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
                                        Image.asset(
                                          'assets/icons/active1.png', height: 22*(screenSize.width)/375,
                                          width: 22*(screenSize.width)/375,
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
                                            'assets/icons/active2.png', height: 22*(screenSize.width)/375,
                                            width: 22*(screenSize.width)/375,
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
                                            'assets/icons/active3.png', height: 22*(screenSize.width)/375,
                                            width: 22*(screenSize.width)/375,
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
                                            'assets/icons/active4.png', height: 22*(screenSize.width)/375,
                                            width: 22*(screenSize.width)/375,
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
                                            'assets/icons/active5.png', height: 22*(screenSize.width)/375,
                                            width: 22*(screenSize.width)/375,
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

                  margin: EdgeInsets.only(right: 15, bottom: 4, top: 4),
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
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                          onPressed: _showLoading?null:() async {
                            setState(() {
                              _showLoading = true;
                            });
                            if (checkInput()) {

                              if (regim != "" && regim != null) {


                                bool getRegim=true;
                                if (regim .contains("children") ) {
                                  if (birthDate != null && calculateAge(birthDate) < 12) {
                                    if (calculateAllMounth(birthDate) >= 5) {

                                    } else{
                                      showSnakBar("این رژیم برای کودکان بالای 5 ماه است.");
                                      getRegim=false;
                                    }}
                                  else {
                                    showSnakBar(
                                        "این رژیم برای کودکان زیر 12 سال است.");
                                    getRegim = false;
                                  }}
                                else if (birthDate != null && calculateAge(birthDate) < 12)
                                { showSnakBar ("این رژیم برای کودکان زیر 12 سال مناسب نمی باشد، لطفا از بخش رژیم های کودکان اقدام کنید.");
                                getRegim=false;

                                }



///////////////////////////////////////////

                                if(getRegim){
                                  bool ok=await okDialog();
                                  if(ok){
                                    if (await checkConnectionInternet()){
                                      await _update(context).whenComplete(() {});
                                    }}
                                  else{ setState(() {
                                    _showLoading = false;
                                  });}
                                }}

///////////////////////////////////////////////////////////////


                            } else
                              showSnakBar(
                                  'لطفا اطلاعات خود را تکمیل کنید.');
                          },
                          child: Text(
                            _showLoading ? '' : ' تایید اطلاعات',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          )),
                    ),
                    _showLoading
                        ? SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20,
                          )
                        : Container()
                  ],
                )),
            Container(
              height: 10*(screenSize.width)/375,
            ),
          ]))
        ]));
  }

  Future _update(BuildContext context) async {


    if (regim != "") {

      var mainUser =await getUser();

      final newPost = {
        'birthdate': birthDate,
        'weight': _weightValue.toStringAsFixed(3),
        'height': _heightValue.toStringAsFixed(1),
        'gender': gender,
        'activity': activity,
        'appetite': appetite,
        'name':name.toString(),
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
                      child: bchart6_3(user: newUser,uidDiet: mainUser.uid),
//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
                    ),
                  ))
                  : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Directionality(
                      textDirection: TextDirection.ltr,
                      child: bchart3_12(
                        user: newUser,uidDiet: mainUser.uid,
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
          if (birthDate != null && calculateAge(newUser.birthdate) < 12)
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
                        metype: regim,
                      counter: 0,
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


  bool checkInput() {
    setState(() {
      name.isEmpty ? _validate4 = true : _validate4 = false;
      _weightC.text.isEmpty ? _validate = true : _validate = false;
      _heightC.text.isEmpty ? _validate2 = true : _validate2 = false;
    });

    if (birthDate == "" ||
        birthDate == "0" ||
        birthDate == null)
      return false;
    if (  name.isEmpty  || name== "" ||  name == null) return false;
    if (calculateAge(birthDate) >= 3) {
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

  Future<bool> okDialog() async {
    String returnVal = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContextcontext) {
          return Padding(
              padding: EdgeInsets.all(0),
              child: Dialog(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                  child: regimProfileDialog()));
        });

    if (returnVal == "ok")
      return true;
    else
      return false;
  }
}
