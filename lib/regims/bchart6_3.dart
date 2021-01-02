import 'dart:convert';
import 'package:barika_web/home/logiin.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/regims/pishFactor.dart';
import 'package:barika_web/services/apiServices.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';
import 'dialog1_2.dart';
import 'dialog6_12.dart';

class bchart6_3 extends StatefulWidget {
  User user;
  String uidDiet;
  String selfId;
  String dietId;

  //baraye tamdid
  bool edit;
  bchart6_3({Key key, this.user,this.selfId,this.dietId,this.uidDiet,this.edit}) : super(key: key);

  State<StatefulWidget> createState() => bchart6_3State();
}

class bchart6_3State extends State<bchart6_3> {
  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }
  User _user;
  String selfId;
  double month = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading=false;
  bool showLoading=false;
  @override
  void initState() {
    selfId=widget.selfId;
    _user = widget.user;
    print(_user.toMap());
    month = (calculateAllMounth(_user.birthdate));
    super.initState();
  }
  var fontvar=1.0;
  @override
  Widget build(BuildContext context) {
    print(calculateAllMounth(_user.birthdate));
    SizeConfig().init(context);
    var bh=SizeConfig.safeBlockHorizontal;
    var bv=SizeConfig.safeBlockVertical;
    fontvar = (bh) / 3.75;
    if(fontvar>2)fontvar=1.7;

    Size screenSize = MediaQuery.of(context).size;
    if(screenSize.width>600)screenSize=Size(600, screenSize.height);

    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(
        key: _scaffoldKey,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(58),
          child: new Container(
            padding: EdgeInsets.only(top: 10),
            decoration: new BoxDecoration(
                color: MyColors.green
            ),
            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 8),
                          child: Text(
                            'نمودارها',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16*fontvar,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            size:32*(screenSize.width)/375,
                            textDirection: TextDirection.rtl,
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'yes');
                          },
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                          splashColor: Colors.amber,
                          padding: EdgeInsets.all(7),
                        ),

//                        IconButton(
//                          icon: Icon(
//                            Icons.search,
//                            size: 28,
//                          ),
//                          onPressed: () {},
//                          alignment: Alignment.topRight,
//                          color: Colors.white,
//                          splashColor: Colors.amber,
//                          padding: EdgeInsets.all(10),
//                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:
      _isLoading?loadingView()
          :

            CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            _user.gender == "female"
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                height: 400*(screenSize.height)/595,
                    decoration: BoxDecoration(
                        color: Color(0xffE9E9E9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'نمودار وزن دختران 0 تا 36 ماه',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: new charts.LineChart(
                              _girlWeghitMonth(),
                              primaryMeasureAxis: new charts.NumericAxisSpec(
                                showAxisLine: true,

                                tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 9,
                                  zeroBound: false,

                                ),
                              ),


                              domainAxis: charts.NumericAxisSpec(
                                showAxisLine: true,

                                tickProviderSpec:
                                charts.BasicNumericTickProviderSpec(
                                    dataIsInWholeNumbers: true,
                                    zeroBound: false,
                                    desiredTickCount: 13
                                ),
                              ),
                              behaviors: [


                                new charts.ChartTitle('وزن (کیلو گرم)',
                                    titleStyleSpec: charts.TextStyleSpec(
                                        fontSize: 12*fontvar.round()),
                                    behaviorPosition: charts.BehaviorPosition
                                        .start,
                                    titleOutsideJustification:
                                    charts.OutsideJustification.middle),


                                new charts.ChartTitle('سن (ماه)',
                                    titleStyleSpec: charts.TextStyleSpec(
                                        fontSize: 12*fontvar.round()),
                                    behaviorPosition: charts.BehaviorPosition
                                        .bottom,
                                    titleOutsideJustification:
                                    charts.OutsideJustification.middle),

                              ],
                              // Disable animations for image tests.
                              animate: true,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: false, stacked: false),
                              customSeriesRenderers: [
                                new charts.LineRendererConfig(
                                    // ID used to link series to this renderer.
                                    customRendererId: 'customPoint')
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Flexible(flex: 2, child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 5 و 95',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      height: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFF0230)),
                                    )
                                  ],
                                ),),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 15 و 90',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffccf03)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 25 و 75',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff93e07b)),
                                    )
                                  ],
                                )),
                                Flexible(flex:1 ,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 50',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff299c06)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 1,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'وزن شما',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000)),
                                    )
                                  ],
                                ),)
                              ],
                            ),)
                        ]))
                : Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                height: 400*(screenSize.height)/595,
                    decoration: BoxDecoration(
                        color: Color(0xffE9E9E9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'نمودار وزن پسران 0 تا 36 ماه',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                            _boyWeghitMonth(),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 10,
                                    zeroBound: false,

                                  ),
                                ),
                                domainAxis: charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(
                                      dataIsInWholeNumbers: true,
                                      zeroBound: false,
                                      desiredTickCount: 13
                                  ),
                                ),
                                behaviors: [


                                  new charts.ChartTitle('وزن (کیلو گرم)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (ماه)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .bottom,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),

                                ],
                            // Disable animations for image tests.
                            animate: true,
                            defaultRenderer: new charts.LineRendererConfig(
                              includeArea: false,
                              stacked: false,
                            ),

                            customSeriesRenderers: [
                              new charts.LineRendererConfig(
                                  // ID used to link series to this renderer.
                                  customRendererId: 'customPoint')
                            ],
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Flexible(flex: 2, child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 5 و 95',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      height: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFF0230)),
                                    )
                                  ],
                                ),),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 15 و 90',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffccf03)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 25 و 75',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff93e07b)),
                                    )
                                  ],
                                )),
                                Flexible(flex:1 ,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 50',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff299c06)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 1,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'وزن شما',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000)),
                                    )
                                  ],
                                ),)
                              ],
                            ),)
                        ])),

                Container(
                  alignment: Alignment.center,
                  width: screenSize.width,
                  padding: EdgeInsets.only(right: 5),
                  margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                  child:
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 12, bottom: 4),
                    child: Text(setStatusWeight(),textDirection: TextDirection.rtl, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
    fontSize: 12*fontvar,
    ),),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.green)),
                ),
            _user.gender == "female"
                ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
    height: 400*(screenSize.height)/595,
                    decoration: BoxDecoration(
                        color: Color(0xffE9E9E9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'نمودار قد دختران 0 تا 36 ماه',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                            _girlHeightMonth(),

                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,
                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 5,
                                    zeroBound: false,

                                  ),
                                ),
                                domainAxis: charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(
                                      dataIsInWholeNumbers: true,
                                      zeroBound: false,
                                      desiredTickCount: 7
                                  ),
                                ),
                                behaviors: [


                                  new charts.ChartTitle('قد (سانتی متر)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (ماه)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .bottom,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),

                                ],
                            // Disable animations for image tests.
                            animate: true,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: false,
                                stacked: false,
                                layoutPaintOrder:
                                    charts.LayoutViewPaintOrder.barTargetLine),
                            customSeriesRenderers: [
                              new charts.LineRendererConfig(
                                  // ID used to link series to this renderer.
                                  customRendererId: 'customPoint')
                            ],
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Flexible(flex: 2, child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 5 و 95',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      height: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFF0230)),
                                    )
                                  ],
                                ),),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 15 و 90',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffccf03)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 25 و 75',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff93e07b)),
                                    )
                                  ],
                                )),
                                Flexible(flex:1 ,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 50',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff299c06)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 1,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'قد شما',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000)),
                                    )
                                  ],
                                ),)
                              ],
                            ),)
                        ]))
                : Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                height: 400*(screenSize.height)/595,
                    decoration: BoxDecoration(
                        color: Color(0xffE9E9E9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'نمودار قد پسران 0 تا 36 ماه',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                            _boyHeightMonth(),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 5,
                                    zeroBound: false,

                                  ),
                                ),
                                domainAxis: charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(
                                      dataIsInWholeNumbers: true,
                                      zeroBound: false,
                                      desiredTickCount: 7
                                  ),
                                ),
                                behaviors: [


                                  new charts.ChartTitle('قد (سانتی متر)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (ماه)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .bottom,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),

                                ],
//                            primaryMeasureAxis: new charts.NumericAxisSpec(
//                              tickProviderSpec:
//                                  new charts.BasicNumericTickProviderSpec(
//                                      desiredTickCount: 5),
//                            ),
//                            domainAxis: charts.NumericAxisSpec(
//                              showAxisLine: true,
//                              tickProviderSpec:
//                                  charts.BasicNumericTickProviderSpec(
//                                      desiredTickCount: 5),
//                            ),
                            // Disable animations for image tests.
                            animate: true,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: false, stacked: false),
                            customSeriesRenderers: [
                              new charts.LineRendererConfig(
                                  // ID used to link series to this renderer.
                                  customRendererId: 'customPoint')
                            ],
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: <Widget>[
                                Flexible(flex: 2, child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 5 و 95',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      height: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFF0230)),
                                    )
                                  ],
                                ),),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 15 و 90',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffccf03)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 2,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 25 و 75',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff93e07b)),
                                    )
                                  ],
                                )),
                                Flexible(flex:1 ,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'صدک 50',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff299c06)),
                                    )
                                  ],
                                )),
                                Flexible(flex: 1,child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(child: Text(
                                      'قد شما',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 10*fontvar,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Container(
                                      width: 8*(screenSize.width)/375,
                                      margin:
                                      EdgeInsets.only(left: 2, right: 2),
                                      height: 8*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff000000)),
                                    )
                                  ],
                                ),)
                              ],
                            ),)

                        ])),

                Container(
                  alignment: Alignment.center,
                  width: screenSize.width,
                  padding: EdgeInsets.only(right: 5),
                  margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                  child:
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 12, bottom: 4),
                    child: Text(setStatusHeight(),textDirection: TextDirection.rtl, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12*fontvar,
                    ),),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.green)),
                ),
            Container(
                padding:
                    EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: screenSize.width,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                          color: MyColors.green,
                          onPressed: () async
                          {
                            setState(() {
                              showLoading=true;
                            });

                            if(month>=24){
                              print(month);
                              callApi2_3();
                            }
                            else{String returnVal = await showDialog(
                                context: context,
                                builder: (BuildContextcontext) {
                                  return Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Dialog(
                                          elevation: 15,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          child: month >= 12
                                              ? dialog1_2(month: month,)
                                              : dialog6_12(month: month,)));
                                });

                            if (returnVal != null)
                              callApi(returnVal);
                            }},
                          child: Text(
                            showLoading ? '' :  ' دریافت رژیم ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14*fontvar),
                          )),
                    ),
                    (showLoading)?
                      SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20*(screenSize.width)/375,
                      ):Container(width:0,height:0),
                  ],
                )),

//
          ]))
        ])));
  }

///// نمودار وزن برای دختران 0 تا 36 ماه
  List<charts.Series<LinearSales, double>> _girlWeghitMonth() {
    final _sadak5 = [
      new LinearSales(0, 2.547905),
      new LinearSales(0.5, 2.894442),
      new LinearSales(1.5, 3.54761),
      new LinearSales(2.5, 4.150639),
      new LinearSales(3.5, 4.707123),
      new LinearSales(4.5, 5.220488),
      new LinearSales(5.5, 5.693974),
      new LinearSales(6.5, 6.130641),
      new LinearSales(7.5, 6.533373),
      new LinearSales(8.5, 6.904886),
      new LinearSales(9.5, 7.247736),
      new LinearSales(10.5, 7.564327),
      new LinearSales(11.5, 7.856916),
      new LinearSales(12.5, 8.127621),
      new LinearSales(13.5, 8.378425),
      new LinearSales(14.5, 8.611186),
      new LinearSales(15.5, 8.827638),
      new LinearSales(16.5, 9.029399),
      new LinearSales(17.5, 9.21798),
      new LinearSales(18.5, 9.394782),
      new LinearSales(19.5, 9.56111),
      new LinearSales(20.5, 9.71817),
      new LinearSales(21.5, 9.867081),
      new LinearSales(22.5, 10.00887),
      new LinearSales(23.5, 10.1445),
      new LinearSales(24.5, 10.27483),
      new LinearSales(25.5, 10.40066),
      new LinearSales(26.5, 10.52274),
      new LinearSales(27.5, 10.64171),
      new LinearSales(28.5, 10.75819),
      new LinearSales(29.5, 10.87273),
      new LinearSales(30.5, 10.98581),
      new LinearSales(31.5, 11.09789),
      new LinearSales(32.5, 11.20934),
      new LinearSales(33.5, 11.32054),
      new LinearSales(34.5, 11.43177),
      new LinearSales(35.5, 11.54332),
      new LinearSales(36, 11.59929),
    ];

    final _sadak15 = [
      new LinearSales(0, 2.747222),
      new LinearSales(0.5, 3.101767),
      new LinearSales(1.5, 3.770157),
      new LinearSales(2.5, 4.387042),
      new LinearSales(3.5, 4.955926),
      new LinearSales(4.5, 5.480295),
      new LinearSales(5.5, 5.96351),
      new LinearSales(6.5, 6.408775),
      new LinearSales(7.5, 6.819122),
      new LinearSales(8.5, 7.197414),
      new LinearSales(9.5, 7.546342),
      new LinearSales(10.5, 7.868436),
      new LinearSales(11.5, 8.166069),
      new LinearSales(12.5, 8.44146),
      new LinearSales(13.5, 8.696684),
      new LinearSales(14.5, 8.93368),
      new LinearSales(15.5, 9.154251),
      new LinearSales(16.5, 9.360079),
      new LinearSales(17.5, 9.552723),
      new LinearSales(18.5, 9.73363),
      new LinearSales(19.5, 9.90414),
      new LinearSales(20.5, 10.06549),
      new LinearSales(21.5, 10.21882),
      new LinearSales(22.5, 10.36518),
      new LinearSales(23.5, 10.50553),
      new LinearSales(24.5, 10.64076),
      new LinearSales(25.5, 10.77167),
      new LinearSales(26.5, 10.89899),
      new LinearSales(27.5, 11.02338),
      new LinearSales(28.5, 11.14545),
      new LinearSales(29.5, 11.26575),
      new LinearSales(30.5, 11.38474),
      new LinearSales(31.5, 11.50288),
      new LinearSales(32.5, 11.62054),
      new LinearSales(33.5, 11.73806),
      new LinearSales(34.5, 11.85574),
      new LinearSales(35.5, 11.97384),
      new LinearSales(36, 12.03312),
    ];

    List<double> _listsadak50 = [
      3.399186,
      3.797528,
      4.544777,
      5.230584,
      5.859961,
      6.437588,
      6.96785,
      7.454854,
      7.902436,
      8.314178,
      8.693418,
      9.043262,
      9.366594,
      9.666089,
      9.944226,
      10.20329,
      10.44541,
      10.67251,
      10.88639,
      11.08868,
      11.2809,
      11.4644,
      11.64043,
      11.81014,
      11.97454,
      12.13456,
      12.29102,
      12.44469,
      12.59622,
      12.74621,
      12.89517,
      13.04357,
      13.19181,
      13.34023,
      13.48913,
      13.63877,
      13.78937,
      13.86507,
    ];

    List<double> _listsadak75 = [
      3.717519,
      4.145594,
      4.946766,
      5.680083,
      6.351512,
      6.966524,
      7.53018,
      8.047178,
      8.521877,
      8.958324,
      9.360271,
      9.731193,
      10.07431,
      10.39258,
      10.68874,
      10.96532,
      11.22463,
      11.46878,
      11.69972,
      11.91921,
      12.12887,
      12.33016,
      12.52439,
      12.71277,
      12.89636,
      13.07613,
      13.25293,
      13.42753,
      13.60059,
      13.77271,
      13.9444,
      14.11611,
      14.28822,
      14.46106,
      14.63491,
      14.80998,
      14.98647,
      15.07529,
    ];

    List<double> _listsadak90 = [
      3.992572,
      4.450126,
      5.305632,
      6.087641,
      6.80277,
      7.457119,
      8.056331,
      8.605636,
      9.109878,
      9.573546,
      10.00079,
      10.39545,
      10.76106,
      11.10089,
      11.41792,
      11.71491,
      11.99438,
      12.25862,
      12.50974,
      12.74964,
      12.98004,
      13.2025,
      13.41844,
      13.62911,
      13.83564,
      14.03902,
      14.24017,
      14.43984,
      14.63873,
      14.83743,
      15.03646,
      15.23626,
      15.43719,
      15.63957,
      15.84365,
      16.04963,
      16.25767,
      16.3625,
    ];

    List<double> _listsadak95 = [
      4.152637,
      4.628836,
      5.519169,
      6.332837,
      7.076723,
      7.757234,
      8.38033,
      8.951544,
      9.476009,
      9.95848,
      10.40335,
      10.8147,
      11.19625,
      11.55145,
      11.88348,
      12.19522,
      12.48934,
      12.76825,
      13.03415,
      13.28904,
      13.53473,
      13.77284,
      14.00484,
      14.23205,
      14.45561,
      14.67659,
      14.89587,
      15.11428,
      15.33249,
      15.55113,
      15.7707,
      15.99164,
      16.21432,
      16.43904,
      16.66605,
      16.89553,
      17.12762,
      17.24469,
    ];
    List<double> _listsadak25 = [
      3.064865,
      3.437628,
      4.138994,
      4.78482,
      5.379141,
      5.925888,
      6.428828,
      6.891533,
      7.317373,
      7.709516,
      8.070932,
      8.4044,
      8.712513,
      8.997692,
      9.262185,
      9.508085,
      9.737329,
      9.951715,
      10.1529,
      10.34241,
      10.52167,
      10.69196,
      10.85446,
      11.01027,
      11.16037,
      11.30567,
      11.44697,
      11.58501,
      11.72047,
      11.85392,
      11.98592,
      12.11692,
      12.24735,
      12.37757,
      12.50791,
      12.63865,
      12.77001,
      12.836,
    ];
    List<double> month = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
      36,
    ];

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse(calculateAllMounth(_user.birthdate).toString()),
          double.parse(_user.weight))
    ];

    final List<LinearSales> _sadak25 = [];
    for (int i = 0; i < _listsadak25.length; i++) {
//      print(month[i].toString() + _listsadak25[i].toString());
      _sadak25.add(
        new LinearSales(month[i], _listsadak25[i]),
      );
    }

    final List<LinearSales> _sadak50 = [];
    for (int i = 0; i < _listsadak50.length; i++)
      _sadak50.add(
        new LinearSales(month[i], _listsadak50[i]),
      );

    final List<LinearSales> _sadak75 = [];
    for (int i = 0; i < _listsadak75.length; i++)
      _sadak75.add(
        new LinearSales(month[i], _listsadak75[i]),
      );
    final List<LinearSales> _sadak90 = [];
    for (int i = 0; i < _listsadak90.length; i++)
      _sadak90.add(
        new LinearSales(month[i], _listsadak90[i]),
      );
    final List<LinearSales> _sadak95 = [];
    for (int i = 0; i < _listsadak95.length; i++)
      _sadak95.add(
        new LinearSales(month[i], _listsadak95[i]),
      );

