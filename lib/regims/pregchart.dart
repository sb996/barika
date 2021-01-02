
import 'package:barika_web/models/user.dart';
import 'package:barika_web/utils/SizeConfig.dart';
import 'package:barika_web/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;


import '../helper.dart';

class pregchart extends StatefulWidget {
  var user;
  String date;
  String ghol;

  pregchart({Key key, this.user, this.date,this.ghol}) : super(key: key);

  @override
  State<StatefulWidget> createState() => pregchartState();
}

class pregchartState extends State<pregchart> {
  Widget loadingView() {
    return new Center(
        child: SpinKitCircle(
      color: MyColors.vazn,
    ));
  }

  bool _isLoading = true;
  User _user;
  int _chart = 0;


  String regimDate;

  @override
  void initState() {
    _user=User.fromJsonDiet(widget.user);
    regimDate = widget.date;
    CalculateBmi();
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

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(58*(screenSize.width)/375,),
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
                                'نمودار',
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
                                Icons.chevron_left,
                                size: 32*(screenSize.width)/375,
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
            body: _isLoading
                ? loadingView()
                : CustomScrollView(slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                      _chart == 1
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              height: 250*(screenSize.width)/375,
                              decoration: BoxDecoration(
                                  color: Color(0xffE9E9E9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                                      Widget>[
                                Text(
                                  'کم وزن',
                                  style: TextStyle(
                                      color: Color(0xff555555),
                                      fontSize: 13*fontvar,
                                      fontWeight: FontWeight.w500),
                                ),
                                Expanded(
                                    child: new charts.LineChart(
                                  _PregnancyDown(),

                                  behaviors: [
                                    new charts.ChartTitle('هفته بارداری',
                                        behaviorPosition:
                                            charts.BehaviorPosition.bottom,
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12*fontvar.round()),
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea),
                                    new charts.ChartTitle('وزن',
                                        titleStyleSpec:
                                            charts.TextStyleSpec(fontSize: 12*fontvar.round()),
                                        behaviorPosition:
                                            charts.BehaviorPosition.end,
                                        titleOutsideJustification: charts
                                            .OutsideJustification
                                            .middleDrawArea),
                                    new charts.RangeAnnotation(
                                      [
                                        new charts.RangeAnnotationSegment(
                                          0.0,
                                          12.0,
                                          charts.RangeAnnotationAxisType.domain,
                                          labelStyleSpec: charts.TextStyleSpec(
                                              color: charts.Color.fromHex(
                                                  code: '#ffffffff'),
                                              fontSize: 12*fontvar.round()),
                                          color: charts.Color.fromHex(
                                              code: '#BDCBCB'),
                                        ),
                                        new charts.RangeAnnotationSegment(
                                          12.0,
                                          24.0,
                                          charts.RangeAnnotationAxisType.domain,
                                          labelStyleSpec: charts.TextStyleSpec(
                                              color: charts.Color.fromHex(
                                                  code: '#ffffffff'),
                                              fontSize: 12*fontvar.round()),
                                          color: charts.Color.fromHex(
                                              code: '#A7BCBB'),
                                        ),
                                        new charts.RangeAnnotationSegment(
                                          24.0,
                                          36.0,
                                          charts.RangeAnnotationAxisType.domain,
                                          labelStyleSpec: charts.TextStyleSpec(
                                              color: charts.Color.fromHex(
                                                  code: '#ffa1a1a1'),
                                              fontSize: 12*fontvar.round()),
                                          color: charts.Color.fromHex(
                                              code: '#BDCBCB'),
                                        ),
                                      ],
                                    )
                                  ],

                                  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                    tickProviderSpec:
                                        new charts.BasicNumericTickProviderSpec(
                                            desiredTickCount: 6),
                                  ),
                                  domainAxis: charts.NumericAxisSpec(
                                    showAxisLine: true,
                                    tickProviderSpec:
                                        charts.BasicNumericTickProviderSpec(
                                            desiredTickCount: 7),
                                  ),
                                  // Disable animations for image tests.
                                  animate: true,
                                  defaultRenderer:
                                      new charts.LineRendererConfig(
                                          includeArea: false, stacked: false),
//      customSeriesRenderers: [
//        new charts.LineRendererConfig(
//          // ID used to link series to this renderer.
//            customRendererId: 'customPoint')
//      ],
                                ))
                              ]))
                          : _chart == 2
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  height: 250*(screenSize.width)/375,
                                  decoration: BoxDecoration(
                                      color: Color(0xffE9E9E9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child:
                                      Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                                          Widget>[
                                    Text(
                                      "وزن نرمال",
                                      style: TextStyle(
                                          color: Color(0xff555555),
                                          fontSize: 13*fontvar,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                        child: new charts.LineChart(
                                      _PregnancyNormal(),
                                      behaviors: [
                                        new charts.ChartTitle('هفته بارداری',
                                            behaviorPosition:
                                                charts.BehaviorPosition.bottom,
                                            titleStyleSpec:
                                                charts.TextStyleSpec(
                                                    fontSize: 12*fontvar.round()),
                                            titleOutsideJustification: charts
                                                .OutsideJustification
                                                .middleDrawArea),
                                        new charts.ChartTitle('وزن',
                                            titleStyleSpec:
                                                charts.TextStyleSpec(
                                                    fontSize: 12*fontvar.round()),
                                            behaviorPosition:
                                                charts.BehaviorPosition.end,
                                            titleOutsideJustification: charts
                                                .OutsideJustification
                                                .middleDrawArea),
                                        new charts.RangeAnnotation(
                                          [
                                            new charts.RangeAnnotationSegment(
                                              0.0,
                                              12.0,
                                              charts.RangeAnnotationAxisType
                                                  .domain,
                                              labelStyleSpec:
                                                  charts.TextStyleSpec(
                                                      color:
                                                          charts.Color.fromHex(
                                                              code:
                                                                  '#ffffffff'),
                                                      fontSize: 12*fontvar.round()),
                                              color: charts.Color.fromHex(
                                                  code: '#BDCBCB'),
                                            ),
                                            new charts.RangeAnnotationSegment(
                                              12.0,
                                              24.0,
                                              charts.RangeAnnotationAxisType
                                                  .domain,
                                              labelStyleSpec:
                                                  charts.TextStyleSpec(
                                                      color:
                                                          charts.Color.fromHex(
                                                              code:
                                                                  '#ffffffff'),
                                                      fontSize: 12*fontvar.round()),
                                              color: charts.Color.fromHex(
                                                  code: '#A7BCBB'),
                                            ),
                                            new charts.RangeAnnotationSegment(
                                              24.0,
                                              36.0,
                                              charts.RangeAnnotationAxisType
                                                  .domain,
                                              labelStyleSpec:
                                                  charts.TextStyleSpec(
                                                      color:
                                                          charts.Color.fromHex(
                                                              code:
                                                                  '#ffa1a1a1'),
                                                      fontSize: 12*fontvar.round()),
                                              color: charts.Color.fromHex(
                                                  code: '#BDCBCB'),
                                            ),
                                          ],
                                        )
                                      ],
                                      primaryMeasureAxis:
                                          new charts.NumericAxisSpec(
                                        tickProviderSpec: new charts
                                                .BasicNumericTickProviderSpec(
                                            desiredTickCount: 6),
                                      ),
                                      domainAxis: charts.NumericAxisSpec(
                                        showAxisLine: true,
                                        tickProviderSpec:
                                            charts.BasicNumericTickProviderSpec(
                                                desiredTickCount: 7),
                                      ),
                                      // Disable animations for image tests.
                                      animate: true,
                                      defaultRenderer:
                                          new charts.LineRendererConfig(
                                              includeArea: false,
                                              stacked: false),
//      customSeriesRenderers: [
//        new charts.LineRendererConfig(
//          // ID used to link series to this renderer.
//            customRendererId: 'customPoint')
//      ],
                                    ))
                                  ]))
                              : _chart == 3
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      height: 250*(screenSize.width)/375,
                                      decoration: BoxDecoration(
                                          color: Color(0xffE9E9E9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                        Text(
                                          'اضافه وزن',
                                          style: TextStyle(
                                              color: Color(0xff555555),
                                              fontSize: 13*fontvar,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                            child: new charts.LineChart(
                                          _PregnancyUp(),
                                          behaviors: [
                                            new charts.ChartTitle(
                                                'هفته بارداری',
                                                behaviorPosition: charts
                                                    .BehaviorPosition.bottom,
                                                titleStyleSpec:
                                                    charts.TextStyleSpec(
                                                        fontSize: 12*fontvar.round()),
                                                titleOutsideJustification:
                                                    charts.OutsideJustification
                                                        .middleDrawArea),
                                            new charts.ChartTitle('وزن',
                                                titleStyleSpec:
                                                    charts.TextStyleSpec(
                                                        fontSize: 12*fontvar.round()),
                                                behaviorPosition:
                                                    charts.BehaviorPosition.end,
                                                titleOutsideJustification:
                                                    charts.OutsideJustification
                                                        .middleDrawArea),
                                            new charts.RangeAnnotation(
                                              [
                                                new charts
                                                        .RangeAnnotationSegment(
                                                    0.0,
                                                    12,
                                                    charts
                                                        .RangeAnnotationAxisType
                                                        .domain,
                                                    labelStyleSpec:
                                                        charts.TextStyleSpec(
                                                            color: charts.Color
                                                                .fromHex(
                                                                    code:
                                                                        '#ffffffff'),
                                                            fontSize: 12*fontvar.round()),
                                                    color: charts.Color.fromHex(
                                                        code: '#BDCBCB')),
                                                new charts
                                                    .RangeAnnotationSegment(
                                                  12.0,
                                                  24.0,
                                                  charts.RangeAnnotationAxisType
                                                      .domain,
                                                  labelStyleSpec:
                                                      charts.TextStyleSpec(
                                                          color: charts.Color
                                                              .fromHex(
                                                                  code:
                                                                      '#ffffffff'),
                                                          fontSize: 12*fontvar.round()),
                                                  color: charts.Color.fromHex(
                                                      code: '#A7BCBB'),
                                                ),
//
//
                                                new charts
                                                    .RangeAnnotationSegment(
                                                  24.0,
                                                  36.0,
                                                  charts.RangeAnnotationAxisType
                                                      .domain,
                                                  labelStyleSpec:
                                                      charts.TextStyleSpec(
                                                          color: charts.Color
                                                              .fromHex(
                                                                  code:
                                                                      '#ffa1a1a1'),
                                                          fontSize: 12*fontvar.round()),
                                                  color: charts.Color.fromHex(
                                                      code: '#BDCBCB'),
                                                ),
                                              ],
                                            )
                                          ],

                                          // Disable animations for image tests.
                                          animate: true,
                                              defaultRenderer:
                                              new charts.LineRendererConfig(
                                                  includeArea: false, stacked: false),

                                          primaryMeasureAxis:
                                              new charts.NumericAxisSpec(
                                            tickProviderSpec: new charts
                                                    .BasicNumericTickProviderSpec(
                                                desiredTickCount: 6),
                                          ),
                                          domainAxis: charts.NumericAxisSpec(
                                              showAxisLine: true,
                                              tickProviderSpec: charts
                                                  .BasicNumericTickProviderSpec(
                                                      desiredTickCount: 7)),
//      customSeriesRenderers: [
//        new charts.LineRendererConfig(
//          // ID used to link series to this renderer.
//            customRendererId: 'customPoint')
//      ],
                                        ))
                                      ]))
                                  : Container(
                                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                      height: 250*(screenSize.width)/375,
                                      decoration: BoxDecoration(color: Color(0xffE9E9E9), borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                        Text(
                                          "چاق",
                                          style: TextStyle(
                                              color: Color(0xff555555),
                                              fontSize: 13*fontvar,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                            child: new charts.LineChart(
                                          _PregnancyFat(),
                                          behaviors: [
                                            new charts.ChartTitle(
                                                'هفته بارداری',
                                                behaviorPosition: charts
                                                    .BehaviorPosition.bottom,
                                                titleStyleSpec:
                                                    charts.TextStyleSpec(
                                                        fontSize: 12*fontvar.round()),
                                                titleOutsideJustification:
                                                    charts.OutsideJustification
                                                        .middleDrawArea),
                                            new charts.ChartTitle('وزن',
                                                titleStyleSpec:
                                                    charts.TextStyleSpec(
                                                        fontSize: 12*fontvar.round()),
                                                behaviorPosition:
                                                    charts.BehaviorPosition.end,
                                                titleOutsideJustification:
                                                    charts.OutsideJustification
                                                        .middleDrawArea),
                                            new charts.RangeAnnotation(
                                              [
                                                new charts
                                                    .RangeAnnotationSegment(
                                                  0.0,
                                                  12.0,
                                                  charts.RangeAnnotationAxisType
                                                      .domain,
                                                  labelStyleSpec:
                                                      charts.TextStyleSpec(
                                                          color: charts.Color
                                                              .fromHex(
                                                                  code:
                                                                      '#ffffffff'),
                                                          fontSize: 12*fontvar.round()),
                                                  color: charts.Color.fromHex(
                                                      code: '#BDCBCB'),
                                                ),
                                                new charts
                                                    .RangeAnnotationSegment(
                                                  12.0,
                                                  24.0,
                                                  charts.RangeAnnotationAxisType
                                                      .domain,
                                                  labelStyleSpec:
                                                      charts.TextStyleSpec(
                                                          color: charts.Color
                                                              .fromHex(
                                                                  code:
                                                                      '#ffffffff'),
                                                          fontSize: 12*fontvar.round()),
                                                  color: charts.Color.fromHex(
                                                      code: '#A7BCBB'),
                                                ),
                                                new charts
                                                    .RangeAnnotationSegment(
                                                  24.0,
                                                  36.0,
                                                  charts.RangeAnnotationAxisType
                                                      .domain,
                                                  labelStyleSpec:
                                                      charts.TextStyleSpec(
                                                          color: charts.Color
                                                              .fromHex(
                                                                  code:
                                                                      '#ffa1a1a1'),
                                                          fontSize: 12*fontvar.round()),
                                                  color: charts.Color.fromHex(
                                                      code: '#BDCBCB'),
                                                ),
                                              ],
                                            )
                                          ],
                                          primaryMeasureAxis:
                                              new charts.NumericAxisSpec(
                                            tickProviderSpec: new charts
                                                    .BasicNumericTickProviderSpec(
                                                desiredTickCount: 6),
                                          ),
                                          domainAxis: charts.NumericAxisSpec(
                                            showAxisLine: true,
                                            tickProviderSpec: charts
                                                .BasicNumericTickProviderSpec(
                                                    desiredTickCount: 7),
                                          ),
                                          // Disable animations for image tests.
                                          animate: true,
                                              defaultRenderer:
                                              new charts.LineRendererConfig(
                                                  includeArea: false, stacked: false),
//      customSeriesRenderers: [
//        new charts.LineRendererConfig(
//          // ID used to link series to this renderer.
//            customRendererId: 'customPoint')
//      ],
                                        ))
                                      ])),

                          Container(
                            alignment: Alignment.center,
                            width: screenSize.width,
                            padding: EdgeInsets.only(right: 5),
                            margin: EdgeInsets.only(right: 12, left: 12, top: 15,bottom: 10),
                            child:
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 12, top: 12, bottom: 4,left: 12),
                              child: Text((int.parse(widget.ghol)>1)?setStatusWeight2():setStatusWeight(),textDirection: TextDirection.rtl, style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12*fontvar,
                              ),

    ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(width: 1, color: Colors.green)),
                          ),
                    ]))
                  ])));
  }

  /////بارداری چاق
  List<charts.Series<LinearSales, double>> _PregnancyFat() {
    List<double> IOM_abovelist = [
      0.15,
      0.31,
      0.46,
      0.62,
      0.77,
      0.92,
      1.08,
      1.23,
      1.38,
      1.54,
      1.69,
      1.85,
      2,
      2.26,
      2.52,
      2.78,
      3.04,
      3.3,
      3.56,
      3.81,
      4.07,
      4.33,
      4.59,
      4.85,
      5.11,
      5.37,
      5.63,
      5.89,
      6.15,
      6.41,
      6.67,
      6.93,
      7.19,
      7.44,
      7.7,
      7.96,
      8.22,
      8.48,
      8.74,
      9,
    ];
    List<double> IOM_belowlist = [
      0.02,
      0.04,
      0.05,
      0.07,
      0.09,
      0.11,
      0.12,
      0.14,
      0.16,
      0.18,
      0.19,
      0.21,
      0.23,
      0.41,
      0.58,
      0.76,
      0.94,
      1.11,
      1.29,
      1.47,
      1.64,
      1.82,
      2,
      2.17,
      2.35,
      2.53,
      2.7,
      2.88,
      3.06,
      3.23,
      3.41,
      3.59,
      3.76,
      3.94,
      4.12,
      4.29,
      4.47,
      4.65,
      4.82,
      5,
    ];

    List<double> month = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
    ];
    final List<LinearSales> IOM_above = [];
    for (int i = 0; i < IOM_abovelist.length; i++)
      IOM_above.add(
        new LinearSales(month[i], IOM_abovelist[i]),
      );

    final List<LinearSales> IOM_below = [];
    for (int i = 0; i < IOM_belowlist.length; i++)
      IOM_below.add(
        new LinearSales(month[i], IOM_belowlist[i]),
      );

    List<LinearSales> _userInfo = [];
    int week = ((DateTime.parse(regimDate)
        .difference(DateTime.parse(getDateToday()))
                      .inDays
                      .abs()) /
                  7)
              .round() +
          int.parse(_user.week);
      print("defrenceee$week");
      double weight =
          double.parse(_user.weight) - double.parse(_user.prev_weight);
      _userInfo.add(new LinearSales(week.toDouble(), weight));


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
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_above,
      ),

      new charts.Series<LinearSales, double>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_below,
      ),

      new charts.Series<LinearSales, double>(
          id: 'Mobile',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.
    ];
  }

  /////بارداری وزن نرمال
  List<charts.Series<LinearSales, double>> _PregnancyNormal() {
    List<double> IOM_abovelist = [
      0.23,
      0.46,
      0.69,
      0.92,
      1.15,
      1.38,
      1.62,
      1.85,
      2.08,
      2.31,
      2.54,
      2.77,
      3,
      3.48,
      3.96,
      4.44,
      4.93,
      5.41,
      5.89,
      6.37,
      6.85,
      7.33,
      7.81,
      8.3,
      8.78,
      9.26,
      9.74,
      10.22,
      10.7,
      11.19,
      11.67,
      12.15,
      12.63,
      13.11,
      13.59,
      14.07,
      14.56,
      15.04,
      15.52,
      16,
    ];
    List<double> IOM_belowlist = [
      0.08,
      0.15,
      0.23,
      0.31,
      0.38,
      0.46,
      0.54,
      0.62,
      0.69,
      0.77,
      0.85,
      0.92,
      1,
      1.39,
      1.78,
      2.17,
      2.56,
      2.94,
      3.33,
      3.72,
      4.11,
      4.5,
      4.89,
      5.28,
      5.67,
      6.06,
      6.44,
      6.83,
      7.22,
      7.61,
      8,
      8.39,
      8.78,
      9.17,
      9.56,
      9.94,
      10.33,
      10.72,
      11.11,
      11.5,
    ];

    List<double> month = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
    ];
    final List<LinearSales> IOM_above = [];
    for (int i = 0; i < IOM_abovelist.length; i++)
      IOM_above.add(
        new LinearSales(month[i], IOM_abovelist[i]),
      );

    final List<LinearSales> IOM_below = [];
    for (int i = 0; i < IOM_belowlist.length; i++)
      IOM_below.add(
        new LinearSales(month[i], IOM_belowlist[i]),
      );
    List<LinearSales> _userInfo = [];
    int week = ((DateTime.parse(regimDate)
        .difference(DateTime.parse(getDateToday()))
        .inDays
        .abs()) /
        7)
        .round() +
        int.parse(_user.week);
    print("defrenceee$week");
    double weight =
        double.parse(_user.weight) - double.parse(_user.prev_weight);
    _userInfo.add(new LinearSales(week.toDouble(), weight));

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
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_above,
      ),

      new charts.Series<LinearSales, double>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_below,
      ),

      new charts.Series<LinearSales, double>(
          id: 'Mobile',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.
    ];
  }

  /////بارداری وزن پایین
  List<charts.Series<LinearSales, double>> _PregnancyDown() {
    List<double> IOM_abovelist = [
      0.23,
      0.46,
      0.69,
      0.92,
      1.15,
      1.38,
      1.62,
      1.85,
      2.08,
      2.31,
      2.54,
      2.77,
      3,
      3.55,
      4.1,
      4.65,
      5.21,
      6.32,
      6.87,
      7.43,
      7.98,
      8.54,
      9.09,
      9.65,
      10.2,
      10.76,
      11.31,
      11.87,
      12.42,
      12.98,
      13.35,
      14.09,
      14.64,
      15.2,
      15.75,
      16.31,
      16.86,
      17.42,
      17.97,
      18,
    ];
    List<double> IOM_belowlist = [
      0.08,
      0.15,
      0.23,
      0.31,
      0.38,
      0.46,
      0.54,
      0.62,
      0.69,
      0.77,
      0.85,
      0.92,
      1,
      1.425,
      1.85,
      2.27,
      2.7,
      3.12,
      3.55,
      3.97,
      4.4,
      4.82,
      5.25,
      5.67,
      6.1,
      6.52,
      6.95,
      7.37,
      7.8,
      8.22,
      8.65,
      9.07,
      9.5,
      9.92,
      10.35,
      10.77,
      11.2,
      11.62,
      12.05,
      12.5,
    ];

    List<double> month = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
    ];
    final List<LinearSales> IOM_above = [];
    for (int i = 0; i < IOM_abovelist.length; i++)
      IOM_above.add(
        new LinearSales(month[i], IOM_abovelist[i]),
      );

    final List<LinearSales> IOM_below = [];
    for (int i = 0; i < IOM_belowlist.length; i++)
      IOM_below.add(
        new LinearSales(month[i], IOM_belowlist[i]),
      );
    List<LinearSales> _userInfo = [];
    int week = ((DateTime.parse(regimDate)
        .difference(DateTime.parse(getDateToday()))
        .inDays
        .abs()) /
        7)
        .round() +
        int.parse(_user.week);
    print("defrenceee$week");
    double weight =
        double.parse(_user.weight) - double.parse(_user.prev_weight);
    _userInfo.add(new LinearSales(week.toDouble(), weight));

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
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_above,
      ),

      new charts.Series<LinearSales, double>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_below,
      ),

      new charts.Series<LinearSales, double>(
          id: 'Mobile',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.
    ];
  }

  /////بارداری وزن بالا
  List<charts.Series<LinearSales, double>> _PregnancyUp() {
    List<double> IOM_abovelist = [
      0.23,
      0.46,
      0.69,
      0.92,
      1.15,
      1.38,
      1.62,
      1.85,
      2.08,
      2.31,
      2.54,
      2.77,
      3,
      3.31,
      3.63,
      3.94,
      4.26,
      4.57,
      4.89,
      5.2,
      5.52,
      5.83,
      6.15,
      6.46,
      6.78,
      7.09,
      7.41,
      7.72,
      8.04,
      8.35,
      8.67,
      8.98,
      9.3,
      9.61,
      9.93,
      10.24,
      10.56,
      10.87,
      11.19,
      11.5,
    ];
    List<double> IOM_belowlist = [
      0.08,
      0.15,
      0.23,
      0.31,
      0.38,
      0.46,
      0.54,
      0.62,
      0.69,
      0.77,
      0.85,
      0.92,
      1,
      1.22,
      1.44,
      1.67,
      1.89,
      2.11,
      2.33,
      2.56,
      2.78,
      3,
      3.22,
      3.44,
      3.67,
      3.89,
      4.11,
      4.33,
      4.56,
      4.78,
      5,
      5.22,
      5.44,
      5.67,
      5.89,
      6.11,
      6.33,
      6.56,
      6.78,
      7,
    ];

    List<double> month = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
    ];
    final List<LinearSales> IOM_above = [];
    for (int i = 0; i < IOM_abovelist.length; i++)
      IOM_above.add(
        new LinearSales(month[i], IOM_abovelist[i]),
      );

    final List<LinearSales> IOM_below = [];
    for (int i = 0; i < IOM_belowlist.length; i++)
      IOM_below.add(
        new LinearSales(month[i], IOM_belowlist[i]),
      );
    List<LinearSales> _userInfo = [];
    int week = ((DateTime.parse(regimDate)
        .difference(DateTime.parse(getDateToday()))
        .inDays
        .abs()) /
        7)
        .round() +
        int.parse(_user.week);
    print("defrenceee$week");
    double weight =
        double.parse(_user.weight) - double.parse(_user.prev_weight);
    _userInfo.add(new LinearSales(week.toDouble(), weight));

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
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_above,
      ),

      new charts.Series<LinearSales, double>(
        id: 'Tablet',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: IOM_below,
      ),

      new charts.Series<LinearSales, double>(
          id: 'Mobile',
          colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: _userInfo)
      // Configure our custom point renderer for this series.
    ];
  }

  CalculateBmi() {
    double bmi = double.parse(_user.weight) /
        (double.parse(_user.height) * double.parse(_user.height) * 0.0001);
    print("it is bmi$bmi");
    int chart = 0;
    //////کم وزن
    if (bmi < 18.5)
      chart = 1;
    /////نرمال
    else if (bmi >= 18.5 && bmi <= 25)
      chart = 2;
    //اضافه ئزن
    else if (bmi > 25 && bmi <= 30)
      chart = 3;
    //چاق
    else if (bmi > 30) chart = 4;

    print("it is chart$chart");
    setState(() {
      _chart = chart;
      _isLoading = false;
    });
  }




  String setStatusWeight() {
    if(_user!=null){
      int type= calculateWeight();
      switch (type){
        case 1:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 11 الی 16 کیلوگرم در طی بارداری هستید.";
          break;
        case 2:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 9 الی 13 کیلوگرم در طی بارداری هستید.";
          break;
        case 3:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 7 الی 10 کیلوگرم در طی بارداری هستید.";
          break;
        case 4:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن کمتر از 7 کیلوگرم در طی بارداری هستید.";
          break;

      }

    }
    else return"";
  }

  String setStatusWeight2() {
    if(_user!=null){
      int type= calculateWeight();
      switch (type){
        case 1:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 13 الی 18 کیلوگرم در طی بارداری هستید.";
          break;
        case 2:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 11 الی 15 کیلوگرم در طی بارداری هستید.";
          break;
        case 3:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن 9 الی 12 کیلوگرم در طی بارداری هستید.";
          break;
        case 4:
          return "با توجه به وزن قبل از بارداری تان، طبق توصیه های سازمان جهانی بهداشت شما مجاز به اضافه کردن کمتر از 9 کیلوگرم در طی بارداری هستید.";
          break;

      }

    }
    else return"";
  }

  int calculateWeight(){
    double bmi = double.parse(_user.prev_weight)/(double.parse(_user.height)*double.parse(_user.height)*0.0001);
    print(bmi.toString()+"it is bmi");

    if(bmi<=18.5)
      return 1;
    else if(bmi>18.5 && bmi<=25)
      return 2;
    else if(bmi>25 && bmi <=30)
      return 3;
    else if(bmi>=30)
      return 4;


  }
}

class LinearSales {
  final double year;
  final double sales;

  LinearSales(this.year, this.sales);
}
