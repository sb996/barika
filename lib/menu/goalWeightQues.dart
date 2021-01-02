import 'dart:convert';
import 'package:barika_web/helper.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/MyNumberpicker.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'package:states_rebuilder/states_rebuilder.dart';

class goalWeightQues extends StatefulWidget {
  @override
  User user;
  goalWeightQues({Key key, this.user}) : super(key: key);

  State<StatefulWidget> createState() => goalWeightQuesState();
}

class goalWeightQuesState extends State<goalWeightQues> {
  User _user;
  String bmi;
  int _type;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String bmiPeriod = "نامشخص";
  @override
  bool _isLoading = true;
  int _radioValue1 = 3;
  bool showLoading=false;
  String weightChange;
  String weightChangeWeek;

  _handleRadioValueChange1(int value) {
    setState(() {
      weightChangeWeek = null;
      weightChange = null;
      _radioValue1 = value;
    });
  }

  void initState() {
    super.initState();
    _user=widget.user;
    _isLoading=false;
  }

  int _currentPrice = 1;

  void _showDialog() {
    final theme = Theme.of(context);
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return
             Theme(
                  data: theme.copyWith(
                    accentColor: Colors.black, // highlted color
                  ),
                  child:  MyNumberPickerDialog.integer(
                    minValue: 1,
                    maxValue: getMaxWeight(),
                    title:  Text(
                      " وزن به کیلو گرم ",
                      style: TextStyle(fontSize: 15 * fontvar),
                      textAlign: TextAlign.center,
                    ),
                    initialIntegerValue: 1,
                    cancelWidget: Text(
                      "لغو",
                      style: TextStyle(color: MyColors.vazn,fontSize: 15 * fontvar),
                    ),
                    confirmWidget: Text(
                      "تایید",
                      style: TextStyle(color: Colors.green,fontSize: 15 * fontvar),
                    ),
                    step: 1,
                    infiniteLoop: true,
                  ));
        }).then((int value) {
      if (value != null) {
        setState(() => _currentPrice = value.round());
        weightChange = _currentPrice.toString();
        print(value);
      }
    });
  }

  void _showDialog1() {
    final theme = Theme.of(context);
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
              data: theme.copyWith(
                accentColor: Colors.black, // highlted color
              ),
              child: new MyNumberPickerDialog.integer(
                minValue: 100,
                maxValue: 1000,
                title: new Text(
                  "تغییرات وزن به گرم ",
                  style: TextStyle(fontSize: 15*fontvar),
                  textAlign: TextAlign.center,
                ),
                infiniteLoop: true,
                highlightSelectedValue: true,
                initialIntegerValue: 100,
                cancelWidget: Text(
                  "لغو",
                  style: TextStyle(color: MyColors.vazn,fontSize: 15 * fontvar),
                ),
                confirmWidget: Text(
                  "تایید",
                  style: TextStyle(color: Colors.green,fontSize: 15 * fontvar),
                ),
                step: 100,
              ));
        }).then((int value) {
      if (value != null) {
        setState(() => _currentPrice = value.round());
        weightChangeWeek = _currentPrice.toString();
        print(value);
      }
    });
  }

  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
          color: MyColors.vazn,
        ));
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
      key: _scaffoldKey,
        backgroundColor: _isLoading?Colors.white:MyColors.green,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: new Container(
            padding: EdgeInsets.only(top: 5, left: 8, right: 8),
            decoration: new BoxDecoration(
                color: MyColors.green
            ),
            child: new SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 0, right: 32),
                            child: Text(
                              'تعیین  هدف',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16*fontvar,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 32,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                          splashColor: Colors.amber,
                          padding: EdgeInsets.all(7),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _isLoading
            ? loadingView()
            : Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top:Radius.circular(22))),
          child: CustomScrollView(slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 30, top: 30),
                    child: Text(
                      "هدف خود را تعیین کنید:",
                      style:
                      TextStyle(fontSize: 16*fontvar, color: Color(0xff3D3D3D),fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 30,left: 30),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue1,
                                  activeColor: MyColors.green,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text(
                                  'کاهش وزن',
                                  style: new TextStyle(fontSize: 14*fontvar,color: Colors.black),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(

                                borderRadius:BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: MyColors.border
                                )

                            ),
                          ),
                          onTap:(){_handleRadioValueChange1(0);},
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                                children: <Widget>[ new Radio(
                                  value: 1,
                                  groupValue: _radioValue1,
                                  activeColor: MyColors.green,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                   Text(
                                    'افزایش وزن',
                                    style: new TextStyle(fontSize: 14*fontvar,color: Colors.black),
                                  )]),
                            decoration: BoxDecoration(

                                borderRadius:BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: MyColors.border
                                )

                            ),
                          ),
                          onTap:(){_handleRadioValueChange1(1);},
                        )