//    var myFakeTabletData = [
//      new LinearSales(0, 10),
//      new LinearSales(1, 50),
//      new LinearSales(2, 200),
//      new LinearSales(3, 150),
//    ];
//
//    var myFakeMobileData = [
//      new LinearSales(0, 15),
//      new LinearSales(1, 75),
//      new LinearSales(2, 300),
//      new LinearSales(3, 225),
//    ];


    return [
      new charts.Series<LinearSales, double>(
        id: '_sadak5',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak5,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak15',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak15,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak25',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.teal.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak25,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak50',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#299c06'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak50,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak75',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.pink.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak75,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak90',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.purple.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak90,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak95',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.lime.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak95,
      ),
      new charts.Series<LinearSales, double>(
          id: '_user',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.

    ];
  }

  ///// نمودار وزن برای پسران 0 تا 36 ماه
  List<charts.Series<LinearSales, double>> _boyWeghitMonth() {
    final _listsadak5 = [
      2.526904,
      2.964656,
      3.774849,
      4.503255,
      5.157412,
      5.744752,
      6.272175,
      6.745993,
      7.171952,
      7.555287,
      7.900755,
      8.212684,
      8.495,
      8.751264,
      8.984701,
      9.198222,
      9.394454,
      9.575757,
      9.744251,
      9.90183,
      10.05019,
      10.19082,
      10.32507,
      10.4541,
      10.57895,
      10.70051,
      10.81958,
      10.93681,
      11.0528,
      11.16803,
      11.28293,
      11.39782,
      11.513,
      11.62869,
      11.74508,
      11.8623,
      11.98046,
      12.03991,
    ];

    final _listsadak15 = [
      2.773802,
      3.20951,
      4.020561,
      4.754479,
      5.416803,
      6.013716,
      6.551379,
      7.035656,
      7.472021,
      7.865533,
      8.220839,
      8.542195,
      8.833486,
      9.098246,
      9.339688,
      9.560722,
      9.763982,
      9.95184,
      10.12643,
      10.28968,
      10.4433,
      10.58881,
      10.72759,
      10.86084,
      10.98963,
      11.1149,
      11.23747,
      11.35806,
      11.47728,
      11.59567,
      11.71368,
      11.8317,
      11.95005,
      12.069,
      12.18875,
      12.30948,
      12.43132,
      12.49268,
    ];
    List<double> _listsadak25 = [
      3.150611,
      3.597396,
      4.428873,
      5.183378,
      5.866806,
      6.484969,
      7.043627,
      7.548346,
      8.004399,
      8.416719,
      8.789882,
      9.12811,
      9.435279,
      9.714942,
      9.970338,
      10.20442,
      10.41986,
      10.6191,
      10.80433,
      10.97753,
      11.14047,
      11.29477,
      11.44185,
      11.58298,
      11.7193,
      11.85182,
      11.98142,
      12.10889,
      12.23491,
      12.36007,
      12.4849,
      12.60983,
      12.73523,
      12.86144,
      12.9887,
      13.11723,
      13.24721,
      13.31278,
    ];

    List<double> _listsadak50 = [
      3.530203,
      4.003106,
      4.879525,
      5.672889,
      6.391392,
      7.041836,
      7.630425,
      8.162951,
      8.644832,
      9.08112,
      9.4765,
      9.835308,
      10.16154,
      10.45885,
      10.73063,
      10.97992,
      11.20956,
      11.42207,
      11.61978,
      11.80478,
      11.97897,
      12.14404,
      12.30154,
      12.45283,
      12.59913,
      12.74154,
      12.88102,
      13.01842,
      13.1545,
      13.2899,
      13.42519,
      13.56088,
      13.69738,
      13.83505,
      13.97418,
      14.11503,
      14.2578,
      14.32994,
    ];

    List<double> _listsadak75 = [
      3.879077,
      4.387423,
      5.327328,
      6.175598,
      6.942217,
      7.635323,
      8.262033,
      8.828786,
      9.34149,
      9.805593,
      10.22612,
      10.60772,
      10.95466,
      11.27087,
      11.55996,
      11.82524,
      12.06973,
      12.29617,
      12.50708,
      12.70473,
      12.89117,
      13.06825,
      13.23765,
      13.40086,
      13.5592,
      13.71386,
      13.8659,
      14.01623,
      14.16567,
      14.31493,
      14.46462,
      14.61527,
      14.76732,
      14.92117,
      15.07711,
      15.23541,
      15.39628,
      15.47772,
    ];

    List<double> _listsadak90 = [
      4.172493,
      4.718161,
      5.728153,
      6.638979,
      7.460702,
      8.202193,
      8.871384,
      9.475466,
      10.02101,
      10.51406,
      10.96017,
      11.36445,
      11.7316,
      12.06595,
      12.37145,
      12.65175,
      12.91015,
      13.14969,
      13.37311,
      13.5829,
      13.78133,
      13.97042,
      14.15201,
      14.32772,
      14.499,
      14.66716,
      14.83332,
      14.99848,
      15.16351,
      15.32917,
      15.4961,
      15.66485,
      15.83588,
      16.00958,
      16.18624,
      16.36612,
      16.5494,
      16.64237,
    ];

    List<double> _listsadak95 = [
      4.340293,
      4.91013,
      5.967102,
      6.921119,
      7.781401,
      8.556813,
      9.255615,
      9.885436,
      10.45331,
      10.96574,
      11.42868,
      11.84763,
      12.22766,
      12.5734,
      12.88911,
      13.17867,
      13.44564,
      13.69325,
      13.92444,
      14.14187,
      14.34795,
      14.54484,
      14.73448,
      14.91861,
      15.09876,
      15.2763,
      15.45242,
      15.62819,
      15.8045,
      15.98214,
      16.16177,
      16.34395,
      16.52915,
      16.71773,
      16.91,
      17.10619,
      17.30646,
      17.40816,
    ];
    List<double> month = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
      36,
    ];

    final List<LinearSales> _sadak5 = [];
    for (int i = 0; i < _listsadak5.length; i++)
      _sadak5.add(
        new LinearSales(month[i], _listsadak5[i]),
      );

    final List<LinearSales> _sadak15 = [];
    for (int i = 0; i < _listsadak15.length; i++)
      _sadak15.add(
        new LinearSales(month[i], _listsadak15[i]),
      );

    final List<LinearSales> _sadak25 = [];
    for (int i = 0; i < _listsadak25.length; i++)
      _sadak25.add(
        new LinearSales(month[i], _listsadak25[i]),
      );

    final List<LinearSales> _sadak50 = [];
    for (int i = 0; i < _listsadak50.length; i++)
      _sadak50.add(
        new LinearSales(month[i], _listsadak50[i]),
      );

    final List<LinearSales> _sadak75 = [];
    for (int i = 0; i < _listsadak75.length; i++)
      _sadak75.add(
        new LinearSales(month[i], _listsadak75[i]),
      );
    final List<LinearSales> _sadak90 = [];
    for (int i = 0; i < _listsadak90.length; i++)
      _sadak90.add(
        new LinearSales(month[i], _listsadak90[i]),
      );
    final List<LinearSales> _sadak95 = [];
    for (int i = 0; i < _listsadak95.length; i++)
      _sadak95.add(
        new LinearSales(month[i], _listsadak95[i]),
      );

//    var myFakeTabletData = [
//      new LinearSales(0, 10),
//      new LinearSales(1, 50),
//      new LinearSales(2, 200),
//      new LinearSales(3, 150),
//    ];
//
//    var myFakeMobileData = [
//      new LinearSales(0, 15),
//      new LinearSales(1, 75),
//      new LinearSales(2, 300),
//      new LinearSales(3, 225),
//    ];

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse(calculateAllMounth(_user.birthdate).toString()),
          double.parse(_user.weight))
    ];
    return [
      new charts.Series<LinearSales, double>(
        id: '_sadak5',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak5,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak15',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak15,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak25',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.teal.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak25,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak50',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#299c06'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak50,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak75',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.pink.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak75,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak90',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.purple.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak90,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak95',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.lime.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak95,
      ),
      new charts.Series<LinearSales, double>(
          id: '_user',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.

    ];
  }

  //// نمودار قد برای دختران 0 تا 36 ماه
  List<charts.Series<LinearSales, double>> _girlHeightMonth() {
    final _listsadak5 = [
      45.57561,
      47.96324,
      51.47996,
      54.17907,
      56.43335,
      58.40032,
      60.16323,
      61.77208,
      63.25958,
      64.64845,
      65.9552,
      67.19226,
      68.36925,
      69.4938,
      70.57207,
      71.60911,
      72.60914,
      73.57571,
      74.51184,
      75.42012,
      76.30282,
      77.16191,
      77.9991,
      78.81595,
      79.61381,
      80.39391,
      81.18804,
      81.97223,
      82.74084,
      83.48951,
      84.21496,
      84.91494,
      85.58809,
      86.23379,
      86.85208,
      87.44359,
      88.00937,
    ];

    final _listsadak15 = [
      46.33934,
      48.74248,
      52.29627,
      55.03144,
      57.31892,
      59.31633,
      61.10726,
      62.7421,
      64.25389,
      65.66559,
      66.99394,
      68.25154,
      69.44814,
      70.59149,
      71.68784,
      72.74233,
      73.75924,
      74.74217,
      75.6942,
      76.61797,
      77.51576,
      78.38958,
      79.2412,
      80.07216,
      80.88385,
      81.67752,
      82.49318,
      83.29459,
      84.07717,
      84.83741,
      85.57273,
      86.28139,
      86.96242,
      87.6155,
      88.24089,
      88.83932,
      89.41196,
    ];
    List<double> _listsadak25 = [
      47.68345,
      50.09686,
      53.69078,
      56.47125,
      58.80346,
      60.84386,
      62.6759,
      64.35005,
      65.89952,
      67.34745,
      68.7107,
      70.00202,
      71.23128,
      72.40633,
      73.53349,
      74.61799,
      75.66416,
      76.67568,
      77.65565,
      78.60678,
      79.53138,
      80.4315,
      81.30893,
      82.16525,
      83.00187,
      83.82007,
      84.67209,
      85.5036,
      86.31151,
      87.09346,
      87.84783,
      88.57362,
      89.27042,
      89.93835,
      90.57795,
      91.1902,
      91.77639,
    ];

    List<double> _listsadak50 = [
      49.2864,
      51.68358,
      55.28613,
      58.09382,
      60.45981,
      62.5367,
      64.40633,
      66.11842,
      67.70574,
      69.19124,
      70.59164,
      71.91962,
      73.18501,
      74.39564,
      75.55785,
      76.67686,
      77.75701,
      78.80198,
      79.81492,
      80.79852,
      81.75512,
      82.68679,
      83.59532,
      84.48233,
      85.34924,
      86.19732,
      87.09026,
      87.95714,
      88.79602,
      89.60551,
      90.38477,
      91.13342,
      91.85154,
      92.53964,
      93.19854,
      93.82945,
      94.43382,
    ];

    List<double> _listsadak75 = [
      51.0187,
      53.36362,
      56.93136,
      59.74045,
      62.1233,
      64.22507,
      66.12418,
      67.8685,
      69.48975,
      71.01019,
      72.44614,
      73.80997,
      75.11133,
      76.35791,
      77.55594,
      78.71058,
      79.82613,
      80.90623,
      81.95399,
      82.97211,
      83.96292,
      84.92846,
      85.87054,
      86.79077,
      87.69056,
      88.57121,
      89.50562,
      90.40982,
      91.28258,
      92.12313,
      92.93113,
      93.70662,
      94.45005,
      95.16218,
      95.84411,
      96.49721,
      97.12307,
    ];

    List<double> _listsadak90 = [
      52.7025,
      54.96222,
      58.45612,
      61.24306,
      63.62648,
      65.74096,
      67.65995,
      69.42868,
      71.07731,
      72.62711,
      74.09378,
      75.48923,
      76.82282,
      78.10202,
      79.3329,
      80.5205,
      81.66903,
      82.78208,
      83.86269,
      84.91353,
      85.93689,
      86.93481,
      87.90908,
      88.86127,
      89.79282,
      90.70499,
      91.67718,
      92.61658,
      93.52227,
      94.39371,
      95.23082,
      96.03385,
      96.80343,
      97.54052,
      98.24636,
      98.92246,
      99.57056,
    ];

    List<double> _listsadak95 = [
      53.77291,
      55.96094,
      59.38911,
      62.15166,
      64.52875,
      66.64653,
      68.57452,
      70.35587,
      72.01952,
      73.58601,
      75.0705,
      76.4846,
      77.83742,
      79.13625,
      80.38705,
      81.59475,
      82.7635,
      83.89683,
      84.99774,
      86.06887,
      87.11249,
      88.13061,
      89.125,
      90.09723,
      91.04873,
      91.98074,
      92.97574,
      93.93693,
      94.86339,
      95.75464,
      96.61061,
      97.43164,
      98.2184,
      98.97193,
      99.69353,
      100.3848,
      101.0475,
    ];
    List<double> month = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
    ];

    final List<LinearSales> _sadak5 = [];
    for (int i = 0; i < _listsadak5.length; i++)
      _sadak5.add(
        new LinearSales(month[i], _listsadak5[i]),
      );

    final List<LinearSales> _sadak15 = [];
    for (int i = 0; i < _listsadak15.length; i++)
      _sadak15.add(
        new LinearSales(month[i], _listsadak15[i]),
      );

    final List<LinearSales> _sadak25 = [];
    for (int i = 0; i < _listsadak25.length; i++)
      _sadak25.add(
        new LinearSales(month[i], _listsadak25[i]),
      );

    final List<LinearSales> _sadak50 = [];
    for (int i = 0; i < _listsadak50.length; i++)
      _sadak50.add(
        new LinearSales(month[i], _listsadak50[i]),
      );

    final List<LinearSales> _sadak75 = [];
    for (int i = 0; i < _listsadak75.length; i++)
      _sadak75.add(
        new LinearSales(month[i], _listsadak75[i]),
      );
    final List<LinearSales> _sadak90 = [];
    for (int i = 0; i < _listsadak90.length; i++)
      _sadak90.add(
        new LinearSales(month[i], _listsadak90[i]),
      );
    final List<LinearSales> _sadak95 = [];
    for (int i = 0; i < _listsadak95.length; i++)
      _sadak95.add(
        new LinearSales(month[i], _listsadak95[i]),
      );

