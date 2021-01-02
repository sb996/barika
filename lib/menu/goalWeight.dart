import 'dart:convert';
import 'package:barika_web/menu/deletegDialog.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/test_state_builder/user_store.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../helper.dart';
import 'goalWeightQues.dart';

class goalWeight extends StatefulWidget {
  @override


  String acountDate;

  goalWeight({Key key,this.acountDate}) : super(key: key);

  State<StatefulWidget> createState() => goalWeightState();
}

class goalWeightState extends State<goalWeight> {
  bool first=true;
  User _user;
  String bmi;
  String persiaDAte = "";
  String diifff = "";
  String bmiPeriod = "نامشخص";
  String acountDate;bool _isLoading = true;
  int etebar=-1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    acountDate=widget.acountDate;

    getUser();

    super.initState();

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

    return  Scaffold(
        key: _scaffoldKey,
      backgroundColor: _isLoading
          ? Colors.white:MyColors.green,
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
                            Icons.chevron_right,
                            size:   32*(screenSize.width)/375,
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
            : Builder(
                builder: (context) => Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.vertical(top:Radius.circular(22))),
    child:CustomScrollView(slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildListDelegate(
                        <Widget>[

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(0xffF4F4F4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                              ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text(
                                        "وضعیت هدف",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17*fontvar,
                                          fontWeight: FontWeight.w500,
                                        ),

                                        textDirection: TextDirection.rtl,
                                      ),

                              Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "وزن هدف",
                                                  style: TextStyle(
                                                    fontSize: 15*fontvar,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  _user.gweight==null?"نامشخص":  _user.gweight + " کیلوگرم ",
                                                  style: TextStyle(
                                                    fontSize: 15*fontvar,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textDirection: TextDirection
                                                      .rtl,
                                                ),
                                              ],
                                            ),

                                            //تاریخ شروع
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "تاریخ شروع",
                                                    style: TextStyle(
                                                      fontSize: 15*fontvar,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    _user.gweight==null?"نامشخص":  persiaDAte,
                                                    style: TextStyle(
                                                      fontSize: 15*fontvar,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    textDirection: TextDirection
                                                        .rtl,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //زمان باقی مانده
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "زمان باقی مانده",
                                                      style: TextStyle(
                                                        fontSize: 15*fontvar,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      _user.gweight==null?"نامشخص":   diifff,
                                                      style: TextStyle(
                                                        fontSize: 15*fontvar,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            //محدوده وزن نرمال
//


//                                    Row(children: <Widget>[
//
//                                        Flexible(flex: 1,child: Column(
//                                          children: <Widget>[
//                                            Row(
//                                              mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                              children: <Widget>[
//                                                Text(
//                                                  "وزن هدف",
//                                                  style: TextStyle(
//                                                    fontSize: 15*fontvar,
//                                                    color: Colors.black,
//                                                    fontWeight: FontWeight.w400,
//                                                  ),
//                                                ),
//                                                Text(
//                                                  _user.gweight==null?"نامشخص":  _user.gweight + " کیلوگرم ",
//                                                  style: TextStyle(
//                                                    fontSize: 15*fontvar,
//                                                    color: Colors.black,
//                                                    fontWeight: FontWeight.w400,
//                                                  ),
//                                                  textDirection: TextDirection
//                                                      .rtl,
//                                                ),
//                                              ],
//                                            ),
//
//                                            //تاریخ شروع
//                                            Padding(
//                                              padding: EdgeInsets.symmetric(
//                                                vertical: 5,
//                                              ),
//                                              child: Row(
//                                                mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                                children: <Widget>[
//                                                  Text(
//                                                    "تاریخ شروع",
//                                                    style: TextStyle(
//                                                      fontSize: 15*fontvar,
//                                                      color: Colors.black,
//                                                      fontWeight: FontWeight.w400,
//                                                    ),
//                                                  ),
//                                                  Text(
//                                                    _user.gweight==null?"نامشخص":  persiaDAte,
//                                                    style: TextStyle(
//                                                      fontSize: 15*fontvar,
//                                                      color: Colors.black,
//                                                      fontWeight: FontWeight.w400,
//                                                    ),
//                                                    textDirection: TextDirection
//                                                        .rtl,
//                                                  ),
//                                                ],
//                                              ),
//                                            ),
//
//                                            //زمان باقی مانده
//                                            Padding(
//                                                padding: EdgeInsets.symmetric(
//                                                  vertical: 5,
//                                                ),
//                                                child: Row(
//                                                  mainAxisAlignment:
//                                                  MainAxisAlignment
//                                                      .spaceBetween,
//                                                  children: <Widget>[
//                                                    Text(
//                                                      "زمان باقی مانده",
//                                                      style: TextStyle(
//                                                        fontSize: 15*fontvar,
//                                                        color: Colors.black,
//                                                        fontWeight: FontWeight.w400,
//                                                      ),
//                                                    ),
//                                                    Text(
//                                                      _user.gweight==null?"نامشخص":   diifff,
//                                                      style: TextStyle(
//                                                        fontSize: 15*fontvar,
//                                                        color: Colors.black,
//                                                        fontWeight: FontWeight.w400,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                )),
//                                            //محدوده وزن نرمال
//
//                                          ],
//                                        ),),
//                                        Flexible(flex: 1,fit: FlexFit.tight,child: Image.network(
//                                          'assets/icons/health.svg',
//                                        height: (MediaQuery.of(context).size.width-30)/2,
//                                          width:  (MediaQuery.of(context).size.width-30)/2,
//                                          alignment: Alignment.center,
//
//                                        ),
//                                        )
//                                      ],)

//


                                        //وزن هدف

                                      ],
                                    ),

                              ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                            color: MyColors.green,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:     Image.asset(
                                            'assets/icons/profile_height.png',
                                            height: 20*(screenSize.width)/375,
                                            color: Colors.white,
                                            width: 20*(screenSize.width)/375,
                                          ),


                                        ),

                                Expanded(child:  Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("قد",   style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13*fontvar),),
                                            Text(double.parse(_user.height)
                                                .toStringAsFixed(1) +
                                                " سانتی متر ",   style: TextStyle(
                                                color: Color(0xff5C5C5C),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10*fontvar),),

                                          ],
                                        ),))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:        Image.asset(
                                            'assets/icons/profile_weight.png',
                                            height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color: Colors.white,
                                          ),


                                        ),

                                        Expanded(child:  Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("وزن ایده آل",   style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13*fontvar),),
                                              Text( _user.ideal_weight == null
                                                  ? "نامشخص"
                                                  : _user.ideal_weight
                                                  .toString() +
                                                  " کیلوگرم ",   style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10*fontvar),),

                                            ],
                                          )),)
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:Text("BMI",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12*fontvar),),


                                        ),

                                        Expanded(child: Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("شاخص توده بدنی",   style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13*fontvar),),
                                              Text(   bmi,   style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10*fontvar),),

                                            ],
                                          ),))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:        Image.asset(
                                            'assets/icons/profile_weight.png',
                                            height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color: Colors.white,
                                          ),


                                        ),


                                        Expanded(child: Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("وزن توصیه شده ما",   style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13*fontvar),),
                                              Text(    _user.ideal_weight == null
                                                  ? "نامشخص"
                                                  : _user.recommended_weight
                                                  .toString() +
                                                  " کیلوگرم ",   style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10*fontvar),),

                                            ],
                                          ),))
                                      ],
                                    ),
                                  ],

                                )),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:     Image.asset(
                                            'assets/icons/profile_weight.png',
                                            height: 20*(screenSize.width)/375,
                                            color: Colors.white,
                                            width: 20*(screenSize.width)/375,
                                          ),


                                        ),

                                Expanded(child: Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("وزن",   style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13*fontvar),),
                                              Text(  double.parse(_user.weight)
                                                  .toStringAsFixed(1) +
                                                  " کیلوگرم ",   style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10*fontvar),),

                                            ],
                                          ),))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:        Image.asset(
                                            'assets/icons/profile_weight.png',
                                            height: 20*(screenSize.width)/375,
                                            width: 20*(screenSize.width)/375,
                                            color: Colors.white,
                                          ),


                                        ),

                                        Expanded(child: Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("محدوده وزن نرمال",   style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13*fontvar),),
                                                 Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      (_user.period_weight == null)
                                                          ?  Flexible(child: Text(
                                                        "نامشخص",
                                                        style: TextStyle(
                                                            color: Color(0xff5C5C5C),
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 10*fontvar),
                                                        textDirection:
                                                        TextDirection.ltr,
                                                      ))
                                                          : Flexible(child:  Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                _user.period_weight
                                                                    .toString() +
                                                                    " ",
                                                                style: TextStyle(
                                                                    color: Color(0xff5C5C5C),
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 10*fontvar),
                                                                textDirection:
                                                                TextDirection.ltr,
                                                              ),
                                                            ),
                                          Flexible(
                                          child: Text(
                                                              "کیلوگرم",
                                                              style: TextStyle(
                                                                  color: Color(0xff5C5C5C),
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 10*fontvar),
                                                              textDirection:
                                                              TextDirection.ltr,
                                                            )),
                                                          ]),)
                                                    ],
                                                  ),])
                                        ))],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin:EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                                          width:45*(screenSize.width)/375 ,
                                          height: 45*(screenSize.width)/375,
                                          decoration: BoxDecoration(
                                              color: MyColors.green,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                          alignment: Alignment.center,
                                          child:Text("BMI",style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12*fontvar),),


                                        ),

                                        Expanded(child:Padding(padding: EdgeInsets.only(right: 8,top: 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                          Text("محدوده BMI ",   style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13*fontvar),),
           Text(   bmiPeriod,   style: TextStyle(
                                                  color: Color(0xff5C5C5C),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10*fontvar),),

                                            ],
                                          ),)
                                        )],
                                    ),

                                  ],

                                ))

                              ],

                            ),
                          ),

