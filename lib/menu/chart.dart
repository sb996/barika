// import 'package:barika/utils/MyDadaPicker.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:barika/helper.dart';
// import 'dart:math';
// import 'package:barika/models/DbDailyInfo.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:barika/models/user.dart';
// import 'package:barika/models/userweight.dart';
// import 'package:barika/sqliteProvider/dailyInfoProvider.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:barika/sqliteProvider/userWeightProvider.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:persian_datepicker/persian_datepicker.dart';
// import 'package:persian_datepicker/persian_datetime.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'chart2.dart';
//
// class chart extends StatefulWidget {
//   @override
// //  chart({Key key, this.pointerValue})
// //      : super(key: key);
//   State<StatefulWidget> createState() => chartState();
// }
//
// class chartState extends State<chart> {
//   static  String pointerValue;
//   int _selectedPage = 0;
//   String _selecteddate = "1398/10/20";
//   String fromDate = "--/--/----";
//   String untilDAte = "--/--/----";
//   bool avctiveDate = false;
//   PersianDatePickerWidget persianDatePicker1;
//   PersianDatePickerWidget persianDatePicker2;
//   final TextEditingController textEditingController = TextEditingController();
//   final TextEditingController textEditingController2 = TextEditingController();
//   PersianDateTime persianDate1;
//   PersianDateTime persianDate2;
//   String gregorianDate1 = "";
//   String gregorianDate2 = "";
//   DateTime dateTime1;
//   DateTime dateTime2;
//   List<DbDailyInfo> _DbDailyInfoList = [];
//   List<int> _water = [];
//   List<double> _actCalory = [];
//   List<double> _allWeight = [];
//   List<UserWeight> _userWeight = [];
//   static List<UserWeight> _userWeight32 = [];
//   bool _isLoading=true;
//   List<double> items = new List();
// //  int min=0,max=0;
// //  List<DataPoint> dataitem = [];
//   Widget loadingView() {
//     return new Center(
//         child:SpinKitCircle(
//           color: MyColors.vazn,
//         )
//     );
//   }
//   User _user;
//   @override
//   void initState() {
//     _getUser();
//
//     setDatePicker1();
//     setDatePicker2();
//
//     persianDate2= PersianDateTime.fromGregorian();
//      persianDate1 = persianDate2.add(Duration(days: -6));
//     untilDAte= persianDate2.toJalaali(format: 'YYYY/MM/DD');
//     fromDate=  persianDate1.toJalaali(format:  'YYYY/MM/DD');
//     dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//         .format((DateTime.parse(getCustomDate(-6)))));
//     dateTime2 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//         .format((DateTime.parse(getDateToday()))));
//
//     print(dateTime2.toString()+"Sf");
//     print(getDateToday()+"Sf");
//     print(dateTime1.toString()+"Sf");
//
//     _getDailyInfo2();
//
//     // TODO: implement initState
//     super.initState();
//   }
//   _getUser() async {
//
//     var response = await getUser();
//
//     if (this.mounted){
//
//       _user = response;
//
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
//       user= await db.paginate();
// //      await db.close();
//       return user;
//     } catch (e) {
//       print(e.toString()+"errrrrorrrrr");
//       return null;
//     }
//   }
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//
//     List<Widget> pageList = List<Widget>();
//     pageList.add(weight());
//     pageList.add(allCalory());
//     pageList.add(actCalory());
//     pageList.add(water());
//
//     if (gregorianDate2 != "") {
//       setState(() {});
//     }
//
//     return Scaffold(
//       appBar: new PreferredSize(
//         preferredSize: Size.fromHeight(100*(screenSize.width)/375),
//         child: new Container(
//           padding: EdgeInsets.only(top: 10*(screenSize.width)/375),
//           decoration: new BoxDecoration(
//             color: MyColors.green
//           ),
//           child: new SafeArea(
//             child: Column(
//               children: <Widget>[
//                 new Expanded(
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(top: 12, bottom: 8),
//                         child: Text(
//                           'نمودار',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16*fontvar,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.chevron_right,
//                           size:  32*(screenSize.width)/375,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context, 'yes');
//                         },
//                         alignment: Alignment.topLeft,
//                         color: Colors.white,
//                         splashColor: Colors.amber,
//                         padding: EdgeInsets.all(7),
//                       ),
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
//                     ],
//                   ),
//                 ),
//                 new Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5),
//                               child: Text("از تاریخ",
//                                   style: TextStyle(
//                                       fontSize: 12*fontvar,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500)),
//                             ),
//                             RaisedButton(
//                                 shape: new RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.circular(8.0),
//                                 ),
//                                 padding: EdgeInsets.symmetric(horizontal: 2),
//                                 onPressed: () {
//                                   MyDatePicker.showDatePicker(
//                                     context,
//
//                                     onConfirm: (int year,int month,int day){
//                                       print(year);
//                                       print(month);
//                                       print(day);
//                                       String datenew=year.toString()+"/"+month.toString()+"/"+day.toString();
//                                       var datenew2 = PersianDateTime(jalaaliDateTime:datenew);
//                                       PersianDateTime datenow = PersianDateTime();
//                                       print(datenew2);
//                                       print(persianDate2);
//                                       print(persianDate1);
//                                       if(((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0))
//                                       &&
//                                      ((datenew2.isBefore(persianDate2))||(datenew2.difference(persianDate2).inDays==0)))
//                                       {
//                                         setState(() {
//
// //                                        untilDAte = newText;
// //                                        persianDate2 = PersianDateTime(jalaaliDateTime: untilDAte);
// //                                        gregorianDate2 = persianDate2.toGregorian(format: 'YYYY-MM-DD');
// //                                        dateTime2 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
// //                                            .format((DateTime.parse(gregorianDate2))));
// //
// //                                        _getDailyInfo2();
//
//
//                                       fromDate = datenew;
//                                       persianDate1 = PersianDateTime(jalaaliDateTime: fromDate);
//                                       gregorianDate1 = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//                                       dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//                                           .format((DateTime.parse(gregorianDate1))));
//
//
//                                       _getDailyInfo2();
//
//
//                                       });}
//                                       else{
//
//                                         Fluttertoast.showToast(
//                                           msg: "امکان انتخاب این تاریخ وجود ندارد.",
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.CENTER,
//                                           timeInSecForIosWeb: 1,
//                                           backgroundColor: Colors.red,
//                                           textColor: Colors.white,
//
//                                           fontSize: 16.0*fontvar,
//                                         );
//                                       }
//                                     },
//
//
//                                     minYear: 1300,
//
//                                     maxYear: 1450,
//                                     confirm: Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(6)),
//                                           color: Colors.green
//                                       ),
//                                       child: Text(
//                                         'تایید',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 18*fontvar,
//                                             fontFamily: "iransansDN",
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),
//                                     cancel:Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                                             color: Colors.red
//                                         ),
//                                         child: Text(
//                                           ' لغو ',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18*fontvar,
//                                               fontFamily: "iransansDN",
//                                               fontWeight: FontWeight.w400),
//                                         )),
//
//                                   );
//                                 },
//                                 color: Colors.white,
//                                 textColor: Colors.white,
//                                 child: Row(
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 5, right: 2, bottom: 5),
//                                       child: Image.network(
//                                         'assets/icons/calendar.svg',
//                                         width: 16*(screenSize.width)/375,
//                                         height:16*(screenSize.width)/375,
//                                         color: Colors.green,
//                                       ),
//                                     ),
//                                     Text(fromDate,
//                                         style: TextStyle(
//                                             fontSize: 12*fontvar,
//                                             color: Color(0xff555555),
//                                             fontWeight: FontWeight.w500)),
//                                   ],
//                                 )),
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 5),
//                               child: Text("تا تاریخ",
//                                   style: TextStyle(
//                                       fontSize: 12*fontvar,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500)),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 5),
//                               child: RaisedButton(
//                                   disabledColor: Colors.white,
//                                   padding: EdgeInsets.symmetric(horizontal: 2),
//                                   shape: new RoundedRectangleBorder(
//                                     borderRadius: new BorderRadius.circular(8.0),
//                                   ),
//                                   onPressed:() {
//                                     MyDatePicker.showDatePicker(
//                                       context,
//                                       onConfirm: (int year,int month,int day){
//                                         print(year);
//                                         print(month);
//                                         print(day);
//                                         String datenew=year.toString()+"/"+month.toString()+"/"+day.toString();
//                                         var datenew2 = PersianDateTime(jalaaliDateTime:datenew);
//                                         PersianDateTime datenow = PersianDateTime();
//                                         print("uuuuuuuuuuu");
//                                         print(((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0)));
//                                         if(((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0))
//                                         &&((datenew2.isAfter(persianDate1))||(datenew2.difference(persianDate1).inDays==0)))
//                                         {
//
//                                           setState(() {
//                                             print("uuuuuuuuuuu");
//                                             print(untilDAte);
//
//                                         untilDAte =datenew;
//                                             print("uuuuuuuuuuu");
//                                             print(untilDAte);
//                                         persianDate2 = PersianDateTime(jalaaliDateTime: untilDAte);
//                                         gregorianDate2 = persianDate2.toGregorian(format: 'YYYY-MM-DD');
//                                         dateTime2 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
//                                             .format((DateTime.parse(gregorianDate2))));
//
//                                         _getDailyInfo2();
//
//                                         });
// //                                          fromDate = datenow.toString();
// //                                          persianDate1 = PersianDateTime(jalaaliDateTime: fromDate);
// //                                          gregorianDate1 = persianDate1.toGregorian(format: 'YYYY-MM-DD');
// //                                          dateTime1 = DateTime.parse(intl.DateFormat('yyyy-MM-dd')
// //                                              .format((DateTime.parse(gregorianDate1))));
// //
// //                                          _getDailyInfo2();
// //
//
//                                         }
//                                         else{
//
//                                           Fluttertoast.showToast(
//                                             msg: "امکان انتخاب این تاریخ وجود ندارد.",
//                                             toastLength: Toast.LENGTH_SHORT,
//                                             gravity: ToastGravity.CENTER,
//                                             timeInSecForIosWeb: 1,
//                                             backgroundColor: Colors.red,
//                                             textColor: Colors.white,
//
//                                             fontSize: 16.0*fontvar,
//                                           );
//                                         }
//                                       },
//
//
//                                       minYear: 1300,
//
//                                       maxYear: 1450,
//                                       confirm: Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                                             color: Colors.green
//                                         ),
//                                         child: Text(
//                                           'تایید',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 18*fontvar,
//                                               fontFamily: "iransansDN",
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ),
//                                       cancel:Container(
//                                           padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.all(Radius.circular(6)),
//                                               color: Colors.red
//                                           ),
//                                           child: Text(
//                                             ' لغو ',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 18*fontvar,
//                                                 fontFamily: "iransansDN",
//                                                 fontWeight: FontWeight.w400),
//                                           )),
//
//                                     );
//                                   },
//
//                                   color: Colors.white,
//                                   textColor: Colors.white,
//                                   child: Row(
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 5, right: 2, bottom: 5),
//                                         child: Image.network(
//                                           'assets/icons/calendar.svg',
//                                           width: 16*(screenSize.width)/375,
//                                           height: 16*(screenSize.width)/375,
//                                           color: Colors.green,
//                                         ),
//                                       ),
//                                       Text(untilDAte,
//                                           style: TextStyle(
//                                               fontSize: 12*fontvar,
//                                               color: Color(0xff555555),
//                                               fontWeight: FontWeight.w500)),
//                                     ],
//                                   )),
//                             )
//                           ],
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: _isLoading?loadingView()
//           : IndexedStack(
//         index: _selectedPage,
//         children: pageList,
//       ),
//       bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           child: Container(
//             height: 60*(screenSize.width)/375,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Expanded(
//                     flex: 1,
//                     child: MaterialButton(
//                         color: _selectedPage == 0 ? Colors.green : Colors.white,
//                         minWidth: 40,
//                         onPressed: () {
//                           setState(() {
//                             _selectedPage = 0;
//                           });
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 5, bottom: 5),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(bottom: 2),
//                                 child: Image.network(
//                                 'assets/icons/vazn.svg',
//                                 height:20*(screenSize.width)/375,
//                                 width:20*(screenSize.width)/375,
//                                 color: _selectedPage == 0
//                                     ? Colors.white
//                                     : Color(0xffE040FB),
//                               ),
//
//                               ),
//                               Text(
//                                 'روند وزن',
//                                 style: TextStyle(
//                                   color: _selectedPage == 0
//                                       ? Colors.white
//                                       : Color(0xff555555),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 10*fontvar,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ))),
//                 Expanded(
//                   flex: 1,
//                   child: MaterialButton(
//                       color: _selectedPage == 1 ? Colors.green : Colors.white,
//                       minWidth: 50,
//                       onPressed: () {
//                         setState(() {
//                           _selectedPage = 1;
//                         });
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 5, bottom: 5),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                         Padding(
//                             padding: EdgeInsets.only(bottom: 2),
//                         child: Image.network(
//                                 'assets/icons/restaurant.svg',
//                                 width: 18*(screenSize.width)/375,
//                                 height: 18*(screenSize.width)/375,
//                                 color: _selectedPage == 1
//                                     ? Colors.white
//                                     : Color(0xffF15A23))),
//                             Text(
//                               'کالری مصرف شده',
//                               style: TextStyle(
//                                 color: _selectedPage == 1
//                                     ? Colors.white
//                                     : Color(0xff555555),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 9*fontvar,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: MaterialButton(
//                         color: _selectedPage == 2 ? Colors.green : Colors.white,
//                         minWidth: 50,
//                         onPressed: () {
//                           setState(() {
//                             _selectedPage = 2;
//                           });
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 5, bottom: 5),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                           Padding(
//                               padding: EdgeInsets.only(bottom: 2),
//                           child: Image.network(
//                                 'assets/icons/sport.svg',
//                                 width: 18*(screenSize.width)/375,
//                                 height: 18*(screenSize.width)/375,
//                                 color: _selectedPage == 2
//                                     ? Colors.white
//                                     : Color(0xffFFEB3B),
//                           )),
//                               Text(
//                                 'کالری سوزانده شده',
//                                 style: TextStyle(
//                                   color: _selectedPage == 2
//                                       ? Colors.white
//                                       : Color(0xff555555),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 9*fontvar,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ))),
//                 Expanded(
//                   flex: 1,
//                   child: MaterialButton(
//                       color: _selectedPage == 3 ? Colors.green : Colors.white,
//                       minWidth: 40,
//                       onPressed: () {
//                         setState(() {
//                           _selectedPage = 3;
//                         });
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 5, bottom: 5),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                         Padding(
//                         padding: EdgeInsets.only(bottom: 2),
//                         child: Image.network(
//                               'assets/icons/water.svg',
//                               width: 18*(screenSize.width)/375,
//                               height: 18*(screenSize.width)/375,
//                               color: _selectedPage == 3
//                                   ? Colors.white
//                                   : Color(0xff24AEFC),
//                         )),
//                             Text(
//                               'روند آب',
//                               style: TextStyle(
//                                 color: _selectedPage == 3
//                                     ? Colors.white
//                                     : Color(0xff555555),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10*fontvar,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//           )),
//     );
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
//
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
//       gregorianDatetime:getDateToday(),
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
//       // datetime: '1397/06/09',
// //       finishDatetime: _selecteddate,
//     ).init();
//   }
//
//
//   _getInfoFromDb() async {
//     var db = new DailyInfoProvider();
//     await db.open();
//     List DbDailyInfo = await db.paginate();
// //    await db.close();
//     if (!(DbDailyInfo == null)) {
//       return DbDailyInfo;
//     }
//   }
//
//   Future<List<UserWeight>> getUWeight() async {
//     List<UserWeight> userweight;
//     try {
//       var db = new userWeightProvider();
//       await db.open();
//       userweight = await db.searchbyUid( _user.uid, "weight");
// //      await db.close();
//       return userweight;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//
//   water() {
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     if (_DbDailyInfoList.isEmpty) {
//       return Container(
//         height: 20*(screenSize.width)/375,
//       );
//     } else {
//       return CustomScrollView(slivers: <Widget>[
//         SliverList(
//             delegate: SliverChildListDelegate(<Widget>[
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//
//                   padding: EdgeInsets.only(top: 15),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: charts.BarChart(
//
//                     _createSampleData(),
//                     domainAxis: new charts.OrdinalAxisSpec(
//                         renderSpec: new charts.SmallTickRendererSpec(
//
//                           // Tick and Label styling here.
//                             labelStyle: new charts.TextStyleSpec(
//                                 fontSize: 9*fontvar.round(), // size in Pts.
//                                 color: charts.MaterialPalette.black),
//
//                             // Change the line colors to match text color.
//                             lineStyle: new charts.LineStyleSpec(
//                                 color: charts.MaterialPalette.black))),
//
//                     /// Assign a custom style for the measure axis.
//                     primaryMeasureAxis: new charts.NumericAxisSpec(
//                         renderSpec: new charts.GridlineRendererSpec(
//
//                           // Tick and Label styling here.
//                             labelStyle: new charts.TextStyleSpec(
//                                 fontSize: 9*fontvar.round(), // size in Pts.
//                                 color: charts.MaterialPalette.black),
//
//                             // Change the line colors to match text color.
//                             lineStyle: new charts.LineStyleSpec(
//                                 color: charts.MaterialPalette.black))),
//                     behaviors: [
//
//
//
//                       new charts.ChartTitle('لیوان',
//                           titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                           behaviorPosition: charts.BehaviorPosition.end,
//                           titleOutsideJustification:
//                           charts.OutsideJustification.middleDrawArea),
//
//
//                       charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                     ],
//                     selectionModels: [
//                       charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                         if (model.hasDatumSelection)
//                           pointerValue = model.selectedSeries[0]
//                               .measureFn(model.selectedDatum[0].index)
//                               .toString();
//                       })
//                     ],
//                     animate: true,
// //                    barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                    domainAxis: new charts.OrdinalAxisSpec(),
//                   )),
//             ]))
//       ]);
//     }
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//
//       if(data.length<50) data.add(
//         new OrdinalSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//             int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//             double.parse(item.water)),
//       );
//     });
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//
//         colorFn: (_, __) => charts.Color.fromHex(code: '#24AEFC'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//
//         data: data,
// //    labelAccessorFn: (OrdinalSales sales, _) =>
// //    sales.sales.toString()
//
//       ) ];
//   }
//
//   actCalory() {
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     if (_DbDailyInfoList.isEmpty) {
//       return Container(
//         height: 20*(screenSize.width)/375,
//       );
//     } else {
//       return CustomScrollView(slivers: <Widget>[
//         SliverList(
//             delegate: SliverChildListDelegate(<Widget>[
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//
//                   padding: EdgeInsets.only(top: 15),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: charts.BarChart(
//                     _createActData(),
//                     domainAxis: new charts.OrdinalAxisSpec(
//                         renderSpec: new charts.SmallTickRendererSpec(
//
//                           // Tick and Label styling here.
//                             labelStyle: new charts.TextStyleSpec(
//                                 fontSize: 9*fontvar.round(), // size in Pts.
//                                 color: charts.MaterialPalette.black),
//
//                             // Change the line colors to match text color.
//                             lineStyle: new charts.LineStyleSpec(
//                                 color: charts.MaterialPalette.black))),
//
//                     /// Assign a custom style for the measure axis.
//                     primaryMeasureAxis: new charts.NumericAxisSpec(
//                         renderSpec: new charts.GridlineRendererSpec(
//
//                           // Tick and Label styling here.
//                             labelStyle: new charts.TextStyleSpec(
//                                 fontSize: 9*fontvar.round(), // size in Pts.
//                                 color: charts.MaterialPalette.black),
//
//                             // Change the line colors to match text color.
//                             lineStyle: new charts.LineStyleSpec(
//                                 color: charts.MaterialPalette.black))),
//                     behaviors: [
//
//
//
//                       new charts.ChartTitle('کالری',
//                           titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                           behaviorPosition: charts.BehaviorPosition.end,
//                           titleOutsideJustification:
//                           charts.OutsideJustification.middleDrawArea),
//
//
//                       charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                     ],
//                     selectionModels: [
//                       charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                         if (model.hasDatumSelection)
//                           pointerValue = model.selectedSeries[0]
//                               .measureFn(model.selectedDatum[0].index)
//                               .toString();
//                       })
//                     ],
//                     animate: true,
//
//                   )),
//
//             ]))
//       ]);
//     }
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createActData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50) data.add(
//         new OrdinalSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//             int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//           double.parse( double.parse(item.total_act).toStringAsFixed(1)))
//       );
//     });
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#FFEB3B'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
// //    labelAccessorFn: (OrdinalSales sales, _) =>
// //    sales.sales.toString()
//
//       ) ];
//   }
//
//   allCalory() {
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     if (_DbDailyInfoList.isEmpty) {
//       return Container(
//         height: 20*(screenSize.width)/375,
//       );
//     } else {
//       return CustomScrollView(slivers: <Widget>[
//         SliverList(
//             delegate: SliverChildListDelegate(<Widget>[
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'انرژی',
//                           style: TextStyle(
//                               color: Color(0xff555555),
//                               fontSize: 13*fontvar,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Expanded(
//                             child: charts.BarChart(
//                               _createallData(),
//                               domainAxis: new charts.OrdinalAxisSpec(
//                                   renderSpec: new charts.SmallTickRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//
//                               /// Assign a custom style for the measure axis.
//                               primaryMeasureAxis: new charts.NumericAxisSpec(
//                                   renderSpec: new charts.GridlineRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//                               behaviors: [
//
//
//
//                                 new charts.ChartTitle('کالری',
//                                     titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                                     behaviorPosition: charts.BehaviorPosition.end,
//                                     titleOutsideJustification:
//                                     charts.OutsideJustification.middleDrawArea),
//
//
//                                 charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                               ],
//                               selectionModels: [
//                                 charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                                   if (model.hasDatumSelection)
//                                     pointerValue = model.selectedSeries[0]
//                                         .measureFn(model.selectedDatum[0].index)
//                                         .toString();
//                                 })
//                               ],
//                               animate: true,
// //                              barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                              domainAxis: new charts.OrdinalAxisSpec(),
//                             ))
//                       ])),
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'چربی',
//                           style: TextStyle(
//                               color: Color(0xff555555),
//                               fontSize: 13*fontvar,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Expanded(
//                             child: charts.BarChart(
//                               _createfatData(),
//                               domainAxis: new charts.OrdinalAxisSpec(
//                                   renderSpec: new charts.SmallTickRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//
//                               /// Assign a custom style for the measure axis.
//                               primaryMeasureAxis: new charts.NumericAxisSpec(
//                                   renderSpec: new charts.GridlineRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//                               behaviors: [
//
//
//
//                                 new charts.ChartTitle('گرم',
//                                     titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                                     behaviorPosition: charts.BehaviorPosition.end,
//                                     titleOutsideJustification:
//                                     charts.OutsideJustification.middleDrawArea),
//
//
//                                 charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                               ],
//                               selectionModels: [
//                                 charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                                   if (model.hasDatumSelection)
//                                     pointerValue = model.selectedSeries[0]
//                                         .measureFn(model.selectedDatum[0].index)
//                                         .toString();
//                                 })
//                               ],
//
//                               animate: true,
// //                              barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                              domainAxis: new charts.OrdinalAxisSpec(),
//                             ))
//                       ])),
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'کربوهیدرات',
//                           style: TextStyle(
//                               color: Color(0xff555555),
//                               fontSize: 13*fontvar,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Expanded(
//                             child: charts.BarChart(
//                               _createcarbData(),
//                               domainAxis: new charts.OrdinalAxisSpec(
//                                   renderSpec: new charts.SmallTickRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//
//                               /// Assign a custom style for the measure axis.
//                               primaryMeasureAxis: new charts.NumericAxisSpec(
//                                   renderSpec: new charts.GridlineRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//                               behaviors: [
//
//
//
//                                 new charts.ChartTitle('گرم',
//                                     titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                                     behaviorPosition: charts.BehaviorPosition.end,
//                                     titleOutsideJustification:
//                                     charts.OutsideJustification.middleDrawArea),
//
//
//                                 charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                               ],
//                               selectionModels: [
//                                 charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                                   if (model.hasDatumSelection)
//                                     pointerValue = model.selectedSeries[0]
//                                         .measureFn(model.selectedDatum[0].index)
//                                         .toString();
//                                 })
//                               ],
//                               animate: true,
// //                              barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                              domainAxis: new charts.OrdinalAxisSpec(),
//                             ))
//                       ])),
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//                   height: 200*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'پروتئین',
//                           style: TextStyle(
//                               color: Color(0xff555555),
//                               fontSize: 13*fontvar,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Expanded(
//                             child: charts.BarChart(
//                               _createproData(),
//                               domainAxis: new charts.OrdinalAxisSpec(
//                                   renderSpec: new charts.SmallTickRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//
//                               /// Assign a custom style for the measure axis.
//                               primaryMeasureAxis: new charts.NumericAxisSpec(
//                                   renderSpec: new charts.GridlineRendererSpec(
//
//                                     // Tick and Label styling here.
//                                       labelStyle: new charts.TextStyleSpec(
//                                           fontSize: 9*fontvar.round(), // size in Pts.
//                                           color: charts.MaterialPalette.black),
//
//                                       // Change the line colors to match text color.
//                                       lineStyle: new charts.LineStyleSpec(
//                                           color: charts.MaterialPalette.black))),
//                               behaviors: [
//
//
//
//                                 new charts.ChartTitle('گرم',
//                                     titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                                     behaviorPosition: charts.BehaviorPosition.end,
//                                     titleOutsideJustification:
//                                     charts.OutsideJustification.middleDrawArea),
//
//
//                                 charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                               ],
//                               selectionModels: [
//                                 charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                                   if (model.hasDatumSelection)
//                                     pointerValue = model.selectedSeries[0]
//                                         .measureFn(model.selectedDatum[0].index)
//                                         .toString();
//                                 })
//                               ],
//                               animate: true,
// //                              barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                              domainAxis: new charts.OrdinalAxisSpec(),
//                             ))
//                       ]))
//             ]))
//       ]);
//     }
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createallData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50) data.add(
//         new OrdinalSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//             int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//             double.parse( double.parse(item.total_act).toStringAsFixed(1))+  double.parse( double.parse(item.total_calorie).toStringAsFixed(1)),
//
//       ));
//     });
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#6CBD45'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
// //          labelAccessorFn: (OrdinalSales sales, _) =>
// //          sales.sales.toString()
// //      insideLabelStyleAccessorFn: (int index) => insideLabelStyleAccessorFn(data[index], index
//
//
//       )
//
//     ];
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createproData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50)  data.add(
//         new OrdinalSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//             int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//             double.parse( double.parse(item.total_protein).toStringAsFixed(1)),
//
//       ));
//     });
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#F15A23'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
// //    labelAccessorFn: (OrdinalSales sales, _) =>
// //    sales.sales.toString()
//       )
//     ];
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createcarbData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50) data.add(
//           new OrdinalSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//               int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//               double.parse( double.parse(item.total_carb).toStringAsFixed(1)),
//
//
//       ));
//     });
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#23C7F1'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
// //          labelAccessorFn: (OrdinalSales sales, _) =>
// //              sales.sales.toString()
//
//
//       )
//
//     ];
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createfatData() {
//     final List<OrdinalSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//
//     _DbDailyInfoList.forEach((item) {
//       var persianDateee =
//       PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50) data.add(new OrdinalSales(
// //        persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//         int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString(),
//        double.parse( double.parse(item.total_fat).toStringAsFixed(1)),
//       ));
//     });
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#A545BD'),
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//
//
//         data: data,
// //    labelAccessorFn: (OrdinalSales sales, _) =>
// //    sales.sales.toString()
//       )
//
//     ];
//   }
//
//   final customTickFormatter =
//   charts.BasicNumericTickFormatterSpec((num value) {
//     print(value.toInt());
//     print(_userWeight32.length.toString()+"length");
// //    print(_userWeight32[value.toInt()].date.toString());
//     if(value.toInt()<_userWeight32.length){
//       var persianDateee = PersianDateTime.fromGregorian(gregorianDateTime: _userWeight32[value.toInt()].date);
//       print( _userWeight32[value.toInt()].toMap());
//       return    int.parse( persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2]).toString();}
//     else
//       return"";
//   });
//
//
//
//   weight() {
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     if (_userWeight.isEmpty) {
//       return Container(
//         height: 20*(screenSize.width)/375,
//       );
//     } else {
//       return CustomScrollView(slivers: <Widget>[
//         SliverList(
//             delegate: SliverChildListDelegate(<Widget>[
//               Container(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//                   padding: EdgeInsets.only(top: 15),
//                   height: 300*(screenSize.width)/375,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE9E9E9),
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
// //                  child:sample2(context)),
//                   child:
//
// //                  wchart(context)
// //              ),
//
//
//
//
//
//
//                   charts.LineChart(
//
//                     _weightc(),
//
//                     defaultRenderer: new charts.LineRendererConfig(includePoints: true,roundEndCaps: true,),
//                     behaviors: [
//                       new charts.ChartTitle('کیلو گرم',
//                           titleStyleSpec: charts.TextStyleSpec(fontSize: 12*fontvar.round()),
//                           behaviorPosition: charts.BehaviorPosition.end,
//                           titleOutsideJustification:
//                           charts.OutsideJustification.middleDrawArea),
//     charts.LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer())
//                     ],
//
//                     selectionModels: [
//                       charts.SelectionModelConfig(changedListener: (charts.SelectionModel model) {
//                         if (model.hasDatumSelection)
//                           pointerValue = model.selectedSeries[0]
//                               .measureFn(model.selectedDatum[0].index)
//                               .toString();
//                       })
//                     ],
//
//
//                     domainAxis: charts.NumericAxisSpec(
//
//
//                       renderSpec: new charts.SmallTickRendererSpec(
// //
//                         // Tick and Label styling here.
//                           labelStyle: new charts.TextStyleSpec(
//                               fontSize: 9*fontvar.round(), // size in Pts.
//                               color: charts.MaterialPalette.black),
//
//                           // Change the line colors to match text color.
//                           lineStyle: new charts.LineStyleSpec(
//                               color: charts.MaterialPalette.black)),
//                       tickFormatterSpec:customTickFormatter ,
//
//                     ),
// //                    domainAxis: new charts.OrdinalAxisSpec(
// //                        renderSpec: new charts.SmallTickRendererSpec(
// //
// //                          // Tick and Label styling here.
// //                            labelStyle: new charts.TextStyleSpec(
// //                                fontSize: 9, // size in Pts.
// //                                color: charts.MaterialPalette.black),
// //
// //                            // Change the line colors to match text color.
// //                            lineStyle: new charts.LineStyleSpec(
// //                                color: charts.MaterialPalette.black))),
//
//                     /// Assign a custom style for the measure axis.
//                     primaryMeasureAxis: new charts.NumericAxisSpec(
//                         renderSpec: new charts.GridlineRendererSpec(
//
//                           // Tick and Label styling here.
//                             labelStyle: new charts.TextStyleSpec(
//                                 fontSize: 9*fontvar.round(), // size in Pts.
//                                 color: charts.MaterialPalette.black),
//
//                             // Change the line colors to match text color.
//                             lineStyle: new charts.LineStyleSpec(
//                                 color: charts.MaterialPalette.black))),
//
//
//                     animate: true,
// //                    barRendererDecorator: new charts.BarLabelDecorator<String>(),
// //                    domainAxis: new charts.OrdinalAxisSpec(),
//                   )),
//
//             ]))
//       ]);
//     }
//   }
//
//
//
//   List<charts.Series<LinearSales, int>> _weightc() {
//
//     final List<LinearSales> data = [
// //      new OrdinalSales(_DbDailyInfoList[0].date.split("-")[2], int.parse(_DbDailyInfoList[0].water)),
//     ];
//     _userWeight.forEach((item) {
//       var persianDateee = PersianDateTime.fromGregorian(gregorianDateTime: item.date);
//       if(data.length<50) {
//         data.add(
//           new LinearSales(
// //            persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[1]+"/"+  persianDateee.toJalaali(format: 'YYYY-MM-DD').split("-")[2],
//               data.length,
//               double.parse(item.weight)),
//         );
//       }});
//
//     return [
//
//       new charts.Series<LinearSales, int>(
//
//           id: 'Sales',
//           colorFn: (_, __) => charts.Color.fromHex(code: '#E040FB'),
//           domainFn: (LinearSales sales, _) => sales.year,
//           measureFn: (LinearSales sales, _) => sales.sales,
//           data: data,
//           labelAccessorFn: (LinearSales sales, _) =>
//           '${sales.sales.toString()}')
// //    labelAccessorFn: (OrdinalSales sales, _) =>
// //    sales.sales.toString()
//
//     ];
//   }
//
//   _getDailyInfo2({bool refresh: false}) async {
//
//     if (refresh = true) {}
//     setState(() {
//       _isLoading=true;
//       _DbDailyInfoList = [];
//       _userWeight = [];
//       _water = [];
//       _actCalory = [];
//       _allWeight = [];
//
//     });
//
//     if ((dateTime1.isBefore(dateTime2) ) || (dateTime1.compareTo(dateTime2) == 0 )) {
//       print("in method");
//       for(int i=0;i<=dateTime2.difference(dateTime1).inDays;i++){
//         DateTime date = new DateTime(dateTime1.year, dateTime1.month, dateTime1.day + i,);
//         date=DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//         var datee= intl.DateFormat('yyyy-MM-dd').format((date));
//         print(datee+"23d");
//         Map <String , dynamic>map={
//           'date':datee.toString()
//         };
//
//         DbDailyInfo dbinfo=await _getDailyInfo(datee);
//         setState(()  {
//           if(dbinfo!=null){
//             _DbDailyInfoList.add(dbinfo);
//           }
//           else{ _DbDailyInfoList.add( DbDailyInfo.fromJson(map));}
//         });
//
//       }
//
//       double weight=0;
//       for(int i=0;i<=dateTime2.difference(dateTime1).inDays;i++){
//
//         DateTime date = new DateTime(dateTime1.year, dateTime1.month, dateTime1.day + i,);
//         date=DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//         var datee= intl.DateFormat('yyyy-MM-dd').format((date));
//
//         print(datee+"23d");
//         UserWeight userWeight=await getUWeight2(datee);
//         setState(() {
//           if(userWeight!=null){
//             _userWeight.add(userWeight);
//             weight=double.parse(userWeight.weight);
//           }
// //          else{ _userWeight.add(UserWeight.fromJson(map));}
//
//
//         });
//
//       }
//
//       print("dfdfdfdfdfdfdf");
//       print(_userWeight.length.toString());
//
//       if(_userWeight.length==0){
//
//         for(int i=0;i<=dateTime2.difference(dateTime1).inDays;i++){
//
//           DateTime date = new DateTime(dateTime1.year, dateTime1.month, dateTime1.day + i,);
//           date=DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(date));
//           var datee= intl.DateFormat('yyyy-MM-dd').format((date));
//
//           print("Dddddddddddddddddddddddd");
//         Map <String , dynamic>map={
//           'date':datee.toString(),
//           'weight':weight.toString()
//         };
//         _userWeight.add(UserWeight.fromJson(map));}}
//       setState(() {
//         _userWeight32=_userWeight;
//         _isLoading=false;
//       });
//
//
//     }}
//
//   Future _getDailyInfo(String gregorianDate) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var db = new DailyInfoProvider();
//     await db.open();
//     DbDailyInfo products = await db.getByDate(gregorianDate);
// //    await db.close();
//     return products;
//   }
//
//
//   Future<UserWeight> getUWeight2(String date) async {
//     UserWeight userweight;
//     try {
//       var db = new userWeightProvider();
//       await db.open();
//       userweight = await db.getByDate( date, "weight");
// //      await db.close();
//       return userweight;
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//
//
// }
//
// class OrdinalSales {
//   final String year;
//   final double sales;
//
//   OrdinalSales(this.year, this.sales);
// }
// class LinearSales {
//   final int year;
//   final double sales;
//
//   LinearSales(this.year, this.sales);
// }
//