//    var myFakeTabletData = [
//      new LinearSales(0, 10),
//      new LinearSales(1, 50),
//      new LinearSales(2, 200),
//      new LinearSales(3, 150),
//    ];
//
//    var myFakeMobileData = [
//      new LinearSales(0, 15),
//      new LinearSales(1, 75),
//      new LinearSales(2, 300),
//      new LinearSales(3, 225),
//    ];

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse(calculateAllMounth(_user.birthdate).toString()),
          double.parse(_user.height))
    ];
    return [
      new charts.Series<LinearSales, double>(
        id: '_sadak5',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak5,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak15',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak15,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak25',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.teal.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak25,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak50',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#299c06'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak50,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak75',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.pink.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak75,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak90',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.purple.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak90,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak95',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.lime.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak95,
      ),
      new charts.Series<LinearSales, double>(
          id: '_user',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.

    ];
  }

  //// نمودار قد برای پسران 0 تا 36 ماه
  List<charts.Series<LinearSales, double>> _boyHeightMonth() {
    final _listsadak5 = [
      45.56841,
      48.55809,
      52.72611,
      55.77345,
      58.23744,
      60.33647,
      62.18261,
      63.84166,
      65.35584,
      66.75398,
      68.05675,
      69.27949,
      70.43397,
      71.52941,
      72.57318,
      73.5713,
      74.52871,
      75.44958,
      76.33742,
      77.19523,
      78.0256,
      78.83077,
      79.61271,
      80.37315,
      81.11363,
      81.83552,
      82.58135,
      83.31105,
      84.02609,
      84.72769,
      85.41688,
      86.09452,
      86.76134,
      87.41799,
      88.06503,
      88.70301,
      89.33242,
    ];

    final _listsadak15 = [
      46.55429,
      49.4578,
      53.55365,
      56.57772,
      59.0383,
      61.1441,
      63.00296,
      64.67854,
      66.21181,
      67.63088,
      68.95591,
      70.20192,
      71.38046,
      72.50055,
      73.56946,
      74.59309,
      75.57634,
      76.5233,
      77.43742,
      78.32168,
      79.17863,
      80.01048,
      80.81919,
      81.60646,
      82.37381,
      83.12259,
      83.87245,
      84.60576,
      85.32399,
      86.02833,
      86.71978,
      87.39917,
      88.06723,
      88.72457,
      89.37177,
      90.00937,
      90.63786,
    ];
    List<double> _listsadak25 = [
      48.18937,
      50.97919,
      54.9791,
      57.9744,
      60.43433,
      62.55409,
      64.43546,
      66.13896,
      67.70375,
      69.15682,
      70.51761,
      71.80065,
      73.01712,
      74.17581,
      75.2838,
      76.34685,
      77.36973,
      78.35646,
      79.31042,
      80.23453,
      81.13131,
      82.00292,
      82.85129,
      83.67811,
      84.48487,
      85.2729,
      86.03703,
      86.78329,
      87.51317,
      88.22788,
      88.9284,
      89.6156,
      90.2902,
      90.95287,
      91.60421,
      92.24482,
      92.87525,
    ];

    List<double> _listsadak50 = [
      49.98888,
      52.69598,
      56.62843,
      59.60895,
      62.077,
      64.21686,
      66.12531,
      67.86018,
      69.45908,
      70.94804,
      72.34586,
      73.66665,
      74.9213,
      76.11838,
      77.2648,
      78.36622,
      79.42734,
      80.45209,
      81.44384,
      82.40544,
      83.33938,
      84.24783,
      85.1327,
      85.99565,
      86.83818,
      87.66161,
      88.45247,
      89.22326,
      89.97549,
      90.71041,
      91.42908,
      92.13242,
      92.82127,
      93.49638,
      94.15847,
      94.80823,
      95.44637,
    ];

    List<double> _listsadak75 = [
      51.77126,
      54.44054,
      58.35059,
      61.33788,
      63.82543,
      65.99131,
      67.92935,
      69.69579,
      71.32735,
      72.84947,
      74.2806,
      75.63462,
      76.92224,
      78.15196,
      79.33061,
      80.4638,
      81.5562,
      82.61174,
      83.63377,
      84.62515,
      85.58837,
      86.52562,
      87.43879,
      88.32957,
      89.19948,
      90.04985,
      90.8787,
      91.68468,
      92.46929,
      93.23385,
      93.97951,
      94.70732,
      95.41824,
      96.11319,
      96.79307,
      97.45873,
      98.11108,
    ];

    List<double> _listsadak90 = [
      53.36153,
      56.03444,
      59.9664,
      62.98158,
      65.49858,
      67.69405,
      69.66122,
      71.45609,
      73.11525,
      74.6641,
      76.1211,
      77.50016,
      78.81202,
      80.0652,
      81.2666,
      82.42185,
      83.53568,
      84.61204,
      85.65431,
      86.66541,
      87.64786,
      88.60385,
      89.53533,
      90.44402,
      91.33143,
      92.19893,
      93.07143,
      93.91817,
      94.74064,
      95.54016,
      96.318,
      97.07531,
      97.81324,
      98.53287,
      99.23531,
      99.92162,
      100.5929,
    ];

    List<double> _listsadak95 = [
      54.30721,
      56.99908,
      60.96465,
      64.00789,
      66.54889,
      68.76538,
      70.75128,
      72.56307,
      74.23767,
      75.80074,
      77.27095,
      78.66234,
      79.98578,
      81.2499,
      82.46167,
      83.6268,
      84.75006,
      85.83547,
      86.88645,
      87.90595,
      88.89652,
      89.86038,
      90.79951,
      91.71563,
      92.61031,
      93.48491,
      94.38775,
      95.263,
      96.1121,
      96.93639,
      97.73717,
      98.51569,
      99.27318,
      100.0109,
      100.73,
      101.4318,
      102.1174,
    ];
    List<double> month = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
    ];

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse(calculateAllMounth(_user.birthdate).toString()),
          double.parse(_user.height))
    ];

    final List<LinearSales> _sadak5 = [];
    for (int i = 0; i < _listsadak5.length; i++)
      _sadak5.add(
        new LinearSales(month[i], _listsadak5[i]),
      );

    final List<LinearSales> _sadak15 = [];
    for (int i = 0; i < _listsadak15.length; i++)
      _sadak15.add(
        new LinearSales(month[i], _listsadak15[i]),
      );

    final List<LinearSales> _sadak25 = [];
    for (int i = 0; i < _listsadak25.length; i++)
      _sadak25.add(
        new LinearSales(month[i], _listsadak25[i]),
      );

    final List<LinearSales> _sadak50 = [];
    for (int i = 0; i < _listsadak50.length; i++)
      _sadak50.add(
        new LinearSales(month[i], _listsadak50[i]),
      );

    final List<LinearSales> _sadak75 = [];
    for (int i = 0; i < _listsadak75.length; i++)
      _sadak75.add(
        new LinearSales(month[i], _listsadak75[i]),
      );
    final List<LinearSales> _sadak90 = [];
    for (int i = 0; i < _listsadak90.length; i++)
      _sadak90.add(
        new LinearSales(month[i], _listsadak90[i]),
      );
    final List<LinearSales> _sadak95 = [];
    for (int i = 0; i < _listsadak95.length; i++)
      _sadak95.add(
        new LinearSales(month[i], _listsadak95[i]),
      );