//                          Card(
//                            shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(15)),
//                            ),
//                            elevation: 8,
//                            child: Padding(
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: 15, vertical: 25),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    //قد
//                                    Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text(
//                                          "قد",
//                                          style: TextStyle(
//                                            fontSize: 13,
//                                            fontWeight: FontWeight.w500,
//                                          ),
//                                        ),
//                                        Text(
//                                          double.parse(_user.height)
//                                                  .toStringAsFixed(1) +
//                                              " سانتی متر ",
//                                          style: TextStyle(
//                                            fontSize: 13,
//                                            fontWeight: FontWeight.w400,
//                                          ),
//                                          textDirection: TextDirection.rtl,
//                                        ),
//                                      ],
//                                    ),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ),
//                                    //وزن
//                                    Padding(
//                                      padding: EdgeInsets.symmetric(
//                                        vertical: 5,
//                                      ),
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: <Widget>[
//                                          Text(
//                                            "وزن ",
//                                            style: TextStyle(
//                                              fontSize: 13,
//                                              fontWeight: FontWeight.w500,
//                                            ),
//                                          ),
//                                          Text(
//                                            double.parse(_user.weight)
//                                                    .toStringAsFixed(1) +
//                                                " کیلوگرم ",
//                                            style: TextStyle(
//                                              fontSize: 13,
//                                              fontWeight: FontWeight.w400,
//                                            ),
//                                            textDirection: TextDirection.rtl,
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ),
//                                    //وزن ایده آل
//                                    Padding(
//                                        padding: EdgeInsets.symmetric(
//                                          vertical: 5,
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(
//                                              "وزن ایده آل",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w500,
//                                              ),
//                                            ),
//                                            Text(
//                                              _user.ideal_weight == null
//                                                  ? "نامشخص"
//                                                  : _user.ideal_weight
//                                                          .toString() +
//                                                      " کیلوگرم ",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w400,
//                                              ),
//                                            ),
//                                          ],
//                                        )),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ),
//                                    //محدوده وزن نرمال
//                                    Padding(
//                                        padding: EdgeInsets.symmetric(
//                                          vertical: 5,
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Flexible(child:   Text(
//                                              "محدوده وزن نرمال",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w500,
//                                              ),
//                                            ),),
//                                            _user.period_weight == null
//                                                ?  Flexible(child: Text(
//                                                    "نامشخص",
//                                                    style: TextStyle(
//                                                      fontSize: 13,
//                                                      fontWeight:
//                                                          FontWeight.w400,
//                                                    ),
//                                                    textDirection:
//                                                        TextDirection.ltr,
//                                                  ))
//                                                : Flexible(child:  Row(
//                                              mainAxisAlignment: MainAxisAlignment.end,
//                                                    children: <Widget>[
//                                                      Text(
//                                                        _user.period_weight
//                                                                .toString() +
//                                                            " ",
//                                                        style: TextStyle(
//                                                          fontSize: 13,
//                                                          fontWeight:
//                                                              FontWeight.w400,
//                                                        ),
//                                                        textDirection:
//                                                            TextDirection.ltr,
//                                                      ),
//                                                      Text(
//                                                        "کیلوگرم",
//                                                        style: TextStyle(
//                                                          fontSize: 13,
//                                                          fontWeight:
//                                                              FontWeight.w400,
//                                                        ),
//                                                        textDirection:
//                                                            TextDirection.ltr,
//                                                      ),
//                                                    ],
//                                                  ))
//                                          ],
//                                        )),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ),
//                                    //وزن توصیه شده ما
//                                    Padding(
//                                        padding: EdgeInsets.symmetric(
//                                          vertical: 5,
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(
//                                              "وزن توصیه شده ما",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w500,
//                                              ),
//                                            ),
//                                            Text(
//                                              _user.ideal_weight == null
//                                                  ? "نامشخص"
//                                                  : _user.recommended_weight
//                                                          .toString() +
//                                                      " کیلوگرم ",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w400,
//                                              ),
//                                            ),
//                                          ],
//                                        )),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ),
//                                    //شاخص توده بدنی
//                                    Padding(
//                                        padding: EdgeInsets.symmetric(
//                                          vertical: 5,
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(
//                                              "شاخص توده بدنی BMI",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w500,
//                                              ),
//                                            ),
//                                            Text(
//                                              bmi,
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w400,
//                                              ),
//                                            ),
//                                          ],
//                                        )),
//                                    Divider(
//                                      height: 1,
//                                      thickness: 1,
//                                      color: Colors.grey.withOpacity(0.5),
//                                    ), //شاخص توده بدنی
//                                    Padding(
//                                        padding: EdgeInsets.symmetric(
//                                          vertical: 5,
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(
//                                              "محدوده شاخص توده بدنی BMI ",
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w500,
//                                              ),
//                                            ),
//                                            Text(
//                                              bmiPeriod,
//                                              textDirection: TextDirection.ltr,
//                                              style: TextStyle(
//                                                fontSize: 13,
//                                                fontWeight: FontWeight.w400,
//                                              ),
//                                            ),
//                                          ],
//                                        )),
//                                  ],
//                                )),
//                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  right: 15, left: 15, bottom: 18, top: 18),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: screenSize.width,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 8),
                                        color: MyColors.green,
                                        onPressed: () async
                                        {


                                        if(_user != null && _user.gcalorie != null){
                                          deleteGoal();
                                        }
                                        else{if(etebar<0)

                                              showSnakBar("شما اشتراک فعالی ندارید.برای دریافت اشتراک به فروشگاه بروید.");
                                          else if (calculateAge(_user.birthdate) < 3)
                                          showSnakBar(
                                                  "برای زیر سه سال غیر فعال است.");
                                          else if (await checkConnectionInternet()) {
                                            String returnVal =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child:
                                                            goalWeightQues(user: _user,)),
                                              ),
                                            );

                                            if (returnVal != null) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              await getUser();
                                            } else {
;
                                            }
                                          }
                                          else {
                                          showSnakBar("اتصال به اینترنت برقرار نیست.");
                                          }
                                        }},
                                        child: Text(
     (_user != null && _user.gcalorie != null)?   'حذف هدف':"تعیین هدف",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14*fontvar),
                                        )),
                                  ),
                                ],
                              )),
                        ],
                      ))
                    ]))));
  }


  Future<void> getEtebar() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String serverDate=prefs.getString('date')??getDateToday();
    print(acountDate);
    print(serverDate);
    print(etebar);
    if(serverDate!=null && acountDate !=null && acountDate !=""){
      var persianDateee = PersianDateTime(jalaaliDateTime: acountDate);
      var dateEtebarstr = persianDateee.toGregorian(format: 'YYYY-MM-DD');
      DateTime datetoday = DateTime.parse(serverDate);
      DateTime dateacount= DateTime.parse(dateEtebarstr);
      print(dateacount
          .difference(datetoday)
          .inDays
          .toString()+"fffffffffffffffffff");
      etebar =dateacount.difference(datetoday).inDays;
      print("getEtebar");
      print(acountDate);
      print(serverDate);
      print(etebar);
    }
    first=false;

  }
   Future<User> getUser() async {

    final reactiveModel = Injector.getAsReactive<userStore>();
    await reactiveModel.setState((store) async => await store.getNotNull(context),
      onData: (context, userSt ) {

        if (userSt.user != null){
          _user= userSt.user;
          if (this.mounted) {
            setState(() {
              print(_user.toMap());
              if (_user.gcalorie != null) {
                persiaDAte = PersianDateTime.fromGregorian(
                    gregorianDateTime: _user.gdate.split("*")[0]).toString(); //
                diifff = DateTime.parse(_user.gdate.split("*")[1]).difference(DateTime.parse(getDateToday())).inDays.toString();
                print(diifff);
                if (int.parse(diifff) <= 0)
                  diifff = "زمان هدف شما به پایان رسیده ";
                else
                  diifff = diifff + " روز ";
              }

              setInfo();

     print(_user.toMap());
     print(first);

          if(first)getEtebar();
          _isLoading=false;
          }); }
        }
        else
          showSnakBar("خطا در برقراری ارتباط");
      },

      onError: (context, error) {
        showSnakBar("خطا در برقراری ارتباط");
      },
    );




  }

   Future<bool> _updateUser(User user) async {

      bool result;
      final reactiveModel = Injector.getAsReactive<userStore>();
      await reactiveModel.setState((store) async =>
      result = await store.updateUser(context, user.toMap6()),
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



  setInfo() {
    print(_user.height + _user.weight + bmiPeriod);
    setState(() {
      double bmiDouble = double.parse(_user.weight) /
          (double.parse(_user.height) * double.parse(_user.height) * 0.0001);
      bmi = bmiDouble.toStringAsFixed(1);
      if (_user.period_weight != null) {
        List<String> bmiList = _user.period_weight.split("-");
        double bmiDouble1 = double.parse(bmiList[0]) /
            (double.parse(_user.height) * double.parse(_user.height) * 0.0001);
        double bmiDouble2 = double.parse(bmiList[1]) /
            (double.parse(_user.height) * double.parse(_user.height) * 0.0001);
        bmiPeriod = bmiDouble1.toStringAsFixed(1) +
            " - " +
            bmiDouble2.toStringAsFixed(1);
      }

      print(_user.height + _user.weight + bmiPeriod + "2");
    });
  }

  Future<void> deleteGoal() async {
    String returnVal = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.all(0),
              child: Dialog(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                  child: deletegDialog()));
        });
    if (returnVal == 'yes') {


      setState(() {
        _isLoading=true;
      });
      int res=_user.calorie-_user.gcalorie;
      if(res<600)res=600;
      _user.calorie= res;
      _user.gcalorie=null;
      _user.gweight=null;
      _user.gdate=null;
      print(_user.toMap());
      print(await _updateUser(_user));
      await   getUser();
      setState(() {
        _isLoading=false;
      });
    } else(){};




  }



  showSnakBar(String name)  {
    if(_scaffoldKey.currentState!=null){
    _scaffoldKey.currentState.showSnackBar(
         SnackBar(
          duration: new Duration(seconds: 2),
          backgroundColor: MyColors.vazn,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          content: Text(
           name,
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15*fontvar,fontFamily: "iransansDN"),textDirection: TextDirection.rtl,),
        ));

  }}


}
