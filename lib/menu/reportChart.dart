// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// // ignore: must_be_immutable
// class LineChartSample6 extends StatelessWidget {
//   final spots = [
//     FlSpot(0, 1),
//     FlSpot(2, 5),
//     FlSpot(4, 3),
//     // FlSpot(6, 5),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black,
//               blurRadius: 10,
//               spreadRadius: 0,
//             )
//           ]),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: LinearGradient(colors: [
//             Colors.yellowAccent,
//             Colors.yellowAccent.withOpacity(0.1),
//           ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(right: 22.0, bottom: 20),
//           child: SizedBox(
//             width: 300,
//             height: 200,
//             child: LineChart(
//                               LineChartData(
//
//                                 lineTouchData: LineTouchData(
//                                   enabled: false,
//                                   getTouchedSpotIndicator:
//                                       (LineChartBarData barData, List<int> spotIndexes) {
//                                     return spotIndexes.map((index) {
//                                       return TouchedSpotIndicatorData(
//                                         FlLine(
//                                           strokeWidth: 1,
//                                           color: Colors.black26,
//                                         ),
//                                         FlDotData(
//                                           show: true,
//                                           getDotPainter:
//                                               (spot, percent, barData, index) =>
//                                               FlDotCirclePainter(
//                                                 radius: 4,
//                                                 color: Color(0xffF15A23),
//                                                 strokeColor: Color(0xffF15A23),
//                                               ),
//                                         ),
//                                       );
//                                     }).toList();
//                                   },
//                                   touchTooltipData: LineTouchTooltipData(
//                                     tooltipBgColor: Colors.transparent,
//
//                                     fitInsideVertically: true,
//                                     tooltipPadding: EdgeInsets.symmetric(horizontal: 2),
//                                     fitInsideHorizontally: true,
//                                     tooltipRoundedRadius: 4,
//                                     getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                                       return lineBarsSpot.map((lineBarSpot) {
//                                         return LineTooltipItem(
//                                           lineBarSpot.y.toString() == "0.0"
//                                               ? ""
//                                               : lineBarSpot.y.toString(),
//                                           TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w400,
//                                               fontFamily: "iransansfanum",
//                                               fontSize: 12 ),
//                                         );
//                                       }).toList();
//                                     },
//                                   ),
//                                 ),
//                                   lineBarsData: [
//                                   LineChartBarData(
//                                   colors: [
//                                   Colors.deepOrangeAccent,
//                                   Colors.orangeAccent,
//                                   ],
//                               spots: spots,
//               isCurved: true,
//               isStrokeCapRound: true,
//               barWidth: 10,
//               belowBarData: BarAreaData(
//                 show: false,
//               ),
//               dotData: FlDotData(
//                 show: true,
//                 getDotPainter: (spot, percent, barData, index) =>
//                     FlDotCirclePainter(radius: 12, color: Colors.deepOrange.withOpacity(0.5)),
//               ),
//             ),
//
//               ],
//
//
//                                 titlesData: FlTitlesData(
//                                   leftTitles: SideTitles(
//                                     showTitles: false,
//                                   ),
//                                   bottomTitles: SideTitles(
//                                       showTitles: true,
//                                       margin: 10,
//                                       getTitles: (val) {
//                                         print(val.toString());
//                                         print("val.toString()");
//
//                                           return "";
//                                       },
//                                       textStyle: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.black,
//                                         fontFamily: 'iransansfanum',
//                                         fontSize: 16 ,
//                                       )),
//                                 ),
//                                 gridData: FlGridData(show: false),
//                                 borderData: FlBorderData(
//                                   show: false,
//                                 ),
//                               ),
//                             ),
//                           ),
// //
//           ),
//         ),
//
//     );
//   }
//
//
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'package:flutter/rendering.dart';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'dart:ui' as ui;
// import 'package:barika/utils/MyDadaPicker.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:barika/helper.dart';
// import 'package:barika/models/DbDailyInfo.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:barika/models/user.dart';
// import 'package:barika/sqliteProvider/dailyInfoProvider.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:persian_datepicker/persian_datepicker.dart';
// import 'package:persian_datepicker/persian_datetime.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:barika/utils/custom_expansion_tile3.dart' as custom;
// import 'package:esys_flutter_share/esys_flutter_share.dart';
// class reportCahrt extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => reportCahrtState();
// }
//
// class reportCahrtState extends State<reportCahrt> {
//   static String pointerValue;
//   GlobalKey _globalKey = new GlobalKey();
//   int _selectedPage = 0;
//   String _selecteddate = "1398/10/20";
//   String fromDate = "--/--/----";
//   String untilDAte = "--/--/----";
//   bool avctiveDate = false;
//   PersianDatePickerWidget persianDatePicker1;
//   PersianDatePickerWidget persianDatePicker2;
//   final TextEditingController textEditingController = TextEditingController();
//   final TextEditingController textEditingController2 = TextEditingController();
//   final GlobalKey<custom.ExpansionTileState3> expansionTileKeyCar = new GlobalKey();// NE
//   PersianDateTime persianDate1;
//   PersianDateTime persianDate2;
//   String gregorianDate1 = "";
//   String gregorianDate2 = "";
//   DateTime dateTime1;
//   DateTime dateTime2;
//   List<DbDailyInfo> _DbDailyInfoList = [];
//   List<DbDailyInfo> _DbDailyInfoList2 = [];
//   List<double> _actCalory = [];
//   List<String> _MyExpandedList = [];
//
//   String _typeChoose = 'کالری مصرف شده';
//   int _index = 12;
//   static List<DbDailyInfo> _userWeight32 = [];
//   static List<DbDailyInfo> _userWeight322 = [];
//   static List<double> _avrege = [];
//   bool _isLoading = true;
//   List<double> items = new List();
//
//   Widget loadingView() {
//     return Center(
//         child: SpinKitCircle(
//           color: MyColors.vazn,
//         ));
//   }
//
//   User _user;
//
//
//   bool inside = false;
//   Uint8List imageInMemory;
//
// //   Future<Uint8List> _capturePng() async {
// //     try {
// //       print('inside');
// //       inside = true;
// //       RenderRepaintBoundary boundary =
// //       _globalKey.currentContext.findRenderObject();
// //       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
// //       ByteData byteData =
// //       await image.toByteData(format: ui.ImageByteFormat.png);
// //       Uint8List pngBytes = byteData.buffer.asUint8List();
// // //      String bs64 = base64Encode(pngBytes);
// // //      print(pngBytes);
// // //      print(bs64);
// //       print('png done');
// //       setState(() {
// //         imageInMemory = pngBytes;
// //         inside = false;
// //       });
// //       // await Share.file('esys image', 'esys.png', imageInMemory, 'image/png', text: 'My optional text.');
// //       return pngBytes;
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
//
//   // Future<void> _capturePng() async {
//   //   RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
//   //   ui.Image image = await boundary.toImage();
//   //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   //   Uint8List pngBytes = byteData.buffer.asUint8List();
//   //   print(pngBytes);
//   //   await Share.file('esys image', 'esys.png', pngBytes, 'image/png', text: 'My optional text.');
//   // }
//   // Future<Uint8List> _capturePng() async {
//   //   RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
//   //
//   //   if (boundary.debugNeedsPaint) {
//   //     print("Waiting for boundary to be painted.");
//   //     await Future.delayed(const Duration(milliseconds: 20));
//   //     return _capturePng();
//   //   }
//   //
//   //   var image = await boundary.toImage();
//   //   var byteData = await image.toByteData(format: ImageByteFormat.png);
//   //   await Share.file('esys image', 'esys.png', byteData.buffer.asUint8List(), 'image/png', text: 'My optional text.');
//   //   return byteData.buffer.asUint8List();
//   // }
//   Future<Uint8List> _capturePng() async {
//     RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
//     var image = await boundary.toImage();
//     var byteData = await image.toByteData(format: ImageByteFormat.png);
//     // var pngBytes = byteData.buffer.asUint8List();
//     await Share.file('esys image', 'esys.png', byteData.buffer.asUint8List(), 'image/png', text: 'My optional text.');
//     return byteData.buffer.asUint8List();
//
//   }
//   @override
//   void initState() {
//     _getUser();
//
//     setDatePicker1();
//     setDatePicker2();
//
//     persianDate2 = PersianDateTime.fromGregorian();
//     persianDate1 = persianDate2.add(Duration(days: -6));
//     untilDAte = persianDate2.toJalaali(format: 'YYYY/MM/DD');
//     fromDate = persianDate1.toJalaali(format: 'YYYY/MM/DD');
//     dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//         .format((DateTime.parse(getCustomDate(-6)))));
//     dateTime2 = DateTime.parse(
//         intl.DateFormat('yyyy-MM-dd').format((DateTime.parse(getDateToday()))));
//     prepareData();
//     _getDailyInfo2();
//
//
//     super.initState();
//   }
//
//   var fontvar = 1.0;
//
//   List<int> showIndexes = [];
//   List<FlSpot> allSpots = [FlSpot(0.0, 0.0)];
//   List<FlSpot> allSpots2 = [FlSpot(0.0, 0.0)];
//   // List<FlSpot> allSpots2 = [FlSpot(0.0, 0.0)];
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh = SizeConfig.safeBlockHorizontal;
//     var bv = SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if (fontvar > 2) fontvar = 1.7;
//
//     Size screenSize = MediaQuery.of(context).size;
//     if (screenSize.width > 600) screenSize = Size(600, screenSize.height);
//
//     if (gregorianDate2 != "") {
//       setState(() {});
//     }
//     final lineBarsData = [
//       LineChartBarData(
//           showingIndicators: showIndexes,
//           spots: allSpots,
//           isCurved: false,
//           barWidth: 3,
//
//           dotData: FlDotData(show: true),
//           colors: [
//
//             Color(0xFFF9C981),
//             // const Color(0xffc471ed),
//             // const Color(0xfff64f59),
//           ],
//           colorStops: [
//             0.1,
//             0.4,
//             0.9
//           ]),
//     ];
//     final lineBarsData2 = [
//       LineChartBarData(
//
//           spots: allSpots2,
//           isCurved: false,
//           barWidth: 3,
//
//           dotData: FlDotData(show: true),
//           colors: [
//
//             Color(0xFFF9C981),
//             // const Color(0xffc471ed),
//             // const Color(0xfff64f59),
//           ],
//           colorStops: [
//             0.1,
//             0.4,
//             0.9
//           ]),
//     ];
//     final LineChartBarData tooltipsOnBar = lineBarsData[0];
//     final LineChartBarData tooltipsOnBar2 = lineBarsData2[0];
//
//     return  RepaintBoundary(
//         key: _globalKey,
//         child:Scaffold(
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(100 * (screenSize.width) / 375),
//               child: Container(
//                 padding: EdgeInsets.only(top: 10 * (screenSize.width) / 375),
//                 decoration: BoxDecoration(color: MyColors.green),
//                 child: SafeArea(
//                   child: Column(
//                     children: <Widget>[
//                       Expanded(
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top: 12, bottom: 8),
//                               child: Text(
//                                 'نمودار',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 16 * fontvar,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.chevron_right,
//                                 size: 32 * (screenSize.width) / 375,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context, 'yes');
//                               },
//                               alignment: Alignment.topLeft,
//                               color: Colors.white,
//                               splashColor: Colors.amber,
//                               padding: EdgeInsets.all(7),
//                             ),
//
// //                        IconButton(
// //                          icon: Icon(
// //                            Icons.search,
// //                            size: 28,
// //                          ),
// //                          onPressed: () {},
// //                          alignment: Alignment.topRight,
// //                          color: Colors.white,
// //                          splashColor: Colors.amber,
// //                          padding: EdgeInsets.all(10),
// //                        ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 5),
//                                     child: Text("از تاریخ",
//                                         style: TextStyle(
//                                             fontSize: 12 * fontvar,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w500)),
//                                   ),
//                                   RaisedButton(
//                                       shape: new RoundedRectangleBorder(
//                                         borderRadius: new BorderRadius.circular(8.0),
//                                       ),
//                                       padding: EdgeInsets.symmetric(horizontal: 2),
//                                       onPressed: () {
//                                         MyDatePicker.showDatePicker(
//                                           context,
//                                           onConfirm: (int year, int month, int day) {
//                                             print(year);
//                                             print(month);
//                                             print(day);
//                                             String datenew = year.toString() +
//                                                 "/" +
//                                                 month.toString() +
//                                                 "/" +
//                                                 day.toString();
//                                             var datenew2 = PersianDateTime(
//                                                 jalaaliDateTime: datenew);
//                                             PersianDateTime datenow = PersianDateTime();
//                                             print(datenew2);
//                                             print(persianDate2);
//                                             print(persianDate1);
//                                             if (((datenew2.isBefore(datenow)) ||
//                                                 (datenew2
//                                                     .difference(datenow)
//                                                     .inDays ==
//                                                     0)) &&
//                                                 ((datenew2.isBefore(persianDate2)) ||
//                                                     (datenew2
//                                                         .difference(persianDate2)
//                                                         .inDays ==
//                                                         0))) {
//                                               setState(() {
// //                                        untilDAte = newText;
// //                                        persianDate2 = PersianDateTime(jalaaliDateTime: untilDAte);
// //                                        gregorianDate2 = persianDate2.toGregorian(format: 'YYYY-MM-DD');
// //                                        dateTime2 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
// //                                            .format((DateTime.parse(gregorianDate2))));
// //
// //                                        _getDailyInfo2();
//
//                                                 fromDate = datenew;
//                                                 persianDate1 = PersianDateTime(
//                                                     jalaaliDateTime: fromDate);
//                                                 gregorianDate1 = persianDate1
//                                                     .toGregorian(format: 'YYYY-MM-DD');
//                                                 dateTime1 = DateTime.parse(
//                                                     intl.DateFormat('yyyy-MM-dd')
//                                                         .format((DateTime.parse(
//                                                         gregorianDate1))));
//
//                                                 _getDailyInfo2();
//                                               });
//                                             } else {
//                                               Fluttertoast.showToast(
//                                                 msg:
//                                                 "امکان انتخاب این تاریخ وجود ندارد.",
//                                                 toastLength: Toast.LENGTH_SHORT,
//                                                 gravity: ToastGravity.CENTER,
//                                                 timeInSecForIosWeb: 1,
//                                                 backgroundColor: Colors.red,
//                                                 textColor: Colors.white,
//                                                 fontSize: 16.0 * fontvar,
//                                               );
//                                             }
//                                           },
//                                           minYear: 1300,
//                                           maxYear: 1450,
//                                           confirm: Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 8, vertical: 2),
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(6)),
//                                                 color: Colors.green),
//                                             child: Text(
//                                               'تایید',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18 * fontvar,
//                                                   fontFamily: "iransansDN",
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                           ),
//                                           cancel: Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 8, vertical: 2),
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.all(
//                                                       Radius.circular(6)),
//                                                   color: Colors.red),
//                                               child: Text(
//                                                 ' لغو ',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18 * fontvar,
//                                                     fontFamily: "iransansDN",
//                                                     fontWeight: FontWeight.w400),
//                                               )),
//                                         );
//                                       },
//                                       color: Colors.white,
//                                       textColor: Colors.white,
//                                       child: Row(
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 5, right: 2, bottom: 5),
//                                             child: SvgPicture.asset(
//                                               'assets/icons/calendar.svg',
//                                               width: 16 * (screenSize.width) / 375,
//                                               height: 16 * (screenSize.width) / 375,
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                           Text(fromDate,
//                                               style: TextStyle(
//                                                   fontSize: 12 * fontvar,
//                                                   color: Color(0xff555555),
//                                                   fontWeight: FontWeight.w500)),
//                                         ],
//                                       )),
//                                 ],
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 5),
//                                     child: Text("تا تاریخ",
//                                         style: TextStyle(
//                                             fontSize: 12 * fontvar,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w500)),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 5),
//                                     child: RaisedButton(
//                                         disabledColor: Colors.white,
//                                         padding: EdgeInsets.symmetric(horizontal: 2),
//                                         shape: new RoundedRectangleBorder(
//                                           borderRadius: new BorderRadius.circular(8.0),
//                                         ),
//                                         onPressed: () {
//                                           MyDatePicker.showDatePicker(
//                                             context,
//                                             onConfirm: (int year, int month, int day) {
//                                               print(year);
//                                               print(month);
//                                               print(day);
//                                               String datenew = year.toString() +
//                                                   "/" +
//                                                   month.toString() +
//                                                   "/" +
//                                                   day.toString();
//                                               var datenew2 = PersianDateTime(
//                                                   jalaaliDateTime: datenew);
//                                               PersianDateTime datenow =
//                                               PersianDateTime();
//                                               print("uuuuuuuuuuu");
//                                               print(((datenew2.isBefore(datenow)) ||
//                                                   (datenew2
//                                                       .difference(datenow)
//                                                       .inDays ==
//                                                       0)));
//                                               if (((datenew2.isBefore(datenow)) ||
//                                                   (datenew2
//                                                       .difference(datenow)
//                                                       .inDays ==
//                                                       0)) &&
//                                                   ((datenew2.isAfter(persianDate1)) ||
//                                                       (datenew2
//                                                           .difference(persianDate1)
//                                                           .inDays ==
//                                                           0))) {
//                                                 setState(() {
//                                                   print("uuuuuuuuuuu");
//                                                   print(untilDAte);
//
//                                                   untilDAte = datenew;
//                                                   print("uuuuuuuuuuu");
//                                                   print(untilDAte);
//                                                   persianDate2 = PersianDateTime(
//                                                       jalaaliDateTime: untilDAte);
//                                                   gregorianDate2 =
//                                                       persianDate2.toGregorian(
//                                                           format: 'YYYY-MM-DD');
//                                                   dateTime2 = DateTime.parse(
//                                                       intl.DateFormat('yyyy-MM-dd')
//                                                           .format((DateTime.parse(
//                                                           gregorianDate2))));
//
//                                                   _getDailyInfo2();
//                                                 });
// //                                          fromDate = datenow.toString();
// //                                          persianDate1 = PersianDateTime(jalaaliDateTime: fromDate);
// //                                          gregorianDate1 = persianDate1.toGregorian(format: 'YYYY-MM-DD');
// //                                          dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
// //                                              .format((DateTime.parse(gregorianDate1))));
// //
// //                                          _getDailyInfo2();
// //
//
//                                               } else {
//                                                 Fluttertoast.showToast(
//                                                   msg:
//                                                   "امکان انتخاب این تاریخ وجود ندارد.",
//                                                   toastLength: Toast.LENGTH_SHORT,
//                                                   gravity: ToastGravity.CENTER,
//                                                   timeInSecForIosWeb: 1,
//                                                   backgroundColor: Colors.red,
//                                                   textColor: Colors.white,
//                                                   fontSize: 16.0 * fontvar,
//                                                 );
//                                               }
//                                             },
//                                             minYear: 1300,
//                                             maxYear: 1450,
//                                             confirm: Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 8, vertical: 2),
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.all(
//                                                       Radius.circular(6)),
//                                                   color: Colors.green),
//                                               child: Text(
//                                                 'تایید',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18 * fontvar,
//                                                     fontFamily: "iransansDN",
//                                                     fontWeight: FontWeight.w400),
//                                               ),
//                                             ),
//                                             cancel: Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 8, vertical: 2),
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.all(
//                                                         Radius.circular(6)),
//                                                     color: Colors.red),
//                                                 child: Text(
//                                                   ' لغو ',
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 18 * fontvar,
//                                                       fontFamily: "iransansDN",
//                                                       fontWeight: FontWeight.w400),
//                                                 )),
//                                           );
//                                         },
//                                         color: Colors.white,
//                                         textColor: Colors.white,
//                                         child: Row(
//                                           children: <Widget>[
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: 5, right: 2, bottom: 5),
//                                               child: SvgPicture.asset(
//                                                 'assets/icons/calendar.svg',
//                                                 width: 16 * (screenSize.width) / 375,
//                                                 height: 16 * (screenSize.width) / 375,
//                                                 color: Colors.green,
//                                               ),
//                                             ),
//                                             Text(untilDAte,
//                                                 style: TextStyle(
//                                                     fontSize: 12 * fontvar,
//                                                     color: Color(0xff555555),
//                                                     fontWeight: FontWeight.w500)),
//                                           ],
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   flex: 7,
//                   child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
//                       // height: 300 * (screenSize.width) / 375,
//                       decoration: BoxDecoration(
//                           color: Color(0xffE9E9E9),
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child:
//                       Stack(
//                           alignment: Alignment.topCenter,
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: <
//                               Widget>[
//
//                             _isLoading
//                                 ?loadingView()
//                                 :
//                             Container(
//                                 margin: EdgeInsets.only(top: 90*screenSize.width/375),
//                                 alignment: Alignment.center,
//                                 width: screenSize.width,
//                                 height: 250,
//                                 child: Stack(
//                                     children: [
//                                       LineChart(
//                                         LineChartData(
//                                           showingTooltipIndicators: showIndexes.map((index) {
//                                             return ShowingTooltipIndicators(index, [
//                                               LineBarSpot(
//                                                   tooltipsOnBar2,
//                                                   lineBarsData2.indexOf(tooltipsOnBar2),
//                                                   tooltipsOnBar2.spots[index]),
//                                             ]);
//                                           }).toList(),
//                                           lineTouchData: LineTouchData(
//                                             enabled: false,
//                                             getTouchedSpotIndicator:
//                                                 (LineChartBarData barData, List<int> spotIndexes) {
//                                               return spotIndexes.map((index) {
//                                                 return TouchedSpotIndicatorData(
//                                                   FlLine(
//                                                     strokeWidth: 1,
//                                                     color: Colors.black26,
//                                                   ),
//                                                   FlDotData(
//                                                     show: true,
//                                                     getDotPainter:
//                                                         (spot, percent, barData, index) =>
//                                                         FlDotCirclePainter(
//                                                           radius: 4,
//                                                           color: Color(0xffF15A23),
//                                                           strokeColor: Color(0xffF15A23),
//                                                         ),
//                                                   ),
//                                                 );
//                                               }).toList();
//                                             },
//                                             touchTooltipData: LineTouchTooltipData(
//                                               tooltipBgColor: Colors.transparent,
//                                               maxContentWidth: 40 * (screenSize.width) / 375,
//                                               fitInsideVertically: true,
//                                               tooltipPadding: EdgeInsets.symmetric(horizontal: 2),
//                                               fitInsideHorizontally: true,
//                                               tooltipRoundedRadius: 4,
//                                               getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                                                 return lineBarsSpot.map((lineBarSpot) {
//                                                   return LineTooltipItem(
//                                                     lineBarSpot.y.toString() == "0.0"
//                                                         ? ""
//                                                         : lineBarSpot.y.toString(),
//                                                     TextStyle(
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.w400,
//                                                         fontFamily: "iransansfanum",
//                                                         fontSize: 12 * fontvar),
//                                                   );
//                                                 }).toList();
//                                               },
//                                             ),
//                                           ),
//                                           lineBarsData: lineBarsData2,
//                                           minY: 0,
//
//
//                                           backgroundColor: Colors.white.withOpacity(0.2),
//                                           titlesData: FlTitlesData(
//                                             leftTitles: SideTitles(
//                                               showTitles: false,
//                                             ),
//                                             bottomTitles: SideTitles(
//                                                 showTitles: true,
//                                                 margin: 10,
//                                                 getTitles: (val) {
//                                                   print(val.toString());
//                                                   print("val.toString()");
//                                                   if (val.toInt() < _userWeight322.length) {
//                                                     var persianDateee =
//                                                     PersianDateTime.fromGregorian(
//                                                         gregorianDateTime:
//                                                         _userWeight322[val.toInt()].date);
//                                                     return int.parse(persianDateee
//                                                         .toJalaali(format: 'YYYY-MM-DD')
//                                                         .split("-")[2])
//                                                         .toString();
//                                                   } else
//                                                     return "";
//                                                 },
//                                                 textStyle: TextStyle(
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black,
//                                                   fontFamily: 'iransansfanum',
//                                                   fontSize: 16 * fontvar,
//                                                 )),
//                                           ),
//                                           gridData: FlGridData(show: false),
//                                           borderData: FlBorderData(
//                                             show: false,
//                                           ),
//                                         ),
//                                       ),
//                                       LineChart(
//                                         LineChartData(
//                                           showingTooltipIndicators: showIndexes.map((index) {
//                                             return ShowingTooltipIndicators(index, [
//                                               LineBarSpot(
//                                                   tooltipsOnBar,
//                                                   lineBarsData.indexOf(tooltipsOnBar),
//                                                   tooltipsOnBar.spots[index]),
//                                             ]);
//                                           }).toList(),
//                                           lineTouchData: LineTouchData(
//                                             enabled: false,
//                                             getTouchedSpotIndicator:
//                                                 (LineChartBarData barData, List<int> spotIndexes) {
//                                               return spotIndexes.map((index) {
//                                                 return TouchedSpotIndicatorData(
//                                                   FlLine(
//                                                     strokeWidth: 1,
//                                                     color: Colors.black26,
//                                                   ),
//                                                   FlDotData(
//                                                     show: true,
//                                                     getDotPainter:
//                                                         (spot, percent, barData, index) =>
//                                                         FlDotCirclePainter(
//                                                           radius: 4,
//                                                           color: Color(0xffF15A23),
//                                                           strokeColor: Color(0xffF15A23),
//                                                         ),
//                                                   ),
//                                                 );
//                                               }).toList();
//                                             },
//                                             touchTooltipData: LineTouchTooltipData(
//                                               tooltipBgColor: Colors.transparent,
//                                               maxContentWidth: 40 * (screenSize.width) / 375,
//                                               fitInsideVertically: true,
//                                               tooltipPadding: EdgeInsets.symmetric(horizontal: 2),
//                                               fitInsideHorizontally: true,
//                                               tooltipRoundedRadius: 4,
//                                               getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                                                 return lineBarsSpot.map((lineBarSpot) {
//                                                   return LineTooltipItem(
//                                                     lineBarSpot.y.toString() == "0.0"
//                                                         ? ""
//                                                         : lineBarSpot.y.toString(),
//                                                     TextStyle(
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.w400,
//                                                         fontFamily: "iransansfanum",
//                                                         fontSize: 12 * fontvar),
//                                                   );
//                                                 }).toList();
//                                               },
//                                             ),
//                                           ),
//                                           lineBarsData: lineBarsData,
//                                           minY: 0,
//
//
//                                           backgroundColor: Colors.white.withOpacity(0.2),
//                                           titlesData: FlTitlesData(
//                                             leftTitles: SideTitles(
//                                               showTitles: false,
//                                             ),
//                                             bottomTitles: SideTitles(
//                                                 showTitles: true,
//                                                 margin: 10,
//                                                 getTitles: (val) {
//                                                   print(val.toString());
//                                                   print("val.toString()");
//                                                   if (val.toInt() < _userWeight32.length) {
//                                                     var persianDateee =
//                                                     PersianDateTime.fromGregorian(
//                                                         gregorianDateTime:
//                                                         _userWeight32[val.toInt()].date);
//                                                     return int.parse(persianDateee
//                                                         .toJalaali(format: 'YYYY-MM-DD')
//                                                         .split("-")[2])
//                                                         .toString();
//                                                   } else
//                                                     return "";
//                                                 },
//                                                 textStyle: TextStyle(
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black,
//                                                   fontFamily: 'iransansfanum',
//                                                   fontSize: 16 * fontvar,
//                                                 )),
//                                           ),
//                                           gridData: FlGridData(show: false),
//                                           borderData: FlBorderData(
//                                             show: false,
//                                           ),
//                                         ),
//                                       ),
//                                     ])
//                             ),
//
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   flex: 4,
//                                   child:     Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         child: Text(
//                                           "نمودار " ,
//                                           style: TextStyle(
//                                               color: Color(0xff555555),
//                                               fontSize: 13* fontvar,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                         padding: EdgeInsets.only(top: 10),
//                                       ),
//                                       Expanded(
//                                         child:      custom.ExpansionTile3(
//                                           key: expansionTileKeyCar,
//                                           onExpansionChanged: (bool expanded) {
//                                             print(expanded);
//                                           },
//
//                                           iconColor: Colors.white,
//                                           headerBackgroundColor: Color(0xff6DC07B),
//                                           backgroundColor: Color(0xffF5FAF2),
//                                           title: Text(
//                                             _typeChoose,
//                                             style:  TextStyle(
//                                               fontSize: 12.0 * fontvar,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                           children: <Widget>[
//                                             Column(
//                                               children: _buildExpandableContent(),
//                                             )
//                                           ],
//                                         ),
//                                       )
//
//                                     ],
//                                   ),
//                                 ),
//                                 Flexible(
//                                     flex: 1,
//
//                                     child:    IconButton(
//                                       alignment: Alignment.center,
//                                       onPressed: () async {await _capturePng();},
//                                       icon: Icon(
//                                         Icons.share,
//                                       ),
//                                       padding: EdgeInsets.only(right: 7 ,left: 7,bottom: 7),
//                                       color: Colors.black,
//                                     ))
//                               ],
//                             ),
//
//                           ])),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     margin:EdgeInsets.only(bottom: 5,left: 4,right: 4),
//                     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
//                     // height: 300 * (screenSize.width) / 375,
//                     decoration: BoxDecoration(
//                         color: Color(0xffE9E9E9),
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     child:
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           child: Text(
//                             "میانگین "+ _typeChoose ,
//                             style: TextStyle(
//                                 color: Color(0xff555555),
//                                 fontSize: 14 * fontvar,
//                                 fontWeight: FontWeight.w600),
//                             textDirection: TextDirection.rtl,
//                           ),
//                           padding: EdgeInsets.only(top: 10),
//                         ),
//                         Padding(
//                           child: Text(
//                             _avrege.isEmpty
//                                 ?""
//                                 : "${double.parse((_avrege.reduce((a, b) => a + b) / _avrege.length).toStringAsFixed(1)).toString()} ",
//                             style: TextStyle(
//                                 color: Color(0xff555555),
//                                 fontSize: 13 * fontvar,
//                                 fontWeight: FontWeight.w500),
//                             textDirection: TextDirection.rtl,
//                           ),
//                           padding: EdgeInsets.only(top: 10),
//                         ),
//
//
//                       ],
//                     ),
//
//                   ),
//                 )
//               ],
//             )
//
//         ));
//   }
//
//   setDatePicker1() {
//     persianDatePicker1 = PersianDatePicker(
//       controller: textEditingController,
//       farsiDigits: false,
//       onChange: (String oldText, String newText) {
//         setState(() {
//           fromDate = newText;
//
//           persianDate1 = PersianDateTime(jalaaliDateTime: fromDate);
//           gregorianDate1 = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//           dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//               .format((DateTime.parse(gregorianDate1))));
//
//           persianDatePicker2.update(
//             minDatetime: persianDate1.toString(),
//             maxDatetime: PersianDateTime().toString(),
//           );
//
//           _getDailyInfo2();
//         });
//
//         Navigator.pop(context);
//       },
//
//       maxDatetime: PersianDateTime().toString(),
// //      datetime:
//       gregorianDatetime: getDateToday(),
//
//       // datetime: '1397/06/09',
// //       finishDatetime: _selecteddate,
//     ).init();
//   }
//
//   setDatePicker2() {
//     persianDatePicker2 = PersianDatePicker(
//       controller: textEditingController2,
//       farsiDigits: false,
//       onChange: (String oldText, String newText) {
//         setState(() {
//           untilDAte = newText;
//           persianDate2 = PersianDateTime(jalaaliDateTime: untilDAte);
//           gregorianDate2 = persianDate2.toGregorian(format: 'YYYY-MM-DD');
//           dateTime2 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//               .format((DateTime.parse(gregorianDate2))));
//
//           _getDailyInfo2();
//         });
//
//         Navigator.pop(context);
//       },
//
//       maxDatetime: PersianDateTime().toString(),
//
//     ).init();
//   }
//
//
//
//
//   List<FlSpot> _weightc(bool empty) {
//
//     final List<FlSpot> data = [];
//     final List<FlSpot> data2 = [];
//     final List<int> dataY = [];
//     _DbDailyInfoList.forEach((item) {
//       if (data.length < 50) {
//         if(empty){
//           dataY.add(data.length);
//           data.add(
//             new FlSpot(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//                 data.length.toDouble(),
//                 double.parse(
//                     double.parse(getChoseType(item)).toStringAsFixed(1))),);
//         }
//         else{
//           if(getChoseType(item)!="0"&&getChoseType(item)!="0.0") {
//             dataY.add(data.length);
//             data.add(
//               FlSpot(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//                   data.length.toDouble(),
//                   double.parse(
//                       double.parse(getChoseType(item)).toStringAsFixed(1))),
//             );
//           }      }}
//     });
//     _DbDailyInfoList2.forEach((item) {
//       print(data2.length.toString()+"data2.length");
//       if (data2.length < 50) {
//         if(empty){
//
//           data2.add(
//             new FlSpot(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//                 data2.length.toDouble(),
//                 double.parse(
//                     double.parse(getChoseType(item)).toStringAsFixed(1))),);
//         }
//         else{
//
//
//           data2.add(
//             FlSpot(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//                 data2.length.toDouble(),
//                 double.parse(
//                     double.parse(getChoseType(item)).toStringAsFixed(1))),
//           );
//         }      }
//     });
//
//     setState(() {
//       allSpots = data;
//       allSpots2 = data2;
//
//
//       showIndexes = dataY;
//
//     });
//
//
//   }
//
//   getExpandedVal(int index) async {
//     setState(() {});
//   }
//
//   _buildExpandableContent() {
//     List<Widget> columnContent = [];
//
//     for (int i = 0; i < _MyExpandedList.length; i++)
//       columnContent.add(Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           GestureDetector(
//             child:Container(
//               width: double.infinity,
//
//               padding:EdgeInsets.symmetric(horizontal: 5,vertical: 8) ,
//               child: Text(
//                 _MyExpandedList[i],
//                 style:  TextStyle(
//                   fontSize: 13.0 * fontvar,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff5c5c5c),),textAlign: TextAlign.right,
//               ),
//
//             ),
//             onTap: () async {
//               setState(()  {
//                 expansionTileKeyCar.currentState.handleTap();
//                 _typeChoose= _MyExpandedList[i];
//                 _index=i;
//
//
//               });
//               await _getDailyInfo2();
//             },
//           ),
//
//           Divider(
//             color: Color(0xff5c5c5c),
//             endIndent: 15,
//             height: 1,
//             indent: 15,
//           )
//         ],
//       ));
//
//     return columnContent;
//   }
//
//   _getDailyInfo2({bool refresh: false}) async {
//     if (refresh = true) {}
//
//     bool empty=false;
//     setState(() {
//       _isLoading = true;
//       _DbDailyInfoList = [];
//       _DbDailyInfoList2 = [];
//       _avrege=[];
//       // allSpots2=[];
//     });
//
//     if ((dateTime1.isBefore(dateTime2)) ||
//         (dateTime1.compareTo(dateTime2) == 0)) {
//       print("in method");
//       for (int i = 0; i <= dateTime2.difference(dateTime1).inDays; i++) {
//         DateTime date = DateTime(
//           dateTime1.year,
//           dateTime1.month,
//           dateTime1.day + i,
//         );
//         date = DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//         var datee = intl.DateFormat('yyyy-MM-dd').format((date));
//
//
//         // setState(() {
//         // var persianDateee=  PersianDateTime.fromGregorian(gregorianDateTime:datee);
//         //
//         //
//         //
//         //   allSpots2.add(
//         //     FlSpot(
//         //       double.parse(persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]),
//         //       0));
//         // });
//         DbDailyInfo dbinfo = await _getDailyInfo(datee);
//         setState(() {
//           if(dbinfo!=null) {
//             if (_index == 1) {
//               if (getChoseType(dbinfo) != null)
//                 _avrege.add(double.parse(getChoseType(dbinfo)));
//             } else {
//               if (getChoseType(dbinfo) != null && getChoseType(dbinfo) != "0" &&
//                   getChoseType(dbinfo) != "0.0")
//                 _avrege.add(double.parse(getChoseType(dbinfo)));
//             }
//             if (getChoseType(dbinfo) != null && getChoseType(dbinfo) != "0" &&
//                 getChoseType(dbinfo) != "0.0") {
//               _DbDailyInfoList.add(dbinfo);
//             }
//             // else{ _DbDailyInfoList.add( DbDailyInfo.fromJson(map));}
//           }});
//       }
//     }
//     if (_DbDailyInfoList.length == 0) {
//       empty=true;
//       for (int i = 0; i <= dateTime2.difference(dateTime1).inDays; i++) {
//         DateTime date = new DateTime(
//           dateTime1.year,
//           dateTime1.month,
//           dateTime1.day + i,
//         );
//         date = DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//         var datee = intl.DateFormat('yyyy-MM-dd').format((date));
//
//         Map<String, dynamic> map = {'date': datee.toString()};
//         _DbDailyInfoList.add(DbDailyInfo.fromJson(map));
//       }
//     }
//     for (int i = 0; i <= dateTime2.difference(dateTime1).inDays; i++) {
//       DateTime date =  DateTime(
//         dateTime1.year,
//         dateTime1.month,
//         dateTime1.day + i,
//       );
//       date = DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//       var datee = intl.DateFormat('yyyy-MM-dd').format((date));
//
//       Map<String, dynamic> map = {'date': datee.toString()};
//       _DbDailyInfoList2.add(DbDailyInfo.fromJson(map));
//     }
//
//     setState(() {
//       _userWeight32 = _DbDailyInfoList;
//       _userWeight322 = _DbDailyInfoList2;
//       _isLoading = false;
//     });
//
//     _weightc(empty);
//   }
//
//   Future _getDailyInfo(String gregorianDate) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var db = new DailyInfoProvider();
//     await db.open();
//     DbDailyInfo products = await db.getByDate(gregorianDate);
// //    await db.close();
//     return products;
//   }
//   _getUser() async {
//     var response = await getUser();
//
//     if (this.mounted) {
//       _user = response;
//
// //      print(_user.toMap());
//
//     }
//     return _user;
//   }
//   static Future<User> getUser() async {
//     User user;
//     try {
//       var db = new userProvider();
//       await db.open();
//       user = await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//   prepareData() async {
//
//
//     setState(() {
//       _MyExpandedList=[
//         'کالری مصرف شده',
//         'کالری سوزانده شده',
//         'کربوهیدرات',
//         'چربی',
//         'پروتئین',
//         'چربی اشباع',
//         'چربی ترانس',
//         'کلسترول',
//         'شکر',
//         'فیبر',
//         'سدیم',
//         'پتاسیم',
//         'فسفر',
//         'آهن',
//         'کلسیم',
//         'منیزیم',
//         'روی',
//         'مس',
//         'سلنیوم',
//         'ویتامین C',
//         'بیوتین',
//         'فولیک اسید',
//         'پانتوتنیک',
//         'ویتامین B1',
//         'ویتامین B2',
//         'نیاسین',
//         'ویتامین B6',
//         'ویتامین B12',
//         'ویتامین A',
//         'ویتامین D',
//         'ویتامین E',
//         'ویتامین K',
//       ];
//
//
//     });
//
//
//
//   }
//   String getChoseType(DbDailyInfo item) {
//     switch(_index) {
//       case 0: return (double.parse( double.parse(item.total_act).toStringAsFixed(1))+  double.parse( double.parse(item.total_calorie).toStringAsFixed(1))).toString();
//       break;
//       case 1: return item.total_act;
//       break;
//       case 2: return item.total_carb;
//       break;
//       case 3: return item.total_fat;
//       break;
//       case 4: return item.total_protein;
//       break;
//       case 5: return item.saturated_fat;
//       break;
//       case 6: return item.trans_fat;
//       break;
//       case 7: return item.cholesterol;
//       break;
//       case 8: return item.sugar;
//       break;
//       case 9: return item.fiber;
//       break;
//       case 10: return item.sodium;
//       break;
//       case 11: return item.potassium;
//       break;
//       case 12: return item.phosphorus;
//       break;
//       case 13: return item.iron;
//       break;
//       case 14: return item.calcium;
//       break;
//       case 15: return item.magnesium;
//       break;
//       case 16: return item.zinc;
//       break;
//       case 17: return item.copper;
//       break;
//       case 18: return item.selenium;
//       break;
//       case 19: return item.vitamin_c;
//       break;
//       case 20: return item.biotin;
//       break;
//       case 21: return item.folic_acid;
//       break;
//       case 22: return item.pantothenic_acid;
//       break;
//       case 23: return item.b1;
//       break;
//       case 24: return item.b2;
//       break;
//       case 25: return item.b3;
//       break;
//       case 26: return item.b6;
//       break;
//       case 27: return item.b12;
//       break;
//       case 28: return item.vitamin_a;
//       break;
//       case 29: return item.vitamin_d;
//       break;
//       case 30: return item.vitamin_e;
//       break;
//       case 31: return item.vitamin_k;
//       break;
//
//       default: {
//         return item.total_calorie;
//       }
//       break;
//     }
//   }
// }
