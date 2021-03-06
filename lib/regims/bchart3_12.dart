
import 'package:barika_web/home/logiin.dart';
import 'package:barika_web/models/user.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../helper.dart';

class bchart3_12 extends StatefulWidget {
  User user;
  String uidDiet;
  String selfId;
  String dietId;
  //baraye tamdid
  bool edit;
  bchart3_12({Key key, this.user,this.uidDiet,this.selfId,this.edit,this.dietId}) : super(key: key);

  State<StatefulWidget> createState() => bchart3_12State();
}

class bchart3_12State extends State<bchart3_12> {
  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }
  String selfId;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _user;
  double month = 0;
  int act=0;
  bool showLoading=false;
  @override
  void initState() {
    selfId=widget.selfId;
    _user = widget.user;
    act=int.parse(_user.activity);
    month = (calculateAllMounth(_user.birthdate));
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

    return Directionality(textDirection: TextDirection.ltr, child:  Scaffold(
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
                            'نمودار وزن دختران 2 تا 12 سال',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: new charts.LineChart(
                              _girlWeghitYear(),
                              primaryMeasureAxis: new charts.NumericAxisSpec(
                                showAxisLine: true,

                                tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 7,
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


                                new charts.ChartTitle('وزن (کیلوگرم)',
                                    titleStyleSpec: charts.TextStyleSpec(
                                        fontSize: 12*fontvar.round()),
                                    behaviorPosition: charts.BehaviorPosition
                                        .start,
                                    titleOutsideJustification:
                                    charts.OutsideJustification.middle),


                                new charts.ChartTitle('سن (سال)',
                                    titleStyleSpec: charts.TextStyleSpec(
                                        fontSize: 12*fontvar.round()),
                                    behaviorPosition: charts.BehaviorPosition
                                        .bottom,
                                    titleOutsideJustification:
                                    charts.OutsideJustification.middle),

                              ],
                              // Disable ani
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
                            'نمودار وزن پسران 2 تا 12 سال',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                                _boyWeghitYear(),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 7,
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


                                  new charts.ChartTitle('وزن (کیلوگرم)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (سال)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .bottom,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),

                                ],
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
                  width: screenSize
                      .width,
                  padding: EdgeInsets.only(right: 5),
                  margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                  child:
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 12, bottom: 4),
                    child: Text(setStatusWeight(), textDirection: TextDirection.rtl, style: TextStyle(
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
                            'نمودار قد دختران 2 تا 12 سال',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                                _girlHeightYear(),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 6,
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


                                  new charts.ChartTitle('سن (سال)',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .bottom,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),

                                ],
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
                            'نمودار قد پسران 2 تا 12 سال',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: new charts.LineChart(
                                _boyHeightYear(),

                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 6,
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


                                  new charts.ChartTitle('سن (سال)',
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
                  width: screenSize
                      .width,
                  padding: EdgeInsets.only(right: 5),
                  margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                  child:
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 12, bottom: 4),
                    child: Text(setStatusHeight(), textDirection: TextDirection.rtl, style: TextStyle(
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
                            'نمودار BMI دختران',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Expanded(
                              child: new charts.LineChart(
                                _girlBmi(),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 7,
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


                                  new charts.ChartTitle('BMI',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (سال)',
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
                                      'BMI شما',
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
                            'نمودار BMI پسران',
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 13*fontvar,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Expanded(
                              child: new charts.LineChart(
                                _boyBmi(),

//    primaryMeasureAxis: new charts.NumericAxisSpec(
//    tickProviderSpec:
//    new charts.BasicNumericTickProviderSpec(zeroBound: false)));
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  showAxisLine: true,

                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(
                                    desiredTickCount: 7,
                                    zeroBound: false,

                                  ),
                                ),
                                domainAxis: charts.NumericAxisSpec(
                                  showAxisLine: true,
                                  tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(
                                    zeroBound: false,
                                    desiredTickCount: 7,

                                  ),
                                ),
                                behaviors: [


                                  new charts.ChartTitle('BMI',
                                      titleStyleSpec: charts.TextStyleSpec(
                                          fontSize: 12*fontvar.round()),
                                      behaviorPosition: charts.BehaviorPosition
                                          .start,
                                      titleOutsideJustification:
                                      charts.OutsideJustification.middle),


                                  new charts.ChartTitle('سن (سال)',
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
                                      'BMI شما',
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
                  width: screenSize
                      .width,
                  padding: EdgeInsets.only(right: 5),
                  margin: EdgeInsets.only(right: 12, left: 12, top: 15),
                  child:
                  Padding(
                    padding: EdgeInsets.only(
                        right: 12, top: 12, bottom: 4),
                    child: Text(setStatusBmi(), textDirection: TextDirection.rtl, style: TextStyle(
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
                          width: screenSize
                              .width,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                              color: MyColors.green,
                              onPressed: () async {
                                setState(() {
                                  showLoading=true;
                                });
                                callApi();
                              },
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

  ///// نمودار BMI برای دختران 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _girlBmi() {


    double bmi = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    print(bmi.toString()+"it is bmi");
    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),bmi)
    ];

    final _listsadak5 = [
      14.39787,
      14.38019,
      14.34527,
      14.31097,
      14.27728,
      14.2442,
      14.21175,
      14.17992,
      14.14871,
      14.11813,
      14.08818,
      14.05885,
      14.03016,
      14.00209,
      13.97466,
      13.94786,
      13.92169,
      13.89615,
      13.87124,
      13.84697,
      13.82333,
      13.80033,
      13.77796,
      13.75624,
      13.73516,
      13.71472,
      13.69493,
      13.67579,
      13.65731,
      13.63948,
      13.62231,
      13.6058,
      13.58997,
      13.5748,
      13.56031,
      13.54649,
      13.53336,
      13.52091,
      13.50915,
      13.49808,
      13.4877,
      13.47802,
      13.46903,
      13.46075,
      13.45317,
      13.4463,
      13.44013,
      13.43467,
      13.42991,
      13.42587,
      13.42254,
      13.41992,
      13.41801,
      13.41681,
      13.41632,
      13.41654,
      13.41748,
      13.41912,
      13.42147,
      13.42453,
      13.42829,
      13.43276,
      13.43793,
      13.4438,
      13.45037,
      13.45764,
      13.4656,
      13.47425,
      13.48359,
      13.49362,
      13.50432,
      13.51571,
      13.52777,
      13.5405,
      13.5539,
      13.56797,
      13.58269,
      13.59807,
      13.6141,
      13.63077,
      13.64809,
      13.66605,
      13.68463,
      13.70384,
      13.72368,
      13.74413,
      13.76519,
      13.78685,
      13.80911,
      13.83197,
      13.85541,
      13.87943,
      13.90402,
      13.92918,
      13.9549,
      13.98118,
      14.008,
      14.03535,
      14.06324,
      14.09166,
      14.12059,
      14.15003,
      14.17997,
      14.21041,
      14.24133,
      14.27272,
      14.30459,
      14.33691,
      14.36969,
      14.4029,
      14.43656,
      14.47063,
      14.50512,
      14.54002,
      14.57531,
      14.61099,
      14.64705,
      14.68347,
      14.72025,
      14.75737,
      14.79484,
      14.83262,

    ];

    final _listsadak15 = [
      14.80134,
      14.77965,
      14.73695,
      14.69516,
      14.65429,
      14.61434,
      14.57531,
      14.5372,
      14.50003,
      14.46378,
      14.42846,
      14.39406,
      14.3606,
      14.32806,
      14.29645,
      14.26576,
      14.23599,
      14.20714,
      14.1792,
      14.15218,
      14.12606,
      14.10084,
      14.07653,
      14.05311,
      14.03059,
      14.00895,
      13.9882,
      13.96833,
      13.94933,
      13.93121,
      13.91396,
      13.89757,
      13.88205,
      13.86739,
      13.85358,
      13.84062,
      13.82852,
      13.81726,
      13.80684,
      13.79726,
      13.78852,
      13.78061,
      13.77353,
      13.76728,
      13.76185,
      13.75724,
      13.75345,
      13.75047,
      13.7483,
      13.74694,
      13.74637,
      13.74661,
      13.74764,
      13.74946,
      13.75206,
      13.75544,
      13.75961,
      13.76454,
      13.77024,
      13.7767,
      13.78393,
      13.7919,
      13.80063,
      13.8101,
      13.8203,
      13.83124,
      13.8429,
      13.85529,
      13.86839,
      13.88221,
      13.89673,
      13.91194,
      13.92785,
      13.94445,
      13.96173,
      13.97968,
      13.99829,
      14.01757,
      14.03751,
      14.05809,
      14.07931,
      14.10116,
      14.12364,
      14.14675,
      14.17046,
      14.19478,
      14.2197,
      14.2452,
      14.27129,
      14.29796,
      14.32519,
      14.35298,
      14.38132,
      14.4102,
      14.43962,
      14.46957,
      14.50003,
      14.531,
      14.56247,
      14.59444,
      14.62688,
      14.6598,
      14.69319,
      14.72703,
      14.76132,
      14.79605,
      14.8312,
      14.86677,
      14.90275,
      14.93913,
      14.9759,
      15.01305,
      15.05056,
      15.08844,
      15.12666,
      15.16522,
      15.20411,
      15.24332,
      15.28283,
      15.32264,
      15.36274,
      15.40311,

    ];
    List<double> _listsadak25 = [
      15.52808,
      15.49976,
      15.44422,
      15.39015,
      15.33754,
      15.2864,
      15.23671,
      15.18848,
      15.14171,
      15.09638,
      15.0525,
      15.01007,
      14.96907,
      14.9295,
      14.89136,
      14.85465,
      14.81934,
      14.78544,
      14.75293,
      14.7218,
      14.69205,
      14.66365,
      14.63661,
      14.61091,
      14.58652,
      14.56345,
      14.54167,
      14.52117,
      14.50194,
      14.48396,
      14.46721,
      14.45169,
      14.43738,
      14.42427,
      14.41233,
      14.40156,
      14.39194,
      14.38345,
      14.37609,
      14.36984,
      14.36469,
      14.36062,
      14.35762,
      14.35567,
      14.35478,
      14.35491,
      14.35606,
      14.35823,
      14.36138,
      14.36552,
      14.37063,
      14.3767,
      14.38372,
      14.39168,
      14.40056,
      14.41035,
      14.42104,
      14.43263,
      14.44509,
      14.45842,
      14.47261,
      14.48765,
      14.50352,
      14.52021,
      14.53772,
      14.55603,
      14.57513,
      14.59501,
      14.61566,
      14.63706,
      14.65922,
      14.68211,
      14.70572,
      14.73005,
      14.75508,
      14.78081,
      14.80722,
      14.8343,
      14.86204,
      14.89043,
      14.91946,
      14.94911,
      14.97938,
      15.01026,
      15.04173,
      15.07378,
      15.10641,
      15.1396,
      15.17334,
      15.20762,
      15.24242,
      15.27775,
      15.31358,
      15.3499,
      15.38671,
      15.42399,
      15.46173,
      15.49992,
      15.53855,
      15.57761,
      15.61709,
      15.65696,
      15.69724,
      15.73789,
      15.77891,
      15.8203,
      15.86203,
      15.9041,
      15.94649,
      15.98919,
      16.0322,
      16.07549,
      16.11907,
      16.1629,
      16.207,
      16.25134,
      16.2959,
      16.34069,
      16.38568,
      16.43087,
      16.47625,
      16.52179,

    ];

    List<double> _listsadak50 = [
      16.4234,
      16.38804,
      16.31897,
      16.25208,
      16.18735,
      16.12475,
      16.06429,
      16.00593,
      15.94967,
      15.89548,
      15.84336,
      15.79329,
      15.74526,
      15.69924,
      15.65523,
      15.61321,
      15.57317,
      15.53508,
      15.49893,
      15.4647,
      15.43238,
      15.40193,
      15.37335,
      15.34661,
      15.32168,
      15.29855,
      15.27719,
      15.25757,
      15.23967,
      15.22347,
      15.20894,
      15.19606,
      15.1848,
      15.17513,
      15.16703,
      15.16047,
      15.15543,
      15.15188,
      15.1498,
      15.14917,
      15.14995,
      15.15213,
      15.15567,
      15.16056,
      15.16678,
      15.17429,
      15.18309,
      15.19313,
      15.20441,
      15.2169,
      15.23058,
      15.24543,
      15.26142,
      15.27854,
      15.29676,
      15.31607,
      15.33644,
      15.35785,
      15.38029,
      15.40374,
      15.42817,
      15.45357,
      15.47991,
      15.50718,
      15.53537,
      15.56444,
      15.59439,
      15.6252,
      15.65684,
      15.6893,
      15.72257,
      15.75662,
      15.79143,
      15.827,
      15.86329,
      15.9003,
      15.93802,
      15.97641,
      16.01546,
      16.05517,
      16.09551,
      16.13646,
      16.17801,
      16.22014,
      16.26284,
      16.30609,
      16.34988,
      16.39418,
      16.43899,
      16.48428,
      16.53005,
      16.57627,
      16.62293,
      16.67002,
      16.71751,
      16.7654,
      16.81368,
      16.86231,
      16.9113,
      16.96062,
      17.01026,
      17.06021,
      17.11045,
      17.16097,
      17.21174,
      17.26277,
      17.31403,
      17.36551,
      17.41719,
      17.46907,
      17.52112,
      17.57333,
      17.6257,
      17.6782,
      17.73082,
      17.78356,
      17.83638,
      17.88929,
      17.94227,
      17.99531,
      18.04838,
      18.10149,

    ];

    List<double> _listsadak75 = [
      17.42746,
      17.38582,
      17.30485,
      17.22693,
      17.15202,
      17.08009,
      17.01107,
      16.94495,
      16.88168,
      16.82123,
      16.76355,
      16.70862,
      16.65641,
      16.60687,
      16.55998,
      16.5157,
      16.474,
      16.43486,
      16.39824,
      16.36411,
      16.33244,
      16.3032,
      16.27636,
      16.25188,
      16.22973,
      16.20988,
      16.19229,
      16.17693,
      16.16378,
      16.15278,
      16.14391,
      16.13714,
      16.13242,
      16.12972,
      16.12901,
      16.13025,
      16.1334,
      16.13843,
      16.14531,
      16.154,
      16.16446,
      16.17665,
      16.19056,
      16.20613,
      16.22334,
      16.24214,
      16.26252,
      16.28443,
      16.30785,
      16.33273,
      16.35906,
      16.38679,
      16.41589,
      16.44633,
      16.47809,
      16.51113,
      16.54542,
      16.58094,
      16.61764,
      16.65551,
      16.69451,
      16.73462,
      16.7758,
      16.81803,
      16.86129,
      16.90553,
      16.95075,
      16.9969,
      17.04396,
      17.09191,
      17.14072,
      17.19037,
      17.24082,
      17.29206,
      17.34405,
      17.39678,
      17.45022,
      17.50434,
      17.55912,
      17.61454,
      17.67057,
      17.7272,
      17.78438,
      17.84212,
      17.90037,
      17.95912,
      18.01835,
      18.07803,
      18.13815,
      18.19867,
      18.25959,
      18.32088,
      18.38251,
      18.44447,
      18.50675,
      18.5693,
      18.63213,
      18.6952,
      18.7585,
      18.82202,
      18.88572,
      18.94959,
      19.01362,
      19.07779,
      19.14207,
      19.20645,
      19.27091,
      19.33544,
      19.40001,
      19.46462,
      19.52924,
      19.59386,
      19.65846,
      19.72302,
      19.78754,
      19.85199,
      19.91636,
      19.98063,
      20.0448,
      20.10884,
      20.17274,
      20.23648,

    ];

    List<double> _listsadak85 = [
      18.01821,
      17.97371,
      17.88749,
      17.80489,
      17.72586,
      17.65035,
      17.5783,
      17.50965,
      17.44435,
      17.38235,
      17.3236,
      17.26804,
      17.21564,
      17.16634,
      17.12009,
      17.07685,
      17.03658,
      16.99923,
      16.96476,
      16.93312,
      16.90428,
      16.8782,
      16.85483,
      16.83413,
      16.81606,
      16.80058,
      16.78765,
      16.77723,
      16.76927,
      16.76375,
      16.7606,
      16.75981,
      16.76132,
      16.76509,
      16.77108,
      16.77925,
      16.78956,
      16.80197,
      16.81644,
      16.83292,
      16.85138,
      16.87177,
      16.89405,
      16.91819,
      16.94415,
      16.97187,
      17.00134,
      17.03249,
      17.06531,
      17.09974,
      17.13575,
      17.17331,
      17.21237,
      17.2529,
      17.29485,
      17.3382,
      17.38291,
      17.42894,
      17.47626,
      17.52482,
      17.5746,
      17.62557,
      17.67768,
      17.7309,
      17.7852,
      17.84055,
      17.89692,
      17.95426,
      18.01256,
      18.07177,
      18.13187,
      18.19283,
      18.2546,
      18.31718,
      18.38051,
      18.44458,
      18.50936,
      18.57481,
      18.64091,
      18.70762,
      18.77493,
      18.8428,
      18.91121,
      18.98012,
      19.04952,
      19.11937,
      19.18965,
      19.26034,
      19.3314,
      19.40282,
      19.47457,
      19.54662,
      19.61895,
      19.69154,
      19.76436,
      19.83739,
      19.91061,
      19.984,
      20.05753,
      20.13118,
      20.20493,
      20.27876,
      20.35264,
      20.42657,
      20.50052,
      20.57446,
      20.64838,
      20.72227,
      20.79609,
      20.86984,
      20.94349,
      21.01703,
      21.09045,
      21.16371,
      21.23681,
      21.30974,
      21.38246,
      21.45498,
      21.52727,
      21.59931,
      21.67111,
      21.74263,

    ];

    List<double> _listsadak90 = [
      18.44139,
      18.39526,
      18.30611,
      18.22103,
      18.13997,
      18.06285,
      17.98962,
      17.92019,
      17.85452,
      17.79253,
      17.73416,
      17.67936,
      17.62805,
      17.58019,
      17.53571,
      17.49455,
      17.45667,
      17.422,
      17.39049,
      17.3621,
      17.33676,
      17.31442,
      17.29505,
      17.27858,
      17.26497,
      17.25417,
      17.24613,
      17.24081,
      17.23815,
      17.23811,
      17.24065,
      17.24571,
      17.25326,
      17.26324,
      17.2756,
      17.29031,
      17.30732,
      17.32657,
      17.34803,
      17.37165,
      17.39739,
      17.42519,
      17.45502,
      17.48683,
      17.52057,
      17.5562,
      17.59369,
      17.63297,
      17.67402,
      17.71678,
      17.76122,
      17.8073,
      17.85496,
      17.90417,
      17.95489,
      18.00708,
      18.06069,
      18.11569,
      18.17203,
      18.22968,
      18.28859,
      18.34873,
      18.41007,
      18.47255,
      18.53615,
      18.60082,
      18.66653,
      18.73325,
      18.80093,
      18.86955,
      18.93906,
      19.00943,
      19.08063,
      19.15262,
      19.22537,
      19.29884,
      19.37301,
      19.44784,
      19.52329,
      19.59935,
      19.67596,
      19.75312,
      19.83077,
      19.9089,
      19.98748,
      20.06647,
      20.14584,
      20.22558,
      20.30564,
      20.38601,
      20.46665,
      20.54754,
      20.62866,
      20.70997,
      20.79145,
      20.87308,
      20.95484,
      21.03669,
      21.11861,
      21.20059,
      21.28259,
      21.3646,
      21.44659,
      21.52854,
      21.61043,
      21.69224,
      21.77396,
      21.85555,
      21.937,
      22.01829,
      22.0994,
      22.18031,
      22.26101,
      22.34148,
      22.4217,
      22.50166,
      22.58133,
      22.66071,
      22.73977,
      22.8185,
      22.89689,
      22.97493,

    ];
    List<double> _listsadak95 = [
      19.10624,
      19.05824,
      18.96595,
      18.87853,
      18.79591,
      18.718,
      18.64472,
      18.57599,
      18.51173,
      18.45187,
      18.39632,
      18.345,
      18.29784,
      18.25475,
      18.21567,
      18.18051,
      18.14919,
      18.12165,
      18.09781,
      18.07759,
      18.06093,
      18.04775,
      18.03799,
      18.03158,
      18.02844,
      18.02851,
      18.03174,
      18.03805,
      18.04738,
      18.05967,
      18.07486,
      18.09289,
      18.1137,
      18.13722,
      18.16341,
      18.19221,
      18.22355,
      18.25738,
      18.29365,
      18.3323,
      18.37327,
      18.41651,
      18.46197,
      18.50959,
      18.55932,
      18.61111,
      18.6649,
      18.72064,
      18.77829,
      18.83778,
      18.89907,
      18.96211,
      19.02685,
      19.09324,
      19.16123,
      19.23077,
      19.30182,
      19.37432,
      19.44822,
      19.52349,
      19.60008,
      19.67794,
      19.75702,
      19.83728,
      19.91867,
      20.00116,
      20.08469,
      20.16923,
      20.25473,
      20.34116,
      20.42846,
      20.51661,
      20.60555,
      20.69525,
      20.78568,
      20.87678,
      20.96853,
      21.06089,
      21.15381,
      21.24727,
      21.34123,
      21.43565,
      21.53049,
      21.62573,
      21.72133,
      21.81725,
      21.91347,
      22.00996,
      22.10667,
      22.20358,
      22.30066,
      22.39789,
      22.49522,
      22.59264,
      22.69011,
      22.78761,
      22.88511,
      22.98258,
      23.08,
      23.17734,
      23.27458,
      23.3717,
      23.46867,
      23.56546,
      23.66206,
      23.75845,
      23.8546,
      23.95049,
      24.0461,
      24.14141,
      24.23641,
      24.33108,
      24.42539,
      24.51933,
      24.61288,
      24.70603,
      24.79876,
      24.89106,
      24.98291,
      25.0743,
      25.16522,
      25.25564,

    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,

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
    final List<LinearSales> _sadak85 = [];
    for (int i = 0; i < _listsadak85.length; i++)
      _sadak85.add(
        new LinearSales(month[i], _listsadak85[i]),
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
  ///// نمودار BMI برای پسران 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _boyBmi() {

    double bmi = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    print(bmi.toString()+"it is bmi");
    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),bmi)
    ];
    final _listsadak5 = [
      14.73732,
      14.71929,
      14.68361,
      14.64843,
      14.61379,
      14.57969,
      14.54615,
      14.51319,
      14.48084,
      14.44909,
      14.41798,
      14.3875,
      14.35767,
      14.32851,
      14.30002,
      14.27222,
      14.2451,
      14.21868,
      14.19297,
      14.16796,
      14.14367,
      14.12009,
      14.09723,
      14.07509,
      14.05366,
      14.03296,
      14.01296,
      13.99367,
      13.97509,
      13.95722,
      13.94003,
      13.92353,
      13.90771,
      13.89257,
      13.87809,
      13.86426,
      13.85108,
      13.83855,
      13.82665,
      13.81537,
      13.80472,
      13.79469,
      13.78527,
      13.77646,
      13.76825,
      13.76065,
      13.75364,
      13.74724,
      13.74144,
      13.73624,
      13.73164,
      13.72764,
      13.72424,
      13.72145,
      13.71927,
      13.71769,
      13.71672,
      13.71637,
      13.71663,
      13.71751,
      13.71901,
      13.72113,
      13.72387,
      13.72724,
      13.73124,
      13.73587,
      13.74113,
      13.74702,
      13.75355,
      13.76071,
      13.76852,
      13.77695,
      13.78603,
      13.79575,
      13.8061,
      13.8171,
      13.82873,
      13.84101,
      13.85392,
      13.86747,
      13.88166,
      13.89648,
      13.91194,
      13.92804,
      13.94476,
      13.96212,
      13.9801,
      13.99871,
      14.01795,
      14.0378,
      14.05828,
      14.07937,
      14.10107,
      14.12338,
      14.1463,
      14.16982,
      14.19394,
      14.21866,
      14.24396,
      14.26985,
      14.29633,
      14.32338,
      14.35101,
      14.3792,
      14.40796,
      14.43727,
      14.46714,
      14.49756,
      14.52852,
      14.56001,
      14.59203,
      14.62458,
      14.65765,
      14.69122,
      14.72531,
      14.75989,
      14.79496,
      14.83052,
      14.86655,
      14.90306,
      14.94002,
      14.97745,
    ];

    final _listsadak15 = [
      15.09033,
      15.07117,
      15.03336,
      14.9962,
      14.95969,
      14.92385,
      14.88866,
      14.85414,
      14.82027,
      14.78707,
      14.75453,
      14.72264,
      14.69142,
      14.66086,
      14.63096,
      14.60173,
      14.57316,
      14.54527,
      14.51805,
      14.49151,
      14.46566,
      14.4405,
      14.41604,
      14.39229,
      14.36926,
      14.34695,
      14.32537,
      14.30453,
      14.28444,
      14.2651,
      14.24651,
      14.22868,
      14.21162,
      14.19532,
      14.17979,
      14.16503,
      14.15103,
      14.1378,
      14.12534,
      14.11363,
      14.10268,
      14.09249,
      14.08305,
      14.07436,
      14.06642,
      14.05921,
      14.05274,
      14.04701,
      14.042,
      14.03772,
      14.03417,
      14.03134,
      14.02922,
      14.02783,
      14.02714,
      14.02717,
      14.02791,
      14.02935,
      14.0315,
      14.03435,
      14.03791,
      14.04216,
      14.04711,
      14.05276,
      14.0591,
      14.06613,
      14.07386,
      14.08228,
      14.09138,
      14.10116,
      14.11163,
      14.12279,
      14.13462,
      14.14712,
      14.1603,
      14.17416,
      14.18868,
      14.20387,
      14.21972,
      14.23624,
      14.25341,
      14.27124,
      14.28972,
      14.30884,
      14.32862,
      14.34903,
      14.37008,
      14.39177,
      14.41409,
      14.43703,
      14.46059,
      14.48478,
      14.50957,
      14.53498,
      14.56099,
      14.5876,
      14.61481,
      14.6426,
      14.67098,
      14.69994,
      14.72948,
      14.75958,
      14.79025,
      14.82148,
      14.85326,
      14.88558,
      14.91845,
      14.95184,
      14.98577,
      15.02022,
      15.05519,
      15.09066,
      15.12664,
      15.16311,
      15.20007,
      15.23751,
      15.27543,
      15.31381,
      15.35265,
      15.39195,
      15.43169,
      15.47187,
    ];
    List<double> _listsadak25 = [
      15.74164,
      15.71963,
      15.67634,
      15.63403,
      15.59268,
      15.55226,
      15.51275,
      15.47414,
      15.43639,
      15.39951,
      15.36345,
      15.32822,
      15.29379,
      15.26016,
      15.22731,
      15.19523,
      15.16392,
      15.13337,
      15.10359,
      15.07458,
      15.04633,
      15.01886,
      14.99218,
      14.96629,
      14.9412,
      14.91694,
      14.89351,
      14.87093,
      14.84921,
      14.82838,
      14.80844,
      14.78941,
      14.7713,
      14.75414,
      14.73792,
      14.72266,
      14.70836,
      14.69504,
      14.68269,
      14.67133,
      14.66094,
      14.65154,
      14.64312,
      14.63567,
      14.6292,
      14.62369,
      14.61914,
      14.61555,
      14.6129,
      14.6112,
      14.61042,
      14.61057,
      14.61163,
      14.61359,
      14.61645,
      14.6202,
      14.62483,
      14.63032,
      14.63668,
      14.64389,
      14.65194,
      14.66082,
      14.67054,
      14.68107,
      14.69241,
      14.70455,
      14.71749,
      14.73121,
      14.74571,
      14.76099,
      14.77703,
      14.79382,
      14.81136,
      14.82965,
      14.84867,
      14.86841,
      14.88888,
      14.91006,
      14.93194,
      14.95453,
      14.9778,
      15.00176,
      15.0264,
      15.05172,
      15.07769,
      15.10433,
      15.13161,
      15.15954,
      15.1881,
      15.2173,
      15.24712,
      15.27755,
      15.30859,
      15.34024,
      15.37248,
      15.40531,
      15.43872,
      15.4727,
      15.50725,
      15.54236,
      15.57803,
      15.61424,
      15.65099,
      15.68826,
      15.72607,
      15.76439,
      15.80322,
      15.84255,
      15.88237,
      15.92268,
      15.96347,
      16.00473,
      16.04646,
      16.08864,
      16.13127,
      16.17434,
      16.21784,
      16.26177,
      16.30612,
      16.35087,
      16.39603,
      16.44158,
    ];

    List<double> _listsadak50 = [
      16.57503,
      16.54777,
      16.49443,
      16.4426,
      16.39224,
      16.34334,
      16.29584,
      16.24972,
      16.20495,
      16.1615,
      16.11933,
      16.07843,
      16.03876,
      16.0003,
      15.96304,
      15.92695,
      15.89203,
      15.85824,
      15.82559,
      15.79406,
      15.76364,
      15.73434,
      15.70614,
      15.67904,
      15.65305,
      15.62817,
      15.60441,
      15.58176,
      15.56025,
      15.53987,
      15.52065,
      15.50258,
      15.48569,
      15.46998,
      15.45546,
      15.44214,
      15.43003,
      15.41914,
      15.40947,
      15.40103,
      15.39382,
      15.38783,
      15.38307,
      15.37953,
      15.37721,
      15.37609,
      15.37618,
      15.37745,
      15.37991,
      15.38353,
      15.38831,
      15.39423,
      15.40127,
      15.40943,
      15.41869,
      15.42902,
      15.44042,
      15.45288,
      15.46636,
      15.48087,
      15.49637,
      15.51287,
      15.53034,
      15.54876,
      15.56812,
      15.58841,
      15.60961,
      15.63171,
      15.65469,
      15.67853,
      15.70323,
      15.72877,
      15.75513,
      15.78231,
      15.81029,
      15.83905,
      15.86858,
      15.89888,
      15.92992,
      15.96169,
      15.99419,
      16.02741,
      16.06132,
      16.09591,
      16.13119,
      16.16712,
      16.20371,
      16.24094,
      16.2788,
      16.31728,
      16.35637,
      16.39606,
      16.43633,
      16.47718,
      16.5186,
      16.56057,
      16.60309,
      16.64614,
      16.68972,
      16.73381,
      16.7784,
      16.8235,
      16.86907,
      16.91512,
      16.96164,
      17.00862,
      17.05604,
      17.1039,
      17.15218,
      17.20089,
      17.25,
      17.29951,
      17.34942,
      17.3997,
      17.45036,
      17.50138,
      17.55276,
      17.60448,
      17.65653,
      17.70892,
      17.76162,
      17.81463,
    ];

    List<double> _listsadak75 = [
      17.55719,
      17.52129,
      17.45135,
      17.38384,
      17.31871,
      17.25593,
      17.19546,
      17.13726,
      17.0813,
      17.02753,
      16.97592,
      16.92645,
      16.87907,
      16.83376,
      16.79048,
      16.7492,
      16.70988,
      16.67251,
      16.63704,
      16.60345,
      16.5717,
      16.54177,
      16.51364,
      16.48726,
      16.46262,
      16.4397,
      16.41846,
      16.39889,
      16.38097,
      16.36468,
      16.35001,
      16.33693,
      16.32545,
      16.31554,
      16.3072,
      16.30042,
      16.29518,
      16.29148,
      16.28932,
      16.28868,
      16.28955,
      16.29192,
      16.29578,
      16.30113,
      16.30794,
      16.3162,
      16.3259,
      16.33702,
      16.34955,
      16.36346,
      16.37875,
      16.39537,
      16.41333,
      16.4326,
      16.45315,
      16.47496,
      16.49801,
      16.52229,
      16.54776,
      16.5744,
      16.60219,
      16.63112,
      16.66114,
      16.69225,
      16.72442,
      16.75763,
      16.79185,
      16.82707,
      16.86325,
      16.90039,
      16.93845,
      16.97742,
      17.01727,
      17.05799,
      17.09955,
      17.14193,
      17.18512,
      17.22909,
      17.27383,
      17.31932,
      17.36552,
      17.41244,
      17.46005,
      17.50833,
      17.55726,
      17.60683,
      17.65702,
      17.7078,
      17.75918,
      17.81112,
      17.86361,
      17.91664,
      17.9702,
      18.02425,
      18.07879,
      18.13381,
      18.18929,
      18.24521,
      18.30156,
      18.35833,
      18.4155,
      18.47306,
      18.53099,
      18.58928,
      18.64792,
      18.70689,
      18.76619,
      18.82579,
      18.8857,
      18.94588,
      19.00634,
      19.06706,
      19.12803,
      19.18924,
      19.25067,
      19.31232,
      19.37417,
      19.43622,
      19.49845,
      19.56086,
      19.62342,
      19.68614,
    ];

    List<double> _listsadak85 = [
      18.16219,
      18.11955,
      18.03668,
      17.957,
      17.88047,
      17.80704,
      17.73667,
      17.66932,
      17.60495,
      17.54351,
      17.48496,
      17.42927,
      17.37639,
      17.32627,
      17.27889,
      17.23419,
      17.19213,
      17.15266,
      17.11575,
      17.08135,
      17.04941,
      17.01988,
      16.99272,
      16.96789,
      16.94533,
      16.92501,
      16.90688,
      16.89089,
      16.87701,
      16.86519,
      16.8554,
      16.8476,
      16.84176,
      16.83784,
      16.8358,
      16.83563,
      16.83729,
      16.84076,
      16.846,
      16.853,
      16.86173,
      16.87217,
      16.88428,
      16.89805,
      16.91346,
      16.93048,
      16.94909,
      16.96925,
      16.99096,
      17.01418,
      17.03888,
      17.06505,
      17.09265,
      17.12166,
      17.15206,
      17.1838,
      17.21688,
      17.25126,
      17.28691,
      17.3238,
      17.36192,
      17.40122,
      17.44168,
      17.48329,
      17.52599,
      17.56978,
      17.61462,
      17.66049,
      17.70736,
      17.7552,
      17.80398,
      17.85369,
      17.90429,
      17.95575,
      18.00807,
      18.0612,
      18.11512,
      18.16981,
      18.22525,
      18.28141,
      18.33827,
      18.3958,
      18.45398,
      18.5128,
      18.57222,
      18.63222,
      18.69279,
      18.7539,
      18.81554,
      18.87767,
      18.94028,
      19.00336,
      19.06688,
      19.13081,
      19.19516,
      19.25988,
      19.32497,
      19.39041,
      19.45618,
      19.52226,
      19.58864,
      19.6553,
      19.72222,
      19.78938,
      19.85678,
      19.92439,
      19.9922,
      20.06019,
      20.12835,
      20.19667,
      20.26514,
      20.33373,
      20.40243,
      20.47124,
      20.54013,
      20.6091,
      20.67814,
      20.74722,
      20.81635,
      20.88551,
      20.95468,
      21.02386,
    ];

    List<double> _listsadak90 = [
      18.60948,
      18.56111,
      18.4673,
      18.37736,
      18.29125,
      18.20892,
      18.13031,
      18.05538,
      17.98408,
      17.91635,
      17.85215,
      17.79143,
      17.73414,
      17.68022,
      17.62963,
      17.58231,
      17.5382,
      17.49725,
      17.45941,
      17.42462,
      17.39282,
      17.36395,
      17.33795,
      17.31477,
      17.29434,
      17.27661,
      17.26151,
      17.24899,
      17.23899,
      17.23145,
      17.22632,
      17.22354,
      17.22306,
      17.22483,
      17.2288,
      17.23493,
      17.24315,
      17.25344,
      17.26575,
      17.28003,
      17.29625,
      17.31437,
      17.33435,
      17.35616,
      17.37975,
      17.4051,
      17.43217,
      17.46092,
      17.49133,
      17.52335,
      17.55696,
      17.59212,
      17.6288,
      17.66696,
      17.70658,
      17.74762,
      17.79004,
      17.83382,
      17.87892,
      17.92532,
      17.97296,
      18.02183,
      18.0719,
      18.12312,
      18.17548,
      18.22893,
      18.28344,
      18.33899,
      18.39554,
      18.45306,
      18.51152,
      18.57089,
      18.63115,
      18.69225,
      18.75418,
      18.8169,
      18.88038,
      18.94459,
      19.00952,
      19.07512,
      19.14137,
      19.20825,
      19.27573,
      19.34378,
      19.41238,
      19.48149,
      19.5511,
      19.62118,
      19.69171,
      19.76266,
      19.83401,
      19.90573,
      19.97781,
      20.05021,
      20.12292,
      20.19592,
      20.26919,
      20.3427,
      20.41643,
      20.49036,
      20.56448,
      20.63877,
      20.7132,
      20.78775,
      20.86242,
      20.93718,
      21.01201,
      21.0869,
      21.16183,
      21.23679,
      21.31175,
      21.38671,
      21.46165,
      21.53655,
      21.61141,
      21.6862,
      21.76091,
      21.83554,
      21.91006,
      21.98447,
      22.05876,
      22.1329
    ];
    List<double> _listsadak95 = [
      19.33801,
      19.2789,
      19.16466,
      19.05567,
      18.95187,
      18.85317,
      18.75949,
      18.67078,
      18.58695,
      18.50792,
      18.43363,
      18.364,
      18.29895,
      18.23842,
      18.18231,
      18.13057,
      18.08311,
      18.03986,
      18.00074,
      17.96568,
      17.93459,
      17.90741,
      17.88405,
      17.86444,
      17.8485,
      17.83614,
      17.8273,
      17.82189,
      17.81983,
      17.82104,
      17.82544,
      17.83295,
      17.84349,
      17.85699,
      17.87335,
      17.89252,
      17.9144,
      17.93893,
      17.96602,
      17.99562,
      18.02764,
      18.06201,
      18.09868,
      18.13758,
      18.17863,
      18.22179,
      18.26698,
      18.31416,
      18.36325,
      18.41421,
      18.46699,
      18.52152,
      18.57775,
      18.63564,
      18.69513,
      18.75617,
      18.81872,
      18.88272,
      18.94814,
      19.01491,
      19.083,
      19.15236,
      19.22295,
      19.29471,
      19.36761,
      19.44161,
      19.51666,
      19.59272,
      19.66974,
      19.74769,
      19.82652,
      19.9062,
      19.98668,
      20.06793,
      20.1499,
      20.23256,
      20.31587,
      20.39979,
      20.48429,
      20.56933,
      20.65487,
      20.74089,
      20.82733,
      20.91417,
      21.00138,
      21.08893,
      21.17677,
      21.26488,
      21.35323,
      21.44178,
      21.53051,
      21.61938,
      21.70837,
      21.79745,
      21.88659,
      21.97576,
      22.06494,
      22.15409,
      22.2432,
      22.33224,
      22.42118,
      22.51,
      22.59868,
      22.68719,
      22.77551,
      22.86363,
      22.95151,
      23.03915,
      23.12651,
      23.21358,
      23.30035,
      23.38679,
      23.47289,
      23.55863,
      23.644,
      23.72897,
      23.81354,
      23.89769,
      23.98141,
      24.06469,
      24.1475,
      24.22985,
    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,

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
    final List<LinearSales> _sadak85 = [];
    for (int i = 0; i < _listsadak85.length; i++)
      _sadak85.add(
        new LinearSales(month[i], _listsadak85[i]),
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
  ///// نمودار وزن برای دختران 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _girlWeghitYear() {


    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),double.parse(_user.weight))
    ];
    final _listsadak5 = [
      10.21027,
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
      11.65542,
      11.76826,
      11.88202,
      11.99685,
      12.11284,
      12.23011,
      12.34871,
      12.4687,
      12.59011,
      12.71297,
      12.83726,
      12.96298,
      13.09012,
      13.21864,
      13.3485,
      13.47966,
      13.61206,
      13.74566,
      13.8804,
      14.01621,
      14.15303,
      14.29081,
      14.42947,
      14.56897,
      14.70924,
      14.85022,
      14.99186,
      15.13412,
      15.27694,
      15.42029,
      15.56413,
      15.70843,
      15.85316,
      15.99831,
      16.14385,
      16.28977,
      16.43608,
      16.58277,
      16.72986,
      16.87736,
      17.02528,
      17.17365,
      17.3225,
      17.47187,
      17.6218,
      17.77232,
      17.9235,
      18.07539,
      18.22805,
      18.38153,
      18.53591,
      18.69124,
      18.84762,
      19.00511,
      19.16378,
      19.32373,
      19.48502,
      19.64775,
      19.81199,
      19.97783,
      20.14535,
      20.31464,
      20.48579,
      20.65887,
      20.83397,
      21.01117,
      21.19055,
      21.37219,
      21.55616,
      21.74253,
      21.93138,
      22.12277,
      22.31677,
      22.51343,
      22.71282,
      22.91497,
      23.11994,
      23.32778,
      23.53851,
      23.75217,
      23.96879,
      24.18838,
      24.41097,
      24.63656,
      24.86516,
      25.09677,
      25.33137,
      25.56895,
      25.80949,
      26.05297,
      26.29934,
      26.54856,
      26.8006,
      27.05539,
      27.31287,
      27.57298,
      27.83564,
      28.10077,
      28.36829,
      28.63809,
      28.91009,
      29.18417,
      29.46022,
      29.73813,
      30.01776,
      30.299,
      30.5817,
      30.86573,
      31.15094,
    ];

    final _listsadak15 = [
      10.57373,
      10.64076,
      10.77167,
      10.89899,
      11.02338,
      11.14545,
      11.26575,
      11.38474,
      11.50288,
      11.62054,
      11.73806,
      11.85574,
      11.97384,
      12.09259,
      12.21216,
      12.33273,
      12.45442,
      12.57735,
      12.70158,
      12.8272,
      12.95423,
      13.08271,
      13.21265,
      13.34405,
      13.47689,
      13.61116,
      13.74682,
      13.88384,
      14.02217,
      14.16176,
      14.30257,
      14.44453,
      14.5876,
      14.73172,
      14.87683,
      15.02287,
      15.16981,
      15.31758,
      15.46614,
      15.61545,
      15.76547,
      15.91616,
      16.06749,
      16.21943,
      16.37197,
      16.52509,
      16.67878,
      16.83304,
      16.98787,
      17.14327,
      17.29926,
      17.45586,
      17.61309,
      17.77097,
      17.92956,
      18.08887,
      18.24897,
      18.40989,
      18.5717,
      18.73445,
      18.89819,
      19.063,
      19.22895,
      19.3961,
      19.56453,
      19.73432,
      19.90554,
      20.07828,
      20.25261,
      20.42863,
      20.6064,
      20.78601,
      20.96755,
      21.15111,
      21.33675,
      21.52456,
      21.71462,
      21.907,
      22.10179,
      22.29905,
      22.49884,
      22.70125,
      22.90633,
      23.11413,
      23.32471,
      23.53813,
      23.75442,
      23.97364,
      24.19581,
      24.42096,
      24.64912,
      24.88031,
      25.11454,
      25.35181,
      25.59214,
      25.83551,
      26.08191,
      26.33132,
      26.58372,
      26.83907,
      27.09734,
      27.35848,
      27.62244,
      27.88915,
      28.15856,
      28.43059,
      28.70516,
      28.98218,
      29.26156,
      29.54321,
      29.827,
      30.11285,
      30.40062,
      30.69019,
      30.98143,
      31.27421,
      31.56838,
      31.86381,
      32.16034,
      32.45781,
      32.75608,
      33.05496,
    ];
    List<double> _listsadak25 = [
      11.23357,
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
      12.90222,
      13.03542,
      13.16977,
      13.30538,
      13.44234,
      13.58071,
      13.72054,
      13.86186,
      14.00469,
      14.14902,
      14.29485,
      14.44217,
      14.59093,
      14.74112,
      14.89269,
      15.0456,
      15.19981,
      15.35527,
      15.51193,
      15.66975,
      15.82868,
      15.98868,
      16.14971,
      16.31173,
      16.47471,
      16.63861,
      16.80342,
      16.9691,
      17.13565,
      17.30305,
      17.4713,
      17.6404,
      17.81035,
      17.98118,
      18.15288,
      18.32549,
      18.49904,
      18.67356,
      18.84908,
      19.02566,
      19.20334,
      19.38217,
      19.56221,
      19.74353,
      19.9262,
      20.11027,
      20.29582,
      20.48293,
      20.67168,
      20.86215,
      21.05441,
      21.24855,
      21.44467,
      21.64283,
      21.84313,
      22.04564,
      22.25047,
      22.45768,
      22.66736,
      22.8796,
      23.09446,
      23.31203,
      23.53237,
      23.75556,
      23.98166,
      24.21073,
      24.44283,
      24.67802,
      24.91634,
      25.15783,
      25.40252,
      25.65046,
      25.90167,
      26.15616,
      26.41394,
      26.67503,
      26.93942,
      27.20709,
      27.47805,
      27.75225,
      28.02968,
      28.31029,
      28.59403,
      28.88087,
      29.17072,
      29.46353,
      29.75922,
      30.0577,
      30.35888,
      30.66267,
      30.96895,
      31.27762,
      31.58856,
      31.90163,
      32.21671,
      32.53364,
      32.8523,
      33.17252,
      33.49415,
      33.81701,
      34.14096,
      34.4658,
      34.79137,
      35.11747,
      35.44394,
      35.77056,
      36.09716,
      36.42354,
      36.7495,
    ];

    List<double> _listsadak50 = [
      12.05504,
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
      13.94108,
      14.09407,
      14.24844,
      14.40429,
      14.56168,
      14.72064,
      14.88121,
      15.04341,
      15.20721,
      15.37263,
      15.53962,
      15.70817,
      15.87824,
      16.04978,
      16.22277,
      16.39715,
      16.57289,
      16.74994,
      16.92827,
      17.10783,
      17.28859,
      17.47052,
      17.65361,
      17.83782,
      18.02314,
      18.20956,
      18.39709,
      18.58571,
      18.77545,
      18.96631,
      19.15831,
      19.35149,
      19.54588,
      19.74151,
      19.93843,
      20.1367,
      20.33636,
      20.53748,
      20.74013,
      20.94438,
      21.1503,
      21.35797,
      21.56748,
      21.77891,
      21.99235,
      22.20789,
      22.42562,
      22.64564,
      22.86804,
      23.09293,
      23.32039,
      23.55052,
      23.78342,
      24.01918,
      24.25789,
      24.49965,
      24.74454,
      24.99264,
      25.24403,
      25.4988,
      25.75702,
      26.01874,
      26.28404,
      26.55298,
      26.82559,
      27.10193,
      27.38203,
      27.66593,
      27.95365,
      28.24521,
      28.5406,
      28.83984,
      29.14291,
      29.4498,
      29.76048,
      30.07493,
      30.39308,
      30.7149,
      31.04032,
      31.36928,
      31.70168,
      32.03745,
      32.37649,
      32.71868,
      33.06392,
      33.41208,
      33.76303,
      34.11663,
      34.47272,
      34.83116,
      35.19176,
      35.55437,
      35.9188,
      36.28486,
      36.65236,
      37.02111,
      37.39089,
      37.76149,
      38.1327,
      38.5043,
      38.87605,
      39.24775,
      39.61914,
      39.99,
      40.36009,
      40.72918,
      41.09701,
      41.46336,
      41.82798,
    ];

    List<double> _listsadak75 = [
      12.98667,
      13.07613,
      13.25293,
      13.42753,
      13.60059,
      13.77271,
      13.9444,
      14.11611,
      14.28823,
      14.46106,
      14.63491,
      14.80998,
      14.98647,
      15.16452,
      15.34425,
      15.52574,
      15.70905,
      15.89422,
      16.08126,
      16.27016,
      16.46093,
      16.65353,
      16.84793,
      17.04408,
      17.24195,
      17.44149,
      17.64265,
      17.84537,
      18.04961,
      18.25533,
      18.46249,
      18.67105,
      18.88097,
      19.09224,
      19.30483,
      19.51874,
      19.73395,
      19.95048,
      20.16834,
      20.38753,
      20.6081,
      20.83007,
      21.05349,
      21.2784,
      21.50486,
      21.73294,
      21.96271,
      22.19425,
      22.42763,
      22.66294,
      22.90029,
      23.13976,
      23.38146,
      23.6255,
      23.87199,
      24.12103,
      24.37274,
      24.62725,
      24.88466,
      25.14509,
      25.40866,
      25.67549,
      25.94569,
      26.21937,
      26.49666,
      26.77764,
      27.06244,
      27.35114,
      27.64385,
      27.94066,
      28.24165,
      28.54689,
      28.85648,
      29.17046,
      29.4889,
      29.81185,
      30.13934,
      30.47142,
      30.80811,
      31.14942,
      31.49536,
      31.84592,
      32.20108,
      32.56084,
      32.92513,
      33.29393,
      33.66717,
      34.04479,
      34.4267,
      34.81282,
      35.20305,
      35.59726,
      35.99535,
      36.39717,
      36.80259,
      37.21144,
      37.62356,
      38.03878,
      38.45691,
      38.87775,
      39.30111,
      39.72676,
      40.15449,
      40.58407,
      41.01526,
      41.44782,
      41.88148,
      42.316,
      42.75111,
      43.18655,
      43.62203,
      44.05728,
      44.49201,
      44.92595,
      45.3588,
      45.79028,
      46.22009,
      46.64794,
      47.07354,
      47.49661,
      47.91684,
      48.33396,
    ];

    List<double> _listsadak90 = [
      13.93766,
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
      16.46789,
      16.68038,
      16.89519,
      17.11235,
      17.33186,
      17.55371,
      17.77788,
      18.00432,
      18.23298,
      18.46379,
      18.69671,
      18.93166,
      19.16858,
      19.40739,
      19.64805,
      19.89048,
      20.13464,
      20.38048,
      20.62795,
      20.87704,
      21.1277,
      21.37993,
      21.63373,
      21.88909,
      22.14604,
      22.4046,
      22.6648,
      22.92668,
      23.19031,
      23.45574,
      23.72305,
      23.99232,
      24.26364,
      24.5371,
      24.81282,
      25.09089,
      25.37145,
      25.65461,
      25.94051,
      26.22926,
      26.52102,
      26.81591,
      27.11407,
      27.41566,
      27.7208,
      28.02965,
      28.34233,
      28.659,
      28.97979,
      29.30484,
      29.63426,
      29.9682,
      30.30677,
      30.65008,
      30.99825,
      31.35137,
      31.70954,
      32.07286,
      32.44138,
      32.8152,
      33.19435,
      33.5789,
      33.96887,
      34.36431,
      34.76522,
      35.17161,
      35.58347,
      36.00078,
      36.42352,
      36.85164,
      37.28507,
      37.72376,
      38.16762,
      38.61656,
      39.07046,
      39.52921,
      39.99268,
      40.46071,
      40.93316,
      41.40984,
      41.89057,
      42.37517,
      42.86342,
      43.35511,
      43.85001,
      44.34788,
      44.84847,
      45.35152,
      45.85676,
      46.36392,
      46.87271,
      47.38283,
      47.894,
      48.40589,
      48.9182,
      49.43061,
      49.9428,
      50.45443,
      50.96519,
      51.47473,
      51.98272,
      52.48882,
      52.9927,
      53.49402,
      53.99244,
      54.48762,
      54.97925,
      55.46697,
      55.95048,
    ];

    List<double> _listsadak95 = [
      14.56636,
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
      17.36244,
      17.60006,
      17.8405,
      18.08377,
      18.32988,
      18.57877,
      18.83042,
      19.08475,
      19.34169,
      19.60118,
      19.86313,
      20.12746,
      20.39409,
      20.66293,
      20.93393,
      21.20699,
      21.48207,
      21.7591,
      22.03803,
      22.31884,
      22.60148,
      22.88594,
      23.17222,
      23.46031,
      23.75024,
      24.04202,
      24.3357,
      24.63133,
      24.92897,
      25.22868,
      25.53055,
      25.83467,
      26.14113,
      26.45005,
      26.76154,
      27.07573,
      27.39274,
      27.71272,
      28.0358,
      28.36213,
      28.69185,
      29.02513,
      29.36212,
      29.70296,
      30.04782,
      30.39685,
      30.75021,
      31.10804,
      31.47049,
      31.83771,
      32.20984,
      32.58701,
      32.96935,
      33.35698,
      33.75001,
      34.14856,
      34.55271,
      34.96256,
      35.37818,
      35.79964,
      36.22699,
      36.66029,
      37.09956,
      37.54482,
      37.99609,
      38.45335,
      38.91658,
      39.38577,
      39.86086,
      40.34179,
      40.82849,
      41.32088,
      41.81885,
      42.32229,
      42.83107,
      43.34505,
      43.86408,
      44.38798,
      44.91658,
      45.44968,
      45.98708,
      46.52854,
      47.07385,
      47.62276,
      48.17501,
      48.73033,
      49.28846,
      49.84911,
      50.41198,
      50.97677,
      51.54317,
      52.11086,
      52.67951,
      53.2488,
      53.81837,
      54.3879,
      54.95703,
      55.52542,
      56.09271,
      56.65855,
      57.22257,
      57.78443,
      58.34376,
      58.90022,
      59.45344,
      60.00308,
      60.54878,
      61.0902,
      61.62701,
    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,
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
  ///// نمودار وزن برای پسرا 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _boyWeghitYear() {

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),double.parse(_user.weight))
    ];
    final _listsadak5 = [
      10.64009,
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
      12.09962,
      12.21984,
      12.34115,
      12.46354,
      12.58701,
      12.71154,
      12.8371,
      12.96366,
      13.09119,
      13.21963,
      13.34895,
      13.47911,
      13.61006,
      13.74176,
      13.87418,
      14.00727,
      14.14102,
      14.2754,
      14.41037,
      14.54593,
      14.68205,
      14.81872,
      14.95595,
      15.09371,
      15.23202,
      15.37087,
      15.51027,
      15.65023,
      15.79076,
      15.93186,
      16.07356,
      16.21586,
      16.35879,
      16.50235,
      16.64657,
      16.79146,
      16.93704,
      17.08332,
      17.23031,
      17.37804,
      17.52651,
      17.67574,
      17.82572,
      17.97649,
      18.12803,
      18.28036,
      18.43348,
      18.5874,
      18.74211,
      18.89763,
      19.05395,
      19.21107,
      19.369,
      19.52773,
      19.68727,
      19.84762,
      20.00878,
      20.17076,
      20.33357,
      20.4972,
      20.66168,
      20.82702,
      20.99322,
      21.16032,
      21.32832,
      21.49726,
      21.66716,
      21.83805,
      22.00997,
      22.18296,
      22.35705,
      22.5323,
      22.70876,
      22.88648,
      23.06551,
      23.24593,
      23.42779,
      23.61117,
      23.79613,
      23.98277,
      24.17115,
      24.36137,
      24.55351,
      24.74766,
      24.94392,
      25.14238,
      25.34314,
      25.54631,
      25.75198,
      25.96027,
      26.17126,
      26.38509,
      26.60184,
      26.82163,
      27.04457,
      27.27076,
      27.50031,
      27.73332,
      27.96989,
      28.21013,
      28.45412,
      28.70197,
      28.95376,
      29.20958,
      29.4695,
      29.7336,
      30.00195,
      30.2746,
      30.55162,
    ];

    final _listsadak15 = [
      11.05266,
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
      12.55436,
      12.67868,
      12.80431,
      12.93128,
      13.05959,
      13.18923,
      13.32017,
      13.45238,
      13.58581,
      13.72043,
      13.85618,
      13.99301,
      14.13086,
      14.26968,
      14.40943,
      14.55004,
      14.69148,
      14.8337,
      14.97666,
      15.12032,
      15.26465,
      15.40962,
      15.55521,
      15.70139,
      15.84814,
      15.99546,
      16.14334,
      16.29176,
      16.44074,
      16.59026,
      16.74033,
      16.89096,
      17.04215,
      17.19393,
      17.34629,
      17.49926,
      17.65285,
      17.80708,
      17.96197,
      18.11754,
      18.2738,
      18.43077,
      18.58848,
      18.74695,
      18.9062,
      19.06624,
      19.2271,
      19.3888,
      19.55136,
      19.71479,
      19.87913,
      20.04438,
      20.21057,
      20.37771,
      20.54584,
      20.71496,
      20.88511,
      21.05629,
      21.22855,
      21.4019,
      21.57637,
      21.75198,
      21.92878,
      22.10678,
      22.28602,
      22.46654,
      22.64838,
      22.83157,
      23.01617,
      23.20222,
      23.38976,
      23.57885,
      23.76955,
      23.96192,
      24.15601,
      24.35189,
      24.54962,
      24.74929,
      24.95096,
      25.1547,
      25.3606,
      25.56874,
      25.77921,
      25.99208,
      26.20745,
      26.42541,
      26.64604,
      26.86945,
      27.09573,
      27.32496,
      27.55726,
      27.7927,
      28.0314,
      28.27343,
      28.51891,
      28.76791,
      29.02052,
      29.27685,
      29.53696,
      29.80095,
      30.06888,
      30.34084,
      30.61689,
      30.8971,
      31.18151,
      31.4702,
      31.76319,
      32.06052,
      32.36224,
    ];
    List<double> _listsadak25 = [
      11.78598,
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
      13.37875,
      13.51197,
      13.64693,
      13.78366,
      13.92218,
      14.0625,
      14.20458,
      14.3484,
      14.49391,
      14.64105,
      14.78977,
      14.93998,
      15.09163,
      15.24463,
      15.39892,
      15.55441,
      15.71103,
      15.86872,
      16.0274,
      16.18701,
      16.34748,
      16.50877,
      16.67081,
      16.83356,
      16.99698,
      17.16103,
      17.32567,
      17.49088,
      17.65664,
      17.82293,
      17.98974,
      18.15706,
      18.32489,
      18.49324,
      18.66211,
      18.83151,
      19.00147,
      19.17199,
      19.34311,
      19.51485,
      19.68724,
      19.86032,
      20.03413,
      20.20871,
      20.38409,
      20.56032,
      20.73745,
      20.91553,
      21.0946,
      21.27471,
      21.45592,
      21.63828,
      21.82185,
      22.00666,
      22.19278,
      22.38027,
      22.56917,
      22.75955,
      22.95145,
      23.14493,
      23.34005,
      23.53686,
      23.73542,
      23.93579,
      24.13801,
      24.34216,
      24.54828,
      24.75645,
      24.9667,
      25.17912,
      25.39375,
      25.61067,
      25.82993,
      26.05161,
      26.27576,
      26.50246,
      26.73177,
      26.96376,
      27.19851,
      27.43609,
      27.67657,
      27.92001,
      28.16651,
      28.41613,
      28.66894,
      28.92502,
      29.18446,
      29.44731,
      29.71365,
      29.98357,
      30.25713,
      30.53439,
      30.81543,
      31.10032,
      31.38912,
      31.68189,
      31.97868,
      32.27955,
      32.58454,
      32.89371,
      33.20709,
      33.52472,
      33.84662,
      34.17281,
      34.5033,
      34.83811,
      35.17724,
      35.52066,
      35.86837,
    ];

    List<double> _listsadak50 = [
      12.67076,
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
      14.40263,
      14.54965,
      14.69893,
      14.85054,
      15.00449,
      15.16078,
      15.3194,
      15.4803,
      15.64343,
      15.80873,
      15.9761,
      16.14548,
      16.31677,
      16.48986,
      16.66468,
      16.8411,
      17.01904,
      17.19839,
      17.37906,
      17.56096,
      17.744,
      17.92809,
      18.11316,
      18.29912,
      18.48592,
      18.6735,
      18.8618,
      19.05077,
      19.24037,
      19.43058,
      19.62136,
      19.8127,
      20.00459,
      20.19703,
      20.39002,
      20.58357,
      20.7777,
      20.97243,
      21.16779,
      21.36383,
      21.56058,
      21.75811,
      21.95645,
      22.15567,
      22.35584,
      22.55702,
      22.7593,
      22.96273,
      23.16742,
      23.37343,
      23.58086,
      23.78979,
      24.00031,
      24.21251,
      24.42648,
      24.64231,
      24.8601,
      25.07992,
      25.30189,
      25.52607,
      25.75257,
      25.98146,
      26.21284,
      26.44679,
      26.68339,
      26.92273,
      27.16489,
      27.40995,
      27.65797,
      27.90904,
      28.16324,
      28.42064,
      28.6813,
      28.9453,
      29.21271,
      29.48359,
      29.758,
      30.03602,
      30.3177,
      30.60311,
      30.8923,
      31.18533,
      31.48225,
      31.78312,
      32.08799,
      32.3969,
      32.70991,
      33.02704,
      33.34835,
      33.67387,
      34.00363,
      34.33766,
      34.67599,
      35.01864,
      35.36562,
      35.71695,
      36.07263,
      36.43266,
      36.79704,
      37.16577,
      37.53881,
      37.91616,
      38.29777,
      38.68361,
      39.07364,
      39.46781,
      39.86604,
      40.26828,
      40.67444,
    ];

    List<double> _listsadak75 = [
      13.63692,
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
      15.55987,
      15.7263,
      15.89565,
      16.06797,
      16.24326,
      16.42153,
      16.60273,
      16.78682,
      16.97373,
      17.16336,
      17.35564,
      17.55044,
      17.74767,
      17.9472,
      18.14892,
      18.3527,
      18.55842,
      18.76598,
      18.97524,
      19.1861,
      19.39846,
      19.6122,
      19.82724,
      20.04348,
      20.26086,
      20.47929,
      20.69871,
      20.91907,
      21.14031,
      21.36242,
      21.58534,
      21.80908,
      22.0336,
      22.25893,
      22.48505,
      22.712,
      22.93978,
      23.16845,
      23.39803,
      23.62858,
      23.86016,
      24.09284,
      24.32667,
      24.56175,
      24.79815,
      25.03598,
      25.27531,
      25.51626,
      25.75894,
      26.00344,
      26.24988,
      26.49839,
      26.74907,
      27.00204,
      27.25743,
      27.51535,
      27.77593,
      28.03928,
      28.30554,
      28.5748,
      28.84718,
      29.12281,
      29.40179,
      29.68422,
      29.97021,
      30.25986,
      30.55326,
      30.85051,
      31.15169,
      31.45689,
      31.76618,
      32.07964,
      32.39734,
      32.71933,
      33.04569,
      33.37646,
      33.7117,
      34.05144,
      34.39573,
      34.7446,
      35.09808,
      35.4562,
      35.81896,
      36.1864,
      36.55851,
      36.93529,
      37.31675,
      37.70287,
      38.09365,
      38.48906,
      38.88907,
      39.29366,
      39.7028,
      40.11642,
      40.5345,
      40.95697,
      41.38377,
      41.81484,
      42.2501,
      42.68947,
      43.13287,
      43.5802,
      44.03137,
      44.48627,
      44.94478,
      45.40679,
      45.87218,
      46.3408,
      46.81253,
    ];

    List<double> _listsadak90 = [
      14.5834,
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
      16.73623,
      16.9267,
      17.12085,
      17.3187,
      17.52025,
      17.72545,
      17.93424,
      18.14654,
      18.36226,
      18.58128,
      18.80348,
      19.02875,
      19.25695,
      19.48794,
      19.7216,
      19.95779,
      20.19637,
      20.43722,
      20.68022,
      20.92526,
      21.17222,
      21.421,
      21.67152,
      21.92369,
      22.17744,
      22.4327,
      22.68943,
      22.94758,
      23.20712,
      23.46802,
      23.73029,
      23.99391,
      24.2589,
      24.52527,
      24.79305,
      25.06229,
      25.33302,
      25.6053,
      25.87919,
      26.15477,
      26.4321,
      26.71128,
      26.99239,
      27.27553,
      27.56081,
      27.84832,
      28.13817,
      28.43049,
      28.72538,
      29.02298,
      29.3234,
      29.62676,
      29.9332,
      30.24283,
      30.55579,
      30.8722,
      31.19218,
      31.51586,
      31.84335,
      32.17478,
      32.51025,
      32.84988,
      33.19377,
      33.54202,
      33.89472,
      34.25197,
      34.61384,
      34.98041,
      35.35176,
      35.72793,
      36.10899,
      36.49499,
      36.88596,
      37.28193,
      37.68294,
      38.08898,
      38.50008,
      38.91622,
      39.33741,
      39.76363,
      40.19484,
      40.63103,
      41.07214,
      41.51813,
      41.96894,
      42.42452,
      42.88478,
      43.34967,
      43.81908,
      44.29292,
      44.77111,
      45.25354,
      45.7401,
      46.23066,
      46.72512,
      47.22334,
      47.72519,
      48.23054,
      48.73924,
      49.25114,
      49.76611,
      50.28397,
      50.80458,
      51.32778,
      51.85339,
      52.38125,
      52.91119,
      53.44304,
      53.97661,
    ];

    List<double> _listsadak95 = [
      15.18777,
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
      17.51093,
      17.71965,
      17.93265,
      18.14992,
      18.37141,
      18.59705,
      18.82675,
      19.06041,
      19.29789,
      19.53907,
      19.78381,
      20.03197,
      20.28339,
      20.53795,
      20.79548,
      21.05586,
      21.31896,
      21.58464,
      21.8528,
      22.12331,
      22.3961,
      22.67106,
      22.94813,
      23.22723,
      23.50833,
      23.79136,
      24.07632,
      24.36317,
      24.65192,
      24.94257,
      25.23514,
      25.52965,
      25.82615,
      26.12468,
      26.4253,
      26.72807,
      27.03308,
      27.34039,
      27.6501,
      27.9623,
      28.27709,
      28.59457,
      28.91486,
      29.23806,
      29.56428,
      29.89365,
      30.22628,
      30.56228,
      30.90178,
      31.24489,
      31.59174,
      31.94243,
      32.29708,
      32.65581,
      33.01871,
      33.38591,
      33.75749,
      34.13355,
      34.5142,
      34.8995,
      35.28955,
      35.68443,
      36.08419,
      36.4889,
      36.89862,
      37.3134,
      37.73327,
      38.15826,
      38.58841,
      39.02372,
      39.46421,
      39.90987,
      40.36069,
      40.81665,
      41.27773,
      41.74388,
      42.21507,
      42.69124,
      43.17232,
      43.65825,
      44.14895,
      44.64432,
      45.14428,
      45.64872,
      46.15753,
      46.6706,
      47.1878,
      47.70901,
      48.23408,
      48.76288,
      49.29526,
      49.83107,
      50.37016,
      50.91236,
      51.45752,
      52.00546,
      52.55602,
      53.10903,
      53.66432,
      54.22171,
      54.78102,
      55.34208,
      55.9047,
      56.46873,
      57.03397,
      57.60024,
      58.16739,
      58.73522,
      59.30357,
    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,
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
///// نمودار قد برای دختران 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _girlHeightYear() {

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),double.parse(_user.height))
    ];
    final _listsadak5 = [
      79.25982,
      79.64777,
      80.44226,
      81.22666,
      81.9954,
      82.74411,
      83.46957,
      84.16953,
      84.84264,
      85.4883,
      86.10656,
      86.69803,
      87.26379,
      87.80528,
      88.34236,
      88.87256,
      89.39733,
      89.91797,
      90.43559,
      90.95115,
      91.46549,
      91.97932,
      92.49325,
      93.00778,
      93.52333,
      94.04022,
      94.55872,
      95.07903,
      95.60128,
      96.12555,
      96.65189,
      97.18029,
      97.71069,
      98.24303,
      98.77719,
      99.31303,
      99.85039,
      100.3891,
      100.9289,
      101.4696,
      102.011,
      102.5529,
      103.0948,
      103.6367,
      104.1782,
      104.7191,
      105.259,
      105.7976,
      106.3348,
      106.8701,
      107.4033,
      107.9342,
      108.4624,
      108.9877,
      109.5099,
      110.0285,
      110.5435,
      111.0545,
      111.5613,
      112.0638,
      112.5616,
      113.0546,
      113.5427,
      114.0256,
      114.5031,
      114.9752,
      115.4418,
      115.9026,
      116.3577,
      116.8069,
      117.2502,
      117.6875,
      118.1189,
      118.5443,
      118.9638,
      119.3774,
      119.7852,
      120.1873,
      120.5838,
      120.9748,
      121.3606,
      121.7413,
      122.1171,
      122.4884,
      122.8555,
      123.2186,
      123.5782,
      123.9347,
      124.2885,
      124.6402,
      124.9902,
      125.3393,
      125.688,
      126.0371,
      126.3872,
      126.7392,
      127.094,
      127.4524,
      127.8154,
      128.184,
      128.5591,
      128.9419,
      129.3334,
      129.7346,
      130.1467,
      130.5705,
      131.0071,
      131.4573,
      131.9218,
      132.4013,
      132.8962,
      133.4067,
      133.9328,
      134.4742,
      135.0304,
      135.6004,
      136.1831,
      136.7769,
      137.3801,
      137.9905,
      138.6058,
      139.2236,
    ];

    final _listsadak15 = [
      80.52476,
      80.91946,
      81.73541,
      82.53699,
      83.31968,
      84.07998,
      84.81532,
      85.52398,
      86.205,
      86.85807,
      87.48344,
      88.08186,
      88.6545,
      89.20285,
      89.74875,
      90.28811,
      90.82228,
      91.35246,
      91.87972,
      92.40497,
      92.92901,
      93.45252,
      93.97609,
      94.50021,
      95.02528,
      95.55164,
      96.07954,
      96.60918,
      97.14072,
      97.67423,
      98.20976,
      98.74731,
      99.28686,
      99.82832,
      100.3716,
      100.9165,
      101.463,
      102.0109,
      102.5599,
      103.1098,
      103.6604,
      104.2115,
      104.7628,
      105.3141,
      105.865,
      106.4154,
      106.9648,
      107.5131,
      108.0599,
      108.605,
      109.148,
      109.6888,
      110.227,
      110.7623,
      111.2944,
      111.8232,
      112.3483,
      112.8696,
      113.3867,
      113.8995,
      114.4077,
      114.9112,
      115.4097,
      115.9031,
      116.3913,
      116.874,
      117.3512,
      117.8228,
      118.2886,
      118.7486,
      119.2028,
      119.6511,
      120.0935,
      120.53,
      120.9607,
      121.3855,
      121.8047,
      122.2182,
      122.6263,
      123.0291,
      123.4268,
      123.8196,
      124.2078,
      124.5916,
      124.9715,
      125.3478,
      125.7208,
      126.0911,
      126.4592,
      126.8255,
      127.1907,
      127.5554,
      127.9203,
      128.2861,
      128.6537,
      129.0238,
      129.3973,
      129.7752,
      130.1584,
      130.5479,
      130.9446,
      131.3496,
      131.7639,
      132.1885,
      132.6243,
      133.0721,
      133.5329,
      134.0072,
      134.4955,
      134.9983,
      135.5157,
      136.0476,
      136.5937,
      137.1534,
      137.7259,
      138.31,
      138.9043,
      139.507,
      140.1161,
      140.7295,
      141.3448,
      141.9594,
    ];
    List<double> _listsadak25 = [
      82.63524,
      83.04213,
      83.8943,
      84.72592,
      85.53389,
      86.31589,
      87.07028,
      87.79609,
      88.49291,
      89.16084,
      89.80045,
      90.4127,
      90.99891,
      91.56066,
      92.12298,
      92.67925,
      93.2307,
      93.7784,
      94.32334,
      94.86634,
      95.40817,
      95.94946,
      96.49076,
      97.03254,
      97.57519,
      98.11905,
      98.66436,
      99.21132,
      99.76009,
      100.3108,
      100.8634,
      101.418,
      101.9745,
      102.5329,
      103.093,
      103.6549,
      104.2182,
      104.7829,
      105.3488,
      105.9156,
      106.4831,
      107.0512,
      107.6194,
      108.1877,
      108.7556,
      109.323,
      109.8895,
      110.4549,
      111.0189,
      111.5812,
      112.1415,
      112.6996,
      113.255,
      113.8077,
      114.3572,
      114.9034,
      115.446,
      115.9847,
      116.5193,
      117.0496,
      117.5754,
      118.0964,
      118.6125,
      119.1235,
      119.6293,
      120.1297,
      120.6246,
      121.1138,
      121.5974,
      122.0753,
      122.5473,
      123.0135,
      123.4739,
      123.9285,
      124.3774,
      124.8207,
      125.2584,
      125.6906,
      126.1177,
      126.5396,
      126.9568,
      127.3694,
      127.7777,
      128.1822,
      128.5831,
      128.9808,
      129.3759,
      129.7689,
      130.1603,
      130.5506,
      130.9406,
      131.3309,
      131.7223,
      132.1156,
      132.5115,
      132.9109,
      133.3147,
      133.7239,
      134.1394,
      134.562,
      134.9929,
      135.4328,
      135.8826,
      136.3433,
      136.8154,
      137.2997,
      137.7967,
      138.3067,
      138.83,
      139.3664,
      139.9157,
      140.4775,
      141.051,
      141.6352,
      142.2288,
      142.8304,
      143.4381,
      144.0501,
      144.6641,
      145.278,
      145.8893,
      146.4958,
    ];

    List<double> _listsadak50 = [
      84.97556,
      85.39732,
      86.29026,
      87.15714,
      87.99602,
      88.80551,
      89.58477,
      90.33342,
      91.05154,
      91.73964,
      92.39854,
      93.02945,
      93.63382,
      94.21336,
      94.79643,
      95.37392,
      95.94693,
      96.51645,
      97.08337,
      97.64848,
      98.21247,
      98.77593,
      99.3394,
      99.90331,
      100.4681,
      101.0339,
      101.6012,
      102.17,
      102.7406,
      103.313,
      103.8873,
      104.4635,
      105.0415,
      105.6213,
      106.2029,
      106.7861,
      107.3707,
      107.9566,
      108.5436,
      109.1316,
      109.7202,
      110.3092,
      110.8984,
      111.4876,
      112.0764,
      112.6646,
      113.2519,
      113.838,
      114.4226,
      115.0055,
      115.5863,
      116.1648,
      116.7406,
      117.3136,
      117.8833,
      118.4496,
      119.0123,
      119.571,
      120.1254,
      120.6755,
      121.221,
      121.7617,
      122.2974,
      122.8279,
      123.3531,
      123.8728,
      124.387,
      124.8956,
      125.3985,
      125.8956,
      126.3869,
      126.8724,
      127.3522,
      127.8263,
      128.2947,
      128.7576,
      129.2152,
      129.6675,
      130.1148,
      130.5574,
      130.9954,
      131.4293,
      131.8593,
      132.2859,
      132.7094,
      133.1304,
      133.5493,
      133.9667,
      134.3832,
      134.7995,
      135.2163,
      135.6342,
      136.054,
      136.4766,
      136.9027,
      137.3333,
      137.7691,
      138.2112,
      138.6602,
      139.1172,
      139.5829,
      140.0581,
      140.5435,
      141.0397,
      141.5472,
      142.0664,
      142.5974,
      143.1404,
      143.695,
      144.2609,
      144.8376,
      145.424,
      146.0192,
      146.62107,
      147.23,
      147.8424,
      148.4569,
      149.0714,
      149.6839,
      150.292,
      150.8936,
      151.4866,
    ];

    List<double> _listsadak75 = [
      87.31121,
      87.74918,
      88.68344,
      89.58751,
      90.46018,
      91.30065,
      92.10859,
      92.88403,
      93.62741,
      94.33951,
      95.0214,
      95.67446,
      96.30029,
      96.90071,
      97.50724,
      98.10855,
      98.70568,
      99.29957,
      99.89104,
      100.4808,
      101.0696,
      101.6579,
      102.2462,
      102.835,
      103.4247,
      104.0154,
      104.6075,
      105.2012,
      105.7965,
      106.3936,
      106.9925,
      107.5933,
      108.1958,
      108.8001,
      109.406,
      110.0134,
      110.6222,
      111.2321,
      111.8431,
      112.4548,
      113.0671,
      113.6797,
      114.2923,
      114.9048,
      115.5167,
      116.1278,
      116.7379,
      117.3466,
      117.9537,
      118.5588,
      119.1616,
      119.7619,
      120.3594,
      120.9537,
      121.5447,
      122.132,
      122.7154,
      123.2946,
      123.8695,
      124.4397,
      125.0051,
      125.5655,
      126.1207,
      126.6706,
      127.215,
      127.7539,
      128.287,
      128.8144,
      129.3359,
      129.8516,
      130.3615,
      130.8656,
      131.364,
      131.8567,
      132.3438,
      132.8255,
      133.302,
      133.7734,
      134.2401,
      134.7023,
      135.1604,
      135.6146,
      136.0654,
      136.5132,
      136.9585,
      137.4018,
      137.8437,
      138.2847,
      138.7256,
      139.1669,
      139.6094,
      140.0538,
      140.501,
      140.9516,
      141.4065,
      141.8665,
      142.3324,
      142.8051,
      143.2852,
      143.7735,
      144.2707,
      144.7773,
      145.2938,
      145.8206,
      146.3579,
      146.9059,
      147.4643,
      148.0329,
      148.6111,
      149.1984,
      149.7937,
      150.3959,
      151.0036,
      151.6153,
      152.2293,
      152.8438,
      153.4568,
      154.0662,
      154.67,
      155.2663,
      155.8529,
      156.428,
    ];

    List<double> _listsadak90 = [
      89.40951,
      89.86316,
      90.83505,
      91.77421,
      92.67969,
      93.55097,
      94.38793,
      95.19083,
      95.9603,
      96.69729,
      97.40303,
      98.07904,
      98.72705,
      99.34899,
      99.97896,
      100.604,
      101.2251,
      101.8432,
      102.459,
      103.0732,
      103.6866,
      104.2996,
      104.9128,
      105.5264,
      106.141,
      106.7567,
      107.3737,
      107.9924,
      108.6127,
      109.2347,
      109.8585,
      110.4841,
      111.1114,
      111.7404,
      112.3709,
      113.0028,
      113.6359,
      114.2701,
      114.9052,
      115.5408,
      116.1768,
      116.813,
      117.449,
      118.0845,
      118.7193,
      119.3531,
      119.9855,
      120.6163,
      121.2452,
      121.8718,
      122.4959,
      123.1171,
      123.7352,
      124.3499,
      124.9608,
      125.5678,
      126.1705,
      126.7688,
      127.3623,
      127.951,
      128.5345,
      129.1127,
      129.6855,
      130.2526,
      130.814,
      131.3696,
      131.9194,
      132.4631,
      133.0009,
      133.5328,
      134.0587,
      134.5787,
      135.093,
      135.6015,
      136.1046,
      136.6024,
      137.095,
      137.5828,
      138.066,
      138.545,
      139.0201,
      139.4918,
      139.9604,
      140.4265,
      140.8906,
      141.3532,
      141.8149,
      142.2764,
      142.7382,
      143.2012,
      143.666,
      144.1333,
      144.6039,
      145.0785,
      145.5579,
      146.0429,
      146.5341,
      147.0322,
      147.5379,
      148.0517,
      148.5741,
      149.1054,
      149.646,
      150.196,
      150.7552,
      151.3236,
      151.9008,
      152.4861,
      153.079,
      153.6783,
      154.283,
      154.8918,
      155.5032,
      156.1156,
      156.7273,
      157.3365,
      157.9413,
      158.5398,
      159.1302,
      159.7107,
      160.2796,
      160.8353,
    ];

    List<double> _listsadak95 = [
      90.66355,
      91.12707,
      92.12168,
      93.08254,
      94.00873,
      94.89974,
      95.75551,
      96.57635,
      97.36295,
      98.11632,
      98.83778,
      99.52891,
      100.1915,
      100.8276,
      101.4726,
      102.1129,
      102.7494,
      103.383,
      104.0144,
      104.6444,
      105.2736,
      105.9025,
      106.5316,
      107.1613,
      107.7919,
      108.4238,
      109.057,
      109.6918,
      110.3283,
      110.9665,
      111.6066,
      112.2483,
      112.8917,
      113.5368,
      114.1833,
      114.8312,
      115.4802,
      116.1301,
      116.7808,
      117.432,
      118.0834,
      118.7348,
      119.3858,
      120.0362,
      120.6857,
      121.334,
      121.9807,
      122.6256,
      123.2684,
      123.9086,
      124.5461,
      125.1804,
      125.8114,
      126.4387,
      127.062,
      127.6811,
      128.2957,
      128.9056,
      129.5105,
      130.1103,
      130.7047,
      131.2936,
      131.8768,
      132.4542,
      133.0256,
      133.5911,
      134.1505,
      134.7038,
      135.251,
      135.7922,
      136.3273,
      136.8565,
      137.3798,
      137.8975,
      138.4097,
      138.9166,
      139.4184,
      139.9155,
      140.4082,
      140.8968,
      141.3817,
      141.8633,
      142.3422,
      142.8188,
      143.2937,
      143.7674,
      144.2406,
      144.7139,
      145.1879,
      145.6634,
      146.141,
      146.6215,
      147.1056,
      147.594,
      148.0874,
      148.5865,
      149.092,
      149.6044,
      150.1242,
      150.652,
      151.188,
      151.7325,
      152.2856,
      152.8473,
      153.4174,
      153.9955,
      154.5812,
      155.1737,
      155.7721,
      156.3755,
      156.9825,
      157.5918,
      158.202,
      158.8115,
      159.4185,
      160.0213,
      160.6182,
      161.2075,
      161.7874,
      162.3564,
      162.9129,
      163.4555,
    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,
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
  ///// نمودار قد برای پسران 2 تا 12 سال
  List<charts.Series<LinearSales, double>> _boyHeightYear() {

    List<LinearSales> _userInfo = [
      new LinearSales(
          double.parse((calculateAllMounth(_user.birthdate)/12).toString()),double.parse(_user.height))
    ];
    final _listsadak5 = [
      80.72977,
      81.08868,
      81.83445,
      82.56406,
      83.27899,
      83.98045,
      84.66948,
      85.34694,
      86.01357,
      86.66999,
      87.3168,
      87.95452,
      88.58366,
      89.20473,
      89.77301,
      90.33306,
      90.88532,
      91.43025,
      91.96832,
      92.49999,
      93.0257,
      93.54592,
      94.06109,
      94.57166,
      95.07806,
      95.5807,
      96.08,
      96.57635,
      97.07013,
      97.5617,
      98.05141,
      98.53958,
      99.02654,
      99.51256,
      99.99791,
      100.4828,
      100.9676,
      101.4523,
      101.9372,
      102.4225,
      102.9082,
      103.3945,
      103.8814,
      104.369,
      104.8574,
      105.3466,
      105.8364,
      106.327,
      106.8182,
      107.3099,
      107.8021,
      108.2946,
      108.7873,
      109.2801,
      109.7727,
      110.2649,
      110.7566,
      111.2476,
      111.7375,
      112.2263,
      112.7135,
      113.1991,
      113.6827,
      114.1642,
      114.6431,
      115.1194,
      115.5927,
      116.0629,
      116.5297,
      116.9928,
      117.4521,
      117.9074,
      118.3585,
      118.8053,
      119.2475,
      119.6851,
      120.1179,
      120.5459,
      120.969,
      121.3872,
      121.8004,
      122.2086,
      122.6119,
      123.0103,
      123.4039,
      123.7928,
      124.1771,
      124.5569,
      124.9325,
      125.304,
      125.6717,
      126.0358,
      126.3966,
      126.7544,
      127.1096,
      127.4624,
      127.8132,
      128.1625,
      128.5106,
      128.8579,
      129.2051,
      129.5524,
      129.9004,
      130.2496,
      130.6005,
      130.9536,
      131.3094,
      131.6686,
      132.0316,
      132.399,
      132.7714,
      133.1491,
      133.5329,
      133.9232,
      134.3205,
      134.7252,
      135.1378,
      135.5588,
      135.9885,
      136.4271,
      136.8751,
      137.3326,
    ];

    final _listsadak15 = [
      81.99171,
      82.36401,
      83.11387,
      83.84716,
      84.56534,
      85.26962,
      85.96098,
      86.64027,
      87.3082,
      87.9654,
      88.61244,
      89.24986,
      89.87816,
      90.49789,
      91.08608,
      91.66589,
      92.23779,
      92.80225,
      93.35972,
      93.91068,
      94.45556,
      94.99482,
      95.52888,
      96.05817,
      96.5831,
      97.10407,
      97.62147,
      98.13566,
      98.64701,
      99.15585,
      99.6625,
      100.1673,
      100.6705,
      101.1723,
      101.6731,
      102.173,
      102.6723,
      103.1712,
      103.6697,
      104.1682,
      104.6666,
      105.1651,
      105.6638,
      106.1627,
      106.6619,
      107.1614,
      107.6611,
      108.1612,
      108.6614,
      109.1619,
      109.6624,
      110.1629,
      110.6633,
      111.1634,
      111.6631,
      112.1623,
      112.6608,
      113.1583,
      113.6548,
      114.1499,
      114.6436,
      115.1356,
      115.6257,
      116.1136,
      116.5992,
      117.0822,
      117.5625,
      118.0398,
      118.5139,
      118.9847,
      119.4519,
      119.9153,
      120.3749,
      120.8305,
      121.2819,
      121.729,
      122.1716,
      122.6099,
      123.0435,
      123.4726,
      123.897,
      124.3168,
      124.7319,
      125.1425,
      125.5485,
      125.9501,
      126.3473,
      126.7402,
      127.1291,
      127.514,
      127.8953,
      128.273,
      128.6474,
      129.0189,
      129.3876,
      129.754,
      130.1183,
      130.4809,
      130.8422,
      131.2026,
      131.5625,
      131.9224,
      132.2828,
      132.6441,
      133.0068,
      133.3714,
      133.7386,
      134.1089,
      134.4828,
      134.8608,
      135.2437,
      135.6318,
      136.026,
      136.4266,
      136.8343,
      137.2496,
      137.673,
      138.105,
      138.5461,
      138.9968,
      139.4573,
      139.928,
    ];
    List<double> _listsadak25 = [
      84.10289,
      84.49471,
      85.25888,
      86.00517,
      86.73507,
      87.44977,
      88.15028,
      88.83745,
      89.51202,
      90.17464,
      90.82592,
      91.46645,
      92.0968,
      92.71756,
      93.3344,
      93.94268,
      94.54291,
      95.13557,
      95.72115,
      96.30009,
      96.87286,
      97.43989,
      98.00159,
      98.55838,
      99.11064,
      99.65875,
      100.2031,
      100.7439,
      101.2817,
      101.8166,
      102.3491,
      102.8792,
      103.4074,
      103.9339,
      104.4588,
      104.9825,
      105.505,
      106.0265,
      106.5472,
      107.0673,
      107.5868,
      108.1058,
      108.6244,
      109.1427,
      109.6607,
      110.1785,
      110.696,
      111.2132,
      111.7302,
      112.2469,
      112.7631,
      113.2789,
      113.7942,
      114.3089,
      114.8229,
      115.336,
      115.8481,
      116.3592,
      116.869,
      117.3774,
      117.8842,
      118.3893,
      118.8926,
      119.3938,
      119.8927,
      120.3893,
      120.8833,
      121.3746,
      121.863,
      122.3483,
      122.8305,
      123.3092,
      123.7845,
      124.2562,
      124.7242,
      125.1882,
      125.6484,
      126.1045,
      126.5565,
      127.0044,
      127.4481,
      127.8876,
      128.3228,
      128.7539,
      129.1807,
      129.6035,
      130.0222,
      130.4369,
      130.8477,
      131.2548,
      131.6584,
      132.0585,
      132.4555,
      132.8495,
      133.2407,
      133.6295,
      134.0161,
      134.4008,
      134.7841,
      135.1663,
      135.5477,
      135.9288,
      136.3101,
      136.692,
      137.075,
      137.4597,
      137.8466,
      138.2362,
      138.6292,
      139.0262,
      139.4278,
      139.8346,
      140.2472,
      140.6664,
      141.0928,
      141.5269,
      141.9694,
      142.4209,
      142.882,
      143.3532,
      143.835,
      144.3277,
    ];

    List<double> _listsadak50 = [
      86.4522,
      86.86161,
      87.65247,
      88.42326,
      89.17549,
      89.91041,
      90.62908,
      91.33242,
      92.02127,
      92.69638,
      93.35847,
      94.00823,
      94.64637,
      95.27359,
      95.91475,
      96.54734,
      97.17191,
      97.78898,
      98.39903,
      99.00254,
      99.59998,
      100.1918,
      100.7783,
      101.36,
      101.9373,
      102.5105,
      103.0799,
      103.6459,
      104.2087,
      104.7687,
      105.3262,
      105.8813,
      106.4343,
      106.9855,
      107.535,
      108.083,
      108.6296,
      109.1751,
      109.7196,
      110.2631,
      110.8058,
      111.3477,
      111.889,
      112.4296,
      112.9696,
      113.509,
      114.0479,
      114.5861,
      115.1238,
      115.6609,
      116.1973,
      116.7329,
      117.2678,
      117.8018,
      118.3348,
      118.8668,
      119.3977,
      119.9272,
      120.4554,
      120.9821,
      121.5072,
      122.0305,
      122.552,
      123.0714,
      123.5886,
      124.1035,
      124.616,
      125.1259,
      125.6331,
      126.1374,
      126.6388,
      127.137,
      127.632,
      128.1237,
      128.6119,
      129.0966,
      129.5777,
      130.055,
      130.5286,
      130.9983,
      131.4641,
      131.926,
      132.384,
      132.8381,
      133.2882,
      133.7345,
      134.1769,
      134.6155,
      135.0504,
      135.4818,
      135.9097,
      136.3343,
      136.7557,
      137.1742,
      137.5899,
      138.0032,
      138.4143,
      138.8234,
      139.231,
      139.6373,
      140.0427,
      140.4477,
      140.8527,
      141.2582,
      141.6646,
      142.0725,
      142.4824,
      142.8949,
      143.3107,
      143.7304,
      144.1545,
      144.5838,
      145.019,
      145.4607,
      145.9097,
      146.3665,
      146.832,
      147.3066,
      147.7911,
      148.2859,
      148.7917,
      149.3088,
    ];

    List<double> _listsadak75 = [
      88.80525,
      89.22805,
      90.05675,
      90.8626,
      91.64711,
      92.41159,
      93.15719,
      93.88496,
      94.59585,
      95.2908,
      95.97068,
      96.63637,
      97.28875,
      97.9287,
      98.58525,
      99.23358,
      99.87426,
      100.5078,
      101.1348,
      101.7556,
      102.3708,
      102.9807,
      103.5858,
      104.1865,
      104.7831,
      105.3759,
      105.9654,
      106.5518,
      107.1354,
      107.7165,
      108.2953,
      108.872,
      109.4469,
      110.0201,
      110.5919,
      111.1623,
      111.7316,
      112.2998,
      112.8671,
      113.4335,
      113.9992,
      114.5641,
      115.1284,
      115.6921,
      116.2551,
      116.8176,
      117.3794,
      117.9407,
      118.5012,
      119.0611,
      119.6203,
      120.1786,
      120.7361,
      121.2926,
      121.848,
      122.4024,
      122.9555,
      123.5073,
      124.0576,
      124.6064,
      125.1535,
      125.6987,
      126.2421,
      126.7834,
      127.3225,
      127.8594,
      128.3937,
      128.9256,
      129.4547,
      129.981,
      130.5044,
      131.0247,
      131.5419,
      132.0559,
      132.5664,
      133.0736,
      133.5771,
      134.0771,
      134.5734,
      135.066,
      135.5548,
      136.0397,
      136.5209,
      136.9982,
      137.4717,
      137.9414,
      138.4073,
      138.8696,
      139.3282,
      139.7833,
      140.235,
      140.6835,
      141.1289,
      141.5713,
      142.0111,
      142.4484,
      142.8835,
      143.3168,
      143.7484,
      144.1789,
      144.6085,
      145.0377,
      145.4669,
      145.8965,
      146.3272,
      146.7593,
      147.1936,
      147.6305,
      148.0707,
      148.5147,
      148.9633,
      149.4172,
      149.8769,
      150.3433,
      150.8169,
      151.2984,
      151.7885,
      152.2878,
      152.7969,
      153.3164,
      153.8466,
      154.3881,
    ];

    List<double> _listsadak90 = [
      90.92619,
      91.35753,
      92.22966,
      93.07608,
      93.89827,
      94.69757,
      95.47522,
      96.23239,
      96.97022,
      97.68978,
      98.39218,
      99.07848,
      99.74979,
      100.4072,
      101.069,
      101.7234,
      102.3709,
      103.012,
      103.6473,
      104.2771,
      104.9021,
      105.5225,
      106.1387,
      106.7513,
      107.3604,
      107.9665,
      108.5698,
      109.1706,
      109.7693,
      110.366,
      110.9609,
      111.5543,
      112.1464,
      112.7374,
      113.3273,
      113.9164,
      114.5047,
      115.0924,
      115.6795,
      116.2661,
      116.8522,
      117.438,
      118.0234,
      118.6084,
      119.1931,
      119.7774,
      120.3613,
      120.9447,
      121.5277,
      122.1101,
      122.6918,
      123.2729,
      123.8532,
      124.4327,
      125.0111,
      125.5884,
      126.1646,
      126.7394,
      127.3128,
      127.8846,
      128.4547,
      129.023,
      129.5893,
      130.1535,
      130.7154,
      131.275,
      131.8321,
      132.3865,
      132.9381,
      133.4868,
      134.0325,
      134.5751,
      135.1144,
      135.6504,
      136.1829,
      136.7118,
      137.2371,
      137.7587,
      138.2765,
      138.7905,
      139.3006,
      139.8069,
      140.3093,
      140.8077,
      141.3023,
      141.793,
      142.28,
      142.7632,
      143.2428,
      143.7188,
      144.1915,
      144.661,
      145.1273,
      145.5909,
      146.0518,
      146.5103,
      146.9668,
      147.4214,
      147.8747,
      148.3268,
      148.7782,
      149.2294,
      149.6808,
      150.1329,
      150.5861,
      151.041,
      151.4982,
      151.9583,
      152.4218,
      152.8894,
      153.3617,
      153.8394,
      154.323,
      154.8133,
      155.3109,
      155.8164,
      156.3303,
      156.8532,
      157.3857,
      157.928,
      158.4807,
      159.0439,
    ];

    List<double> _listsadak95 = [
      92.19688,
      92.63177,
      93.53407,
      94.40885,
      95.25754,
      96.08149,
      96.88198,
      97.66027,
      98.41758,
      99.15514,
      99.87416,
      100.5759,
      101.2615,
      101.9324,
      102.593,
      103.247,
      103.8948,
      104.537,
      105.1739,
      105.8061,
      106.434,
      107.0579,
      107.6784,
      108.2956,
      108.9101,
      109.522,
      110.1317,
      110.7394,
      111.3454,
      111.95,
      112.5533,
      113.1555,
      113.7568,
      114.3574,
      114.9575,
      115.557,
      116.1561,
      116.755,
      117.3536,
      117.9521,
      118.5505,
      119.1487,
      119.7469,
      120.345,
      120.943,
      121.5408,
      122.1384,
      122.7359,
      123.333,
      123.9297,
      124.526,
      125.1217,
      125.7168,
      126.3111,
      126.9045,
      127.4969,
      128.0882,
      128.6782,
      129.2668,
      129.8538,
      130.4392,
      131.0226,
      131.6041,
      132.1834,
      132.7605,
      133.335,
      133.907,
      134.4763,
      135.0426,
      135.606,
      136.1662,
      136.7231,
      137.2767,
      137.8267,
      138.3731,
      138.9159,
      139.4548,
      139.9899,
      140.5211,
      141.0484,
      141.5716,
      142.0908,
      142.6061,
      143.1173,
      143.6245,
      144.1278,
      144.6272,
      145.1228,
      145.6148,
      146.1032,
      146.5882,
      147.0699,
      147.5486,
      148.0245,
      148.4979,
      148.9689,
      149.438,
      149.9053,
      150.3714,
      150.8365,
      151.301,
      151.7655,
      152.2303,
      152.696,
      153.1631,
      153.6321,
      154.1035,
      154.578,
      155.0562,
      155.5386,
      156.0258,
      156.5186,
      157.0174,
      157.5229,
      158.0356,
      158.5562,
      159.0851,
      159.6228,
      160.1697,
      160.7262,
      161.2924,
      161.8686,
    ];
    List<double> month = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,
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
    double bmi = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    double month=(calculateAllMounth(_user.birthdate)/12);

    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(month<=24)
    {
      if(bmi<15.52)
        _type=1;
      else if(bmi>=15.52&&bmi<=17.42)
        _type=2;
      else if(bmi>17.42)
        _type=3;
    }
    else if(month>24&&month<=24.5)
    {
      if(bmi<15.49)
        _type=1;
      else if(bmi>=15.49&&bmi<=17.38)
        _type=2;
      else if(bmi>17.38)
        _type=3;
    }

    else if(month>24.5&&month<=25.5)
    {
      if(bmi<15.44)
        _type=1;
      else if(bmi>=15.44&&bmi<=17.30)
        _type=2;
      else if(bmi>17.30)
        _type=3;
    }
    else if(month>25.5&&month<=26.5)
    {
      if(bmi<15.39)
        _type=1;
      else if(bmi>=15.39&&bmi<=17.22)
        _type=2;
      else if(bmi>17.22)
        _type=3;
    }
    else if(month>26.5&&month<=27.5)
    {
      if(bmi<15.33)
        _type=1;
      else if(bmi>=15.33&&bmi<=17.15)
        _type=2;
      else if(bmi>17.15)
        _type=3;
    }

    else if(month>27.5&&month<=28.5)
    {
      if(bmi<15.28)
        _type=1;
      else if(bmi>=15.28&&bmi<=17.08)
        _type=2;
      else if(bmi>17.08)
        _type=3;
    }

    else if(month>28.5&&month<=29.5)
    {
      if(bmi<15.23)
        _type=1;
      else if(bmi>=15.23&&bmi<=17.01)
        _type=2;
      else if(bmi>17.01)
        _type=3;
    }

    else if(month>29.5&&month<=30.5)
    {
      if(bmi<15.18)
        _type=1;
      else if(bmi>=15.18&&bmi<=16.94)
        _type=2;
      else if(bmi>16.94)
        _type=3;
    }

    else if(month>30.5&&month<=31.5)
    {
      if(bmi<15.14)
        _type=1;
      else if(bmi>=15.14&&bmi<=16.88)
        _type=2;
      else if(bmi>16.88)
        _type=3;
    }

    else if(month>31.5&&month<=32.5)
    {
      if(bmi<15.09)
        _type=1;
      else if(bmi>=15.09&&bmi<=16.82)
        _type=2;
      else if(bmi>16.82)
        _type=3;
    }
    else if(month>32.5&&month<=33.5)
    {
      if(bmi<15.05)
        _type=1;
      else if(bmi>=15.05&&bmi<=16.76)
        _type=2;
      else if(bmi>16.76)
        _type=3;
    }
    else if(month>33.5&&month<=34.5)
    {
      if(bmi<15.01)
        _type=1;
      else if(bmi>=15.01&&bmi<=16.70)
        _type=2;
      else if(bmi>16.70)
        _type=3;
    }
    else if(month>34.5&&month<=35.5)
    {
      if(bmi<14.96)
        _type=1;
      else if(bmi>=14.96&&bmi<=16.65)
        _type=2;
      else if(bmi>16.65)
        _type=3;
    }

    else if(month>35.5&&month<=36.5)
    {
      if(bmi<14.92)
        _type=1;
      else if(bmi>=14.92&&bmi<=16.60)
        _type=2;
      else if(bmi>16.60)
        _type=3;
    }

    else if(month>36.5&&month<=37.5)
    {
      if(bmi<14.89)
        _type=1;
      else if(bmi>=14.89&&bmi<=16.55)
        _type=2;
      else if(bmi>16.55)
        _type=3;
    }

    else if(month>37.5&&month<=38.5)
    {
      if(bmi<14.85)
        _type=1;
      else if(bmi>=14.85&&bmi<=16.51)
        _type=2;
      else if(bmi>16.51)
        _type=3;
    }

    else if(month>38.5&&month<=39.5)
    {
      if(bmi<14.81)
        _type=1;
      else if(bmi>=14.81&&bmi<=16.47)
        _type=2;
      else if(bmi>16.47)
        _type=3;
    }

    else if(month>39.5&&month<=40.5)
    {
      if(bmi<14.78)
        _type=1;
      else if(bmi>=14.78&&bmi<=16.43)
        _type=2;
      else if(bmi>16.43)
        _type=3;
    }

    else if(month>40.5&&month<=41.5)
    {
      if(bmi<14.75)
        _type=1;
      else if(bmi>=14.75&&bmi<=16.39)
        _type=2;
      else if(bmi>16.39)
        _type=3;
    }
    else if(month>41.5&&month<=42.5)
    {
      if(bmi<14.72)
        _type=1;
      else if(bmi>=14.72&&bmi<=16.36)
        _type=2;
      else if(bmi>16.36)
        _type=3;
    }
    else if(month>42.5&&month<=43.5)
    {
      if(bmi<14.69)
        _type=1;
      else if(bmi>=14.69&&bmi<=16.33)
        _type=2;
      else if(bmi>16.33)
        _type=3;
    }

    else if(month>43.5&&month<=44.5)
    {
      if(bmi<14.66)
        _type=1;
      else if(bmi>=14.66&&bmi<=16.30)
        _type=2;
      else if(bmi>16.30)
        _type=3;
    }

    else if(month>44.5&&month<=45.5)
    {
      if(bmi<14.63)
        _type=1;
      else if(bmi>=14.63&&bmi<=16.27)
        _type=2;
      else if(bmi>16.27)
        _type=3;
    }
    else if(month>45.5&&month<=46.5)
    {
      if(bmi<14.61)
        _type=1;
      else if(bmi>=14.61&&bmi<=16.25)
        _type=2;
      else if(bmi>16.25)
        _type=3;
    }

    else if(month>46.5&&month<=47.5)
    {
      if(bmi<14.58)
        _type=1;
      else if(bmi>=14.58&&bmi<=16.22)
        _type=2;
      else if(bmi>16.22)
        _type=3;
    }

    else if(month>47.5&&month<=48.5)
    {
      if(bmi<14.56)
        _type=1;
      else if(bmi>=14.56&&bmi<=16.20)
        _type=2;
      else if(bmi>16.20)
        _type=3;
    }

    else if(month>48.5&&month<=49.5)
    {
      if(bmi<14.54)
        _type=1;
      else if(bmi>=14.54&&bmi<=16.19)
        _type=2;
      else if(bmi>16.19)
        _type=3;
    }
    else if(month>49.5&&month<=50.5)
    {
      if(bmi<14.52)
        _type=1;
      else if(bmi>=14.52&&bmi<=16.17)
        _type=2;
      else if(bmi>16.17)
        _type=3;
    }
    else if(month>50.5&&month<=51.5)
    {
      if(bmi<14.50)
        _type=1;
      else if(bmi>=14.50&&bmi<=16.16)
        _type=2;
      else if(bmi>16.16)
        _type=3;
    }
    else if(month>51.5&&month<=52.5)
    {
      if(bmi<14.48)
        _type=1;
      else if(bmi>=14.48&&bmi<=16.15)
        _type=2;
      else if(bmi>16.15)
        _type=3;
    }

    else if(month>52.5&&month<=53.5)
    {
      if(bmi<14.46)
        _type=1;
      else if(bmi>=14.46&&bmi<=16.14)
        _type=2;
      else if(bmi>16.14)
        _type=3;
    }

    else if(month>53.5&&month<=54.5)
    {
      if(bmi<14.45)
        _type=1;
      else if(bmi>=14.45&&bmi<=16.13)
        _type=2;
      else if(bmi>16.13)
        _type=3;
    }
    else if(month>54.5&&month<=55.5)
    {
      if(bmi<14.43)
        _type=1;
      else if(bmi>=14.43&&bmi<=16.13)
        _type=2;
      else if(bmi>16.13)
        _type=3;
    }
    else if(month>55.5&&month<=56.5)
    {
      if(bmi<14.42)
        _type=1;
      else if(bmi>=14.42&&bmi<=16.1297)
        _type=2;
      else if(bmi>16.1297)
        _type=3;
    }

    else if(month>56.5&&month<=57.5)
    {
      if(bmi<14.41)
        _type=1;
      else if(bmi>=14.41&&bmi<=16.1290)
        _type=2;
      else if(bmi>16.1290)
        _type=3;
    }

    else if(month>57.5&&month<=58.5)
    {
      if(bmi<14.40)
        _type=1;
      else if(bmi>=14.40&&bmi<=16.1302)
        _type=2;
      else if(bmi>16.1302)
        _type=3;
    }

    else if(month>58.5&&month<=59.5)
    {
      if(bmi<14.39)
        _type=1;
      else if(bmi>=14.39&&bmi<=16.133)
        _type=2;
      else if(bmi>16.133)
        _type=3;
    }
    else if(month>59.5&&month<=60.5)
    {
      if(bmi<14.38)
        _type=1;
      else if(bmi>=14.38&&bmi<=16.138)
        _type=2;
      else if(bmi>16.138)
        _type=3;
    }
    else if(month>60.5&&month<=61.5)
    {
      if(bmi<14.37)
        _type=1;
      else if(bmi>=14.37&&bmi<=16.145)
        _type=2;
      else if(bmi>16.145)
        _type=3;
    }
    else if(month>61.5&&month<=62.5)
    {
      if(bmi<14.369)
        _type=1;
      else if(bmi>=14.369&&bmi<=16.154)
        _type=2;
      else if(bmi>16.154)
        _type=3;
    }
    else if(month>62.5&&month<=63.5)
    {
      if(bmi<14.364)
        _type=1;
      else if(bmi>=14.364&&bmi<=16.164)
        _type=2;
      else if(bmi>16.164)
        _type=3;
    }
    else if(month>63.5&&month<=64.5)
    {
      if(bmi<14.360)
        _type=1;
      else if(bmi>=14.360&&bmi<=16.176)
        _type=2;
      else if(bmi>16.176)
        _type=3;
    }

    else if(month>64.5&&month<=65.5)
    {
      if(bmi<14.357)
        _type=1;
      else if(bmi>=14.357&&bmi<=16.190)
        _type=2;
      else if(bmi>16.190)
        _type=3;
    }

    else if(month>65.5&&month<=66.5)
    {
      if(bmi<14.355)
        _type=1;
      else if(bmi>=14.355&&bmi<=16.206)
        _type=2;
      else if(bmi>16.206)
        _type=3;
    }

    else if(month>66.5&&month<=67.5)
    {
      if(bmi<14.3547)
        _type=1;
      else if(bmi>=14.3547&&bmi<=16.223)
        _type=2;
      else if(bmi>16.223)
        _type=3;
    }

    else if(month>67.5&&month<=68.5)
    {
      if(bmi<14.3549)
        _type=1;
      else if(bmi>=14.3549&&bmi<=16.242)
        _type=2;
      else if(bmi>16.242)
        _type=3;
    }
    else if(month>68.5&&month<=69.5)
    {
      if(bmi<14.356)
        _type=1;
      else if(bmi>=14.356&&bmi<=16.262)
        _type=2;
      else if(bmi>16.262)
        _type=3;
    }
    else if(month>69.5&&month<=70.5)
    {
      if(bmi<14.358)
        _type=1;
      else if(bmi>=14.358&&bmi<=16.284)
        _type=2;
      else if(bmi>16.284)
        _type=3;
    }

    else if(month>70.5&&month<=71.5)
    {
      if(bmi<14.361)
        _type=1;
      else if(bmi>=14.361&&bmi<=16.307)
        _type=2;
      else if(bmi>16.307)
        _type=3;
    }

    else if(month>71.5&&month<=72.5)
    {
      if(bmi<14.355)
        _type=1;
      else if(bmi>=14.365&&bmi<=16.332)
        _type=2;
      else if(bmi>16.332)
        _type=3;
    }

    else if(month>72.5&&month<=73.5)
    {
      if(bmi<14.370)
        _type=1;
      else if(bmi>=14.370&&bmi<=16.359)
        _type=2;
      else if(bmi>16.359)
        _type=3;
    }
    else if(month>73.5&&month<=74.5)
    {
      if(bmi<14.376)
        _type=1;
      else if(bmi>=14.376&&bmi<=16.386)
        _type=2;
      else if(bmi>16.386)
        _type=3;
    }

    else if(month>74.5&&month<=75.5)
    {
      if(bmi<14.383)
        _type=1;
      else if(bmi>=14.383&&bmi<=16.415)
        _type=2;
      else if(bmi>16.415)
        _type=3;
    }

    else if(month>75.5&&month<=76.5)
    {
      if(bmi<14.391)
        _type=1;
      else if(bmi>=14.391&&bmi<=16.446)
        _type=2;
      else if(bmi>16.446)
        _type=3;
    }

    else if(month>76.5&&month<=77.5)
    {
      if(bmi<14.40)
        _type=1;
      else if(bmi>=14.40&&bmi<=16.47)
        _type=2;
      else if(bmi>16.47)
        _type=3;
    }

    else if(month>77.5&&month<=78.5)
    {
      if(bmi<14.41)
        _type=1;
      else if(bmi>=14.41&&bmi<=16.51)
        _type=2;
      else if(bmi>16.51)
        _type=3;
    }

    else if(month>78.5&&month<=79.5)
    {
      if(bmi<14.42)
        _type=1;
      else if(bmi>=14.42&&bmi<=16.54)
        _type=2;
      else if(bmi>16.54)
        _type=3;
    }

    else if(month>79.5&&month<=80.5)
    {
      if(bmi<14.43)
        _type=1;
      else if(bmi>=14.43&&bmi<=16.58)
        _type=2;
      else if(bmi>16.58)
        _type=3;
    }

    else if(month>80.5&&month<=81.5)
    {
      if(bmi<14.44)
        _type=1;
      else if(bmi>=14.44&&bmi<=16.61)
        _type=2;
      else if(bmi>16.61)
        _type=3;
    }
    else if(month>81.5&&month<=82.5)
    {
      if(bmi<14.45)
        _type=1;
      else if(bmi>=14.45&&bmi<=16.65)
        _type=2;
      else if(bmi>16.65)
        _type=3;
    }

    else if(month>82.5&&month<=83.5)
    {
      if(bmi<14.47)
        _type=1;
      else if(bmi>=14.47&&bmi<=16.69)
        _type=2;
      else if(bmi>16.69)
        _type=3;
    }

    else if(month>83.5&&month<=84.5)
    {
      if(bmi<14.48)
        _type=1;
      else if(bmi>=14.48&&bmi<=16.73)
        _type=2;
      else if(bmi>16.73)
        _type=3;
    }

    else if(month>84.5&&month<=85.5)
    {
      if(bmi<14.50)
        _type=1;
      else if(bmi>=14.50&&bmi<=16.77)
        _type=2;
      else if(bmi>16.77)
        _type=3;
    }
    else if(month>85.5&&month<=86.5)
    {
      if(bmi<14.52)
        _type=1;
      else if(bmi>=14.52&&bmi<=16.81)
        _type=2;
      else if(bmi>16.81)
        _type=3;
    }

    else if(month>86.5&&month<=87.5)
    {
      if(bmi<14.53)
        _type=1;
      else if(bmi>=14.53&&bmi<=16.86)
        _type=2;
      else if(bmi>16.86)
        _type=3;
    }

    else if(month>87.5&&month<=88.5)
    {
      if(bmi<14.55)
        _type=1;
      else if(bmi>=14.55&&bmi<=16.90)
        _type=2;
      else if(bmi>16.90)
        _type=3;
    }

    else if(month>88.5&&month<=89.5)
    {
      if(bmi<14.57)
        _type=1;
      else if(bmi>=14.57&&bmi<=16.95)
        _type=2;
      else if(bmi>16.95)
        _type=3;
    }

    else if(month>89.5&&month<=90.5)
    {
      if(bmi<14.59)
        _type=1;
      else if(bmi>=14.59&&bmi<=16.99)
        _type=2;
      else if(bmi>16.99)
        _type=3;
    }

    else if(month>90.5&&month<=91.5)
    {
      if(bmi<14.61)
        _type=1;
      else if(bmi>=14.61&&bmi<=17.04)
        _type=2;
      else if(bmi>17.04)
        _type=3;
    }

    else if(month>91.5&&month<=92.5)
    {
      if(bmi<14.63)
        _type=1;
      else if(bmi>=14.63&&bmi<=17.09)
        _type=2;
      else if(bmi>17.09)
        _type=3;
    }

    else if(month>92.5&&month<=93.5)
    {
      if(bmi<14.65)
        _type=1;
      else if(bmi>=14.65&&bmi<=17.14)
        _type=2;
      else if(bmi>17.14)
        _type=3;
    }
    else if(month>93.5&&month<=94.5)
    {
      if(bmi<14.68)
        _type=1;
      else if(bmi>=14.68&&bmi<=17.19)
        _type=2;
      else if(bmi>17.19)
        _type=3;
    }

    else if(month>94.5&&month<=95.5)
    {
      if(bmi<14.70)
        _type=1;
      else if(bmi>=14.70&&bmi<=17.24)
        _type=2;
      else if(bmi>17.24)
        _type=3;
    }

    else if(month>95.5&&month<=96.5)
    {
      if(bmi<14.73)
        _type=1;
      else if(bmi>=14.73&&bmi<=17.29)
        _type=2;
      else if(bmi>17.29)
        _type=3;
    }

    else if(month>96.5&&month<=97.5)
    {
      if(bmi<14.75)
        _type=1;
      else if(bmi>=14.75&&bmi<=17.34)
        _type=2;
      else if(bmi>17.34)
        _type=3;
    }

    else if(month>97.5&&month<=98.5)
    {
      if(bmi<14.78)
        _type=1;
      else if(bmi>=14.78&&bmi<=17.39)
        _type=2;
      else if(bmi>17.39)
        _type=3;
    }

    else if(month>98.5&&month<=99.5)
    {
      if(bmi<14.80)
        _type=1;
      else if(bmi>=14.80&&bmi<=17.45)
        _type=2;
      else if(bmi>17.45)
        _type=3;
    }

    else if(month>99.5&&month<=100.5)
    {
      if(bmi<14.83)
        _type=1;
      else if(bmi>=14.83&&bmi<=17.50)
        _type=2;
      else if(bmi>17.50)
        _type=3;
    }



    else if(month>100.5&&month<=101.5)
    {
      if(bmi<14.86)
        _type=1;
      else if(bmi>=14.86&&bmi<=17.55)
        _type=2;
      else if(bmi>17.55)
        _type=3;
    }
    else if(month>101.5&&month<=102.5)
    {
      if(bmi<14.89)
        _type=1;
      else if(bmi>=14.89&&bmi<=17.61)
        _type=2;
      else if(bmi>17.61)
        _type=3;
    }
    else if(month>102.5&&month<=103.5)
    {
      if(bmi<14.91)
        _type=1;
      else if(bmi>=14.91&&bmi<=17.67)
        _type=2;
      else if(bmi>17.67)
        _type=3;
    }
    else if(month>103.5&&month<=104.5)
    {
      if(bmi<14.94)
        _type=1;
      else if(bmi>=14.94&&bmi<=17.72)
        _type=2;
      else if(bmi>17.72)
        _type=3;
    }
    else if(month>104.5&&month<=105.5)
    {
      if(bmi<14.97)
        _type=1;
      else if(bmi>=14.97&&bmi<=17.78)
        _type=2;
      else if(bmi>17.78)
        _type=3;
    }
    else if(month>105.5&&month<=106.5)
    {
      if(bmi<15.01)
        _type=1;
      else if(bmi>=15.01&&bmi<=17.84)
        _type=2;
      else if(bmi>17.84)
        _type=3;
    }

    else if(month>106.5&&month<=107.5)
    {
      if(bmi<15.04)
        _type=1;
      else if(bmi>=15.04&&bmi<=17.90)
        _type=2;
      else if(bmi>17.90)
        _type=3;
    }
    else if(month>107.5&&month<=108.5)
    {
      if(bmi<15.07)
        _type=1;
      else if(bmi>=15.07&&bmi<=17.95)
        _type=2;
      else if(bmi>17.95)
        _type=3;
    }

    else if(month>108.5&&month<=109.5)
    {
      if(bmi<15.10)
        _type=1;
      else if(bmi>=15.10&&bmi<=18.01)
        _type=2;
      else if(bmi>18.01)
        _type=3;
    }

    else if(month>109.5&&month<=110.5)
    {
      if(bmi<15.13)
        _type=1;
      else if(bmi>=15.13&&bmi<=18.07)
        _type=2;
      else if(bmi>18.07)
        _type=3;
    }

    else if(month>110.5&&month<=111.5)
    {
      if(bmi<15.17)
        _type=1;
      else if(bmi>=15.17&&bmi<=18.13)
        _type=2;
      else if(bmi>18.13)
        _type=3;
    }
    else if(month>111.5&&month<=112.5)
    {
      if(bmi<15.20)
        _type=1;
      else if(bmi>=15.20&&bmi<=18.19)
        _type=2;
      else if(bmi>18.19)
        _type=3;
    }
    else if(month>112.5&&month<=113.5)
    {
      if(bmi<15.24)
        _type=1;
      else if(bmi>=15.24&&bmi<=18.25)
        _type=2;
      else if(bmi>18.25)
        _type=3;
    }
    else if(month>113.5&&month<=114.5)
    {
      if(bmi<15.27)
        _type=1;
      else if(bmi>=15.27&&bmi<=18.32)
        _type=2;
      else if(bmi>18.32)
        _type=3;
    }

    else if(month>114.5&&month<=115.5)
    {
      if(bmi<15.31)
        _type=1;
      else if(bmi>=15.31&&bmi<=18.38)
        _type=2;
      else if(bmi>18.38)
        _type=3;
    }

    else if(month>115.5&&month<=116.5)
    {
      if(bmi<15.34)
        _type=1;
      else if(bmi>=15.34&&bmi<=18.44)
        _type=2;
      else if(bmi>18.44)
        _type=3;
    }
    else if(month>116.5&&month<=117.5)
    {
      if(bmi<15.38)
        _type=1;
      else if(bmi>=15.38&&bmi<=18.50)
        _type=2;
      else if(bmi>18.50)
        _type=3;
    }

    else if(month>117.5&&month<=118.5)
    {
      if(bmi<15.42)
        _type=1;
      else if(bmi>=15.42&&bmi<=18.56)
        _type=2;
      else if(bmi>18.56)
        _type=3;
    }
    else if(month>118.5&&month<=119.5)
    {
      if(bmi<15.46)
        _type=1;
      else if(bmi>=15.46&&bmi<=18.63)
        _type=2;
      else if(bmi>18.63)
        _type=3;
    }
    else if(month>119.5&&month<=120.5)
    {
      if(bmi<15.49)
        _type=1;
      else if(bmi>=15.49&&bmi<=18.69)
        _type=2;
      else if(bmi>18.69)
        _type=3;
    }

    else if(month>120.5&&month<=121.5)
    {
      if(bmi<15.53)
        _type=1;
      else if(bmi>=15.53&&bmi<=18.75)
        _type=2;
      else if(bmi>18.75)
        _type=3;
    }
    else if(month>121.5&&month<=122.5)
    {
      if(bmi<15.57)
        _type=1;
      else if(bmi>=15.57&&bmi<=18.82)
        _type=2;
      else if(bmi>18.82)
        _type=3;
    }

    else if(month>122.5&&month<=123.5)
    {
      if(bmi<15.61)
        _type=1;
      else if(bmi>=15.61&&bmi<=18.88)
        _type=2;
      else if(bmi>18.88)
        _type=3;
    }
    else if(month>123.5&&month<=124.5)
    {
      if(bmi<15.65)
        _type=1;
      else if(bmi>=15.65&&bmi<=18.94)
        _type=2;
      else if(bmi>18.94)
        _type=3;
    }

    else if(month>124.5&&month<=125.5)
    {
      if(bmi<15.69)
        _type=1;
      else if(bmi>=15.69&&bmi<=19.01)
        _type=2;
      else if(bmi>19.01)
        _type=3;
    }
    else if(month>125.5&&month<=126.5)
    {
      if(bmi<15.73)
        _type=1;
      else if(bmi>=15.73&&bmi<=19.07)
        _type=2;
      else if(bmi>19.07)
        _type=3;
    }
    else if(month>126.5&&month<=127.5)
    {
      if(bmi<15.77)
        _type=1;
      else if(bmi>=15.77&&bmi<=19.14)
        _type=2;
      else if(bmi>19.14)
        _type=3;
    }
    else if(month>127.5&&month<=128.5)
    {
      if(bmi<15.82)
        _type=1;
      else if(bmi>=15.82&&bmi<=19.20)
        _type=2;
      else if(bmi>19.20)
        _type=3;
    }

    else if(month>128.5&&month<=129.5)
    {
      if(bmi<15.86)
        _type=1;
      else if(bmi>=15.86&&bmi<=19.27)
        _type=2;
      else if(bmi>19.27)
        _type=3;
    }

    else if(month>129.5&&month<=130.5)
    {
      if(bmi<15.90)
        _type=1;
      else if(bmi>=15.90&&bmi<=19.33)
        _type=2;
      else if(bmi>19.33)
        _type=3;
    }
    else if(month>130.5&&month<=131.5)
    {
      if(bmi<15.94)
        _type=1;
      else if(bmi>=15.94&&bmi<=19.40)
        _type=2;
      else if(bmi>19.40)
        _type=3;
    }
    else if(month>131.5&&month<=132.5)
    {
      if(bmi<15.98)
        _type=1;
      else if(bmi>=15.98&&bmi<=19.46)
        _type=2;
      else if(bmi>19.46)
        _type=3;
    }
    else if(month>132.5&&month<=133.5)
    {
      if(bmi<16.03)
        _type=1;
      else if(bmi>=16.03&&bmi<=19.52)
        _type=2;
      else if(bmi>19.52)
        _type=3;
    }

    else if(month>133.5&&month<=134.5)
    {
      if(bmi<16.07)
        _type=1;
      else if(bmi>=16.07&&bmi<=19.59)
        _type=2;
      else if(bmi>19.59)
        _type=3;
    }
    else if(month>134.5&&month<=135.5)
    {
      if(bmi<16.11)
        _type=1;
      else if(bmi>=16.11&&bmi<=19.65)
        _type=2;
      else if(bmi>19.65)
        _type=3;
    }
    else if(month>135.5&&month<=136.5)
    {
      if(bmi<16.16)
        _type=1;
      else if(bmi>=16.16&&bmi<=19.72)
        _type=2;
      else if(bmi>19.72)
        _type=3;
    }
    else if(month>136.5&&month<=137.5)
    {
      if(bmi<16.20)
        _type=1;
      else if(bmi>=16.20&&bmi<=19.78)
        _type=2;
      else if(bmi>19.78)
        _type=3;
    }
    else if(month>137.5&&month<=138.5)
    {
      if(bmi<16.25)
        _type=1;
      else if(bmi>=16.25&&bmi<=19.85)
        _type=2;
      else if(bmi>19.85)
        _type=3;
    }
    else if(month>138.5&&month<=139.5)
    {
      if(bmi<16.29)
        _type=1;
      else if(bmi>=16.29&&bmi<=19.91)
        _type=2;
      else if(bmi>19.91)
        _type=3;
    }
    else if(month>139.5&&month<=140.5)
    {
      if(bmi<16.34)
        _type=1;
      else if(bmi>=16.34&&bmi<=19.98)
        _type=2;
      else if(bmi>19.98)
        _type=3;
    }

    else if(month>140.5&&month<=141.5)
    {
      if(bmi<16.38)
        _type=1;
      else if(bmi>=16.38&&bmi<=20.04)
        _type=2;
      else if(bmi>20.04)
        _type=3;
    }
    else if(month>141.5&&month<=142.5)
    {
      if(bmi<16.43)
        _type=1;
      else if(bmi>=16.43&&bmi<=20.10)
        _type=2;
      else if(bmi>20.10)
        _type=3;
    }
    else if(month>142.5&&month<=143.5)
    {
      if(bmi<16.47)
        _type=1;
      else if(bmi>=16.47&&bmi<=20.17)
        _type=2;
      else if(bmi>20.17)
        _type=3;
    }

    else if(month>143.5&&month<=144.5)
    {
      if(bmi<16.52)
        _type=1;
      else if(bmi>=16.52&&bmi<=20.23)
        _type=2;
      else if(bmi>20.23)
        _type=3;
    }
    else if(month>144.5)
    {
      if(bmi<16.56)
        _type=1;
      else if(bmi>=16.56&&bmi<=20.30)
        _type=2;
      else if(bmi>20.30)
        _type=3;
    }


    return _type;
  }
  calculateTypeBoy(){
    double bmi = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    double month=(calculateAllMounth(_user.birthdate)/12);

    int _type=0;
    //1>>loss
    //2>>normal
    //3>>extra

    if(month<=24)
    {
      if(bmi<15.74)
        _type=1;
      else if(bmi>=15.74&&bmi<=17.55)
        _type=2;
      else if(bmi>17.55)
        _type=3;
    }
    else if(month>24&&month<=24.5)
    {
      if(bmi<15.71)
        _type=1;
      else if(bmi>=15.71&&bmi<=17.52)
        _type=2;
      else if(bmi>17.52)
        _type=3;
    }

    else if(month>24.5&&month<=25.5)
    {
      if(bmi<15.67)
        _type=1;
      else if(bmi>=15.67&&bmi<=17.45)
        _type=2;
      else if(bmi>17.45)
        _type=3;
    }
    else if(month>25.5&&month<=26.5)
    {
      if(bmi<15.63)
        _type=1;
      else if(bmi>=15.63&&bmi<=17.38)
        _type=2;
      else if(bmi>17.38)
        _type=3;
    }
    else if(month>26.5&&month<=27.5)
    {
      if(bmi<15.59)
        _type=1;
      else if(bmi>=15.59&&bmi<=17.31)
        _type=2;
      else if(bmi>17.31)
        _type=3;
    }

    else if(month>27.5&&month<=28.5)
    {
      if(bmi<15.55)
        _type=1;
      else if(bmi>=15.55&&bmi<=17.25)
        _type=2;
      else if(bmi>17.25)
        _type=3;
    }

    else if(month>28.5&&month<=29.5)
    {
      if(bmi<15.51)
        _type=1;
      else if(bmi>=15.51&&bmi<=17.19)
        _type=2;
      else if(bmi>17.19)
        _type=3;
    }

    else if(month>29.5&&month<=30.5)
    {
      if(bmi<15.47)
        _type=1;
      else if(bmi>=15.47&&bmi<=17.13)
        _type=2;
      else if(bmi>17.13)
        _type=3;
    }

    else if(month>30.5&&month<=31.5)
    {
      if(bmi<15.43)
        _type=1;
      else if(bmi>=15.43&&bmi<=17.08)
        _type=2;
      else if(bmi>17.08)
        _type=3;
    }

    else if(month>31.5&&month<=32.5)
    {
      if(bmi<15.39)
        _type=1;
      else if(bmi>=15.39&&bmi<=17.02)
        _type=2;
      else if(bmi>17.02)
        _type=3;
    }
    else if(month>32.5&&month<=33.5)
    {
      if(bmi<15.36)
        _type=1;
      else if(bmi>=15.36&&bmi<=16.97)
        _type=2;
      else if(bmi>16.97)
        _type=3;
    }
    else if(month>33.5&&month<=34.5)
    {
      if(bmi<15.32)
        _type=1;
      else if(bmi>=15.32&&bmi<=16.92)
        _type=2;
      else if(bmi>16.92)
        _type=3;
    }
    else if(month>34.5&&month<=35.5)
    {
      if(bmi<15.29)
        _type=1;
      else if(bmi>=15.29&&bmi<=16.87)
        _type=2;
      else if(bmi>16.87)
        _type=3;
    }

    else if(month>35.5&&month<=36.5)
    {
      if(bmi<15.26)
        _type=1;
      else if(bmi>=15.26&&bmi<=16.83)
        _type=2;
      else if(bmi>16.83)
        _type=3;
    }

    else if(month>36.5&&month<=37.5)
    {
      if(bmi<15.22)
        _type=1;
      else if(bmi>=15.22&&bmi<=16.79)
        _type=2;
      else if(bmi>16.79)
        _type=3;
    }

    else if(month>37.5&&month<=38.5)
    {
      if(bmi<15.19)
        _type=1;
      else if(bmi>=15.19&&bmi<=16.74)
        _type=2;
      else if(bmi>16.74)
        _type=3;
    }

    else if(month>38.5&&month<=39.5)
    {
      if(bmi<15.16)
        _type=1;
      else if(bmi>=15.16&&bmi<=16.70)
        _type=2;
      else if(bmi>16.70)
        _type=3;
    }

    else if(month>39.5&&month<=40.5)
    {
      if(bmi<15.13)
        _type=1;
      else if(bmi>=15.13&&bmi<=16.67)
        _type=2;
      else if(bmi>16.67)
        _type=3;
    }

    else if(month>40.5&&month<=41.5)
    {
      if(bmi<15.10)
        _type=1;
      else if(bmi>=15.10&&bmi<=16.63)
        _type=2;
      else if(bmi>16.63)
        _type=3;
    }
    else if(month>41.5&&month<=42.5)
    {
      if(bmi<15.07)
        _type=1;
      else if(bmi>=15.07&&bmi<=16.60)
        _type=2;
      else if(bmi>16.60)
        _type=3;
    }
    else if(month>42.5&&month<=43.5)
    {
      if(bmi<15.04)
        _type=1;
      else if(bmi>=15.04&&bmi<=16.57)
        _type=2;
      else if(bmi>16.57)
        _type=3;
    }

    else if(month>43.5&&month<=44.5)
    {
      if(bmi<15.01)
        _type=1;
      else if(bmi>=15.01&&bmi<=16.54)
        _type=2;
      else if(bmi>16.54)
        _type=3;
    }

    else if(month>44.5&&month<=45.5)
    {
      if(bmi<14.99)
        _type=1;
      else if(bmi>=14.99&&bmi<=16.51)
        _type=2;
      else if(bmi>16.51)
        _type=3;
    }
    else if(month>45.5&&month<=46.5)
    {
      if(bmi<14.96)
        _type=1;
      else if(bmi>=14.96&&bmi<=16.48)
        _type=2;
      else if(bmi>16.48)
        _type=3;
    }

    else if(month>46.5&&month<=47.5)
    {
      if(bmi<14.94)
        _type=1;
      else if(bmi>=14.94&&bmi<=16.46)
        _type=2;
      else if(bmi>16.46)
        _type=3;
    }

    else if(month>47.5&&month<=48.5)
    {
      if(bmi<14.91)
        _type=1;
      else if(bmi>=14.91&&bmi<=16.43)
        _type=2;
      else if(bmi>16.43)
        _type=3;
    }

    else if(month>48.5&&month<=49.5)
    {
      if(bmi<14.89)
        _type=1;
      else if(bmi>=14.89&&bmi<=16.41)
        _type=2;
      else if(bmi>16.41)
        _type=3;
    }
    else if(month>49.5&&month<=50.5)
    {
      if(bmi<14.87)
        _type=1;
      else if(bmi>=14.87&&bmi<=16.39)
        _type=2;
      else if(bmi>16.39)
        _type=3;
    }
    else if(month>50.5&&month<=51.5)
    {
      if(bmi<14.84)
        _type=1;
      else if(bmi>=14.84&&bmi<=16.38)
        _type=2;
      else if(bmi>16.38)
        _type=3;
    }
    else if(month>51.5&&month<=52.5)
    {
      if(bmi<14.82)
        _type=1;
      else if(bmi>=14.82&&bmi<=16.36)
        _type=2;
      else if(bmi>16.36)
        _type=3;
    }

    else if(month>52.5&&month<=53.5)
    {
      if(bmi<14.80)
        _type=1;
      else if(bmi>=14.80&&bmi<=16.35)
        _type=2;
      else if(bmi>16.35)
        _type=3;
    }

    else if(month>53.5&&month<=54.5)
    {
      if(bmi<14.78)
        _type=1;
      else if(bmi>=14.78&&bmi<=16.33)
        _type=2;
      else if(bmi>16.33)
        _type=3;
    }
    else if(month>54.5&&month<=55.5)
    {
      if(bmi<14.77)
        _type=1;
      else if(bmi>=14.77&&bmi<=16.32)
        _type=2;
      else if(bmi>16.32)
        _type=3;
    }
    else if(month>55.5&&month<=56.5)
    {
      if(bmi<14.75)
        _type=1;
      else if(bmi>=14.75&&bmi<=16.31)
        _type=2;
      else if(bmi>16.31)
        _type=3;
    }

    else if(month>56.5&&month<=57.5)
    {
      if(bmi<14.73)
        _type=1;
      else if(bmi>=14.73&&bmi<=16.3072)
        _type=2;
      else if(bmi>16.3072)
        _type=3;
    }
    else if(month>57.5&&month<=58.5)
    {
      if(bmi<14.72)
        _type=1;
      else if(bmi>=14.72&&bmi<=16.30042)
        _type=2;
      else if(bmi>16.30042)
        _type=3;
    }

    else if(month>58.5&&month<=59.5)
    {
      if(bmi<14.70)
        _type=1;
      else if(bmi>=14.70&&bmi<=16.2951)
        _type=2;
      else if(bmi>16.2951)
        _type=3;
    }
    else if(month>59.5&&month<=60.5)
    {
      if(bmi<14.69)
        _type=1;
      else if(bmi>=14.69&&bmi<=16.2914)
        _type=2;
      else if(bmi>16.2914)
        _type=3;
    }
    else if(month>60.5&&month<=61.5)
    {
      if(bmi<14.68)
        _type=1;
      else if(bmi>=14.68&&bmi<=16.28932)
        _type=2;
      else if(bmi>16.28932)
        _type=3;
    }
    else if(month>61.5&&month<=62.5)
    {
      if(bmi<14.67)
        _type=1;
      else if(bmi>=14.67&&bmi<=16.2886)
        _type=2;
      else if(bmi>16.2886)
        _type=3;
    }
    else if(month>62.5&&month<=63.5)
    {
      if(bmi<14.66)
        _type=1;
      else if(bmi>=14.66&&bmi<=16.28955)
        _type=2;
      else if(bmi>16.28955)
        _type=3;
    }
    else if(month>63.5&&month<=64.5)
    {
      if(bmi<14.65)
        _type=1;
      else if(bmi>=14.65&&bmi<=16.29192)
        _type=2;
      else if(bmi>16.29192)
        _type=3;
    }

    else if(month>64.5&&month<=65.5)
    {
      if(bmi<14.64)
        _type=1;
      else if(bmi>=14.64&&bmi<=16.29578)
        _type=2;
      else if(bmi>16.29578)
        _type=3;
    }

    else if(month>65.5&&month<=66.5)
    {
      if(bmi<14.63)
        _type=1;
      else if(bmi>=14.63&&bmi<=16.30113)
        _type=2;
      else if(bmi>16.30113)
        _type=3;
    }

    else if(month>66.5&&month<=67.5)
    {
      if(bmi<14.6292)
        _type=1;
      else if(bmi>=14.6292&&bmi<=16.3079)
        _type=2;
      else if(bmi>16.3079)
        _type=3;
    }

    else if(month>67.5&&month<=68.5)
    {
      if(bmi<14.62369)
        _type=1;
      else if(bmi>=14.62369&&bmi<=16.31)
        _type=2;
      else if(bmi>16.31)
        _type=3;
    }
    else if(month>68.5&&month<=69.5)
    {
      if(bmi<14.6191)
        _type=1;
      else if(bmi>=14.6191&&bmi<=16.32)
        _type=2;
      else if(bmi>16.32)
        _type=3;
    }
    else if(month>69.5&&month<=70.5)
    {
      if(bmi<14.6155)
        _type=1;
      else if(bmi>=14.6155&&bmi<=16.33)
        _type=2;
      else if(bmi>16.33)
        _type=3;
    }

    else if(month>70.5&&month<=71.5)
    {
      if(bmi<14.6129)
        _type=1;
      else if(bmi>=14.6129&&bmi<=16.34)
        _type=2;
      else if(bmi>16.34)
        _type=3;
    }

    else if(month>71.5&&month<=72.5)
    {
      if(bmi<14.6112)
        _type=1;
      else if(bmi>=14.6112&&bmi<=16.36)
        _type=2;
      else if(bmi>16.36)
        _type=3;
    }

    else if(month>72.5&&month<=73.5)
    {
      if(bmi<14.61042)
        _type=1;
      else if(bmi>=14.61042&&bmi<=16.37)
        _type=2;
      else if(bmi>16.37)
        _type=3;
    }
    else if(month>73.5&&month<=74.5)
    {
      if(bmi<14.6105)
        _type=1;
      else if(bmi>=14.6105&&bmi<=16.39)
        _type=2;
      else if(bmi>16.39)
        _type=3;
    }

    else if(month>74.5&&month<=75.5)
    {
      if(bmi<14.6116)
        _type=1;
      else if(bmi>=14.6116&&bmi<=16.41)
        _type=2;
      else if(bmi>16.41)
        _type=3;
    }

    else if(month>75.5&&month<=76.5)
    {
      if(bmi<14.6135)
        _type=1;
      else if(bmi>=14.6135&&bmi<=16.43)
        _type=2;
      else if(bmi>16.43)
        _type=3;
    }

    else if(month>76.5&&month<=77.5)
    {
      if(bmi<14.6164)
        _type=1;
      else if(bmi>=14.6164&&bmi<=16.45)
        _type=2;
      else if(bmi>16.45)
        _type=3;
    }

    else if(month>77.5&&month<=78.5)
    {
      if(bmi<14.6202)
        _type=1;
      else if(bmi>=14.6202&&bmi<=16.47)
        _type=2;
      else if(bmi>16.47)
        _type=3;
    }

    else if(month>78.5&&month<=79.5)
    {
      if(bmi<14.6248)
        _type=1;
      else if(bmi>=14.6248&&bmi<=16.49)
        _type=2;
      else if(bmi>16.49)
        _type=3;
    }

    else if(month>79.5&&month<=80.5)
    {
      if(bmi<14.63032)
        _type=1;
      else if(bmi>=14.63032&&bmi<=16.52)
        _type=2;
      else if(bmi>16.52)
        _type=3;
    }

    else if(month>80.5&&month<=81.5)
    {
      if(bmi<14.6366)
        _type=1;
      else if(bmi>=14.6366&&bmi<=16.54)
        _type=2;
      else if(bmi>16.54)
        _type=3;
    }
    else if(month>81.5&&month<=82.5)
    {
      if(bmi<14.64)
        _type=1;
      else if(bmi>=14.64&&bmi<=16.57)
        _type=2;
      else if(bmi>16.57)
        _type=3;
    }

    else if(month>82.5&&month<=83.5)
    {
      if(bmi<14.65)
        _type=1;
      else if(bmi>=14.65&&bmi<=16.60)
        _type=2;
      else if(bmi>16.60)
        _type=3;
    }

    else if(month>83.5&&month<=84.5)
    {
      if(bmi<14.66)
        _type=1;
      else if(bmi>=14.66&&bmi<=16.63)
        _type=2;
      else if(bmi>16.63)
        _type=3;
    }

    else if(month>84.5&&month<=85.5)
    {
      if(bmi<14.67)
        _type=1;
      else if(bmi>=14.67&&bmi<=16.66)
        _type=2;
      else if(bmi>16.66)
        _type=3;
    }
    else if(month>85.5&&month<=86.5)
    {
      if(bmi<14.68)
        _type=1;
      else if(bmi>=14.68&&bmi<=16.69)
        _type=2;
      else if(bmi>16.69)
        _type=3;
    }

    else if(month>86.5&&month<=87.5)
    {
      if(bmi<14.69)
        _type=1;
      else if(bmi>=14.69&&bmi<=16.72)
        _type=2;
      else if(bmi>16.72)
        _type=3;
    }

    else if(month>87.5&&month<=88.5)
    {
      if(bmi<14.70)
        _type=1;
      else if(bmi>=14.70&&bmi<=16.75)
        _type=2;
      else if(bmi>16.75)
        _type=3;
    }

    else if(month>88.5&&month<=89.5)
    {
      if(bmi<14.71)
        _type=1;
      else if(bmi>=14.71&&bmi<=16.79)
        _type=2;
      else if(bmi>16.79)
        _type=3;
    }

    else if(month>89.5&&month<=90.5)
    {
      if(bmi<14.73)
        _type=1;
      else if(bmi>=14.73&&bmi<=16.82)
        _type=2;
      else if(bmi>16.82)
        _type=3;
    }

    else if(month>90.5&&month<=91.5)
    {
      if(bmi<14.74)
        _type=1;
      else if(bmi>=14.74&&bmi<=16.86)
        _type=2;
      else if(bmi>16.86)
        _type=3;
    }

    else if(month>91.5&&month<=92.5)
    {
      if(bmi<14.76)
        _type=1;
      else if(bmi>=14.76&&bmi<=16.90)
        _type=2;
      else if(bmi>16.90)
        _type=3;
    }

    else if(month>92.5&&month<=93.5)
    {
      if(bmi<14.77)
        _type=1;
      else if(bmi>=14.77&&bmi<=16.93)
        _type=2;
      else if(bmi>16.93)
        _type=3;
    }
    else if(month>93.5&&month<=94.5)
    {
      if(bmi<14.79)
        _type=1;
      else if(bmi>=14.79&&bmi<=16.97)
        _type=2;
      else if(bmi>16.97)
        _type=3;
    }

    else if(month>94.5&&month<=95.5)
    {
      if(bmi<14.91)
        _type=1;
      else if(bmi>=14.91&&bmi<=17.01)
        _type=2;
      else if(bmi>17.01)
        _type=3;
    }

    else if(month>95.5&&month<=96.5)
    {
      if(bmi<14.82)
        _type=1;
      else if(bmi>=14.82&&bmi<=17.05)
        _type=2;
      else if(bmi>17.05)
        _type=3;
    }

    else if(month>96.5&&month<=97.5)
    {
      if(bmi<14.84)
        _type=1;
      else if(bmi>=14.84&&bmi<=17.09)
        _type=2;
      else if(bmi>17.09)
        _type=3;
    }

    else if(month>97.5&&month<=98.5)
    {
      if(bmi<14.86)
        _type=1;
      else if(bmi>=14.86&&bmi<=17.14)
        _type=2;
      else if(bmi>17.14)
        _type=3;
    }

    else if(month>98.5&&month<=99.5)
    {
      if(bmi<14.88)
        _type=1;
      else if(bmi>=14.88&&bmi<=17.18)
        _type=2;
      else if(bmi>17.18)
        _type=3;
    }

    else if(month>99.5&&month<=100.5)
    {
      if(bmi<14.91)
        _type=1;
      else if(bmi>=14.91&&bmi<=17.22)
        _type=2;
      else if(bmi>17.22)
        _type=3;
    }



    else if(month>100.5&&month<=101.5)
    {
      if(bmi<14.93)
        _type=1;
      else if(bmi>=14.93&&bmi<=17.27)
        _type=2;
      else if(bmi>17.27)
        _type=3;
    }
    else if(month>101.5&&month<=102.5)
    {
      if(bmi<14.95)
        _type=1;
      else if(bmi>=14.95&&bmi<=17.31)
        _type=2;
      else if(bmi>17.31)
        _type=3;
    }
    else if(month>102.5&&month<=103.5)
    {
      if(bmi<14.97)
        _type=1;
      else if(bmi>=14.97&&bmi<=17.36)
        _type=2;
      else if(bmi>17.36)
        _type=3;
    }
    else if(month>103.5&&month<=104.5)
    {
      if(bmi<15.00)
        _type=1;
      else if(bmi>=15.00&&bmi<=17.41)
        _type=2;
      else if(bmi>17.41)
        _type=3;
    }
    else if(month>104.5&&month<=105.5)
    {
      if(bmi<15.02)
        _type=1;
      else if(bmi>=15.02&&bmi<=17.46)
        _type=2;
      else if(bmi>17.46)
        _type=3;
    }
    else if(month>105.5&&month<=106.5)
    {
      if(bmi<15.05)
        _type=1;
      else if(bmi>=15.05&&bmi<=17.50)
        _type=2;
      else if(bmi>17.50)
        _type=3;
    }

    else if(month>106.5&&month<=107.5)
    {
      if(bmi<15.07)
        _type=1;
      else if(bmi>=15.07&&bmi<=17.55)
        _type=2;
      else if(bmi>17.55)
        _type=3;
    }
    else if(month>107.5&&month<=108.5)
    {
      if(bmi<15.10)
        _type=1;
      else if(bmi>=15.10&&bmi<=17.60)
        _type=2;
      else if(bmi>17.60)
        _type=3;
    }

    else if(month>108.5&&month<=109.5)
    {
      if(bmi<15.13)
        _type=1;
      else if(bmi>=15.13&&bmi<=17.65)
        _type=2;
      else if(bmi>17.65)
        _type=3;
    }

    else if(month>109.5&&month<=110.5)
    {
      if(bmi<15.15)
        _type=1;
      else if(bmi>=15.15&&bmi<=17.70)
        _type=2;
      else if(bmi>17.70)
        _type=3;
    }

    else if(month>110.5&&month<=111.5)
    {
      if(bmi<15.18)
        _type=1;
      else if(bmi>=15.18&&bmi<=17.75)
        _type=2;
      else if(bmi>17.75)
        _type=3;
    }
    else if(month>111.5&&month<=112.5)
    {
      if(bmi<15.21)
        _type=1;
      else if(bmi>=15.21&&bmi<=17.81)
        _type=2;
      else if(bmi>17.81)
        _type=3;
    }
    else if(month>112.5&&month<=113.5)
    {
      if(bmi<15.24)
        _type=1;
      else if(bmi>=15.24&&bmi<=17.86)
        _type=2;
      else if(bmi>17.86)
        _type=3;
    }
    else if(month>113.5&&month<=114.5)
    {
      if(bmi<15.27)
        _type=1;
      else if(bmi>=15.27&&bmi<=17.91)
        _type=2;
      else if(bmi>17.91)
        _type=3;
    }

    else if(month>114.5&&month<=115.5)
    {
      if(bmi<15.30)
        _type=1;
      else if(bmi>=15.30&&bmi<=17.97)
        _type=2;
      else if(bmi>17.97)
        _type=3;
    }

    else if(month>115.5&&month<=116.5)
    {
      if(bmi<15.34)
        _type=1;
      else if(bmi>=15.34&&bmi<=18.02)
        _type=2;
      else if(bmi>18.02)
        _type=3;
    }
    else if(month>116.5&&month<=117.5)
    {
      if(bmi<15.37)
        _type=1;
      else if(bmi>=15.37&&bmi<=18.07)
        _type=2;
      else if(bmi>18.07)
        _type=3;
    }

    else if(month>117.5&&month<=118.5)
    {
      if(bmi<15.40)
        _type=1;
      else if(bmi>=15.40&&bmi<=18.13)
        _type=2;
      else if(bmi>18.13)
        _type=3;
    }
    else if(month>118.5&&month<=119.5)
    {
      if(bmi<15.43)
        _type=1;
      else if(bmi>=15.43&&bmi<=18.18)
        _type=2;
      else if(bmi>18.18)
        _type=3;
    }
    else if(month>119.5&&month<=120.5)
    {
      if(bmi<15.47)
        _type=1;
      else if(bmi>=15.47&&bmi<=18.24)
        _type=2;
      else if(bmi>18.24)
        _type=3;
    }

    else if(month>120.5&&month<=121.5)
    {
      if(bmi<15.50)
        _type=1;
      else if(bmi>=15.50&&bmi<=18.30)
        _type=2;
      else if(bmi>18.30)
        _type=3;
    }
    else if(month>121.5&&month<=122.5)
    {
      if(bmi<15.54)
        _type=1;
      else if(bmi>=15.54&&bmi<=18.35)
        _type=2;
      else if(bmi>18.35)
        _type=3;
    }

    else if(month>122.5&&month<=123.5)
    {
      if(bmi<15.57)
        _type=1;
      else if(bmi>=15.57&&bmi<=18.41)
        _type=2;
      else if(bmi>18.41)
        _type=3;
    }
    else if(month>123.5&&month<=124.5)
    {
      if(bmi<15.61)
        _type=1;
      else if(bmi>=15.61&&bmi<=18.47)
        _type=2;
      else if(bmi>18.47)
        _type=3;
    }

    else if(month>124.5&&month<=125.5)
    {
      if(bmi<15.45)
        _type=1;
      else if(bmi>=15.45&&bmi<=18.53)
        _type=2;
      else if(bmi>18.53)
        _type=3;
    }
    else if(month>125.5&&month<=126.5)
    {
      if(bmi<15.68)
        _type=1;
      else if(bmi>=15.68&&bmi<=18.58)
        _type=2;
      else if(bmi>18.58)
        _type=3;
    }
    else if(month>126.5&&month<=127.5)
    {
      if(bmi<15.72)
        _type=1;
      else if(bmi>=15.72&&bmi<=18.64)
        _type=2;
      else if(bmi>18.64)
        _type=3;
    }
    else if(month>127.5&&month<=128.5)
    {
      if(bmi<15.76)
        _type=1;
      else if(bmi>=15.76&&bmi<=18.70)
        _type=2;
      else if(bmi>18.70)
        _type=3;
    }

    else if(month>128.5&&month<=129.5)
    {
      if(bmi<15.80)
        _type=1;
      else if(bmi>=15.80&&bmi<=18.76)
        _type=2;
      else if(bmi>18.76)
        _type=3;
    }

    else if(month>129.5&&month<=130.5)
    {
      if(bmi<15.84)
        _type=1;
      else if(bmi>=15.84&&bmi<=18.82)
        _type=2;
      else if(bmi>18.82)
        _type=3;
    }
   else if(month>130.5&&month<=131.5)
    {
      if(bmi<15.88)
        _type=1;
      else if(bmi>=15.88&&bmi<=18.88)
        _type=2;
      else if(bmi>18.88)
        _type=3;
    }
   else if(month>131.5&&month<=132.5)
    {
      if(bmi<15.92)
        _type=1;
      else if(bmi>=15.92&&bmi<=18.94)
        _type=2;
      else if(bmi>18.94)
        _type=3;
    }
   else if(month>132.5&&month<=133.5)
    {
      if(bmi<15.96)
        _type=1;
      else if(bmi>=15.96&&bmi<=19.00)
        _type=2;
      else if(bmi>19.00)
        _type=3;
    }

   else if(month>133.5&&month<=134.5)
    {
      if(bmi<16.00)
        _type=1;
      else if(bmi>=16.00&&bmi<=19.06)
        _type=2;
      else if(bmi>19.06)
        _type=3;
    }
   else if(month>134.5&&month<=135.5)
    {
      if(bmi<16.04)
        _type=1;
      else if(bmi>=16.04&&bmi<=19.12)
        _type=2;
      else if(bmi>19.12)
        _type=3;
    }
   else if(month>135.5&&month<=136.5)
    {
      if(bmi<16.08)
        _type=1;
      else if(bmi>=16.08&&bmi<=19.18)
        _type=2;
      else if(bmi>19.18)
        _type=3;
    }
   else if(month>136.5&&month<=137.5)
    {
      if(bmi<16.13)
        _type=1;
      else if(bmi>=16.13&&bmi<=19.25)
        _type=2;
      else if(bmi>19.25)
        _type=3;
    }
   else if(month>137.5&&month<=138.5)
    {
      if(bmi<16.17)
        _type=1;
      else if(bmi>=16.17&&bmi<=19.31)
        _type=2;
      else if(bmi>19.31)
        _type=3;
    }
   else if(month>138.5&&month<=139.5)
    {
      if(bmi<16.21)
        _type=1;
      else if(bmi>=16.21&&bmi<=19.37)
        _type=2;
      else if(bmi>19.37)
        _type=3;
    }
   else if(month>139.5&&month<=140.5)
    {
      if(bmi<16.26)
        _type=1;
      else if(bmi>=16.26&&bmi<=19.43)
        _type=2;
      else if(bmi>19.43)
        _type=3;
    }

   else if(month>140.5&&month<=141.5)
    {
      if(bmi<16.30)
        _type=1;
      else if(bmi>=16.30&&bmi<=19.49)
        _type=2;
      else if(bmi>19.49)
        _type=3;
    }
   else if(month>141.5&&month<=142.5)
    {
      if(bmi<16.35)
        _type=1;
      else if(bmi>=16.35&&bmi<=19.56)
        _type=2;
      else if(bmi>19.56)
        _type=3;
    }
   else if(month>142.5&&month<=143.5)
    {
      if(bmi<16.39)
        _type=1;
      else if(bmi>=16.39&&bmi<=19.62)
        _type=2;
      else if(bmi>19.62)
        _type=3;
    }


   else if(month>143)
    {
      if(bmi<16.44)
        _type=1;
      else if(bmi>=16.44&&bmi<=19.68)
        _type=2;
      else if(bmi>19.68)
        _type=3;
    }


    return _type;
  }
  calculateCal() {
    double calory;
    _user.gender == "female"
        ? calory = double.parse(_user.height) * 12
        : calory = double.parse(_user.height) * 14;

    switch (act) {
      case 1:
        {
          calory= calory * 0.8;
        }
        break;
      case 2:
        {
          calory=  calory * 0.9;
        }
        break;
      case 3:
        {
          calory=  calory * 1;
        }
        break;
      case 4:
        {
          calory=  calory * 1.1;
        }
        break;
      case 5:
        {
          calory=  calory * 1.2;
        }
        break;
    }

int type;
    _user.gender == "female"
        ? type= calculateTypeGirl()
        : type= calculateTypeBoy();

    switch (type) {
      case 1:
        {
          calory = calory +250;
        }
        break;
      case 2:
        {
          calory = calory ;
        }
        break;
      case 3:
        {
          calory = calory -400;
        }
        break;
    }

    return calory.round();



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

  calculateTypeBoyHeight(){
    double mounth=(calculateAllMounth(_user.birthdate)/12);
    double weight=double.parse(_user.height);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,



    ];
    List sadak5 = [
      80.72977,
      81.08868,
      81.83445,
      82.56406,
      83.27899,
      83.98045,
      84.66948,
      85.34694,
      86.01357,
      86.66999,
      87.3168,
      87.95452,
      88.58366,
      89.20473,
      89.77301,
      90.33306,
      90.88532,
      91.43025,
      91.96832,
      92.49999,
      93.0257,
      93.54592,
      94.06109,
      94.57166,
      95.07806,
      95.5807,
      96.08,
      96.57635,
      97.07013,
      97.5617,
      98.05141,
      98.53958,
      99.02654,
      99.51256,
      99.99791,
      100.4828,
      100.9676,
      101.4523,
      101.9372,
      102.4225,
      102.9082,
      103.3945,
      103.8814,
      104.369,
      104.8574,
      105.3466,
      105.8364,
      106.327,
      106.8182,
      107.3099,
      107.8021,
      108.2946,
      108.7873,
      109.2801,
      109.7727,
      110.2649,
      110.7566,
      111.2476,
      111.7375,
      112.2263,
      112.7135,
      113.1991,
      113.6827,
      114.1642,
      114.6431,
      115.1194,
      115.5927,
      116.0629,
      116.5297,
      116.9928,
      117.4521,
      117.9074,
      118.3585,
      118.8053,
      119.2475,
      119.6851,
      120.1179,
      120.5459,
      120.969,
      121.3872,
      121.8004,
      122.2086,
      122.6119,
      123.0103,
      123.4039,
      123.7928,
      124.1771,
      124.5569,
      124.9325,
      125.304,
      125.6717,
      126.0358,
      126.3966,
      126.7544,
      127.1096,
      127.4624,
      127.8132,
      128.1625,
      128.5106,
      128.8579,
      129.2051,
      129.5524,
      129.9004,
      130.2496,
      130.6005,
      130.9536,
      131.3094,
      131.6686,
      132.0316,
      132.399,
      132.7714,
      133.1491,
      133.5329,
      133.9232,
      134.3205,
      134.7252,
      135.1378,
      135.5588,
      135.9885,
      136.4271,
      136.8751,
      137.3326,

    ]; List sadak25 = [
      84.10289,
      84.49471,
      85.25888,
      86.00517,
      86.73507,
      87.44977,
      88.15028,
      88.83745,
      89.51202,
      90.17464,
      90.82592,
      91.46645,
      92.0968,
      92.71756,
      93.3344,
      93.94268,
      94.54291,
      95.13557,
      95.72115,
      96.30009,
      96.87286,
      97.43989,
      98.00159,
      98.55838,
      99.11064,
      99.65875,
      100.2031,
      100.7439,
      101.2817,
      101.8166,
      102.3491,
      102.8792,
      103.4074,
      103.9339,
      104.4588,
      104.9825,
      105.505,
      106.0265,
      106.5472,
      107.0673,
      107.5868,
      108.1058,
      108.6244,
      109.1427,
      109.6607,
      110.1785,
      110.696,
      111.2132,
      111.7302,
      112.2469,
      112.7631,
      113.2789,
      113.7942,
      114.3089,
      114.8229,
      115.336,
      115.8481,
      116.3592,
      116.869,
      117.3774,
      117.8842,
      118.3893,
      118.8926,
      119.3938,
      119.8927,
      120.3893,
      120.8833,
      121.3746,
      121.863,
      122.3483,
      122.8305,
      123.3092,
      123.7845,
      124.2562,
      124.7242,
      125.1882,
      125.6484,
      126.1045,
      126.5565,
      127.0044,
      127.4481,
      127.8876,
      128.3228,
      128.7539,
      129.1807,
      129.6035,
      130.0222,
      130.4369,
      130.8477,
      131.2548,
      131.6584,
      132.0585,
      132.4555,
      132.8495,
      133.2407,
      133.6295,
      134.0161,
      134.4008,
      134.7841,
      135.1663,
      135.5477,
      135.9288,
      136.3101,
      136.692,
      137.075,
      137.4597,
      137.8466,
      138.2362,
      138.6292,
      139.0262,
      139.4278,
      139.8346,
      140.2472,
      140.6664,
      141.0928,
      141.5269,
      141.9694,
      142.4209,
      142.882,
      143.3532,
      143.835,
      144.3277,


    ]; List sadak75 = [88.80525,
      89.22805,
      90.05675,
      90.8626,
      91.64711,
      92.41159,
      93.15719,
      93.88496,
      94.59585,
      95.2908,
      95.97068,
      96.63637,
      97.28875,
      97.9287,
      98.58525,
      99.23358,
      99.87426,
      100.5078,
      101.1348,
      101.7556,
      102.3708,
      102.9807,
      103.5858,
      104.1865,
      104.7831,
      105.3759,
      105.9654,
      106.5518,
      107.1354,
      107.7165,
      108.2953,
      108.872,
      109.4469,
      110.0201,
      110.5919,
      111.1623,
      111.7316,
      112.2998,
      112.8671,
      113.4335,
      113.9992,
      114.5641,
      115.1284,
      115.6921,
      116.2551,
      116.8176,
      117.3794,
      117.9407,
      118.5012,
      119.0611,
      119.6203,
      120.1786,
      120.7361,
      121.2926,
      121.848,
      122.4024,
      122.9555,
      123.5073,
      124.0576,
      124.6064,
      125.1535,
      125.6987,
      126.2421,
      126.7834,
      127.3225,
      127.8594,
      128.3937,
      128.9256,
      129.4547,
      129.981,
      130.5044,
      131.0247,
      131.5419,
      132.0559,
      132.5664,
      133.0736,
      133.5771,
      134.0771,
      134.5734,
      135.066,
      135.5548,
      136.0397,
      136.5209,
      136.9982,
      137.4717,
      137.9414,
      138.4073,
      138.8696,
      139.3282,
      139.7833,
      140.235,
      140.6835,
      141.1289,
      141.5713,
      142.0111,
      142.4484,
      142.8835,
      143.3168,
      143.7484,
      144.1789,
      144.6085,
      145.0377,
      145.4669,
      145.8965,
      146.3272,
      146.7593,
      147.1936,
      147.6305,
      148.0707,
      148.5147,
      148.9633,
      149.4172,
      149.8769,
      150.3433,
      150.8169,
      151.2984,
      151.7885,
      152.2878,
      152.7969,
      153.3164,
      153.8466,
      154.3881,

    ];List sadak90 = [90.92619,
      91.35753,
      92.22966,
      93.07608,
      93.89827,
      94.69757,
      95.47522,
      96.23239,
      96.97022,
      97.68978,
      98.39218,
      99.07848,
      99.74979,
      100.4072,
      101.069,
      101.7234,
      102.3709,
      103.012,
      103.6473,
      104.2771,
      104.9021,
      105.5225,
      106.1387,
      106.7513,
      107.3604,
      107.9665,
      108.5698,
      109.1706,
      109.7693,
      110.366,
      110.9609,
      111.5543,
      112.1464,
      112.7374,
      113.3273,
      113.9164,
      114.5047,
      115.0924,
      115.6795,
      116.2661,
      116.8522,
      117.438,
      118.0234,
      118.6084,
      119.1931,
      119.7774,
      120.3613,
      120.9447,
      121.5277,
      122.1101,
      122.6918,
      123.2729,
      123.8532,
      124.4327,
      125.0111,
      125.5884,
      126.1646,
      126.7394,
      127.3128,
      127.8846,
      128.4547,
      129.023,
      129.5893,
      130.1535,
      130.7154,
      131.275,
      131.8321,
      132.3865,
      132.9381,
      133.4868,
      134.0325,
      134.5751,
      135.1144,
      135.6504,
      136.1829,
      136.7118,
      137.2371,
      137.7587,
      138.2765,
      138.7905,
      139.3006,
      139.8069,
      140.3093,
      140.8077,
      141.3023,
      141.793,
      142.28,
      142.7632,
      143.2428,
      143.7188,
      144.1915,
      144.661,
      145.1273,
      145.5909,
      146.0518,
      146.5103,
      146.9668,
      147.4214,
      147.8747,
      148.3268,
      148.7782,
      149.2294,
      149.6808,
      150.1329,
      150.5861,
      151.041,
      151.4982,
      151.9583,
      152.4218,
      152.8894,
      153.3617,
      153.8394,
      154.323,
      154.8133,
      155.3109,
      155.8164,
      156.3303,
      156.8532,
      157.3857,
      157.928,
      158.4807,
      159.0439,

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
    double mounth=(calculateAllMounth(_user.birthdate)/12);
    double weight=double.parse(_user.height);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,


    ];
    List sadak5 = [
      79.25982,
      79.64777,
      80.44226,
      81.22666,
      81.9954,
      82.74411,
      83.46957,
      84.16953,
      84.84264,
      85.4883,
      86.10656,
      86.69803,
      87.26379,
      87.80528,
      88.34236,
      88.87256,
      89.39733,
      89.91797,
      90.43559,
      90.95115,
      91.46549,
      91.97932,
      92.49325,
      93.00778,
      93.52333,
      94.04022,
      94.55872,
      95.07903,
      95.60128,
      96.12555,
      96.65189,
      97.18029,
      97.71069,
      98.24303,
      98.77719,
      99.31303,
      99.85039,
      100.3891,
      100.9289,
      101.4696,
      102.011,
      102.5529,
      103.0948,
      103.6367,
      104.1782,
      104.7191,
      105.259,
      105.7976,
      106.3348,
      106.8701,
      107.4033,
      107.9342,
      108.4624,
      108.9877,
      109.5099,
      110.0285,
      110.5435,
      111.0545,
      111.5613,
      112.0638,
      112.5616,
      113.0546,
      113.5427,
      114.0256,
      114.5031,
      114.9752,
      115.4418,
      115.9026,
      116.3577,
      116.8069,
      117.2502,
      117.6875,
      118.1189,
      118.5443,
      118.9638,
      119.3774,
      119.7852,
      120.1873,
      120.5838,
      120.9748,
      121.3606,
      121.7413,
      122.1171,
      122.4884,
      122.8555,
      123.2186,
      123.5782,
      123.9347,
      124.2885,
      124.6402,
      124.9902,
      125.3393,
      125.688,
      126.0371,
      126.3872,
      126.7392,
      127.094,
      127.4524,
      127.8154,
      128.184,
      128.5591,
      128.9419,
      129.3334,
      129.7346,
      130.1467,
      130.5705,
      131.0071,
      131.4573,
      131.9218,
      132.4013,
      132.8962,
      133.4067,
      133.9328,
      134.4742,
      135.0304,
      135.6004,
      136.1831,
      136.7769,
      137.3801,
      137.9905,
      138.6058,
      139.2236,


    ]; List sadak25 = [
      82.63524,
      83.04213,
      83.8943,
      84.72592,
      85.53389,
      86.31589,
      87.07028,
      87.79609,
      88.49291,
      89.16084,
      89.80045,
      90.4127,
      90.99891,
      91.56066,
      92.12298,
      92.67925,
      93.2307,
      93.7784,
      94.32334,
      94.86634,
      95.40817,
      95.94946,
      96.49076,
      97.03254,
      97.57519,
      98.11905,
      98.66436,
      99.21132,
      99.76009,
      100.3108,
      100.8634,
      101.418,
      101.9745,
      102.5329,
      103.093,
      103.6549,
      104.2182,
      104.7829,
      105.3488,
      105.9156,
      106.4831,
      107.0512,
      107.6194,
      108.1877,
      108.7556,
      109.323,
      109.8895,
      110.4549,
      111.0189,
      111.5812,
      112.1415,
      112.6996,
      113.255,
      113.8077,
      114.3572,
      114.9034,
      115.446,
      115.9847,
      116.5193,
      117.0496,
      117.5754,
      118.0964,
      118.6125,
      119.1235,
      119.6293,
      120.1297,
      120.6246,
      121.1138,
      121.5974,
      122.0753,
      122.5473,
      123.0135,
      123.4739,
      123.9285,
      124.3774,
      124.8207,
      125.2584,
      125.6906,
      126.1177,
      126.5396,
      126.9568,
      127.3694,
      127.7777,
      128.1822,
      128.5831,
      128.9808,
      129.3759,
      129.7689,
      130.1603,
      130.5506,
      130.9406,
      131.3309,
      131.7223,
      132.1156,
      132.5115,
      132.9109,
      133.3147,
      133.7239,
      134.1394,
      134.562,
      134.9929,
      135.4328,
      135.8826,
      136.3433,
      136.8154,
      137.2997,
      137.7967,
      138.3067,
      138.83,
      139.3664,
      139.9157,
      140.4775,
      141.051,
      141.6352,
      142.2288,
      142.8304,
      143.4381,
      144.0501,
      144.6641,
      145.278,
      145.8893,
      146.4958,


    ]; List sadak75 = [87.31121,
      87.74918,
      88.68344,
      89.58751,
      90.46018,
      91.30065,
      92.10859,
      92.88403,
      93.62741,
      94.33951,
      95.0214,
      95.67446,
      96.30029,
      96.90071,
      97.50724,
      98.10855,
      98.70568,
      99.29957,
      99.89104,
      100.4808,
      101.0696,
      101.6579,
      102.2462,
      102.835,
      103.4247,
      104.0154,
      104.6075,
      105.2012,
      105.7965,
      106.3936,
      106.9925,
      107.5933,
      108.1958,
      108.8001,
      109.406,
      110.0134,
      110.6222,
      111.2321,
      111.8431,
      112.4548,
      113.0671,
      113.6797,
      114.2923,
      114.9048,
      115.5167,
      116.1278,
      116.7379,
      117.3466,
      117.9537,
      118.5588,
      119.1616,
      119.7619,
      120.3594,
      120.9537,
      121.5447,
      122.132,
      122.7154,
      123.2946,
      123.8695,
      124.4397,
      125.0051,
      125.5655,
      126.1207,
      126.6706,
      127.215,
      127.7539,
      128.287,
      128.8144,
      129.3359,
      129.8516,
      130.3615,
      130.8656,
      131.364,
      131.8567,
      132.3438,
      132.8255,
      133.302,
      133.7734,
      134.2401,
      134.7023,
      135.1604,
      135.6146,
      136.0654,
      136.5132,
      136.9585,
      137.4018,
      137.8437,
      138.2847,
      138.7256,
      139.1669,
      139.6094,
      140.0538,
      140.501,
      140.9516,
      141.4065,
      141.8665,
      142.3324,
      142.8051,
      143.2852,
      143.7735,
      144.2707,
      144.7773,
      145.2938,
      145.8206,
      146.3579,
      146.9059,
      147.4643,
      148.0329,
      148.6111,
      149.1984,
      149.7937,
      150.3959,
      151.0036,
      151.6153,
      152.2293,
      152.8438,
      153.4568,
      154.0662,
      154.67,
      155.2663,
      155.8529,
      156.428,

    ];List sadak90 = [89.40951,
      89.86316,
      90.83505,
      91.77421,
      92.67969,
      93.55097,
      94.38793,
      95.19083,
      95.9603,
      96.69729,
      97.40303,
      98.07904,
      98.72705,
      99.34899,
      99.97896,
      100.604,
      101.2251,
      101.8432,
      102.459,
      103.0732,
      103.6866,
      104.2996,
      104.9128,
      105.5264,
      106.141,
      106.7567,
      107.3737,
      107.9924,
      108.6127,
      109.2347,
      109.8585,
      110.4841,
      111.1114,
      111.7404,
      112.3709,
      113.0028,
      113.6359,
      114.2701,
      114.9052,
      115.5408,
      116.1768,
      116.813,
      117.449,
      118.0845,
      118.7193,
      119.3531,
      119.9855,
      120.6163,
      121.2452,
      121.8718,
      122.4959,
      123.1171,
      123.7352,
      124.3499,
      124.9608,
      125.5678,
      126.1705,
      126.7688,
      127.3623,
      127.951,
      128.5345,
      129.1127,
      129.6855,
      130.2526,
      130.814,
      131.3696,
      131.9194,
      132.4631,
      133.0009,
      133.5328,
      134.0587,
      134.5787,
      135.093,
      135.6015,
      136.1046,
      136.6024,
      137.095,
      137.5828,
      138.066,
      138.545,
      139.0201,
      139.4918,
      139.9604,
      140.4265,
      140.8906,
      141.3532,
      141.8149,
      142.2764,
      142.7382,
      143.2012,
      143.666,
      144.1333,
      144.6039,
      145.0785,
      145.5579,
      146.0429,
      146.5341,
      147.0322,
      147.5379,
      148.0517,
      148.5741,
      149.1054,
      149.646,
      150.196,
      150.7552,
      151.3236,
      151.9008,
      152.4861,
      153.079,
      153.6783,
      154.283,
      154.8918,
      155.5032,
      156.1156,
      156.7273,
      157.3365,
      157.9413,
      158.5398,
      159.1302,
      159.7107,
      160.2796,
      160.8353,

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

  calculateTypeBoyWeight(){
    double mounth=(calculateAllMounth(_user.birthdate)/12);
    double weight=double.parse(_user.weight);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,


    ];
    List sadak5 = [
      10.64009,
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
      12.09962,
      12.21984,
      12.34115,
      12.46354,
      12.58701,
      12.71154,
      12.8371,
      12.96366,
      13.09119,
      13.21963,
      13.34895,
      13.47911,
      13.61006,
      13.74176,
      13.87418,
      14.00727,
      14.14102,
      14.2754,
      14.41037,
      14.54593,
      14.68205,
      14.81872,
      14.95595,
      15.09371,
      15.23202,
      15.37087,
      15.51027,
      15.65023,
      15.79076,
      15.93186,
      16.07356,
      16.21586,
      16.35879,
      16.50235,
      16.64657,
      16.79146,
      16.93704,
      17.08332,
      17.23031,
      17.37804,
      17.52651,
      17.67574,
      17.82572,
      17.97649,
      18.12803,
      18.28036,
      18.43348,
      18.5874,
      18.74211,
      18.89763,
      19.05395,
      19.21107,
      19.369,
      19.52773,
      19.68727,
      19.84762,
      20.00878,
      20.17076,
      20.33357,
      20.4972,
      20.66168,
      20.82702,
      20.99322,
      21.16032,
      21.32832,
      21.49726,
      21.66716,
      21.83805,
      22.00997,
      22.18296,
      22.35705,
      22.5323,
      22.70876,
      22.88648,
      23.06551,
      23.24593,
      23.42779,
      23.61117,
      23.79613,
      23.98277,
      24.17115,
      24.36137,
      24.55351,
      24.74766,
      24.94392,
      25.14238,
      25.34314,
      25.54631,
      25.75198,
      25.96027,
      26.17126,
      26.38509,
      26.60184,
      26.82163,
      27.04457,
      27.27076,
      27.50031,
      27.73332,
      27.96989,
      28.21013,
      28.45412,
      28.70197,
      28.95376,
      29.20958,
      29.4695,
      29.7336,
      30.00195,
      30.2746,
      30.55162,


    ]; List sadak25 = [
      11.78598,
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
      13.37875,
      13.51197,
      13.64693,
      13.78366,
      13.92218,
      14.0625,
      14.20458,
      14.3484,
      14.49391,
      14.64105,
      14.78977,
      14.93998,
      15.09163,
      15.24463,
      15.39892,
      15.55441,
      15.71103,
      15.86872,
      16.0274,
      16.18701,
      16.34748,
      16.50877,
      16.67081,
      16.83356,
      16.99698,
      17.16103,
      17.32567,
      17.49088,
      17.65664,
      17.82293,
      17.98974,
      18.15706,
      18.32489,
      18.49324,
      18.66211,
      18.83151,
      19.00147,
      19.17199,
      19.34311,
      19.51485,
      19.68724,
      19.86032,
      20.03413,
      20.20871,
      20.38409,
      20.56032,
      20.73745,
      20.91553,
      21.0946,
      21.27471,
      21.45592,
      21.63828,
      21.82185,
      22.00666,
      22.19278,
      22.38027,
      22.56917,
      22.75955,
      22.95145,
      23.14493,
      23.34005,
      23.53686,
      23.73542,
      23.93579,
      24.13801,
      24.34216,
      24.54828,
      24.75645,
      24.9667,
      25.17912,
      25.39375,
      25.61067,
      25.82993,
      26.05161,
      26.27576,
      26.50246,
      26.73177,
      26.96376,
      27.19851,
      27.43609,
      27.67657,
      27.92001,
      28.16651,
      28.41613,
      28.66894,
      28.92502,
      29.18446,
      29.44731,
      29.71365,
      29.98357,
      30.25713,
      30.53439,
      30.81543,
      31.10032,
      31.38912,
      31.68189,
      31.97868,
      32.27955,
      32.58454,
      32.89371,
      33.20709,
      33.52472,
      33.84662,
      34.17281,
      34.5033,
      34.83811,
      35.17724,
      35.52066,
      35.86837,


    ]; List sadak75 = [13.63692,
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
      15.55987,
      15.7263,
      15.89565,
      16.06797,
      16.24326,
      16.42153,
      16.60273,
      16.78682,
      16.97373,
      17.16336,
      17.35564,
      17.55044,
      17.74767,
      17.9472,
      18.14892,
      18.3527,
      18.55842,
      18.76598,
      18.97524,
      19.1861,
      19.39846,
      19.6122,
      19.82724,
      20.04348,
      20.26086,
      20.47929,
      20.69871,
      20.91907,
      21.14031,
      21.36242,
      21.58534,
      21.80908,
      22.0336,
      22.25893,
      22.48505,
      22.712,
      22.93978,
      23.16845,
      23.39803,
      23.62858,
      23.86016,
      24.09284,
      24.32667,
      24.56175,
      24.79815,
      25.03598,
      25.27531,
      25.51626,
      25.75894,
      26.00344,
      26.24988,
      26.49839,
      26.74907,
      27.00204,
      27.25743,
      27.51535,
      27.77593,
      28.03928,
      28.30554,
      28.5748,
      28.84718,
      29.12281,
      29.40179,
      29.68422,
      29.97021,
      30.25986,
      30.55326,
      30.85051,
      31.15169,
      31.45689,
      31.76618,
      32.07964,
      32.39734,
      32.71933,
      33.04569,
      33.37646,
      33.7117,
      34.05144,
      34.39573,
      34.7446,
      35.09808,
      35.4562,
      35.81896,
      36.1864,
      36.55851,
      36.93529,
      37.31675,
      37.70287,
      38.09365,
      38.48906,
      38.88907,
      39.29366,
      39.7028,
      40.11642,
      40.5345,
      40.95697,
      41.38377,
      41.81484,
      42.2501,
      42.68947,
      43.13287,
      43.5802,
      44.03137,
      44.48627,
      44.94478,
      45.40679,
      45.87218,
      46.3408,
      46.81253,

    ];List sadak90 = [14.5834,
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
      16.73623,
      16.9267,
      17.12085,
      17.3187,
      17.52025,
      17.72545,
      17.93424,
      18.14654,
      18.36226,
      18.58128,
      18.80348,
      19.02875,
      19.25695,
      19.48794,
      19.7216,
      19.95779,
      20.19637,
      20.43722,
      20.68022,
      20.92526,
      21.17222,
      21.421,
      21.67152,
      21.92369,
      22.17744,
      22.4327,
      22.68943,
      22.94758,
      23.20712,
      23.46802,
      23.73029,
      23.99391,
      24.2589,
      24.52527,
      24.79305,
      25.06229,
      25.33302,
      25.6053,
      25.87919,
      26.15477,
      26.4321,
      26.71128,
      26.99239,
      27.27553,
      27.56081,
      27.84832,
      28.13817,
      28.43049,
      28.72538,
      29.02298,
      29.3234,
      29.62676,
      29.9332,
      30.24283,
      30.55579,
      30.8722,
      31.19218,
      31.51586,
      31.84335,
      32.17478,
      32.51025,
      32.84988,
      33.19377,
      33.54202,
      33.89472,
      34.25197,
      34.61384,
      34.98041,
      35.35176,
      35.72793,
      36.10899,
      36.49499,
      36.88596,
      37.28193,
      37.68294,
      38.08898,
      38.50008,
      38.91622,
      39.33741,
      39.76363,
      40.19484,
      40.63103,
      41.07214,
      41.51813,
      41.96894,
      42.42452,
      42.88478,
      43.34967,
      43.81908,
      44.29292,
      44.77111,
      45.25354,
      45.7401,
      46.23066,
      46.72512,
      47.22334,
      47.72519,
      48.23054,
      48.73924,
      49.25114,
      49.76611,
      50.28397,
      50.80458,
      51.32778,
      51.85339,
      52.38125,
      52.91119,
      53.44304,
      53.97661,

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
    double mounth=(calculateAllMounth(_user.birthdate)/12);
    double weight=double.parse(_user.weight);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,


    ];
    List sadak5 = [
      10.21027,
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
      11.65542,
      11.76826,
      11.88202,
      11.99685,
      12.11284,
      12.23011,
      12.34871,
      12.4687,
      12.59011,
      12.71297,
      12.83726,
      12.96298,
      13.09012,
      13.21864,
      13.3485,
      13.47966,
      13.61206,
      13.74566,
      13.8804,
      14.01621,
      14.15303,
      14.29081,
      14.42947,
      14.56897,
      14.70924,
      14.85022,
      14.99186,
      15.13412,
      15.27694,
      15.42029,
      15.56413,
      15.70843,
      15.85316,
      15.99831,
      16.14385,
      16.28977,
      16.43608,
      16.58277,
      16.72986,
      16.87736,
      17.02528,
      17.17365,
      17.3225,
      17.47187,
      17.6218,
      17.77232,
      17.9235,
      18.07539,
      18.22805,
      18.38153,
      18.53591,
      18.69124,
      18.84762,
      19.00511,
      19.16378,
      19.32373,
      19.48502,
      19.64775,
      19.81199,
      19.97783,
      20.14535,
      20.31464,
      20.48579,
      20.65887,
      20.83397,
      21.01117,
      21.19055,
      21.37219,
      21.55616,
      21.74253,
      21.93138,
      22.12277,
      22.31677,
      22.51343,
      22.71282,
      22.91497,
      23.11994,
      23.32778,
      23.53851,
      23.75217,
      23.96879,
      24.18838,
      24.41097,
      24.63656,
      24.86516,
      25.09677,
      25.33137,
      25.56895,
      25.80949,
      26.05297,
      26.29934,
      26.54856,
      26.8006,
      27.05539,
      27.31287,
      27.57298,
      27.83564,
      28.10077,
      28.36829,
      28.63809,
      28.91009,
      29.18417,
      29.46022,
      29.73813,
      30.01776,
      30.299,
      30.5817,
      30.86573,
      31.15094,

    ]; List sadak25 = [
      11.23357,
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
      12.90222,
      13.03542,
      13.16977,
      13.30538,
      13.44234,
      13.58071,
      13.72054,
      13.86186,
      14.00469,
      14.14902,
      14.29485,
      14.44217,
      14.59093,
      14.74112,
      14.89269,
      15.0456,
      15.19981,
      15.35527,
      15.51193,
      15.66975,
      15.82868,
      15.98868,
      16.14971,
      16.31173,
      16.47471,
      16.63861,
      16.80342,
      16.9691,
      17.13565,
      17.30305,
      17.4713,
      17.6404,
      17.81035,
      17.98118,
      18.15288,
      18.32549,
      18.49904,
      18.67356,
      18.84908,
      19.02566,
      19.20334,
      19.38217,
      19.56221,
      19.74353,
      19.9262,
      20.11027,
      20.29582,
      20.48293,
      20.67168,
      20.86215,
      21.05441,
      21.24855,
      21.44467,
      21.64283,
      21.84313,
      22.04564,
      22.25047,
      22.45768,
      22.66736,
      22.8796,
      23.09446,
      23.31203,
      23.53237,
      23.75556,
      23.98166,
      24.21073,
      24.44283,
      24.67802,
      24.91634,
      25.15783,
      25.40252,
      25.65046,
      25.90167,
      26.15616,
      26.41394,
      26.67503,
      26.93942,
      27.20709,
      27.47805,
      27.75225,
      28.02968,
      28.31029,
      28.59403,
      28.88087,
      29.17072,
      29.46353,
      29.75922,
      30.0577,
      30.35888,
      30.66267,
      30.96895,
      31.27762,
      31.58856,
      31.90163,
      32.21671,
      32.53364,
      32.8523,
      33.17252,
      33.49415,
      33.81701,
      34.14096,
      34.4658,
      34.79137,
      35.11747,
      35.44394,
      35.77056,
      36.09716,
      36.42354,
      36.7495,

    ]; List sadak75 = [12.98667,
      13.07613,
      13.25293,
      13.42753,
      13.60059,
      13.77271,
      13.9444,
      14.11611,
      14.28823,
      14.46106,
      14.63491,
      14.80998,
      14.98647,
      15.16452,
      15.34425,
      15.52574,
      15.70905,
      15.89422,
      16.08126,
      16.27016,
      16.46093,
      16.65353,
      16.84793,
      17.04408,
      17.24195,
      17.44149,
      17.64265,
      17.84537,
      18.04961,
      18.25533,
      18.46249,
      18.67105,
      18.88097,
      19.09224,
      19.30483,
      19.51874,
      19.73395,
      19.95048,
      20.16834,
      20.38753,
      20.6081,
      20.83007,
      21.05349,
      21.2784,
      21.50486,
      21.73294,
      21.96271,
      22.19425,
      22.42763,
      22.66294,
      22.90029,
      23.13976,
      23.38146,
      23.6255,
      23.87199,
      24.12103,
      24.37274,
      24.62725,
      24.88466,
      25.14509,
      25.40866,
      25.67549,
      25.94569,
      26.21937,
      26.49666,
      26.77764,
      27.06244,
      27.35114,
      27.64385,
      27.94066,
      28.24165,
      28.54689,
      28.85648,
      29.17046,
      29.4889,
      29.81185,
      30.13934,
      30.47142,
      30.80811,
      31.14942,
      31.49536,
      31.84592,
      32.20108,
      32.56084,
      32.92513,
      33.29393,
      33.66717,
      34.04479,
      34.4267,
      34.81282,
      35.20305,
      35.59726,
      35.99535,
      36.39717,
      36.80259,
      37.21144,
      37.62356,
      38.03878,
      38.45691,
      38.87775,
      39.30111,
      39.72676,
      40.15449,
      40.58407,
      41.01526,
      41.44782,
      41.88148,
      42.316,
      42.75111,
      43.18655,
      43.62203,
      44.05728,
      44.49201,
      44.92595,
      45.3588,
      45.79028,
      46.22009,
      46.64794,
      47.07354,
      47.49661,
      47.91684,
      48.33396,

    ];List sadak90 = [13.93766,
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
      16.46789,
      16.68038,
      16.89519,
      17.11235,
      17.33186,
      17.55371,
      17.77788,
      18.00432,
      18.23298,
      18.46379,
      18.69671,
      18.93166,
      19.16858,
      19.40739,
      19.64805,
      19.89048,
      20.13464,
      20.38048,
      20.62795,
      20.87704,
      21.1277,
      21.37993,
      21.63373,
      21.88909,
      22.14604,
      22.4046,
      22.6648,
      22.92668,
      23.19031,
      23.45574,
      23.72305,
      23.99232,
      24.26364,
      24.5371,
      24.81282,
      25.09089,
      25.37145,
      25.65461,
      25.94051,
      26.22926,
      26.52102,
      26.81591,
      27.11407,
      27.41566,
      27.7208,
      28.02965,
      28.34233,
      28.659,
      28.97979,
      29.30484,
      29.63426,
      29.9682,
      30.30677,
      30.65008,
      30.99825,
      31.35137,
      31.70954,
      32.07286,
      32.44138,
      32.8152,
      33.19435,
      33.5789,
      33.96887,
      34.36431,
      34.76522,
      35.17161,
      35.58347,
      36.00078,
      36.42352,
      36.85164,
      37.28507,
      37.72376,
      38.16762,
      38.61656,
      39.07046,
      39.52921,
      39.99268,
      40.46071,
      40.93316,
      41.40984,
      41.89057,
      42.37517,
      42.86342,
      43.35511,
      43.85001,
      44.34788,
      44.84847,
      45.35152,
      45.85676,
      46.36392,
      46.87271,
      47.38283,
      47.894,
      48.40589,
      48.9182,
      49.43061,
      49.9428,
      50.45443,
      50.96519,
      51.47473,
      51.98272,
      52.48882,
      52.9927,
      53.49402,
      53.99244,
      54.48762,
      54.97925,
      55.46697,
      55.95048,

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

  calculateTypeBoyBMI(){
    double mounth=calculateAllMounth(_user.birthdate)/12;
    double weight = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,


    ];
    List sadak5 = [
      14.73732,
      14.71929,
      14.68361,
      14.64843,
      14.61379,
      14.57969,
      14.54615,
      14.51319,
      14.48084,
      14.44909,
      14.41798,
      14.3875,
      14.35767,
      14.32851,
      14.30002,
      14.27222,
      14.2451,
      14.21868,
      14.19297,
      14.16796,
      14.14367,
      14.12009,
      14.09723,
      14.07509,
      14.05366,
      14.03296,
      14.01296,
      13.99367,
      13.97509,
      13.95722,
      13.94003,
      13.92353,
      13.90771,
      13.89257,
      13.87809,
      13.86426,
      13.85108,
      13.83855,
      13.82665,
      13.81537,
      13.80472,
      13.79469,
      13.78527,
      13.77646,
      13.76825,
      13.76065,
      13.75364,
      13.74724,
      13.74144,
      13.73624,
      13.73164,
      13.72764,
      13.72424,
      13.72145,
      13.71927,
      13.71769,
      13.71672,
      13.71637,
      13.71663,
      13.71751,
      13.71901,
      13.72113,
      13.72387,
      13.72724,
      13.73124,
      13.73587,
      13.74113,
      13.74702,
      13.75355,
      13.76071,
      13.76852,
      13.77695,
      13.78603,
      13.79575,
      13.8061,
      13.8171,
      13.82873,
      13.84101,
      13.85392,
      13.86747,
      13.88166,
      13.89648,
      13.91194,
      13.92804,
      13.94476,
      13.96212,
      13.9801,
      13.99871,
      14.01795,
      14.0378,
      14.05828,
      14.07937,
      14.10107,
      14.12338,
      14.1463,
      14.16982,
      14.19394,
      14.21866,
      14.24396,
      14.26985,
      14.29633,
      14.32338,
      14.35101,
      14.3792,
      14.40796,
      14.43727,
      14.46714,
      14.49756,
      14.52852,
      14.56001,
      14.59203,
      14.62458,
      14.65765,
      14.69122,
      14.72531,
      14.75989,
      14.79496,
      14.83052,
      14.86655,
      14.90306,
      14.94002,
      14.97745,

    ]; List sadak25 = [
      15.74164,
      15.71963,
      15.67634,
      15.63403,
      15.59268,
      15.55226,
      15.51275,
      15.47414,
      15.43639,
      15.39951,
      15.36345,
      15.32822,
      15.29379,
      15.26016,
      15.22731,
      15.19523,
      15.16392,
      15.13337,
      15.10359,
      15.07458,
      15.04633,
      15.01886,
      14.99218,
      14.96629,
      14.9412,
      14.91694,
      14.89351,
      14.87093,
      14.84921,
      14.82838,
      14.80844,
      14.78941,
      14.7713,
      14.75414,
      14.73792,
      14.72266,
      14.70836,
      14.69504,
      14.68269,
      14.67133,
      14.66094,
      14.65154,
      14.64312,
      14.63567,
      14.6292,
      14.62369,
      14.61914,
      14.61555,
      14.6129,
      14.6112,
      14.61042,
      14.61057,
      14.61163,
      14.61359,
      14.61645,
      14.6202,
      14.62483,
      14.63032,
      14.63668,
      14.64389,
      14.65194,
      14.66082,
      14.67054,
      14.68107,
      14.69241,
      14.70455,
      14.71749,
      14.73121,
      14.74571,
      14.76099,
      14.77703,
      14.79382,
      14.81136,
      14.82965,
      14.84867,
      14.86841,
      14.88888,
      14.91006,
      14.93194,
      14.95453,
      14.9778,
      15.00176,
      15.0264,
      15.05172,
      15.07769,
      15.10433,
      15.13161,
      15.15954,
      15.1881,
      15.2173,
      15.24712,
      15.27755,
      15.30859,
      15.34024,
      15.37248,
      15.40531,
      15.43872,
      15.4727,
      15.50725,
      15.54236,
      15.57803,
      15.61424,
      15.65099,
      15.68826,
      15.72607,
      15.76439,
      15.80322,
      15.84255,
      15.88237,
      15.92268,
      15.96347,
      16.00473,
      16.04646,
      16.08864,
      16.13127,
      16.17434,
      16.21784,
      16.26177,
      16.30612,
      16.35087,
      16.39603,
      16.44158,

    ]; List sadak75 = [17.55719,
      17.52129,
      17.45135,
      17.38384,
      17.31871,
      17.25593,
      17.19546,
      17.13726,
      17.0813,
      17.02753,
      16.97592,
      16.92645,
      16.87907,
      16.83376,
      16.79048,
      16.7492,
      16.70988,
      16.67251,
      16.63704,
      16.60345,
      16.5717,
      16.54177,
      16.51364,
      16.48726,
      16.46262,
      16.4397,
      16.41846,
      16.39889,
      16.38097,
      16.36468,
      16.35001,
      16.33693,
      16.32545,
      16.31554,
      16.3072,
      16.30042,
      16.29518,
      16.29148,
      16.28932,
      16.28868,
      16.28955,
      16.29192,
      16.29578,
      16.30113,
      16.30794,
      16.3162,
      16.3259,
      16.33702,
      16.34955,
      16.36346,
      16.37875,
      16.39537,
      16.41333,
      16.4326,
      16.45315,
      16.47496,
      16.49801,
      16.52229,
      16.54776,
      16.5744,
      16.60219,
      16.63112,
      16.66114,
      16.69225,
      16.72442,
      16.75763,
      16.79185,
      16.82707,
      16.86325,
      16.90039,
      16.93845,
      16.97742,
      17.01727,
      17.05799,
      17.09955,
      17.14193,
      17.18512,
      17.22909,
      17.27383,
      17.31932,
      17.36552,
      17.41244,
      17.46005,
      17.50833,
      17.55726,
      17.60683,
      17.65702,
      17.7078,
      17.75918,
      17.81112,
      17.86361,
      17.91664,
      17.9702,
      18.02425,
      18.07879,
      18.13381,
      18.18929,
      18.24521,
      18.30156,
      18.35833,
      18.4155,
      18.47306,
      18.53099,
      18.58928,
      18.64792,
      18.70689,
      18.76619,
      18.82579,
      18.8857,
      18.94588,
      19.00634,
      19.06706,
      19.12803,
      19.18924,
      19.25067,
      19.31232,
      19.37417,
      19.43622,
      19.49845,
      19.56086,
      19.62342,
      19.68614,

    ];List sadak90 = [18.60948,
      18.56111,
      18.4673,
      18.37736,
      18.29125,
      18.20892,
      18.13031,
      18.05538,
      17.98408,
      17.91635,
      17.85215,
      17.79143,
      17.73414,
      17.68022,
      17.62963,
      17.58231,
      17.5382,
      17.49725,
      17.45941,
      17.42462,
      17.39282,
      17.36395,
      17.33795,
      17.31477,
      17.29434,
      17.27661,
      17.26151,
      17.24899,
      17.23899,
      17.23145,
      17.22632,
      17.22354,
      17.22306,
      17.22483,
      17.2288,
      17.23493,
      17.24315,
      17.25344,
      17.26575,
      17.28003,
      17.29625,
      17.31437,
      17.33435,
      17.35616,
      17.37975,
      17.4051,
      17.43217,
      17.46092,
      17.49133,
      17.52335,
      17.55696,
      17.59212,
      17.6288,
      17.66696,
      17.70658,
      17.74762,
      17.79004,
      17.83382,
      17.87892,
      17.92532,
      17.97296,
      18.02183,
      18.0719,
      18.12312,
      18.17548,
      18.22893,
      18.28344,
      18.33899,
      18.39554,
      18.45306,
      18.51152,
      18.57089,
      18.63115,
      18.69225,
      18.75418,
      18.8169,
      18.88038,
      18.94459,
      19.00952,
      19.07512,
      19.14137,
      19.20825,
      19.27573,
      19.34378,
      19.41238,
      19.48149,
      19.5511,
      19.62118,
      19.69171,
      19.76266,
      19.83401,
      19.90573,
      19.97781,
      20.05021,
      20.12292,
      20.19592,
      20.26919,
      20.3427,
      20.41643,
      20.49036,
      20.56448,
      20.63877,
      20.7132,
      20.78775,
      20.86242,
      20.93718,
      21.01201,
      21.0869,
      21.16183,
      21.23679,
      21.31175,
      21.38671,
      21.46165,
      21.53655,
      21.61141,
      21.6862,
      21.76091,
      21.83554,
      21.91006,
      21.98447,
      22.05876,
      22.1329,

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
  calculateTypeGirlBMI(){
    double mounth=calculateAllMounth(_user.birthdate)/12;
    double weight = double.parse(_user.weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    int _type=0;
    List mounthList = [
      1.96,
      2,
      2.09,
      2.17,
      2.25,
      2.34,
      2.42,
      2.5,
      2.59,
      2.67,
      2.75,
      2.84,
      2.92,
      3,
      3.09,
      3.17,
      3.25,
      3.34,
      3.42,
      3.5,
      3.59,
      3.67,
      3.75,
      3.84,
      3.92,
      4,
      4.09,
      4.17,
      4.25,
      4.34,
      4.42,
      4.5,
      4.59,
      4.67,
      4.75,
      4.84,
      4.92,
      5,
      5.09,
      5.17,
      5.25,
      5.34,
      5.42,
      5.5,
      5.59,
      5.67,
      5.75,
      5.84,
      5.92,
      6,
      6.09,
      6.17,
      6.25,
      6.34,
      6.42,
      6.5,
      6.59,
      6.67,
      6.75,
      6.84,
      6.92,
      7,
      7.09,
      7.17,
      7.25,
      7.34,
      7.42,
      7.5,
      7.59,
      7.67,
      7.75,
      7.84,
      7.92,
      8,
      8.09,
      8.17,
      8.25,
      8.34,
      8.42,
      8.5,
      8.59,
      8.67,
      8.75,
      8.84,
      8.92,
      9,
      9.09,
      9.17,
      9.25,
      9.34,
      9.42,
      9.5,
      9.59,
      9.67,
      9.75,
      9.84,
      9.92,
      10,
      10.09,
      10.17,
      10.25,
      10.34,
      10.42,
      10.5,
      10.59,
      10.67,
      10.75,
      10.84,
      10.92,
      11,
      11.09,
      11.17,
      11.25,
      11.34,
      11.42,
      11.5,
      11.59,
      11.67,
      11.75,
      11.84,
      11.92,
      12,

    ];
    List sadak5 = [
      14.39787,
      14.38019,
      14.34527,
      14.31097,
      14.27728,
      14.2442,
      14.21175,
      14.17992,
      14.14871,
      14.11813,
      14.08818,
      14.05885,
      14.03016,
      14.00209,
      13.97466,
      13.94786,
      13.92169,
      13.89615,
      13.87124,
      13.84697,
      13.82333,
      13.80033,
      13.77796,
      13.75624,
      13.73516,
      13.71472,
      13.69493,
      13.67579,
      13.65731,
      13.63948,
      13.62231,
      13.6058,
      13.58997,
      13.5748,
      13.56031,
      13.54649,
      13.53336,
      13.52091,
      13.50915,
      13.49808,
      13.4877,
      13.47802,
      13.46903,
      13.46075,
      13.45317,
      13.4463,
      13.44013,
      13.43467,
      13.42991,
      13.42587,
      13.42254,
      13.41992,
      13.41801,
      13.41681,
      13.41632,
      13.41654,
      13.41748,
      13.41912,
      13.42147,
      13.42453,
      13.42829,
      13.43276,
      13.43793,
      13.4438,
      13.45037,
      13.45764,
      13.4656,
      13.47425,
      13.48359,
      13.49362,
      13.50432,
      13.51571,
      13.52777,
      13.5405,
      13.5539,
      13.56797,
      13.58269,
      13.59807,
      13.6141,
      13.63077,
      13.64809,
      13.66605,
      13.68463,
      13.70384,
      13.72368,
      13.74413,
      13.76519,
      13.78685,
      13.80911,
      13.83197,
      13.85541,
      13.87943,
      13.90402,
      13.92918,
      13.9549,
      13.98118,
      14.008,
      14.03535,
      14.06324,
      14.09166,
      14.12059,
      14.15003,
      14.17997,
      14.21041,
      14.24133,
      14.27272,
      14.30459,
      14.33691,
      14.36969,
      14.4029,
      14.43656,
      14.47063,
      14.50512,
      14.54002,
      14.57531,
      14.61099,
      14.64705,
      14.68347,
      14.72025,
      14.75737,
      14.79484,
      14.83262,
      14.87073,

    ]; List sadak25 = [
      15.52808,
      15.49976,
      15.44422,
      15.39015,
      15.33754,
      15.2864,
      15.23671,
      15.18848,
      15.14171,
      15.09638,
      15.0525,
      15.01007,
      14.96907,
      14.9295,
      14.89136,
      14.85465,
      14.81934,
      14.78544,
      14.75293,
      14.7218,
      14.69205,
      14.66365,
      14.63661,
      14.61091,
      14.58652,
      14.56345,
      14.54167,
      14.52117,
      14.50194,
      14.48396,
      14.46721,
      14.45169,
      14.43738,
      14.42427,
      14.41233,
      14.40156,
      14.39194,
      14.38345,
      14.37609,
      14.36984,
      14.36469,
      14.36062,
      14.35762,
      14.35567,
      14.35478,
      14.35491,
      14.35606,
      14.35823,
      14.36138,
      14.36552,
      14.37063,
      14.3767,
      14.38372,
      14.39168,
      14.40056,
      14.41035,
      14.42104,
      14.43263,
      14.44509,
      14.45842,
      14.47261,
      14.48765,
      14.50352,
      14.52021,
      14.53772,
      14.55603,
      14.57513,
      14.59501,
      14.61566,
      14.63706,
      14.65922,
      14.68211,
      14.70572,
      14.73005,
      14.75508,
      14.78081,
      14.80722,
      14.8343,
      14.86204,
      14.89043,
      14.91946,
      14.94911,
      14.97938,
      15.01026,
      15.04173,
      15.07378,
      15.10641,
      15.1396,
      15.17334,
      15.20762,
      15.24242,
      15.27775,
      15.31358,
      15.3499,
      15.38671,
      15.42399,
      15.46173,
      15.49992,
      15.53855,
      15.57761,
      15.61709,
      15.65696,
      15.69724,
      15.73789,
      15.77891,
      15.8203,
      15.86203,
      15.9041,
      15.94649,
      15.98919,
      16.0322,
      16.07549,
      16.11907,
      16.1629,
      16.207,
      16.25134,
      16.2959,
      16.34069,
      16.38568,
      16.43087,
      16.47625,
      16.52179,
      16.5675,

    ]; List sadak75 = [17.42746,
      17.38582,
      17.30485,
      17.22693,
      17.15202,
      17.08009,
      17.01107,
      16.94495,
      16.88168,
      16.82123,
      16.76355,
      16.70862,
      16.65641,
      16.60687,
      16.55998,
      16.5157,
      16.474,
      16.43486,
      16.39824,
      16.36411,
      16.33244,
      16.3032,
      16.27636,
      16.25188,
      16.22973,
      16.20988,
      16.19229,
      16.17693,
      16.16378,
      16.15278,
      16.14391,
      16.13714,
      16.13242,
      16.12972,
      16.12901,
      16.13025,
      16.1334,
      16.13843,
      16.14531,
      16.154,
      16.16446,
      16.17665,
      16.19056,
      16.20613,
      16.22334,
      16.24214,
      16.26252,
      16.28443,
      16.30785,
      16.33273,
      16.35906,
      16.38679,
      16.41589,
      16.44633,
      16.47809,
      16.51113,
      16.54542,
      16.58094,
      16.61764,
      16.65551,
      16.69451,
      16.73462,
      16.7758,
      16.81803,
      16.86129,
      16.90553,
      16.95075,
      16.9969,
      17.04396,
      17.09191,
      17.14072,
      17.19037,
      17.24082,
      17.29206,
      17.34405,
      17.39678,
      17.45022,
      17.50434,
      17.55912,
      17.61454,
      17.67057,
      17.7272,
      17.78438,
      17.84212,
      17.90037,
      17.95912,
      18.01835,
      18.07803,
      18.13815,
      18.19867,
      18.25959,
      18.32088,
      18.38251,
      18.44447,
      18.50675,
      18.5693,
      18.63213,
      18.6952,
      18.7585,
      18.82202,
      18.88572,
      18.94959,
      19.01362,
      19.07779,
      19.14207,
      19.20645,
      19.27091,
      19.33544,
      19.40001,
      19.46462,
      19.52924,
      19.59386,
      19.65846,
      19.72302,
      19.78754,
      19.85199,
      19.91636,
      19.98063,
      20.0448,
      20.10884,
      20.17274,
      20.23648,
      20.30006,

    ];List sadak90 = [18.44139,
      18.39526,
      18.30611,
      18.22103,
      18.13997,
      18.06285,
      17.98962,
      17.92019,
      17.85452,
      17.79253,
      17.73416,
      17.67936,
      17.62805,
      17.58019,
      17.53571,
      17.49455,
      17.45667,
      17.422,
      17.39049,
      17.3621,
      17.33676,
      17.31442,
      17.29505,
      17.27858,
      17.26497,
      17.25417,
      17.24613,
      17.24081,
      17.23815,
      17.23811,
      17.24065,
      17.24571,
      17.25326,
      17.26324,
      17.2756,
      17.29031,
      17.30732,
      17.32657,
      17.34803,
      17.37165,
      17.39739,
      17.42519,
      17.45502,
      17.48683,
      17.52057,
      17.5562,
      17.59369,
      17.63297,
      17.67402,
      17.71678,
      17.76122,
      17.8073,
      17.85496,
      17.90417,
      17.95489,
      18.00708,
      18.06069,
      18.11569,
      18.17203,
      18.22968,
      18.28859,
      18.34873,
      18.41007,
      18.47255,
      18.53615,
      18.60082,
      18.66653,
      18.73325,
      18.80093,
      18.86955,
      18.93906,
      19.00943,
      19.08063,
      19.15262,
      19.22537,
      19.29884,
      19.37301,
      19.44784,
      19.52329,
      19.59935,
      19.67596,
      19.75312,
      19.83077,
      19.9089,
      19.98748,
      20.06647,
      20.14584,
      20.22558,
      20.30564,
      20.38601,
      20.46665,
      20.54754,
      20.62866,
      20.70997,
      20.79145,
      20.87308,
      20.95484,
      21.03669,
      21.11861,
      21.20059,
      21.28259,
      21.3646,
      21.44659,
      21.52854,
      21.61043,
      21.69224,
      21.77396,
      21.85555,
      21.937,
      22.01829,
      22.0994,
      22.18031,
      22.26101,
      22.34148,
      22.4217,
      22.50166,
      22.58133,
      22.66071,
      22.73977,
      22.8185,
      22.89689,
      22.97493,
      23.05259,

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
  String setStatusBmi() {
    if(_user!=null){

      int type=
      _user.gender=="female"
          ? calculateTypeGirlBMI()
          :  calculateTypeBoyBMI();

      switch (type){
        case 1:
          return "از نظر شاخص توده بدنی(BMI)، موقعيت فعلي كودک شما زير صدک 5 است و كم وزن محسوب ميشود.";
          break;
        case 2:
          return "از نظر شاخص توده بدنی(BMI)، موقعيت فعلي كودک شما بين صدک 5-25 است و نسبتا كم وزن محسوب ميشود.";
          break;
        case 3:
          return "از نظر شاخص توده بدنی(BMI)، موقعيت فعلي كودک شما بين صدک 25-75 است و در محدوده نرمال ميباشد.";
          break;
        case 4:
          return "از نظر شاخص توده بدنی(BMI)، موقعيت فعلي كودک شما بين صدک 75-90 است و نسبتا داراي اضافه وزن میباشد.";
          break;
        case 5:
          return "از نظر شاخص توده بدنی(BMI)، موقعيت فعلي كودک شما بالاتر از صدک  90 است و داراي اضافه وزن ميباشد.";
          break;

      }

    }
    else return"";
  }




Future<void> callApi() async {

    int calorie=calculateCal();
    print(calorie);
    if(calorie<600)calorie=600;

    if(await checkConnectionInternet()){
      Navigator.pop(context);
      if(widget.dietId!=null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child:widget.selfId==null
                    ? LoginScreen(type:"children3-12" ,
                    url :"https://api2.barikaapp.com/api/v3/diets/children"
                        "/${widget.uidDiet}?"
                        "user_name=${_user.name}&"
                        "user_height=${_user.height}&"
                        "user_weight=${_user.weight}&"
                        "user_birthdate=${_user.birthdate}&"
                        "user_sex=${_user.gender}&"
                        "user_appetite=${_user.appetite}&"
                        "user_activity=${_user.activity}&"
                        "dietId=${widget.dietId}&"
                        // "selfId=${widget.selfId}&"
                        "type=children3-12&"
                        "type2=$calorie"
                    ,counter: 0,metype:"children" ,user: _user,uid: widget.uidDiet,edit: widget.edit,dietId:  widget.dietId,)
                    : LoginScreen(type:"children3-12" ,
                    url :"https://api2.barikaapp.com/api/v3/diets/children"
                        "/${widget.uidDiet}?"
                        "user_name=${_user.name}&"
                        "user_height=${_user.height}&"
                        "user_weight=${_user.weight}&"
                        "user_birthdate=${_user.birthdate}&"
                        "user_sex=${_user.gender}&"
                        "user_appetite=${_user.appetite}&"
                        "user_activity=${_user.activity}&"
                        "dietId=${widget.dietId}&"
                        "selfId=${widget.selfId}&"
                        "type=children3-12&"
                        "type2=$calorie"
                    ,counter: 0,metype:"children" ,user: _user,uid: widget.uidDiet,edit: widget.edit,dietId:  widget.dietId,)


//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
          )));
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: widget.selfId==null
                    ? LoginScreen(type:"children3-12" ,
                    url :"https://api2.barikaapp.com/api/v3/diets/children"
        "/${widget.uidDiet}?"
        "user_name=${_user.name}&"
        "user_height=${_user.height}&"
        "user_weight=${_user.weight}&"
        "user_birthdate=${_user.birthdate}&"
        "user_sex=${_user.gender}&"
        "user_appetite=${_user.appetite}&"
        "user_activity=${_user.activity}&"
        // "dietId=${widget.dietId}&"
        // "selfId=${widget.selfId}&"
        "type=children3-12&"
        "type2=$calorie",counter: 0
        ,metype:"children" ,user: _user,uid: widget.uidDiet,edit: widget.edit,dietId:  widget.dietId,)

            : LoginScreen(type:"children3-12" ,
        url :"https://api2.barikaapp.com/api/v3/diets/children"
        "/${widget.uidDiet}?"
        "user_name=${_user.name}&"
        "user_height=${_user.height}&"
        "user_weight=${_user.weight}&"
        "user_birthdate=${_user.birthdate}&"
        "user_sex=${_user.gender}&"
        "user_appetite=${_user.appetite}&"
        "user_activity=${_user.activity}&"
        // "dietId=${widget.dietId}&"
        "selfId=${widget.selfId}&"
        "type=children3-12&"
        "type2=$calorie",counter: 0
        ,metype:"children" ,user: _user,uid: widget.uidDiet,edit: widget.edit,dietId:  widget.dietId,)


//                                builder: (context) => Directionality(textDirection: TextDirection.rtl, child:questionnaire()),
          ),

        ));
      }}
    else showSnakBar('اتصال به اینترنت را بررسی کنید.');

    setState(() {
      showLoading=false;
    });

}
  showSnakBar(String s) {
    setState(() {
      showLoading=false;
    });
    _scaffoldKey.currentState.showSnackBar( SnackBar(
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

}
class LinearSales {
  final double year;
  final double sales;

  LinearSales(this.year, this.sales);
}