//    var myFakeTabletData = [
//      new LinearSales(0, 10),
//      new LinearSales(1, 50),
//      new LinearSales(2, 200),
//      new LinearSales(3, 150),
//    ];
//
//    var myFakeMobileData = [
//      new LinearSales(0, 15),
//      new LinearSales(1, 75),
//      new LinearSales(2, 300),
//      new LinearSales(3, 225),
//    ];
    return [
      new charts.Series<LinearSales, double>(
        id: '_sadak5',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak5,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak15',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak15,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak25',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.teal.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak25,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak50',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#299c06'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.cyan.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak50,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak75',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#93e07b'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.pink.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak75,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak90',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#fccf03'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.purple.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak90,
      ),
      new charts.Series<LinearSales, double>(
        id: '_sadak95',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.Color.fromHex(code: '#FF0230'),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
        charts.MaterialPalette.lime.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: _sadak95,
      ),
      new charts.Series<LinearSales, double>(
          id: '_user',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.

    ];
  }

  calculateTypeGirl(){
    double height=double.parse(_user.height);
    double weight=double.parse(_user.weight);
    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(height<=77)
      {
        if(weight<9.5)
          _type=1;
        else if(weight>=9.5&&weight<=10.6)
          _type=2;
        else if(weight>10.6)
          _type=3;
      }
    else if(height>77&&height<=77.5)
      {
        if(weight<9.6)
          _type=1;
        else if(weight>=9.6&&weight<=10.7)
          _type=2;
        else if(weight>10.7)
          _type=3;
      }
    else if(height>77.5&&height<=78.5)
      {
        if(weight<9.8)
          _type=1;
        else if(weight>=9.8&&weight<=11.0)
          _type=2;
        else if(weight>11.0)
          _type=3;
      }
    else if(height>78.5&&height<=79.5)
      {
        if(weight<10)
          _type=1;
        else if(weight>=10&&weight<=11.2)
          _type=2;
        else if(weight>11.2)
          _type=3;
      }
    else if(height>79.5&&height<=80.5)
      {
        if(weight<10.3)
          _type=1;
        else if(weight>=10.3&&weight<=11.4)
          _type=2;
        else if(weight>11.4)
          _type=3;
      }
    else if(height>80.5&&height<=81.5)
      {
        if(weight<10.5)
          _type=1;
        else if(weight>=10.5&&weight<=11.7)
          _type=2;
        else if(weight>11.7)
          _type=3;
      }
  else if(height>81.5&&height<=82.5)
      {
        if(weight<10.7)
          _type=1;
        else if(weight>=10.7&&weight<=11.9)
          _type=2;
        else if(weight>11.9)
          _type=3;
      }
  else if(height>82.5&&height<=83.5)
      {
        if(weight<10.9)
          _type=1;
        else if(weight>=10.9&&weight<=12.1)
          _type=2;
        else if(weight>12.1)
          _type=3;
      }
else if(height>83.5&&height<=84.5)
      {
        if(weight<11.1)
          _type=1;
        else if(weight>=11.1&&weight<=12.4)
          _type=2;
        else if(weight>12.4)
          _type=3;
      }
  else if(height>84.5&&height<=85.5)
      {
        if(weight<11.3)
          _type=1;
        else if(weight>=11.3&&weight<=12.6)
          _type=2;
        else if(weight>12.6)
          _type=3;
      }
  else if(height>85.5&&height<=86.5)
      {
        if(weight<11.5)
          _type=1;
        else if(weight>=11.5&&weight<=12.8)
          _type=2;
        else if(weight>12.8)
          _type=3;
      }
  else if(height>86.5&&height<=87.5)
      {
        if(weight<11.7)
          _type=1;
        else if(weight>=11.7&&weight<=13.1)
          _type=2;
        else if(weight>13.1)
          _type=3;
      }
  else if(height>87.5&&height<=88.5)
      {
        if(weight<12.0)
          _type=1;
        else if(weight>=12.0&&weight<=13.3)
          _type=2;
        else if(weight>13.3)
          _type=3;
      }
    else if(height>88.5&&height<=89.5)
    {
      if(weight<12.2)
        _type=1;
      else if(weight>=12.2&&weight<=13.5)
        _type=2;
      else if(weight>13.5)
        _type=3;
    }
    else if(height>89.5&&height<=90.5)
    {
      if(weight<12.4)
        _type=1;
      else if(weight>=12.4&&weight<=13.8)
        _type=2;
      else if(weight>13.8)
        _type=3;
    }
    else if(height>90.5&&height<=91.5)
    {
      if(weight<12.6)
        _type=1;
      else if(weight>=12.6&&weight<=14)
        _type=2;
      else if(weight>14)
        _type=3;
    }
 else if(height>91.5&&height<=92.5)
    {
      if(weight<12.8)
        _type=1;
      else if(weight>=12.8&&weight<=14.3)
        _type=2;
      else if(weight>14.3)
        _type=3;
    }
 else if(height>92.5&&height<=93.5)
    {
      if(weight<13.1)
        _type=1;
      else if(weight>=13.1&&weight<=14.6)
        _type=2;
      else if(weight>14.6)
        _type=3;
    }
 else if(height>93.5&&height<=94.5)
    {
      if(weight<13.3)
        _type=1;
      else if(weight>=13.3&&weight<=14.8)
        _type=2;
      else if(weight>14.8)
        _type=3;
    }
 else if(height>94.5&&height<=95.5)
    {
      if(weight<13.5)
        _type=1;
      else if(weight>=13.5&&weight<=15.1)
        _type=2;
      else if(weight>15.1)
        _type=3;
    }
 else if(height>95.5&&height<=96.5)
    {
      if(weight<13.7)
        _type=1;
      else if(weight>=13.7&&weight<=15.4)
        _type=2;
      else if(weight>15.4)
        _type=3;
    }
 else if(height>96.5&&height<=97.5)
    {
      if(weight<14)
        _type=1;
      else if(weight>=14&&weight<=15.6)
        _type=2;
      else if(weight>15.6)
        _type=3;
    }
 else if(height>97.5&&height<=98.5)
    {
      if(weight<14.2)
        _type=1;
      else if(weight>=14.2&&weight<=15.9)
        _type=2;
      else if(weight>15.9)
        _type=3;
    }
 else if(height>98.5&&height<=99.5)
    {
      if(weight<14.5)
        _type=1;
      else if(weight>=14.5&&weight<=16.2)
        _type=2;
      else if(weight>16.2)
        _type=3;
    }
 else if(height>99.5&&height<=100.5)
    {
      if(weight<14.7)
        _type=1;
      else if(weight>=14.7&&weight<=16.5)
        _type=2;
      else if(weight>16.5)
        _type=3;
    }
 else if(height>100.5&&height<=101.5)
    {
      if(weight<15)
        _type=1;
      else if(weight>=15&&weight<=16.8)
        _type=2;
      else if(weight>16.8)
        _type=3;
    }
 else if(height>101.5&&height<=102.5)
    {
      if(weight<15.2)
        _type=1;
      else if(weight>=15.2&&weight<=17.2)
        _type=2;
      else if(weight>17.2)
        _type=3;
    }
 else if(height>102.5&&height<=103.5)
    {
      if(weight<15.5)
        _type=1;
      else if(weight>=15.5&&weight<=17.5)
        _type=2;
      else if(weight>17.5)
        _type=3;
    }
 else if(height>103.5&&height<=104.5)
    {
      if(weight<15.8)
        _type=1;
      else if(weight>=15.8&&weight<=17.8)
        _type=2;
      else if(weight>17.8)
        _type=3;
    }
 else if(height>104.5&&height<=105.5)
    {
      if(weight<16.0)
        _type=1;
      else if(weight>=16.0&&weight<=18.2)
        _type=2;
      else if(weight>18.2)
        _type=3;
    }
 else if(height>105.5&&height<=106.5)
    {
      if(weight<16.3)
        _type=1;
      else if(weight>=16.3&&weight<=18.5)
        _type=2;
      else if(weight>18.5)
        _type=3;
    }
 else if(height>106.5&&height<=107.5)
    {
      if(weight<16.6)
        _type=1;
      else if(weight>=16.6&&weight<=18.9)
        _type=2;
      else if(weight>18.9)
        _type=3;
    }
 else if(height>107.5&&height<=108.5)
    {
      if(weight<16.9)
        _type=1;
      else if(weight>=16.9&&weight<=19.2)
        _type=2;
      else if(weight>19.2)
        _type=3;
    }
 else if(height>108.5&&height<=109.5)
    {
      if(weight<17.2)
        _type=1;
      else if(weight>=17.2&&weight<=19.6)
        _type=2;
      else if(weight>19.6)
        _type=3;
    }
 else if(height>109.5&&height<=110.5)
    {
      if(weight<17.5)
        _type=1;
      else if(weight>=17.5&&weight<=20)
        _type=2;
      else if(weight>20)
        _type=3;
    }
 else if(height>110.5&&height<=111.5)
    {
      if(weight<17.9)
        _type=1;
      else if(weight>=17.9&&weight<=20.4)
        _type=2;
      else if(weight>20.4)
        _type=3;
    }
 else if(height>111.5&&height<=112.5)
    {
      if(weight<18.2)
        _type=1;
      else if(weight>=18.2&&weight<=20.8)
        _type=2;
      else if(weight>20.8)
        _type=3;
    }
 else if(height>112.5&&height<=113.5)
    {
      if(weight<18.5)
        _type=1;
      else if(weight>=18.5&&weight<=21.2)
        _type=2;
      else if(weight>21.2)
        _type=3;
    }
 else if(height>113.5&&height<=114.5)
    {
      if(weight<18.9)
        _type=1;
      else if(weight>=18.9&&weight<=21.6)
        _type=2;
      else if(weight>21.6)
        _type=3;
    }
 else if(height>114.5&&height<=115.5)
    {
      if(weight<19.2)
        _type=1;
      else if(weight>=19.2&&weight<=22)
        _type=2;
      else if(weight>22)
        _type=3;
    }
 else if(height>115.5&&height<=116.5)
    {
      if(weight<19.6)
        _type=1;
      else if(weight>=19.6&&weight<=22.4)
        _type=2;
      else if(weight>22.4)
        _type=3;
    }
 else if(height>116.5&&height<=117.5)
    {
      if(weight<20)
        _type=1;
      else if(weight>=20&&weight<=22.9)
        _type=2;
      else if(weight>22.9)
        _type=3;
    }
 else if(height>117.5&&height<=118.5)
    {
      if(weight<20.4)
        _type=1;
      else if(weight>=20.4&&weight<=23.3)
        _type=2;
      else if(weight>23.3)
        _type=3;
    }
 else if(height>118.5&&height<=119.5)
    {
      if(weight<20.7)
        _type=1;
      else if(weight>=20.7&&weight<=23.7)
        _type=2;
      else if(weight>23.7)
        _type=3;
    }
 else if(height>119.5&&height<=120.5)
    {
      if(weight<21.1)
        _type=1;
      else if(weight>=21.1&&weight<=24.2)
        _type=2;
      else if(weight>24.2)
        _type=3;
    }
 else if(height>120.5)
    {
      if(weight<21.6)
        _type=1;
      else if(weight>=21.6&&weight<=24.6)
        _type=2;
      else if(weight>24.6)
        _type=3;
    }

return _type;
  }
  calculateTypeBoy(){
    double height=double.parse(_user.height);
    double weight=double.parse(_user.weight);
    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(height<=77)
    {
      if(weight<9.7)
        _type=1;
      else if(weight>=9.7&&weight<=10.8)
        _type=2;
      else if(weight>10.8)
        _type=3;
    }
    else if(height>77&&height<=77.5)
    {
      if(weight<9.8)
        _type=1;
      else if(weight>=9.8&&weight<=10.9)
        _type=2;
      else if(weight>10.9)
        _type=3;
    }
    else if(height>77.5&&height<=78.5)
    {
      if(weight<10)
        _type=1;
      else if(weight>=10&&weight<=11.1)
        _type=2;
      else if(weight>11.1)
        _type=3;
    }
    else if(height>78.5&&height<=79.5)
    {
      if(weight<10.3)
        _type=1;
      else if(weight>=10.3&&weight<=11.4)
        _type=2;
      else if(weight>11.4)
        _type=3;
    }
    else if(height>79.5&&height<=80.5)
    {
      if(weight<10.5)
        _type=1;
      else if(weight>=10.5&&weight<=11.6)
        _type=2;
      else if(weight>11.6)
        _type=3;
    }
    else if(height>80.5&&height<=81.5)
    {
      if(weight<10.7)
        _type=1;
      else if(weight>=10.7&&weight<=11.9)
        _type=2;
      else if(weight>11.9)
        _type=3;
    }
    else if(height>81.5&&height<=82.5)
    {
      if(weight<10.9)
        _type=1;
      else if(weight>=10.9&&weight<=12.1)
        _type=2;
      else if(weight>12.1)
        _type=3;
    }
    else if(height>82.5&&height<=83.5)
    {
      if(weight<11.1)
        _type=1;
      else if(weight>=11.1&&weight<=12.3)
        _type=2;
      else if(weight>12.3)
        _type=3;
    }
    else if(height>83.5&&height<=84.5)
    {
      if(weight<11.3)
        _type=1;
      else if(weight>=11.3&&weight<=12.6)
        _type=2;
      else if(weight>12.6)
        _type=3;
    }
    else if(height>84.5&&height<=85.5)
    {
      if(weight<11.6)
        _type=1;
      else if(weight>=11.6&&weight<=12.8)
        _type=2;
      else if(weight>12.8)
        _type=3;
    }
    else if(height>85.5&&height<=86.5)
    {
      if(weight<11.8)
        _type=1;
      else if(weight>=11.8&&weight<=13.0)
        _type=2;
      else if(weight>13.0)
        _type=3;
    }
    else if(height>86.5&&height<=87.5)
    {
      if(weight<12)
        _type=1;
      else if(weight>=12&&weight<=13.3)
        _type=2;
      else if(weight>13.3)
        _type=3;
    }
    else if(height>87.5&&height<=88.5)
    {
      if(weight<12.2)
        _type=1;
      else if(weight>=12.2&&weight<=13.5)
        _type=2;
      else if(weight>13.5)
        _type=3;
    }
    else if(height>88.5&&height<=89.5)
    {
      if(weight<12.4)
        _type=1;
      else if(weight>=12.4&&weight<=13.8)
        _type=2;
      else if(weight>13.8)
        _type=3;
    }
    else if(height>89.5&&height<=90.5)
    {
      if(weight<12.6)
        _type=1;
      else if(weight>=12.6&&weight<=14.0)
        _type=2;
      else if(weight>14.0)
        _type=3;
    }
    else if(height>90.5&&height<=91.5)
    {
      if(weight<12.9)
        _type=1;
      else if(weight>=12.9&&weight<=14.3)
        _type=2;
      else if(weight>14.3)
        _type=3;
    }
    else if(height>91.5&&height<=92.5)
    {
      if(weight<13.1)
        _type=1;
      else if(weight>=13.1&&weight<=14.5)
        _type=2;
      else if(weight>14.5)
        _type=3;
    }
    else if(height>92.5&&height<=93.5)
    {
      if(weight<13.3)
        _type=1;
      else if(weight>=13.3&&weight<=14.8)
        _type=2;
      else if(weight>14.8)
        _type=3;
    }
    else if(height>93.5&&height<=94.5)
    {
      if(weight<13.5)
        _type=1;
      else if(weight>=13.5&&weight<=15.0)
        _type=2;
      else if(weight>15.0)
        _type=3;
    }
    else if(height>94.5&&height<=95.5)
    {
      if(weight<13.8)
        _type=1;
      else if(weight>=13.8&&weight<=15.3)
        _type=2;
      else if(weight>15.3)
        _type=3;
    }
    else if(height>95.5&&height<=96.5)
    {
      if(weight<14)
        _type=1;
      else if(weight>=14&&weight<=15.6)
        _type=2;
      else if(weight>15.6)
        _type=3;
    }
    else if(height>96.5&&height<=97.5)
    {
      if(weight<14.3)
        _type=1;
      else if(weight>=14.3&&weight<=15.8)
        _type=2;
      else if(weight>15.8)
        _type=3;
    }
    else if(height>97.5&&height<=98.5)
    {
      if(weight<14.5)
        _type=1;
      else if(weight>=14.5&&weight<=16.1)
        _type=2;
      else if(weight>16.1)
        _type=3;
    }
    else if(height>98.5&&height<=99.5)
    {
      if(weight<14.7)
        _type=1;
      else if(weight>=14.7&&weight<=16.4)
        _type=2;
      else if(weight>16.4)
        _type=3;
    }
    else if(height>99.5&&height<=100.5)
    {
      if(weight<15)
        _type=1;
      else if(weight>=15&&weight<=16.7)
        _type=2;
      else if(weight>16.7)
        _type=3;
    }
    else if(height>100.5&&height<=101.5)
    {
      if(weight<15.3)
        _type=1;
      else if(weight>=15.3&&weight<=17)
        _type=2;
      else if(weight>17)
        _type=3;
    }
    else if(height>101.5&&height<=102.5)
    {
      if(weight<15.5)
        _type=1;
      else if(weight>=15.5&&weight<=17.3)
        _type=2;
      else if(weight>17.3)
        _type=3;
    }
    else if(height>102.5&&height<=103.5)
    {
      if(weight<15.8)
        _type=1;
      else if(weight>=15.8&&weight<=17.6)
        _type=2;
      else if(weight>17.6)
        _type=3;
    }
    else if(height>103.5&&height<=104.5)
    {
      if(weight<16.1)
        _type=1;
      else if(weight>=16.1&&weight<=17.9)
        _type=2;
      else if(weight>17.9)
        _type=3;
    }
    else if(height>104.5&&height<=105.5)
    {
      if(weight<16.3)
        _type=1;
      else if(weight>=16.3&&weight<=18.2)
        _type=2;
      else if(weight>18.2)
        _type=3;
    }
    else if(height>105.5&&height<=106.5)
    {
      if(weight<16.3)
        _type=1;
      else if(weight>=16.3&&weight<=18.5)
        _type=2;
      else if(weight>18.5)
        _type=3;
    }
    else if(height>106.5&&height<=107.5)
    {
      if(weight<16.9)
        _type=1;
      else if(weight>=16.9&&weight<=18.9)
        _type=2;
      else if(weight>18.9)
        _type=3;
    }
    else if(height>107.5&&height<=108.5)
    {
      if(weight<17.2)
        _type=1;
      else if(weight>=17.2&&weight<=19.2)
        _type=2;
      else if(weight>19.2)
        _type=3;
    }
    else if(height>108.5&&height<=109.5)
    {
      if(weight<17.5)
        _type=1;
      else if(weight>=17.5&&weight<=19.6)
        _type=2;
      else if(weight>19.6)
        _type=3;
    }
    else if(height>109.5&&height<=110.5)
    {
      if(weight<17.8)
        _type=1;
      else if(weight>=17.8&&weight<=19.9)
        _type=2;
      else if(weight>19.9)
        _type=3;
    }
    else if(height>110.5&&height<=111.5)
    {
      if(weight<18.1)
        _type=1;
      else if(weight>=18.1&&weight<=20.3)
        _type=2;
      else if(weight>20.3)
        _type=3;
    }
    else if(height>111.5&&height<=112.5)
    {
      if(weight<18.4)
        _type=1;
      else if(weight>=18.4&&weight<=20.6)
        _type=2;
      else if(weight>20.6)
        _type=3;
    }
    else if(height>112.5&&height<=113.5)
    {
      if(weight<18.8)
        _type=1;
      else if(weight>=18.8&&weight<=21.0)
        _type=2;
      else if(weight>21.0)
        _type=3;
    }
    else if(height>113.5&&height<=114.5)
    {
      if(weight<19.1)
        _type=1;
      else if(weight>=19.1&&weight<=21.4)
        _type=2;
      else if(weight>21.4)
        _type=3;
    }
    else if(height>114.5&&height<=115.5)
    {
      if(weight<19.4)
        _type=1;
      else if(weight>=19.4&&weight<=21.8)
        _type=2;
      else if(weight>21.8)
        _type=3;
    }
    else if(height>115.5&&height<=116.5)
    {
      if(weight<19.8)
        _type=1;
      else if(weight>=19.8&&weight<=22.2)
        _type=2;
      else if(weight>22.2)
        _type=3;
    }
    else if(height>116.5&&height<=117.5)
    {
      if(weight<20.1)
        _type=1;
      else if(weight>=20.1&&weight<=22.6)
        _type=2;
      else if(weight>22.6)
        _type=3;
    }
    else if(height>117.5&&height<=118.5)
    {
      if(weight<20.5)
        _type=1;
      else if(weight>=20.5&&weight<=23.0)
        _type=2;
      else if(weight>23.0)
        _type=3;
    }
    else if(height>118.5&&height<=119.5)
    {
      if(weight<20.8)
        _type=1;
      else if(weight>=20.8&&weight<=23.4)
        _type=2;
      else if(weight>23.4)
        _type=3;
    }
    else if(height>119.5&&height<=120.5)
    {
      if(weight<21.2)
        _type=1;
      else if(weight>=21.2&&weight<=23.9)
        _type=2;
      else if(weight>23.9)
        _type=3;
    }
    else if(height>120.5)
    {
      if(weight<21.6)
        _type=1;
      else if(weight>=21.6&&weight<=24.3)
        _type=2;
      else if(weight>24.3)
        _type=3;
    }

    return _type;
  }

  calculateTypeGirlShow(){
    double height=double.parse(_user.height);
    double weight=double.parse(_user.weight);
    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(height<=77)
    {
      //5 , زیر 5
      if(weight<=8.8)
        _type=1;
      //5 , 25
      else if(weight>8.8&&weight<9.5)
        _type=2;
      //25 == 75
      else if(weight>=9.5&&weight<=10.6)
        _type=3;
      //75 90
      else if(weight>10.6&&weight<11.26)
        _type=4;
      //90 , up 90
      else if(weight>=11.26)
        _type=5;
    }
    else if(height>77&&height<=77.5)
    {
      //5 , زیر 5
      if(weight<=8.9)
        _type=1;
      //5 , 25
      else if(weight>8.9&&weight<9.6)
        _type=2;
      //25 == 75
      else if(weight>=9.6&&weight<=10.7)
        _type=3;
      //75 90
      else if(weight>10.7&&weight<11.3)
        _type=4;
      //90 , up 90
      else if(weight>=11.3)
        _type=5;
    }
    else if(height>77.5&&height<=78.5)
    {
      //5 , زیر 5
      if(weight<=9.1)
        _type=1;
      //5 , 25
      else if(weight>9.1&&weight<9.8)
        _type=2;
      //25 == 75
      else if(weight>=9.8&&weight<=11.02)
        _type=3;
      //75 90
      else if(weight>11.02&&weight<11.6)
        _type=4;
      //90 , up 90
      else if(weight>=11.6)
        _type=5;
    }
    else if(height>78.5&&height<=79.5)
    {
      //5 , زیر 5
      if(weight<=9.3)
        _type=1;
      //5 , 25
      else if(weight>9.3&&weight<10.0)
        _type=2;
      //25 == 75
      else if(weight>=10.0&&weight<=11.2)
        _type=3;
      //75 90
      else if(weight>11.2&&weight<11.8)
        _type=4;
      //90 , up 90
      else if(weight>=11.8)
        _type=5;
    }
    else if(height>79.5&&height<=80.5)
    {
      //5 , زیر 5
      if(weight<=9.5)
        _type=1;
      //5 , 25
      else if(weight>9.5&&weight<10.3)
        _type=2;
      //25 == 75
      else if(weight>=10.3&&weight<=11.4)
        _type=3;
      //75 90
      else if(weight>11.4&&weight<12.0)
        _type=4;
      //90 , up 90
      else if(weight>=12.0)
        _type=5;
    }
    else if(height>80.5&&height<=81.5)
    {
      //5 , زیر 5
      if(weight<=9.7)
        _type=1;
      //5 , 25
      else if(weight>9.7&&weight<10.5)
        _type=2;
      //25 == 75
      else if(weight>=10.5&&weight<=11.7)
        _type=3;
      //75 90
      else if(weight>11.7&&weight<12.3)
        _type=4;
      //90 , up 90
      else if(weight>=12.3)
        _type=5;
    }
    else if(height>81.5&&height<=82.5)
    {
      //5 , زیر 5
      if(weight<=9.9)
        _type=1;
      //5 , 25
      else if(weight>9.9&&weight<10.7)
        _type=2;
      //25 == 75
      else if(weight>=10.7&&weight<=11.9)
        _type=3;
      //75 90
      else if(weight>11.9&&weight<12.5)
        _type=4;
      //90 , up 90
      else if(weight>=12.5)
        _type=5;
    }
    else if(height>82.5&&height<=83.5)
    {
      //5 , زیر 5
      if(weight<=10.1)
        _type=1;
      //5 , 25
      else if(weight>10.1&&weight<10.9)
        _type=2;
      //25 == 75
      else if(weight>=10.9&&weight<=12.1)
        _type=3;
      //75 90
      else if(weight>12.1&&weight<12.8)
        _type=4;
      //90 , up 90
      else if(weight>=12.8)
        _type=5;
    }
    else if(height>83.5&&height<=84.5)
    {
      //5 , زیر 5
      if(weight<=10.4)
        _type=1;
      //5 , 25
      else if(weight>10.4&&weight<11.1)
        _type=2;
      //25 == 75
      else if(weight>=11.1&&weight<=12.4)
        _type=3;
      //75 90
      else if(weight>12.4&&weight<13.05)
        _type=4;
      //90 , up 90
      else if(weight>=13.05)
        _type=5;
    }
    else if(height>84.5&&height<=85.5)
    {
      //5 , زیر 5
      if(weight<=10.6)
        _type=1;
      //5 , 25
      else if(weight>10.6&&weight<11.3)
        _type=2;
      //25 == 75
      else if(weight>=11.3&&weight<=12.6)
        _type=3;
      //75 90
      else if(weight>12.6&&weight<13.2)
        _type=4;
      //90 , up 90
      else if(weight>=13.2)
        _type=5;
    }
    else if(height>85.5&&height<=86.5)
    {
      //5 , زیر 5
      if(weight<=10.8)
        _type=1;
      //5 , 25
      else if(weight>10.8&&weight<11.5)
        _type=2;
      //25 == 75
      else if(weight>=11.5&&weight<=12.8)
        _type=3;
      //75 90
      else if(weight>12.8&&weight<13.5)
        _type=4;
      //90 , up 90
      else if(weight>=13.5)
        _type=5;
    }
    else if(height>86.5&&height<=87.5)
    {
      //5 , زیر 5
      if(weight<=11.00)
        _type=1;
      //5 , 25
      else if(weight>11.00&&weight<11.7)
        _type=2;
      //25 == 75
      else if(weight>=11.7&&weight<=13.1)
        _type=3;
      //75 90
      else if(weight>13.1&&weight<13.8)
        _type=4;
      //90 , up 90
      else if(weight>=13.8)
        _type=5;
    }
    else if(height>87.5&&height<=88.5)
    {
      //5 , زیر 5
      if(weight<=11.2)
        _type=1;
      //5 , 25
      else if(weight>11.2&&weight<12.0)
        _type=2;
      //25 == 75
      else if(weight>=12.0&&weight<=13.3)
        _type=3;
      //75 90
      else if(weight>13.3&&weight<14.0)
        _type=4;
      //90 , up 90
      else if(weight>=14.0)
        _type=5;
    }
    else if(height>88.5&&height<=89.5)
    {
      //5 , زیر 5
      if(weight<=11.4)
        _type=1;
      //5 , 25
      else if(weight>11.4&&weight<12.2)
        _type=2;
      //25 == 75
      else if(weight>=12.2&&weight<=13.5)
        _type=3;
      //75 90
      else if(weight>13.5&&weight<14.3)
        _type=4;
      //90 , up 90
      else if(weight>=14.3)
        _type=5;
    }
    else if(height>89.5&&height<=90.5)
    {
      if(weight<=11.6)
        _type=1;
      //5 , 25
      else if(weight>11.6&&weight<12.4)
        _type=2;
      //25 == 75
      else if(weight>=12.4&&weight<=13.8)
        _type=3;
      //75 90
      else if(weight>13.8&&weight<14.5)
        _type=4;
      //90 , up 90
      else if(weight>=14.5)
        _type=5;
    }
    else if(height>90.5&&height<=91.5)
    {
      if(weight<=11.8)
        _type=1;
      //5 , 25
      else if(weight>11.8&&weight<12.6)
        _type=2;
      //25 == 75
      else if(weight>=12.6&&weight<=14.08)
        _type=3;
      //75 90
      else if(weight>14.08&&weight<14.8)
        _type=4;
      //90 , up 90
      else if(weight>=14.8)
        _type=5;
    }
    else if(height>91.5&&height<=92.5)
    {
      if(weight<=12.04)
        _type=1;
      //5 , 25
      else if(weight>12.04&&weight<12.8)
        _type=2;
      //25 == 75
      else if(weight>=12.8&&weight<=14.3)
        _type=3;
      //75 90
      else if(weight>14.3&&weight<15.15)
        _type=4;
      //90 , up 90
      else if(weight>=15.15)
        _type=5;
    }
    else if(height>92.5&&height<=93.5)
    {
      if(weight<=12.25)
        _type=1;
      //5 , 25
      else if(weight>12.25&&weight<13.1)
        _type=2;
      //25 == 75
      else if(weight>=13.1&&weight<=14.6)
        _type=3;
      //75 90
      else if(weight>14.6&&weight<15.4)
        _type=4;
      //90 , up 90
      else if(weight>=15.4)
        _type=5;
    }
    else if(height>93.5&&height<=94.5)
    {
      if(weight<=12.4)
        _type=1;
      //5 , 25
      else if(weight>12.4&&weight<13.32)
        _type=2;
      //25 == 75
      else if(weight>=13.32&&weight<=14.8)
        _type=3;
      //75 90
      else if(weight>14.8&&weight<15.7)
        _type=4;
      //90 , up 90
      else if(weight>=15.7)
        _type=5;
    }
    else if(height>94.5&&height<=95.5)
    {
      if(weight<=12.6)
        _type=1;
      //5 , 25
      else if(weight>12.6&&weight<13.55)
        _type=2;
      //25 == 75
      else if(weight>=13.55&&weight<=15.1)
        _type=3;
      //75 90
      else if(weight>15.1&&weight<16.0)
        _type=4;
      //90 , up 90
      else if(weight>=16.0)
        _type=5;
    }
    else if(height>95.5&&height<=96.5)
    {
      if(weight<=12.9)
        _type=1;
      //5 , 25
      else if(weight>12.9&&weight<13.7)
        _type=2;
      //25 == 75
      else if(weight>=13.7&&weight<=15.4)
        _type=3;
      //75 90
      else if(weight>15.4&&weight<16.3)
        _type=4;
      //90 , up 90
      else if(weight>=16.3)
        _type=5;
    }
    else if(height>96.5&&height<=97.5)
    {
      if(weight<=13.12)
        _type=1;
      //5 , 25
      else if(weight>13.12&&weight<14.02)
        _type=2;
      //25 == 75
      else if(weight>=14.02&&weight<=15.6)
        _type=3;
      //75 90
      else if(weight>15.6&&weight<16.6)
        _type=4;
      //90 , up 90
      else if(weight>=16.6)
        _type=5;
    }
    else if(height>97.5&&height<=98.5)
    {
      if(weight<=13.35)
        _type=1;
      //5 , 25
      else if(weight>13.35&&weight<14.26)
        _type=2;
      //25 == 75
      else if(weight>=14.26&&weight<=15.97)
        _type=3;
      //75 90
      else if(weight>15.97&&weight<17.01)
        _type=4;
      //90 , up 90
      else if(weight>=17.01)
        _type=5;
    }
    else if(height>98.5&&height<=99.5)
    {
      if(weight<=13.5)
        _type=1;
      //5 , 25
      else if(weight>13.5&&weight<14.5)
        _type=2;
      //25 == 75
      else if(weight>=14.5&&weight<=16.2)
        _type=3;
      //75 90
      else if(weight>16.2&&weight<17.3)
        _type=4;
      //90 , up 90
      else if(weight>=17.3)
        _type=5;
    }
    else if(height>99.5&&height<=100.5)
    {
      if(weight<=13.8)
        _type=1;
      //5 , 25
      else if(weight>13.8&&weight<14.7)
        _type=2;
      //25 == 75
      else if(weight>=14.7&&weight<=16.5)
        _type=3;
      //75 90
      else if(weight>16.5&&weight<17.7)
        _type=4;
      //90 , up 90
      else if(weight>=17.7)
        _type=5;
    }
    else if(height>100.5&&height<=101.5)
    {
      if(weight<=14.05)
        _type=1;
      //5 , 25
      else if(weight>14.05&&weight<15.01)
        _type=2;
      //25 == 75
      else if(weight>=15.01&&weight<=16.88)
        _type=3;
      //75 90
      else if(weight>16.88&&weight<18.06)
        _type=4;
      //90 , up 90
      else if(weight>=18.06)
        _type=5;
    }
    else if(height>101.5&&height<=102.5)
    {
      if(weight<=14.29)
        _type=1;
      //5 , 25
      else if(weight>14.29&&weight<15.27)
        _type=2;
      //25 == 75
      else if(weight>=15.27&&weight<=17.2)
        _type=3;
      //75 90
      else if(weight>17.2&&weight<18.4)
        _type=4;
      //90 , up 90
      else if(weight>=18.4)
        _type=5;
    }
    else if(height>102.5&&height<=103.5)
    {
      if(weight<=14.5)
        _type=1;
      //5 , 25
      else if(weight>14.5&&weight<15.5)
        _type=2;
      //25 == 75
      else if(weight>=15.5&&weight<=17.5)
        _type=3;
      //75 90
      else if(weight>17.5&&weight<18.8)
        _type=4;
      //90 , up 90
      else if(weight>=18.8)
        _type=5;
    }
    else if(height>103.5&&height<=104.5)
    {
      if(weight<=14.7)
        _type=1;
      //5 , 25
      else if(weight>14.7&&weight<15.8)
        _type=2;
      //25 == 75
      else if(weight>=15.8&&weight<=17.8)
        _type=3;
      //75 90
      else if(weight>17.8&&weight<19.1)
        _type=4;
      //90 , up 90
      else if(weight>=19.1)
        _type=5;
    }
    else if(height>104.5&&height<=105.5)
    {
      if(weight<=15.03)
        _type=1;
      //5 , 25
      else if(weight>15.03&&weight<16.09)
        _type=2;
      //25 == 75
      else if(weight>=16.09&&weight<=18.2)
        _type=3;
      //75 90
      else if(weight>18.2&&weight<19.5)
        _type=4;
      //90 , up 90
      else if(weight>=19.5)
        _type=5;
    }
    else if(height>105.5&&height<=106.5)
    {
      if(weight<=15.29)
        _type=1;
      //5 , 25
      else if(weight>15.29&&weight<16.38)
        _type=2;
      //25 == 75
      else if(weight>=16.38&&weight<=18.55)
        _type=3;
      //75 90
      else if(weight>18.55&&weight<20.0)
        _type=4;
      //90 , up 90
      else if(weight>=20.0)
        _type=5;
    }
    else if(height>106.5&&height<=107.5)
    {
      if(weight<=15.56)
        _type=1;
      //5 , 25
      else if(weight>15.56&&weight<16.67)
        _type=2;
      //25 == 75
      else if(weight>=16.67&&weight<=18.91)
        _type=3;
      //75 90
      else if(weight>18.91&&weight<20.4)
        _type=4;
      //90 , up 90
      else if(weight>=20.4)
        _type=5;
    }
    else if(height>107.5&&height<=108.5)
    {
      if(weight<=15.83)
        _type=1;
      //5 , 25
      else if(weight>15.83&&weight<16.97)
        _type=2;
      //25 == 75
      else if(weight>=16.97&&weight<=19.28)
        _type=3;
      //75 90
      else if(weight>19.28&&weight<20.8)
        _type=4;
      //90 , up 90
      else if(weight>=20.8)
        _type=5;
    }
    else if(height>108.5&&height<=109.5)
    {
      if(weight<=16.11)
        _type=1;
      //5 , 25
      else if(weight>16.11&&weight<17.2)
        _type=2;
      //25 == 75
      else if(weight>=17.2&&weight<=19.66)
        _type=3;
      //75 90
      else if(weight>19.66&&weight<21.2)
        _type=4;
      //90 , up 90
      else if(weight>=21.2)
        _type=5;
    }
    else if(height>109.5&&height<=110.5)
    {
      if(weight<=16.39)
        _type=1;
      //5 , 25
      else if(weight>16.39&&weight<17.59)
        _type=2;
      //25 == 75
      else if(weight>=17.59&&weight<=20.04)
        _type=3;
      //75 90
      else if(weight>20.04&&weight<21.7)
        _type=4;
      //90 , up 90
      else if(weight>=21.7)
        _type=5;
    }
    else if(height>110.5&&height<=111.5)
    {
      if(weight<=16.68)
        _type=1;
      //5 , 25
      else if(weight>16.68&&weight<17.9)
        _type=2;
      //25 == 75
      else if(weight>=17.9&&weight<=20.4)
        _type=3;
      //75 90
      else if(weight>20.4&&weight<22.1)
        _type=4;
      //90 , up 90
      else if(weight>=22.1)
        _type=5;
    }
    else if(height>111.5&&height<=112.5)
    {
      if(weight<=16.98)
        _type=1;
      //5 , 25
      else if(weight>16.98&&weight<18.24)
        _type=2;
      //25 == 75
      else if(weight>=18.24&&weight<=20.83)
        _type=3;
      //75 90
      else if(weight>20.83&&weight<22.5)
        _type=4;
      //90 , up 90
      else if(weight>=22.5)
        _type=5;
    }
    else if(height>112.5&&height<=113.5)
    {
      if(weight<=17.2)
        _type=1;
      //5 , 25
      else if(weight>17.2&&weight<18.5)
        _type=2;
      //25 == 75
      else if(weight>=18.5&&weight<=21.23)
        _type=3;
      //75 90
      else if(weight>21.23&&weight<23.05)
        _type=4;
      //90 , up 90
      else if(weight>=23.05)
        _type=5;
    }
    else if(height>113.5&&height<=114.5)
    {
      if(weight<=17.6)
        _type=1;
      //5 , 25
      else if(weight>17.6&&weight<18.9)
        _type=2;
      //25 == 75
      else if(weight>=18.9&&weight<=21.64)
        _type=3;
      //75 90
      else if(weight>21.64&&weight<23.5)
        _type=4;
      //90 , up 90
      else if(weight>=23.5)
        _type=5;
    }
    else if(height>114.5&&height<=115.5)
    {
      if(weight<=17.9)
        _type=1;
      //5 , 25
      else if(weight>17.9&&weight<19.2)
        _type=2;
      //25 == 75
      else if(weight>=19.2&&weight<=22.0)
        _type=3;
      //75 90
      else if(weight>22.0&&weight<23.9)
        _type=4;
      //90 , up 90
      else if(weight>=23.9)
        _type=5;
    }
    else if(height>115.5&&height<=116.5)
    {
      if(weight<=18.27)
        _type=1;
      //5 , 25
      else if(weight>18.27&&weight<19.6)
        _type=2;
      //25 == 75
      else if(weight>=19.6&&weight<=22.4)
        _type=3;
      //75 90
      else if(weight>22.4&&weight<24.4)
        _type=4;
      //90 , up 90
      else if(weight>=24.2)
        _type=5;
    }
    else if(height>116.5&&height<=117.5)
    {
      if(weight<=18.6)
        _type=1;
      //5 , 25
      else if(weight>18.6&&weight<20.0)
        _type=2;
      //25 == 75
      else if(weight>=20.0&&weight<=22.9)
        _type=3;
      //75 90
      else if(weight>22.9&&weight<24.8)
        _type=4;
      //90 , up 90
      else if(weight>=24.8)
        _type=5;
    }
    else if(height>117.5&&height<=118.5)
    {
      if(weight<=18.9)
        _type=1;
      //5 , 25
      else if(weight>18.9&&weight<20.4)
        _type=2;
      //25 == 75
      else if(weight>=20.4&&weight<=23.34)
        _type=3;
      //75 90
      else if(weight>23.34&&weight<25.34)
        _type=4;
      //90 , up 90
      else if(weight>=25.34)
        _type=5;
    }
    else if(height>118.5&&height<=119.5)
    {
      if(weight<=19.33)
        _type=1;
      //5 , 25
      else if(weight>19.33&&weight<20.79)
        _type=2;
      //25 == 75
      else if(weight>=20.79&&weight<=23.77)
        _type=3;
      //75 90
      else if(weight>23.77&&weight<25.79)
        _type=4;
      //90 , up 90
      else if(weight>=25.79)
        _type=5;
    }
    else if(height>119.5&&height<=120.5)
    {
      if(weight<=19.71)
        _type=1;
      //5 , 25
      else if(weight>19.71&&weight<21.19)
        _type=2;
      //25 == 75
      else if(weight>=21.19&&weight<=24.20)
        _type=3;
      //75 90
      else if(weight>24.20&&weight<26.24)
        _type=4;
      //90 , up 90
      else if(weight>=26.24)
        _type=5;
    }
    else if(height>120.5)
    {
      if(weight<=20.1)
        _type=1;
      //5 , 25
      else if(weight>20.1&&weight<21.6)
        _type=2;
      //25 == 75
      else if(weight>=21.6&&weight<=24.64)
        _type=3;
      //75 90
      else if(weight>24.64&&weight<26.68)
        _type=4;
      //90 , up 90
      else if(weight>=26.68)
        _type=5;
    }

    return _type;
  }
  calculateTypeBoyShow(){
    double height=double.parse(_user.height);
    double weight=double.parse(_user.weight);
    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(height<=77)
    {
      //5 , زیر 5
      if(weight<=9.11)
        _type=1;
      //5 , 25
      else if(weight>9.11&&weight<9.7)
        _type=2;
      //25 == 75
      else if(weight>=9.7&&weight<=10.8)
        _type=3;
      //75 90
      else if(weight>10.8&&weight<11.4)
        _type=4;
      //90 , up 90
      else if(weight>=11.4)
        _type=5;
    }
    else if(height>77&&height<=77.5)
    {
      //5 , زیر 5
      if(weight<=9.2)
        _type=1;
      //5 , 25
      else if(weight>9.2&&weight<9.8)
        _type=2;
      //25 == 75
      else if(weight>=9.8&&weight<=10.9)
        _type=3;
      //75 90
      else if(weight>10.9&&weight<11.5)
        _type=4;
      //90 , up 90
      else if(weight>=11.5)
        _type=5;
    }
    else if(height>77.5&&height<=78.5)
    {
      //5 , زیر 5
      if(weight<=9.4)
        _type=1;
      //5 , 25
      else if(weight>9.4&&weight<10.0)
        _type=2;
      //25 == 75
      else if(weight>=10.0&&weight<=11.1)
        _type=3;
      //75 90
      else if(weight>11.1&&weight<11.7)
        _type=4;
      //90 , up 90
      else if(weight>=11.7)
        _type=5;
    }
    else if(height>78.5&&height<=79.5)
    {
      //5 , زیر 5
      if(weight<=9.6)
        _type=1;
      //5 , 25
      else if(weight>9.6&&weight<10.3)
        _type=2;
      //25 == 75
      else if(weight>=10.3&&weight<=11.4)
        _type=3;
      //75 90
      else if(weight>11.4&&weight<12.0)
        _type=4;
      //90 , up 90
      else if(weight>=12.0)
        _type=5;
    }
    else if(height>79.5&&height<=80.5)
    {
      //5 , زیر 5
      if(weight<=9.8)
        _type=1;
      //5 , 25
      else if(weight>9.8&&weight<10.5)
        _type=2;
      //25 == 75
      else if(weight>=10.5&&weight<=11.6)
        _type=3;
      //75 90
      else if(weight>11.6&&weight<12.2)
        _type=4;
      //90 , up 90
      else if(weight>=12.2)
        _type=5;
    }
    else if(height>80.5&&height<=81.5)
    {
      //5 , زیر 5
      if(weight<=10.0)
        _type=1;
      //5 , 25
      else if(weight>10.0&&weight<10.7)
        _type=2;
      //25 == 75
      else if(weight>=10.7&&weight<=11.9)
        _type=3;
      //75 90
      else if(weight>11.9&&weight<12.5)
        _type=4;
      //90 , up 90
      else if(weight>=12.5)
        _type=5;
    }
    else if(height>81.5&&height<=82.5)
    {
      //5 , زیر 5
      if(weight<=10.2)
        _type=1;
      //5 , 25
      else if(weight>10.2&&weight<10.9)
        _type=2;
      //25 == 75
      else if(weight>=10.9&&weight<=12.1)
        _type=3;
      //75 90
      else if(weight>12.1&&weight<12.7)
        _type=4;
      //90 , up 90
      else if(weight>=12.7)
        _type=5;
    }
    else if(height>82.5&&height<=83.5)
    {
      //5 , زیر 5
      if(weight<=10.4)
        _type=1;
      //5 , 25
      else if(weight>10.4&&weight<11.1)
        _type=2;
      //25 == 75
      else if(weight>=11.1&&weight<=12.3)
        _type=3;
      //75 90
      else if(weight>12.3&&weight<13.00)
        _type=4;
      //90 , up 90
      else if(weight>=13.00)
        _type=5;
    }
    else if(height>83.5&&height<=84.5)
    {
      //5 , زیر 5
      if(weight<=10.6)
        _type=1;
      //5 , 25
      else if(weight>10.6&&weight<11.3)
        _type=2;
      //25 == 75
      else if(weight>=11.3&&weight<=12.6)
        _type=3;
      //75 90
      else if(weight>12.6&&weight<13.2)
        _type=4;
      //90 , up 90
      else if(weight>=13.2)
        _type=5;
    }
    else if(height>84.5&&height<=85.5)
    {
      //5 , زیر 5
      if(weight<=10.8)
        _type=1;
      //5 , 25
      else if(weight>10.8&&weight<11.6)
        _type=2;
      //25 == 75
      else if(weight>=11.6&&weight<=12.8)
        _type=3;
      //75 90
      else if(weight>12.8&&weight<13.4)
        _type=4;
      //90 , up 90
      else if(weight>=13.4)
        _type=5;
    }
    else if(height>85.5&&height<=86.5)
    {
      //5 , زیر 5
      if(weight<=11.03)
        _type=1;
      //5 , 25
      else if(weight>11.03&&weight<11.8)
        _type=2;
      //25 == 75
      else if(weight>=11.8&&weight<=13.08)
        _type=3;
      //75 90
      else if(weight>13.08&&weight<13.7)
        _type=4;
      //90 , up 90
      else if(weight>=13.7)
        _type=5;
    }
    else if(height>86.5&&height<=87.5)
    {
      //5 , زیر 5
      if(weight<=11.23)
        _type=1;
      //5 , 25
      else if(weight>11.23&&weight<12.03)
        _type=2;
      //25 == 75
      else if(weight>=12.03&&weight<=13.32)
        _type=3;
      //75 90
      else if(weight>13.32&&weight<13.99)
        _type=4;
      //90 , up 90
      else if(weight>=13.99)
        _type=5;
    }
    else if(height>87.5&&height<=88.5)
    {
      //5 , زیر 5
      if(weight<=11.4)
        _type=1;
      //5 , 25
      else if(weight>11.4&&weight<12.2)
        _type=2;
      //25 == 75
      else if(weight>=12.2&&weight<=13.5)
        _type=3;
      //75 90
      else if(weight>13.5&&weight<14.2)
        _type=4;
      //90 , up 90
      else if(weight>=14.2)
        _type=5;
    }
    else if(height>88.5&&height<=89.5)
    {
      //5 , زیر 5
      if(weight<=11.6)
        _type=1;
      //5 , 25
      else if(weight>11.6&&weight<12.4)
        _type=2;
      //25 == 75
      else if(weight>=12.4&&weight<=13.8)
        _type=3;
      //75 90
      else if(weight>13.8&&weight<14.5)
        _type=4;
      //90 , up 90
      else if(weight>=14.5)
        _type=5;
    }
    else if(height>89.5&&height<=90.5)
    {
      if(weight<=11.8)
        _type=1;
      //5 , 25
      else if(weight>11.8&&weight<12.6)
        _type=2;
      //25 == 75
      else if(weight>=12.6&&weight<=14.0)
        _type=3;
      //75 90
      else if(weight>14.0&&weight<14.7)
        _type=4;
      //90 , up 90
      else if(weight>=14.7)
        _type=5;
    }
    else if(height>90.5&&height<=91.5)
    {
      if(weight<=12.05)
        _type=1;
      //5 , 25
      else if(weight>12.05&&weight<12.9)
        _type=2;
      //25 == 75
      else if(weight>=12.9&&weight<=14.3)
        _type=3;
      //75 90
      else if(weight>14.3&&weight<15.03)
        _type=4;
      //90 , up 90
      else if(weight>=15.03)
        _type=5;
    }
    else if(height>91.5&&height<=92.5)
    {
      if(weight<=12.2)
        _type=1;
      //5 , 25
      else if(weight>12.2&&weight<13.13)
        _type=2;
      //25 == 75
      else if(weight>=13.13&&weight<=14.5)
        _type=3;
      //75 90
      else if(weight>14.5&&weight<15.3)
        _type=4;
      //90 , up 90
      else if(weight>=15.3)
        _type=5;
    }
    else if(height>92.5&&height<=93.5)
    {
      if(weight<=12.4)
        _type=1;
      //5 , 25
      else if(weight>12.4&&weight<13.3)
        _type=2;
      //25 == 75
      else if(weight>=13.3&&weight<=14.8)
        _type=3;
      //75 90
      else if(weight>14.8&&weight<15.5)
        _type=4;
      //90 , up 90
      else if(weight>=15.5)
        _type=5;
    }
    else if(height>93.5&&height<=94.5)
    {
      if(weight<=12.7)
        _type=1;
      //5 , 25
      else if(weight>12.7&&weight<13.5)
        _type=2;
      //25 == 75
      else if(weight>=13.5&&weight<=15.07)
        _type=3;
      //75 90
      else if(weight>15.07&&weight<15.85)
        _type=4;
      //90 , up 90
      else if(weight>=15.85)
        _type=5;
    }
    else if(height>94.5&&height<=95.5)
    {
      if(weight<=12.9)
        _type=1;
      //5 , 25
      else if(weight>12.9&&weight<13.8)
        _type=2;
      //25 == 75
      else if(weight>=13.8&&weight<=15.3)
        _type=3;
      //75 90
      else if(weight>15.3&&weight<16.1)
        _type=4;
      //90 , up 90
      else if(weight>=16.1)
        _type=5;
    }
    else if(height>95.5&&height<=96.5)
    {
      if(weight<=13.1)
        _type=1;
      //5 , 25
      else if(weight>13.1&&weight<14.06)
        _type=2;
      //25 == 75
      else if(weight>=14.06&&weight<=15.60)
        _type=3;
      //75 90
      else if(weight>15.60&&weight<16.4)
        _type=4;
      //90 , up 90
      else if(weight>=16.4)
        _type=5;
    }
    else if(height>96.5&&height<=97.5)
    {
      if(weight<=13.3)
        _type=1;
      //5 , 25
      else if(weight>13.3&&weight<14.3)
        _type=2;
      //25 == 75
      else if(weight>=14.3&&weight<=15.8)
        _type=3;
      //75 90
      else if(weight>15.8&&weight<16.7)
        _type=4;
      //90 , up 90
      else if(weight>=16.7)
        _type=5;
    }
    else if(height>97.5&&height<=98.5)
    {
      if(weight<=13.6)
        _type=1;
      //5 , 25
      else if(weight>13.6&&weight<14.5)
        _type=2;
      //25 == 75
      else if(weight>=14.5&&weight<=16.1)
        _type=3;
      //75 90
      else if(weight>16.1&&weight<17.03)
        _type=4;
      //90 , up 90
      else if(weight>=17.03)
        _type=5;
    }
    else if(height>98.5&&height<=99.5)
    {
      if(weight<=13.8)
        _type=1;
      //5 , 25
      else if(weight>13.8&&weight<14.7)
        _type=2;
      //25 == 75
      else if(weight>=14.7&&weight<=16.4)
        _type=3;
      //75 90
      else if(weight>16.4&&weight<17.3)
        _type=4;
      //90 , up 90
      else if(weight>=17.3)
        _type=5;
    }
    else if(height>99.5&&height<=100.5)
    {
      if(weight<=14.08)
        _type=1;
      //5 , 25
      else if(weight>14.08&&weight<15.04)
        _type=2;
      //25 == 75
      else if(weight>=15.04&&weight<=16.73)
        _type=3;
      //75 90
      else if(weight>16.73&&weight<17.6)
        _type=4;
      //90 , up 90
      else if(weight>=17.6)
        _type=5;
    }
    else if(height>100.5&&height<=101.5)
    {
      if(weight<=14.3)
        _type=1;
      //5 , 25
      else if(weight>14.3&&weight<15.3)
        _type=2;
      //25 == 75
      else if(weight>=15.3&&weight<=17.02)
        _type=3;
      //75 90
      else if(weight>17.02&&weight<17.99)
        _type=4;
      //90 , up 90
      else if(weight>=17.99)
        _type=5;
    }
    else if(height>101.5&&height<=102.5)
    {
      if(weight<=14.5)
        _type=1;
      //5 , 25
      else if(weight>14.5&&weight<15.5)
        _type=2;
      //25 == 75
      else if(weight>=15.5&&weight<=17.3)
        _type=3;
      //75 90
      else if(weight>17.3&&weight<18.3)
        _type=4;
      //90 , up 90
      else if(weight>=18.3)
        _type=5;
    }
    else if(height>102.5&&height<=103.5)
    {
      if(weight<=14.8)
        _type=1;
      //5 , 25
      else if(weight>14.8&&weight<15.8)
        _type=2;
      //25 == 75
      else if(weight>=15.8&&weight<=17.6)
        _type=3;
      //75 90
      else if(weight>17.6&&weight<18.6)
        _type=4;
      //90 , up 90
      else if(weight>=18.6)
        _type=5;
    }
    else if(height>103.5&&height<=104.5)
    {
      if(weight<=15.09)
        _type=1;
      //5 , 25
      else if(weight>15.09&&weight<16.1)
        _type=2;
      //25 == 75
      else if(weight>=16.1&&weight<=17.9)
        _type=3;
      //75 90
      else if(weight>17.9&&weight<19.0)
        _type=4;
      //90 , up 90
      else if(weight>=19.0)
        _type=5;
    }
    else if(height>104.5&&height<=105.5)
    {
      if(weight<=15.3)
        _type=1;
      //5 , 25
      else if(weight>15.3&&weight<16.3)
        _type=2;
      //25 == 75
      else if(weight>=16.3&&weight<=18.2)
        _type=3;
      //75 90
      else if(weight>18.2&&weight<19.3)
        _type=4;
      //90 , up 90
      else if(weight>=19.3)
        _type=5;
    }
    else if(height>105.5&&height<=106.5)
    {
      if(weight<=15.63)
        _type=1;
      //5 , 25
      else if(weight>15.63&&weight<16.66)
        _type=2;
      //25 == 75
      else if(weight>=16.66&&weight<=18.58)
        _type=3;
      //75 90
      else if(weight>18.58&&weight<19.75)
        _type=4;
      //90 , up 90
      else if(weight>=19.75)
        _type=5;
    }
    else if(height>106.5&&height<=107.5)
    {
      if(weight<=15.9)
        _type=1;
      //5 , 25
      else if(weight>15.9&&weight<16.9)
        _type=2;
      //25 == 75
      else if(weight>=16.9&&weight<=18.92)
        _type=3;
      //75 90
      else if(weight>18.92&&weight<20.1)
        _type=4;
      //90 , up 90
      else if(weight>=20.1)
        _type=5;
    }
    else if(height>107.5&&height<=108.5)
    {
      if(weight<=16.19)
        _type=1;
      //5 , 25
      else if(weight>16.19&&weight<17.2)
        _type=2;
      //25 == 75
      else if(weight>=17.2&&weight<=19.2)
        _type=3;
      //75 90
      else if(weight>19.2&&weight<20.5)
        _type=4;
      //90 , up 90
      else if(weight>=20.5)
        _type=5;
    }
    else if(height>108.5&&height<=109.5)
    {
      if(weight<=16.4)
        _type=1;
      //5 , 25
      else if(weight>16.4&&weight<17.5)
        _type=2;
      //25 == 75
      else if(weight>=17.5&&weight<=19.60)
        _type=3;
      //75 90
      else if(weight>19.60&&weight<20.9)
        _type=4;
      //90 , up 90
      else if(weight>=20.9)
        _type=5;
    }
    else if(height>109.5&&height<=110.5)
    {
      if(weight<=16.7)
        _type=1;
      //5 , 25
      else if(weight>16.7&&weight<17.8)
        _type=2;
      //25 == 75
      else if(weight>=17.8&&weight<=19.9)
        _type=3;
      //75 90
      else if(weight>19.9&&weight<21.3)
        _type=4;
      //90 , up 90
      else if(weight>=21.3)
        _type=5;
    }
    else if(height>110.5&&height<=111.5)
    {
      if(weight<=17.08)
        _type=1;
      //5 , 25
      else if(weight>17.08&&weight<18.16)
        _type=2;
      //25 == 75
      else if(weight>=18.16&&weight<=20.3)
        _type=3;
      //75 90
      else if(weight>20.3&&weight<21.7)
        _type=4;
      //90 , up 90
      else if(weight>=21.7)
        _type=5;
    }
    else if(height>111.5&&height<=112.5)
    {
      if(weight<=17.39)
        _type=1;
      //5 , 25
      else if(weight>17.39&&weight<18.4)
        _type=2;
      //25 == 75
      else if(weight>=18.4&&weight<=20.68)
        _type=3;
      //75 90
      else if(weight>20.68&&weight<22.16)
        _type=4;
      //90 , up 90
      else if(weight>=22.16)
        _type=5;
    }
    else if(height>112.5&&height<=113.5)
    {
      if(weight<=17.7)
        _type=1;
      //5 , 25
      else if(weight>17.7&&weight<18.8)
        _type=2;
      //25 == 75
      else if(weight>=18.8&&weight<=21.05)
        _type=3;
      //75 90
      else if(weight>21.05&&weight<22.60)
        _type=4;
      //90 , up 90
      else if(weight>=22.60)
        _type=5;
    }
    else if(height>113.5&&height<=114.5)
    {
      if(weight<=18.02)
        _type=1;
      //5 , 25
      else if(weight>18.02&&weight<19.13)
        _type=2;
      //25 == 75
      else if(weight>=19.13&&weight<=21.43)
        _type=3;
      //75 90
      else if(weight>21.43&&weight<23.04)
        _type=4;
      //90 , up 90
      else if(weight>=23.04)
        _type=5;
    }
    else if(height>114.5&&height<=115.5)
    {
      if(weight<=18.35)
        _type=1;
      //5 , 25
      else if(weight>18.35&&weight<19.47)
        _type=2;
      //25 == 75
      else if(weight>=19.47&&weight<=21.82)
        _type=3;
      //75 90
      else if(weight>21.82&&weight<23.5)
        _type=4;
      //90 , up 90
      else if(weight>=23.5)
        _type=5;
    }
    else if(height>115.5&&height<=116.5)
    {
      if(weight<=18.6)
        _type=1;
      //5 , 25
      else if(weight>18.6&&weight<19.8)
        _type=2;
      //25 == 75
      else if(weight>=19.8&&weight<=22.2)
        _type=3;
      //75 90
      else if(weight>22.2&&weight<23.96)
        _type=4;
      //90 , up 90
      else if(weight>=23.96)
        _type=5;
    }
    else if(height>116.5&&height<=117.5)
    {
      if(weight<=19.01)
        _type=1;
      //5 , 25
      else if(weight>19.01&&weight<20.1)
        _type=2;
      //25 == 75
      else if(weight>=20.1&&weight<=22.6)
        _type=3;
      //75 90
      else if(weight>22.6&&weight<24.4)
        _type=4;
      //90 , up 90
      else if(weight>=24.4)
        _type=5;
    }
    else if(height>117.5&&height<=118.5)
    {
      if(weight<=19.35)
        _type=1;
      //5 , 25
      else if(weight>19.35&&weight<20.52)
        _type=2;
      //25 == 75
      else if(weight>=20.52&&weight<=23.0)
        _type=3;
      //75 90
      else if(weight>23.0&&weight<24.9)
        _type=4;
      //90 , up 90
      else if(weight>=24.9)
        _type=5;
    }
    else if(height>118.5&&height<=119.5)
    {
      if(weight<=19.69)
        _type=1;
      //5 , 25
      else if(weight>19.69&&weight<20.8)
        _type=2;
      //25 == 75
      else if(weight>=20.8&&weight<=23.48)
        _type=3;
      //75 90
      else if(weight>23.48&&weight<25.42)
        _type=4;
      //90 , up 90
      else if(weight>=25.42)
        _type=5;
    }
    else if(height>119.5&&height<=120.5)
    {
      if(weight<=20.04)
        _type=1;
      //5 , 25
      else if(weight>20.04&&weight<21.25)
        _type=2;
      //25 == 75
      else if(weight>=21.25&&weight<=23.91)
        _type=3;
      //75 90
      else if(weight>23.91&&weight<25.93)
        _type=4;
      //90 , up 90
      else if(weight>=25.93)
        _type=5;
    }
    else if(height>120.5)
    {
      if(weight<=20.3)
        _type=1;
      //5 , 25
      else if(weight>20.3&&weight<21.6)
        _type=2;
      //25 == 75
      else if(weight>=21.6&&weight<=24.3)
        _type=3;
      //75 90
      else if(weight>24.3&&weight<26.4)
        _type=4;
      //90 , up 90
      else if(weight>=26.4)
        _type=5;
    }

    return _type;
  }

  calculateTypeBoyWeight(){
    double mounth=calculateAllMounth(_user.birthdate);
    double weight=double.parse(_user.weight);
    int _type=0;

    List mounthList = [0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
      36,
    ];
    List sadak5 = [2.526904,
      2.964656,
      3.774849,
      4.503255,
      5.157412,
      5.744752,
      6.272175,
      6.745993,
      7.171952,
      7.555287,
      7.900755,
      8.212684,
      8.495,
      8.751264,
      8.984701,
      9.198222,
      9.394454,
      9.575757,
      9.744251,
      9.90183,
      10.05019,
      10.19082,
      10.32507,
      10.4541,
      10.57895,
      10.70051,
      10.81958,
      10.93681,
      11.0528,
      11.16803,
      11.28293,
      11.39782,
      11.513,
      11.62869,
      11.74508,
      11.8623,
      11.98046,
      12.03991,
    ]; List sadak25 = [3.150611,
      3.597396,
      4.428873,
      5.183378,
      5.866806,
      6.484969,
      7.043627,
      7.548346,
      8.004399,
      8.416719,
      8.789882,
      9.12811,
      9.435279,
      9.714942,
      9.970338,
      10.20442,
      10.41986,
      10.6191,
      10.80433,
      10.97753,
      11.14047,
      11.29477,
      11.44185,
      11.58298,
      11.7193,
      11.85182,
      11.98142,
      12.10889,
      12.23491,
      12.36007,
      12.4849,
      12.60983,
      12.73523,
      12.86144,
      12.9887,
      13.11723,
      13.24721,
      13.31278,

    ]; List sadak75 = [3.879077,
      4.387423,
      5.327328,
      6.175598,
      6.942217,
      7.635323,
      8.262033,
      8.828786,
      9.34149,
      9.805593,
      10.22612,
      10.60772,
      10.95466,
      11.27087,
      11.55996,
      11.82524,
      12.06973,
      12.29617,
      12.50708,
      12.70473,
      12.89117,
      13.06825,
      13.23765,
      13.40086,
      13.5592,
      13.71386,
      13.8659,
      14.01623,
      14.16567,
      14.31493,
      14.46462,
      14.61527,
      14.76732,
      14.92117,
      15.07711,
      15.23541,
      15.39628,
      15.47772,

    ];List sadak90 = [4.172493,
      4.718161,
      5.728153,
      6.638979,
      7.460702,
      8.202193,
      8.871384,
      9.475466,
      10.02101,
      10.51406,
      10.96017,
      11.36445,
      11.7316,
      12.06595,
      12.37145,
      12.65175,
      12.91015,
      13.14969,
      13.37311,
      13.5829,
      13.78133,
      13.97042,
      14.15201,
      14.32772,
      14.499,
      14.66716,
      14.83332,
      14.99848,
      15.16351,
      15.32917,
      15.4961,
      15.66485,
      15.83588,
      16.00958,
      16.18624,
      16.36612,
      16.5494,
      16.64237,

    ];
    for(int i=0;i<mounthList.length;i++ ){

      if(mounth<=mounthList[i]){
        if(weight<=sadak5[i]){
          _type=1;
          break;
        }
        else if(sadak5[i]<weight&&weight<sadak25[i]){
          _type=2;
          break;
        }
        else if(sadak25[i]<=weight&&weight<=sadak75[i]){
          _type=3;
          break;
        }
        else if(sadak75[i]<weight&&weight<sadak90[i]){
          _type=4;
          break;
        }
        else if(sadak90[i]<=weight){
          _type=5;
          break;
        }
      }

    }

    return _type;
  }
  calculateTypeBoyHeight(){
    double mounth=calculateAllMounth(_user.birthdate);
    double weight=double.parse(_user.height);
    int _type=0;
    List mounthList = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      36,

    ];
    List sadak5 = [
      45.56841,
      48.55809,
      52.72611,
      55.77345,
      58.23744,
      60.33647,
      62.18261,
      63.84166,
      65.35584,
      66.75398,
      68.05675,
      69.27949,
      70.43397,
      71.52941,
      72.57318,
      73.5713,
      74.52871,
      75.44958,
      76.33742,
      77.19523,
      78.0256,
      78.83077,
      79.61271,
      80.37315,
      81.11363,
      81.83552,
      82.58135,
      83.31105,
      84.02609,
      84.72769,
      85.41688,
      86.09452,
      86.76134,
      87.41799,
      88.06503,
      88.70301,
      89.33242,
    ]; List sadak25 = [
      48.18937,
      50.97919,
      54.9791,
      57.9744,
      60.43433,
      62.55409,
      64.43546,
      66.13896,
      67.70375,
      69.15682,
      70.51761,
      71.80065,
      73.01712,
      74.17581,
      75.2838,
      76.34685,
      77.36973,
      78.35646,
      79.31042,
      80.23453,
      81.13131,
      82.00292,
      82.85129,
      83.67811,
      84.48487,
      85.2729,
      86.03703,
      86.78329,
      87.51317,
      88.22788,
      88.9284,
      89.6156,
      90.2902,
      90.95287,
      91.60421,
      92.24482,
      92.87525,
    ]; List sadak75 = [51.77126,
      54.44054,
      58.35059,
      61.33788,
      63.82543,
      65.99131,
      67.92935,
      69.69579,
      71.32735,
      72.84947,
      74.2806,
      75.63462,
      76.92224,
      78.15196,
      79.33061,
      80.4638,
      81.5562,
      82.61174,
      83.63377,
      84.62515,
      85.58837,
      86.52562,
      87.43879,
      88.32957,
      89.19948,
      90.04985,
      90.8787,
      91.68468,
      92.46929,
      93.23385,
      93.97951,
      94.70732,
      95.41824,
      96.11319,
      96.79307,
      97.45873,
      98.11108,

    ];List sadak90 = [53.36153,
      56.03444,
      59.9664,
      62.98158,
      65.49858,
      67.69405,
      69.66122,
      71.45609,
      73.11525,
      74.6641,
      76.1211,
      77.50016,
      78.81202,
      80.0652,
      81.2666,
      82.42185,
      83.53568,
      84.61204,
      85.65431,
      86.66541,
      87.64786,
      88.60385,
      89.53533,
      90.44402,
      91.33143,
      92.19893,
      93.07143,
      93.91817,
      94.74064,
      95.54016,
      96.318,
      97.07531,
      97.81324,
      98.53287,
      99.23531,
      99.92162,
      100.5929,

    ];
    for(int i=0;i<mounthList.length;i++ ){

      if(mounth<=mounthList[i]){
        if(weight<=sadak5[i]){
          _type=1;
          break;
        }
        else if(sadak5[i]<weight&&weight<sadak25[i]){
          _type=2;
          break;
        }
        else if(sadak25[i]<=weight&&weight<=sadak75[i]){
          _type=3;
          break;
        }
        else if(sadak75[i]<weight&&weight<sadak90[i]){
          _type=4;
          break;
        }
        else if(sadak90[i]<=weight){
          _type=5;
          break;
        }
      }

    }

    return _type;
  }
  calculateTypeGirlWeight(){
    double mounth=calculateAllMounth(_user.birthdate);
    double weight=double.parse(_user.weight);
    int _type=0;

    List mounthList = [
      0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      35.5,
      36

    ];
    List sadak5 = [
      2.547905,
      2.894442,
      3.54761,
      4.150639,
      4.707123,
      5.220488,
      5.693974,
      6.130641,
      6.533373,
      6.904886,
      7.247736,
      7.564327,
      7.856916,
      8.127621,
      8.378425,
      8.611186,
      8.827638,
      9.029399,
      9.21798,
      9.394782,
      9.56111,
      9.71817,
      9.867081,
      10.00887,
      10.1445,
      10.27483,
      10.40066,
      10.52274,
      10.64171,
      10.75819,
      10.87273,
      10.98581,
      11.09789,
      11.20934,
      11.32054,
      11.43177,
      11.54332,
      11.59929,

    ]; List sadak25 = [
      3.064865,
      3.437628,
      4.138994,
      4.78482,
      5.379141,
      5.925888,
      6.428828,
      6.891533,
      7.317373,
      7.709516,
      8.070932,
      8.4044,
      8.712513,
      8.997692,
      9.262185,
      9.508085,
      9.737329,
      9.951715,
      10.1529,
      10.34241,
      10.52167,
      10.69196,
      10.85446,
      11.01027,
      11.16037,
      11.30567,
      11.44697,
      11.58501,
      11.72047,
      11.85392,
      11.98592,
      12.11692,
      12.24735,
      12.37757,
      12.50791,
      12.63865,
      12.77001,
      12.836,

    ]; List sadak75 = [3.717519,
      4.145594,
      4.946766,
      5.680083,
      6.351512,
      6.966524,
      7.53018,
      8.047178,
      8.521877,
      8.958324,
      9.360271,
      9.731193,
      10.07431,
      10.39258,
      10.68874,
      10.96532,
      11.22463,
      11.46878,
      11.69972,
      11.91921,
      12.12887,
      12.33016,
      12.52439,
      12.71277,
      12.89636,
      13.07613,
      13.25293,
      13.42753,
      13.60059,
      13.77271,
      13.9444,
      14.11611,
      14.28822,
      14.46106,
      14.63491,
      14.80998,
      14.98647,
      15.07529,

    ];List sadak90 = [
      3.992572,
      4.450126,
      5.305632,
      6.087641,
      6.80277,
      7.457119,
      8.056331,
      8.605636,
      9.109878,
      9.573546,
      10.00079,
      10.39545,
      10.76106,
      11.10089,
      11.41792,
      11.71491,
      11.99438,
      12.25862,
      12.50974,
      12.74964,
      12.98004,
      13.2025,
      13.41844,
      13.62911,
      13.83564,
      14.03902,
      14.24017,
      14.43984,
      14.63873,
      14.83743,
      15.03646,
      15.23626,
      15.43719,
      15.63957,
      15.84365,
      16.04963,
      16.25767,
      16.3625,
    ];
    for(int i=0;i<mounthList.length;i++ ){

      if(mounth<=mounthList[i]){
        if(weight<=sadak5[i]){
          _type=1;
          break;
        }
        else if(sadak5[i]<weight&&weight<sadak25[i]){
          _type=2;
          break;
        }
        else if(sadak25[i]<=weight&&weight<=sadak75[i]){
          _type=3;
          break;
        }
        else if(sadak75[i]<weight&&weight<sadak90[i]){
          _type=4;
          break;
        }
        else if(sadak90[i]<=weight){
          _type=5;
          break;
        }
      }

    }

    return _type;
  }
  calculateTypeGirlHeight(){
    double mounth=calculateAllMounth(_user.birthdate);
    double weight=double.parse(_user.height);
    int _type=0;

    List mounthList = [0,
      0.5,
      1.5,
      2.5,
      3.5,
      4.5,
      5.5,
      6.5,
      7.5,
      8.5,
      9.5,
      10.5,
      11.5,
      12.5,
      13.5,
      14.5,
      15.5,
      16.5,
      17.5,
      18.5,
      19.5,
      20.5,
      21.5,
      22.5,
      23.5,
      24.5,
      25.5,
      26.5,
      27.5,
      28.5,
      29.5,
      30.5,
      31.5,
      32.5,
      33.5,
      34.5,
      36,

    ];
    List sadak5 = [
      45.57561,
      47.96324,
      51.47996,
      54.17907,
      56.43335,
      58.40032,
      60.16323,
      61.77208,
      63.25958,
      64.64845,
      65.9552,
      67.19226,
      68.36925,
      69.4938,
      70.57207,
      71.60911,
      72.60914,
      73.57571,
      74.51184,
      75.42012,
      76.30282,
      77.16191,
      77.9991,
      78.81595,
      79.61381,
      80.39391,
      81.18804,
      81.97223,
      82.74084,
      83.48951,
      84.21496,
      84.91494,
      85.58809,
      86.23379,
      86.85208,
      87.44359,
      88.00937,

    ]; List sadak25 = [
      47.68345,
      50.09686,
      53.69078,
      56.47125,
      58.80346,
      60.84386,
      62.6759,
      64.35005,
      65.89952,
      67.34745,
      68.7107,
      70.00202,
      71.23128,
      72.40633,
      73.53349,
      74.61799,
      75.66416,
      76.67568,
      77.65565,
      78.60678,
      79.53138,
      80.4315,
      81.30893,
      82.16525,
      83.00187,
      83.82007,
      84.67209,
      85.5036,
      86.31151,
      87.09346,
      87.84783,
      88.57362,
      89.27042,
      89.93835,
      90.57795,
      91.1902,
      91.77639,

    ]; List sadak75 = [51.0187,
      53.36362,
      56.93136,
      59.74045,
      62.1233,
      64.22507,
      66.12418,
      67.8685,
      69.48975,
      71.01019,
      72.44614,
      73.80997,
      75.11133,
      76.35791,
      77.55594,
      78.71058,
      79.82613,
      80.90623,
      81.95399,
      82.97211,
      83.96292,
      84.92846,
      85.87054,
      86.79077,
      87.69056,
      88.57121,
      89.50562,
      90.40982,
      91.28258,
      92.12313,
      92.93113,
      93.70662,
      94.45005,
      95.16218,
      95.84411,
      96.49721,
      97.12307,

    ];List sadak90 = [
      52.7025,
      54.96222,
      58.45612,
      61.24306,
      63.62648,
      65.74096,
      67.65995,
      69.42868,
      71.07731,
      72.62711,
      74.09378,
      75.48923,
      76.82282,
      78.10202,
      79.3329,
      80.5205,
      81.66903,
      82.78208,
      83.86269,
      84.91353,
      85.93689,
      86.93481,
      87.90908,
      88.86127,
      89.79282,
      90.70499,
      91.67718,
      92.61658,
      93.52227,
      94.39371,
      95.23082,
      96.03385,
      96.80343,
      97.54052,
      98.24636,
      98.92246,
      99.57056,

    ];
    for(int i=0;i<mounthList.length;i++ ){

      if(mounth<=mounthList[i]){
        if(weight<=sadak5[i]){
          _type=1;
          break;
        }
        else if(sadak5[i]<weight&&weight<sadak25[i]){
          _type=2;
          break;
        }
        else if(sadak25[i]<=weight&&weight<=sadak75[i]){
          _type=3;
          break;
        }
        else if(sadak75[i]<weight&&weight<sadak90[i]){
          _type=4;
          break;
        }
        else if(sadak90[i]<=weight){
          _type=5;
          break;
        }
      }

    }

    return _type;
  }

  calculateCal2_3(int type,String regim) {
    switch (regim) {
      case "children25-27":
        {
          if (type == 1)
            return 900;
          else if (type == 2)
            return 700;
          else if (type == 3)
            return 500;
        }
        break;
      case "children28-30":
        {
          if (type == 1)
            return 1100;
          else if (type == 2)
            return 900;
          else if (type == 3)
            return 700;
        }
        break;

      case "children31-33":
        {
          if (type == 1)
            return 1300;
          else if (type == 2)
            return 1100;
          else if (type == 3)
            return 900;
        }
        break;

      case "children34-36":
        {
          if (type == 1)
            return 1500;
          else if (type == 2)
            return 1300;
          else if (type == 3)
            return 1100;
        }
        break;
    }




  }

  Future<void> callApi(String returnVal) async {


    print("callApi"+returnVal+"callApi");
    if(calculateAllMounth(_user.birthdate)<24){
      int type2;
      String type2Str="normal";
      if(calculateAllMounth(_user.birthdate)>=12){
        _user.gender=="female"
            ?type2=calculateTypeGirl()
            :type2=calculateTypeBoy();


        switch (type2){
          case (1):
            type2Str="low";
            break;
          case (2):
            type2Str="normal";
            break;
          case (3):
            type2Str="extra";
            break;

        }
      }
      print(type2Str);
      if(await checkConnectionInternet())
        goLuncher(returnVal,type2Str);

      else showSnakBar('اتصال به اینترنت را بررسی کنید.');
    }
    else{
      int type2;
        _user.gender=="female"
            ?type2=calculateTypeGirl()
            :type2=calculateTypeBoy();
      int calorie=calculateCal2_3(type2,returnVal);

//      if(calorie<600)calorie=600;

if(await checkConnectionInternet()){
  Navigator.pop(context);

  ////tamdid regim
  if(widget.dietId!=null){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child:widget.selfId==null
                  ?LoginScreen(type: "children2-3",url :"https://api2.barikaapp.com/api/v3/diets/children/${widget.uidDiet}?"
                  "user_name=${_user.name}&"
                  "user_height=${_user.height}&"
                  "user_weight=${_user.weight}&"
                  "user_birthdate=${_user.birthdate}&"
                  "user_sex=${_user.gender}&"
                  "user_appetite=${_user.appetite}&"
                  "user_activity=${_user.activity}&"
                  "dietId=${widget.dietId}&"
                  // "selfId=${widget.selfId}&"
                  "type=children2-3&"
                  "type2=$calorie",
                  metype: "children",user: _user,uid:widget.uidDiet ,edit: widget.edit,counter: 0,dietId:  widget.dietId,)

                  : LoginScreen(type: "children2-3",url :"https://api2.barikaapp.com/api/v3/diets/children/${widget.uidDiet}?"
                  "user_name=${_user.name}&"
                  "user_height=${_user.height}&"
                  "user_weight=${_user.weight}&"
                  "user_birthdate=${_user.birthdate}&"
                  "user_sex=${_user.gender}&"
                  "user_appetite=${_user.appetite}&"
                  "user_activity=${_user.activity}&"
                  "dietId=${widget.dietId}&"
                  "selfId=${widget.selfId}&"
                  "type=children2-3&"
                  "type2=$calorie",
                metype: "children",user: _user,uid:widget.uidDiet ,edit: widget.edit,counter: 0,dietId:  widget.dietId,)

//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
        )),
      );}
  else{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child:widget.selfId==null
                ?LoginScreen(type: "children2-3",url :"https://api2.barikaapp.com/api/v3/diets/children/${widget.uidDiet}?"
                "user_name=${_user.name}&"
                "user_height=${_user.height}&"
                "user_weight=${_user.weight}&"
                "user_birthdate=${_user.birthdate}&"
                "user_sex=${_user.gender}&"
                "user_appetite=${_user.appetite}&"
                "user_activity=${_user.activity}&"
                // "dietId=${widget.dietId}&"
                // "selfId=${widget.selfId}&"
                "type=children2-3&"
                "type2=$calorie",
              metype: "children",user: _user,uid:widget.uidDiet ,edit: widget.edit,counter: 0,dietId: widget.dietId)
                : LoginScreen(type: "children2-3",url :"https://api2.barikaapp.com/api/v3/diets/children/${widget.uidDiet}?"
                "user_name=${_user.name}&"
                "user_height=${_user.height}&"
                "user_weight=${_user.weight}&"
                "user_birthdate=${_user.birthdate}&"
                "user_sex=${_user.gender}&"
                "user_appetite=${_user.appetite}&"
                "user_activity=${_user.activity}&"
                // "dietId=${widget.dietId}&"
                "selfId=${widget.selfId}&"
                "type=children2-3&"
                "type2=$calorie",
              metype: "children",user: _user,uid:widget.uidDiet ,edit: widget.edit,counter: 0,dietId: widget.dietId,)),