//                        new Radio(
//                          value: 2,
//                          groupValue: _radioValue1,
//                          onChanged: _handleRadioValueChange1,
//                        ),
//                        new Text(
//                          'تثبیت وزن',
//                          style: new TextStyle(fontSize: 13.0),
//                        ),
                      ],
                    ),
                  ),
                  (_radioValue1 == 0)?
                  Padding(
                    padding: EdgeInsets.only(right: 30, top: 20),
                    child: Text(
                      "میزان کاهش وزن خود را انتخاب کنید",
                      style:
                      TextStyle(fontSize: 16*fontvar, color: Color(0xff3D3D3D),fontWeight: FontWeight.w400),
                    ),
                  )

                      : (_radioValue1 == 1)?
                  Padding(
                    padding: EdgeInsets.only(right: 30, top: 20),
                    child: Text(
                      "میزان افزایش  وزن خود را انتخاب کنید",
                      style:
                      TextStyle(fontSize: 16*fontvar, color: Color(0xff3D3D3D),fontWeight: FontWeight.w400),
                    ),
                  ):Container(),
                  (_radioValue1 <=1 )?
                  Container(
                    width: screenSize.width,
                    padding: EdgeInsets.only(right: 5),
                    margin: EdgeInsets.only(right: 30, left: 30, top: 5),
                    child: FlatButton(
                      onPressed: _showDialog,
                      child: Text(weightChange == null
                          ? "--انتخاب کنید--"
                          : weightChange + " کیلو گرم ", style: new TextStyle(fontSize: 14*fontvar,color: Colors.black,fontWeight: FontWeight.w400),),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: MyColors.border)),
                  ):Container(),
                  (_radioValue1 == 0)?
                  Padding(
                      padding: EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        "میزان کاهش وزن هفتگی را انتخاب کنید",
                        style:
                        TextStyle(fontSize: 16*fontvar, color: Color(0xff3D3D3D),fontWeight: FontWeight.w400),
                      ))
                      : (_radioValue1 == 1)?
                  Padding(
                    padding: EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      "میزان افزایش وزن هفتگی را انتخاب کنید",
                      style:
                      TextStyle(fontSize: 16*fontvar, color: Color(0xff3D3D3D),fontWeight: FontWeight.w400),
                    ),
                  ):Container(),
                  (_radioValue1 <=1 )?
                  Container(
                    width: screenSize.width,
                    padding: EdgeInsets.only(right: 5),
                    margin: EdgeInsets.only(right: 30, left: 30, top: 5),
                    child: FlatButton(
                      onPressed: _showDialog1,
                      child: Text(weightChangeWeek == null
                          ? "--انتخاب کنید--"
                          : weightChangeWeek + "  گرم ",
                        style: new TextStyle(fontSize: 14*fontvar,color: Colors.black,fontWeight: FontWeight.w400),),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: MyColors.border)),
                  ):Container(),
                  (_radioValue1 <=1 )?
                  Container(
                      padding: EdgeInsets.only(
                          right: 40, left: 40, bottom: 10, top: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: screenSize.width,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 18),
                                color: MyColors.green,
                                disabledColor: MyColors.green.withOpacity(0.5) ,
                                onPressed:


                                ((weightChangeWeek==null||weightChange==null) || showLoading)
                                    ?null
                                    : () async {
                                  if (await checkConnectionInternet()) {
                                    await setInfo();
                                    Navigator.pop(context, "yes");
                                  } else {

                                    setState(() {
                                      showLoading = false;
                                    });
                                    showSnakBar("اتصال به اینترنت برقرار نیست");
                                  }
                                },
                                child: Text(
                                  showLoading? ''
                                      :  'تعیین هدف',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14*fontvar),
                                )),
                          ),
                          (showLoading)?
                            SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ):Container(width:0,height:0),
                        ],
                      )):Container(),
                  Card(

                      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
                      elevation: 5,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                         Padding(padding: EdgeInsets.only(top: 12,right: 10),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(child:  Image.asset( 'assets/icons/tik.png', ),flex:1,),

                                Flexible(
                                flex: 13,child: Padding(padding: EdgeInsets.only(right: 8),child: Text(
                                  "شما مجاز به کاهش و یا افزایش 100 گرم تا 1 کیلو در هر هفته می باشید.",
                                  style: TextStyle(fontSize: 14*fontvar,fontWeight: FontWeight.w400,color:Color(0xff3D3D3D)),
                                ),)),
                              ],
                            )),
                          Padding(padding: EdgeInsets.only(top: 12,right: 10),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(child:  Image.asset( 'assets/icons/tik.png',),flex: 1,),

                                  Flexible(
                                      flex: 13,child: Padding(padding: EdgeInsets.only(right: 8),child: Text(
                                    "پیشنهاد می کنیم در هفته بیش از 500 گرم کاهش و یا افزایش وزن نداشته باشید.",
                                    style: TextStyle(fontSize: 14*fontvar,fontWeight: FontWeight.w400,color:Color(0xff3D3D3D)),
                                  ),)),
                                ],
                              )),
                        ],
                      )
                  ),
                ]))
          ]),
        ));
  }




 updateUser(User user) async {
    bool result;
    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store) async =>
    result = await store.updateUser(context, user.toMap5()),
        onData: (context, userSt) {
          print(userSt.user);
          print("user after update");
          if (result) {
            showSnakBar("اطلاعات ویرایش شد.");
          }
          else
            showSnakBar("خطا در برقراری ارتباط");
        },

        onError: (context, error) {
          showSnakBar("خطا در برقراری ارتباط");

        });
  }

  setInfo() async {

    print(showLoading);
    setState(() {
      showLoading=true;
    });
    int newcalorie;
    int oldcalorie = _user.calorie;
    int variabel = int.parse(weightChangeWeek);
    double gweight;
    int gcalorie;
    int week =
    (double.parse(weightChange) * 1000 / double.parse(weightChangeWeek))
        .ceil();
    var now = new DateTime.now();
    final custom = intl.DateFormat('yyyy-MM-dd').format((new DateTime(
      now.year,
      now.month,
      now.day + week * 7,
    )));
//  String date='${custom.year.toString()}-${custom.month.toString()}-${custom.day.toString()}';
    print(custom.toString());
    if (_radioValue1 == 0) {
      switch (variabel) {
        case 100:
          variabel = 100;
          break;
        case 200:
          variabel = 190;
          break;
        case 300:
          variabel = 270;
          break;
        case 400:
          variabel = 340;
          break;
        case 500:
          variabel = 400;
          break;
        case 600:
          variabel = 460;
          break;
        case 700:
          variabel = 510;
          break;
        case 800:
          variabel = 560;
          break;
        case 900:
          variabel = 600;
          break;
        case 1000:
          variabel = 640;
          break;
      }

      newcalorie = oldcalorie - variabel;
      gweight = double.parse(_user.weight) - double.parse(weightChange);
      gcalorie = variabel * (-1);
    }
    if (_radioValue1 == 1) {
      newcalorie = oldcalorie + variabel;
      gweight = double.parse(_user.weight) + double.parse(weightChange);
      gcalorie = variabel;
    }

    if(newcalorie<600) newcalorie=600;
    gweight = double.parse(gweight.toStringAsFixed(1));
    _user.calorie = newcalorie;
    _user.gcalorie = gcalorie;
    _user.gweight = gweight.toString();
    _user.gdate = getDateToday() + "*" + custom.toString();
    print(_user.toMap());
    print(await updateUser(_user));
  }


  int getMaxWeight() {
    double height = double.parse(_user.height);
    double weight = double.parse(_user.weight);

    print((28 * height * height * 0.0001));
    if (_radioValue1 == 0)
      return (weight - (19 * height * height * 0.0001)).round() < 1
          ? 2
          : (weight - (19 * height * height * 0.0001)).round();
    else if (_radioValue1 == 1)
      return ((28 * height * height * 0.0001) - weight).round() < 1
          ? 2
          : ((28 * height * height * 0.0001) - weight).round();
  }


  showSnakBar(String name)  {

    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          duration: new Duration(seconds: 2),
          backgroundColor: MyColors.vazn,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          content: Text(name,
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15*fontvar,fontFamily: "iransansDN"),textDirection: TextDirection.rtl,),
        ));

  }
}