//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
      ),
    );
  }
}
else showSnakBar('اتصال به اینترنت را بررسی کنید.');



    }

    setState(() {
      showLoading=false;
    });
}

  showSnakBar(String s) {
    setState(() {
      showLoading=false;
    });
    _scaffoldKey.currentState.showSnackBar( SnackBar(
      duration:  Duration(seconds: 2),
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

  String setStatusHeight() {
    if(_user!=null){

      int type=
      _user.gender=="female"
          ? calculateTypeGirlHeight()
          :  calculateTypeBoyHeight();

      switch (type){
        case 1:
          return "از نظر رشد قدی، موقعيت فعلي كودک شما زير صدک 5 است و کوتاه قد محسوب ميشود.";
          break;
        case 2:
          return "از نظر رشد قدی، موقعيت فعلي كودک شما بين صدک 5-25 است و نسبتا کوتاه قد محسوب ميشود.";
          break;
        case 3:
          return "از نظر رشد قدی، موقعيت فعلي كودک شما بين صدک 25-75 است و در محدوده نرمال ميباشد.";
          break;
        case 4:
          return "از نظر رشد قدی، موقعيت فعلي كودک شما بين صدک 75-90 است و نسبتا بلند قد میباشد.";
          break;
        case 5:
          return "از نظر رشد قدی، موقعيت فعلي كودک شما بالاتر از صدک  90 است و  بلند قد ميباشد.";
          break;
        default: {
          return "";
        }
        break;
      }

    }
    else return"";
  }
  String setStatusWeight() {
    if(_user!=null){

      int type=
      _user.gender=="female"
          ? calculateTypeGirlWeight()
          :  calculateTypeBoyWeight();

      switch (type){
        case 1:
          return "از نظر رشد وزني، موقعيت فعلي كودک شما زير صدک 5 است و كم وزن محسوب ميشود.";
          break;
        case 2:
          return "از نظر رشد وزني، موقعيت فعلي كودک شما بين صدک 5-25 است و نسبتا كم وزن محسوب ميشود.";
          break;
        case 3:
          return "از نظر رشد وزني، موقعيت فعلي كودک شما بين صدک 25-75 است و در محدوده نرمال ميباشد.";
          break;
        case 4:
          return "از نظر رشد وزني، موقعيت فعلي كودک شما بين صدک 75-90 است و نسبتا داراي اضافه وزن میباشد.";
          break;
        case 5:
          return "از نظر رشد وزني، موقعيت فعلي كودک شما بالاتر از صدک  90 است و داراي اضافه وزن ميباشد.";
          break;

      }

    }
    else return"";
  }
  Future<void> goLuncher(returnVal,type2Str) async {

    setState(() {
      _isLoading=true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user_token');
    try {
        final response = await Provider.of<apiServices>(context, listen: false)
          .getDietChild(
          widget.uidDiet,
            _user.name,
            _user.height,
            _user.weight,
            _user.birthdate,
            _user.gender,
            _user.appetite,
            _user.activity,
            widget.dietId!=null ? widget.dietId.toString():null,
            selfId!=null ? selfId.toString():null,
            returnVal,
            type2Str,
            'Bearer ' + apiToken

        );

      print(response.bodyString);
      print(returnVal);
      print(type2Str);
        final post = json.decode(response.bodyString);
      if (response.statusCode == 200 && post["msg"]=="success" ) {
        int logId= post["logId"];
        if(post["msg"]=="success"){
          Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Directionality(
                    textDirection: TextDirection
                        .rtl, child: pishFactor(dietType: returnVal, diet:"children",returnVal:"zir2",edit:widget.edit,uidDiet:widget.uidDiet,dietId: widget.dietId,)),
          ),
        );}
      } else {
        showSnakBar("خطا در دریافت اطلاعات");
        setState(() {

          _isLoading=false;
        });
        print(response.statusCode.toString() + "error");
      }
    }catch (e) {
      showSnakBar("خطا در دریافت اطلاعات");
      setState(() {
        _isLoading=false;
      });
      print(e.toString() + "catttttch");
    }




  }

  Future<void> callApi2_3() async {
    print("inja"+month.toString());
   if( month>=24&&month<=26)
  {
    print("inja"+month.toString());
    await callApi("children25-27");}

   else if( month>26&&month<=29)
     await callApi("children28-30");

   else if( month>29&&month<=32)
     await callApi("children31-33")
   ;
   else if( month>32&&month<=36)
     await callApi("children34-36");



  }

}

class LinearSales {
  final double year;
  final double sales;

  LinearSales(this.year, this.sales);
}
