// import 'dart:convert';
// import 'dart:ui';
// import 'package:barika_web/bottomMenu/waterDialog.dart';
// import 'package:barika_web/home/rizmoghazi.dart';
// import 'package:barika_web/menu/deletegDialog.dart';
// import 'package:barika_web/models/DbActivities.dart';
// import 'package:barika_web/models/DbDailyInfo.dart';
// import 'package:barika_web/models/DbDailyType.dart';
// import 'package:barika_web/models/DbFood.dart';
// import 'package:barika_web/models/user.dart';
// import 'package:barika_web/utils/MyDadaPicker.dart';
// import 'package:barika_web/utils/SizeConfig.dart';
// import 'package:barika_web/utils/colors.dart';
// import 'package:barika_web/utils/date.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gradient_progress/gradient_progress.dart';
// import 'package:persian_datepicker/persian_datetime.dart';
// import 'package:persian_datepicker/persian_datepicker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tutorial_coach_mark/animated_focus_light.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
// import '../helper.dart';
//
// class dailyInfo extends StatefulWidget {
//   final date;
//   @override
//   dailyInfo({Key key,this.date}) : super(key: key);
//
//
//   State<StatefulWidget> createState() => dailyInfoState();
// }
//
// class dailyInfoState extends State<dailyInfo> {
//   RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
//   User _user ;
//   List<DbDailyType>_breakFast=[];
//   List<String>_breakFastUnit=[];
//   List<double>_breakFastValue=[0,0,0,0];
//   List<DbDailyType>_lunch=[];
//   List<String>_lunchUnit=[];
//   List<double>_lunchValue=[0,0,0,0];
//   List<DbDailyType>_dinner=[];
//   List<String>_dinnerUnit=[];
//   List<double>_dinnerValue=[0,0,0,0];
//   List<DbDailyType>_break=[];
//   List<String>_breakUnit=[];
//   List<double>_breakValue=[0,0,0,0];
//   List<DbDailyType>_act=[];
//   DbDailyInfo dailyInfo;
//   double _totalFoodCal=0;
//   double _totalCal=0;
//   double _totalActCal=0;
//   double _totalActshow=0;
//   double _totalfoodshow=0;
//   String water="0";
//   PersianDateTime persianDate1 ;
//   PersianDateTime persianDate2 ;
//   int _totlaCal=240000;
//   String gregorianDate="";
//   Color textColor = Color(0xff555555);
//   // List<allRecipes> _allRecipes = [];
//   int _counter = 0;
//   List<bool> arrayDaysEnable = [false, false, false, false, false, false, false];
//   List<PersianDateTime> arrayDays = [PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian(),PersianDateTime.fromGregorian()];
//   List<String> arrayDaysName = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه',];
//   final TextEditingController textEditingController = TextEditingController();
//   String _selecteddate;
//   PersianDatePickerWidget persianDatePicker;
//   int arrayIndex;
//
//
//   List<TargetFocus> targets = List();
//   GlobalKey keyButton1 = GlobalKey();
//   void initState() {
//
//
//     persianDate1 =widget.date?? PersianDateTime.fromGregorian(gregorianDateTime: dateCall.getDate());// default is now
//     persianDate2 =  PersianDateTime(jalaaliDateTime: _selecteddate);
//     gregorianDate= persianDate1.toGregorian(format: 'YYYY-MM-DD');
//     _getUser();
//     _getDailyInfo();
//     calculateDays();
//     initTargets();
//     WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//     super.initState();
//   }
//
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
//     return WillPopScope(child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: MyColors.green,
//           centerTitle: true,
//           actions: <Widget>[
//             Padding(padding: EdgeInsets.only(top: 4),child:     IconButton(
//               icon: Icon(
//                 Icons.chevron_right,
//                 size: 32*(screenSize.width)/375,
//                 textDirection: TextDirection.rtl,
//               ),
//               onPressed: () {
//                 Navigator.pop(context, persianDate1);
//               },
//               alignment: Alignment.topLeft,
//               color: Colors.white,
//               splashColor: Colors.amber,
//               padding: EdgeInsets.all(7),
//             )),
//           ],
//           automaticallyImplyLeading: false,
//           title: Text("گزارش روزانه",style: TextStyle(
//               color: Colors.white,
//               fontSize:16*fontvar,
//               fontWeight:FontWeight.w700
//           ),),
//         ),
//         body:  CustomScrollView(slivers: <Widget>[
//           SliverList(
//               delegate: SliverChildListDelegate(<Widget>[
//
//                 Card(
//                   margin: EdgeInsets.only(right: 14, left: 14, top: 30, bottom: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.white,
//                   elevation: 11,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Text(
//                               persianDate1.jalaaliMonthName,
//                               style: TextStyle(
//                                 color: Color(0xff242424),
//                                 fontSize: 10*fontvar,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: "iransansDN",
//                               ),
//                             ),
//
//                             GestureDetector(
//                               onTap: (){
//                                 MyDatePicker.showDatePicker(
//                                   context,
//
//                                   onConfirm: (int year,int month,int day) async {
//                                     print(year);
//                                     print(month);
//                                     print(day);
//                                     String datenew=year.toString()+"/"+month.toString()+"/"+day.toString();
//                                     var datenew2 = PersianDateTime(jalaaliDateTime:datenew);
//                                     PersianDateTime datenow = PersianDateTime();
//
//                                     if((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0))
//                                     {
//                                       print(datenow);
//                                       print("efefe");
//                                       print((datenew2.isBefore(datenow)));
//                                       setState(() {
//
//
//                                       _selecteddate = datenew;
//                                       print(_selecteddate);
//                                       persianDate1 =  PersianDateTime(jalaaliDateTime: _selecteddate);
//                                       gregorianDate= persianDate1.toGregorian(format: 'YYYY-MM-DD');
//                                       dateCall.saveDate(persianDate1);
//                                       print(gregorianDate+"ll"+getDateToday());
//                                       });
//                                       calculateDays();
//                                       await _getDailyInfo();
//                                       dateCall.saveDate(persianDate1);
//                                     }
//                                     else{
//
//                                       Fluttertoast.showToast(
//                                         msg: "امکان انتخاب این تاریخ وجود ندارد.",
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.CENTER,
//                                         timeInSecForIosWeb: 1,
//                                         backgroundColor: Colors.red,
//                                         textColor: Colors.white,
//
//                                         fontSize: 16.0*fontvar,
//                                       );
//                                     }
//                                   },
//
//
//                                   minYear: 1300,
//
//                                   maxYear: 1450,
//                                   confirm: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(Radius.circular(6)),
//                                         color: Colors.green
//                                     ),
//                                     child: Text(
//                                       'تایید',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18*fontvar,
//                                           fontFamily: "iransansDN",
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   cancel:Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(Radius.circular(6)),
//                                           color: Colors.red
//                                       ),
//                                       child: Text(
//                                         ' لغو ',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 18*fontvar,
//                                             fontFamily: "iransansDN",
//                                             fontWeight: FontWeight.w400),
//                                       )),
//
//                                 );
//                               },
//
//                               child:    Image.network(
//                                 'assets/icons/calendar.svg',
//                                 width: (screenSize.width - 85) / 8,
//                                 height: (screenSize.width - 85) / 8,
//                                 color: Color(0xff6DC07B),
//                               ),
//                             ),
//
//
//                           ],
//                         ),
//                         showDays(arrayDays[0], 0),
//                         showDays(arrayDays[1], 1),
//                         showDays(arrayDays[2], 2),
//                         showDays(arrayDays[3], 3),
//                         showDays(arrayDays[4], 4),
//                         showDays(arrayDays[5], 5),
//                         showDays(arrayDays[6], 6)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Card(
//                     margin: EdgeInsets.only(right: 14, left: 14, top: 3),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     color: Colors.white,
//                     elevation: 11,child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 7),
//
//                   child: Row(
//                     textDirection: TextDirection.ltr,
//                     crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.center,
//                         children: <Widget>[
// //                                        Text(
// //                                          '1550',
// //                                          style: TextStyle(
// //                                              color: textColor,
// //                                              fontSize: 15,
// //                                              fontWeight: FontWeight.w400),
// //                                        ),
//                           _user != null
//                               ? _user.calorie == null
//                               ? Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: 5, top: 2),
//                             child: Icon(
//                               Icons.all_inclusive,
//                               size: 26*(screenSize.width/375),
//                             ),
//                           )
//                               : Text(
//                             _user.calorie
//                                 .toStringAsFixed(0),
//                             textDirection:
//                             TextDirection.ltr,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18*fontvar,
//                                 fontFamily:
//                                 "iransansDN",
//                                 fontWeight:
//                                 FontWeight.w400),
//                           )
//                               : Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: 5, top: 2),
//                             child: Icon(
//                               Icons.all_inclusive,
//                               size: 26*(screenSize.width/375),
//                             ),
//                           ),
//                           Text(
//                             'کالری مجاز',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               right: 5, left: 5, top: 7*(screenSize.width/375)),
//                           child: Icon(
//                             Icons.remove,
//                             size: 20*(screenSize.width/375),
//                           )),
//                       Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             (_totalActshow+_totalCal).toStringAsFixed(0),
//                             textDirection: TextDirection.ltr,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           Text(
//                             '   غذا   ',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               right: 5, left: 5, top: 7*(screenSize.width/375)),
//                           child: Icon(
//                             Icons.add,
//                             size: 20*(screenSize.width/375),
//                           )),
//                       Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             (_totalActshow).toStringAsFixed(0),
//                             textDirection: TextDirection.ltr,
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           Text(
//                             '  فعالیت  ',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                           padding: EdgeInsets.only(
//                               right: 5, left: 5, top: 7*(screenSize.width/375)),
//                           child: Icon(
//                             Icons.drag_handle,
//                           size: 20*(screenSize.width/375),
//                           )),
//                       Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.center,
//                         children: <Widget>[
// //                                        Text(
// //                                          '155',
// //                                          style: TextStyle(
// //                                              color: textColor,
// //                                              fontSize: 15,
// //                                              fontWeight: FontWeight.w400),
// //                                        ),
//                           _user != null
//                               ? _user.calorie == null
//                               ? Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: 5, top: 2),
//                             child: Icon(
//                               Icons.all_inclusive,
//                                 size: 26*(screenSize.width/375),
//                             ),
//                           )
//                               : Text(
//                               ((_user.calorie -
//                                   _totalCal)
//                                   .toStringAsFixed(0)),
//                               textDirection:
//                               TextDirection.ltr,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18*fontvar,
//                                   fontFamily:
//                                   "iransansDN",
//                                   fontWeight:
//                                   FontWeight.w400))
//                               : Text(("0"),
//                               textDirection:
//                               TextDirection.ltr,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18*fontvar,
//                                   fontFamily: "iransansDN",
//                                   fontWeight:
//                                   FontWeight.w400)),
//                           Text(
//                             'باقی مانده',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12*fontvar,
//                                 fontFamily: "iransansDN",
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//                 Container(
//                   margin: EdgeInsets.only(top: 15,right: 5,left: 4),
//                   color: Colors.white,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Progressbar(dailyInfo==null? "0":dailyInfo.total_protein, 'پروتئین'),
//                       Progressbar(dailyInfo==null? "0":dailyInfo.total_fat, 'چربی'),
//                       Progressbar(dailyInfo==null? "0":dailyInfo.total_carb, 'کربوهیدرات'),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: ((screenSize.width - 55) / 2) * (127 / 160),
//                   margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 17),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                           child:    Container(
//                             height: ((screenSize.width - 55) / 2) * (127 / 160),
//                             margin: EdgeInsets.symmetric(horizontal: 7.5),
//                             child: RaisedButton(
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.circular(10),
//                                 ),
//                                 padding:
//                                 EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                                 color: Color(0xff23AEF1),
//                                 onPressed: () async {
//                         String returnvsl = await showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return Padding(
//                                                 padding: EdgeInsets.all(0),
//                                                 child: Dialog(
//                                                     elevation: 15,
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                       BorderRadius.circular(10),
//                                                     ),
//                                                     backgroundColor: Colors.transparent,
//                                                     child: waterDialog()));
//                                           });
//                                       print(returnvsl);
//                                       if (returnvsl == "yes") {
//
//                                           await getmain2();
//
//                                       }
//                                 },
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Image.network(
//                                       'assets/icons/water.svg',
//                                       width: 40 /
//                                           114 *
//                                           ((screenSize.width - 55) / 2) *
//                                           (127 / 160),
//                                       height: 40 /
//                                           114 *
//                                           ((screenSize.width - 55) / 2) *
//                                           (127 / 160),
//                                       color: Colors.white,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         top: 8,
//                                       ),
//                                       child: Text(
//                                         dailyInfo == null
//                                             ? "0" + ' لیوان آب'
//                                             : water + ' لیوان آب',
//                                         textDirection: TextDirection.rtl,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 16*fontvar),
//                                       ),
//                                     )
//                                   ],
//                                 )),
//                           )),
//                       Expanded(
//                           child: Container(
//                             key: keyButton1,
//                             height: ((screenSize.width - 55) / 2) * (127 / 160),
//                             margin: EdgeInsets.symmetric(horizontal: 7.5),
//                             child: RaisedButton(
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.circular(10),
//                                 ),
//                                 padding:
//                                 EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                                 color: Color(0xffF15A23),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Directionality(
//                                           textDirection: TextDirection.rtl,
//                                           child: rizMoghazi(
//                                             riz: riz(calculateAge(_user.birthdate),
//                                                 _user.gender, _user.birthdate),
//                                             calorie: _user.calorie,
//                                           )),
//                                     ),
//                                   );
//                                 },
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Image.network(
//                                       'assets/icons/rizmoghazi.svg',
//                                       width: 40 /
//                                           114 *
//                                           ((screenSize.width - 55) / 2) *
//                                           (127 / 160),
//                                       height: 40 /
//                                           114 *
//                                           ((screenSize.width - 55) / 2) *
//                                           (127 / 160),
//                                       color: Colors.white,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         top: 8,
//                                       ),
//                                       child: Text(
//                                         'وضعیت ویتامین ها و مواد معدنی',
//                                         textDirection: TextDirection.rtl,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 15*fontvar),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     )
//                                   ],
//                                 )),
//                           )),
//                     ],
//                   ),
//                 ),
//                 Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                 elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child:Column(
//                       children: <Widget>[
//
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: screenSize.width*(86/375), margin: EdgeInsets.only(bottom: 10),
//                             decoration: BoxDecoration(
//                               color:Color(0xffEF6844),
//                               borderRadius:  BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(10)),
//                             ),
//                             alignment: Alignment.centerRight,
//                             child:
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: screenSize.width * (62 / 375) - 6,
//                                           height: screenSize.width * (62 / 375) - 6,
//                                           child: Image.network('assets/icons/bfDaily.svg',
//
//                                             width: screenSize.width * (62 / 375) - 6,
//                                             height: screenSize.width * (62 / 375) - 6,),
//                                         ),
//                                         Padding(padding: EdgeInsets.only(right: 5),child: Text(
//                                           'صبحانه',
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                         ),)
//                                       ],
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(left: 5),
//                                         child: Text(
//                                           _breakFastValue[0].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")+ " کالری",style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 17*fontvar,
//                                         ),
//                                         ))
//                                   ],
//                                 ),
//                                 Container(
//                                   width:MediaQuery.of(context).size.width ,
//                                   height: 1,
//                                   color:Color(0xffF2F2F2),
//                                   // thickness: 10,
//                                 ),
//                                 Expanded(
//                                   child:  Container(
//                                     alignment: Alignment.center,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakFastValue[1].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم پروتئین",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakFastValue[2].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم چربی",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),   Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakFastValue[3].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم کربوهیدرات",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//
//                         ),
//                         Column(
//                           children: makeTypeList(_breakFast,_breakFastUnit),
//                         ),
//
//               Container(
//                 margin: EdgeInsets.only(left:8 ,bottom: 12),
//                 child:           Align(
//                   alignment: Alignment.bottomLeft,
//                   child:SizedBox(
//                     width: screenSize.width*(120/375),
//                     height: 35.0,
//                     child: RaisedButton(
//                       onPressed: () async {
//                         // String returnVal = await Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodScreen(vade: 0,)),
//                         //   ),
//                         // );
//                         //
//                         // if (returnVal == 'yes') {
//                         //   await _getDailyInfo(refresh:  true);
//                         //
//                         // }
//
//                       },
//
//                       textColor: Colors.white,
//                       disabledTextColor: Colors.white,
//                       disabledColor: MyColors.btmGray,
//
//                       shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.all(Radius.circular(10)),
//
//                       ),
//                       child: Center(
//                         child: Text(
//                           'افزودن صبحانه',
//                           style: TextStyle(fontSize: 11*fontvar,fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       color:Color(0xff6DC07B),
//                     ),
//                   ),
//                 ),
//               )
//
//
//
//
//
//                       ],
//                     )
//                 ),
//                 Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child:Column(
//                       children: <Widget>[
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: screenSize.width*(86/375), margin: EdgeInsets.only(bottom: 10),
//                             decoration: BoxDecoration(
//                               color:Color(0xffEF6844),
//                               borderRadius:  BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(10)),
//                             ),
//                             alignment: Alignment.centerRight,
//                             child:
//                            Column(
//                              children: [
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: [
//                                        SizedBox(
//                                          width: screenSize.width * (62 / 375) - 6,
//                                          height: screenSize.width * (62 / 375) - 6,
//                                          child: Image.asset('assets/images/lunch.png',
//
//                                            width: screenSize.width * (62 / 375) - 6,
//                                            height: screenSize.width * (62 / 375) - 6,),
//                                        ),
//                                        Padding(padding: EdgeInsets.only(right: 5),child: Text(
//                                          'ناهار',
//                                          textAlign: TextAlign.right,
//                                          textDirection: TextDirection.rtl,
//                                          style: TextStyle(
//                                              color: Colors.white,
//                                              fontSize: 16*fontvar,
//                                              fontWeight: FontWeight.w500),
//                                        ),)
//                                      ],
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 5),
//                                        child: Text(
//                                          _lunchValue[0].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")+  " کالری",style: TextStyle(
//                                      color: Colors.white,
//                                      fontSize: 17*fontvar,
//                                    ),
//                                    ))
//                                  ],
//                                ),
//                                Container(
//                                  width:MediaQuery.of(context).size.width ,
//                                  height: 1,
//                                  color:Color(0xffF2F2F2),
//                                  // thickness: 10,
//                                ),
//                               Expanded(
//                                 child:  Container(
//                                   alignment: Alignment.center,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                           flex: 1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Text(_lunchValue[1].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:16*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//                                               Text(" گرم پروتئین",style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:12*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//
//                                             ],
//                                           )
//                                       ),
//                                       Container(
//                                         width: 1,
//                                         height:  screenSize.width*(16/375),
//                                         color: Colors.white,
//                                       ),
//                                       Expanded(
//                                           flex: 1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Text(_lunchValue[2].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:16*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//                                               Text(" گرم چربی",style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:12*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//
//                                             ],
//                                           )
//                                       ),
//                                       Container(
//                                         width: 1,
//                                         height:  screenSize.width*(16/375),
//                                         color: Colors.white,
//                                       ),   Expanded(
//                                           flex: 1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             children: [
//                                               Text(_lunchValue[3].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:16*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//                                               Text(" گرم کربوهیدرات",style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize:12*fontvar ,
//                                                   fontWeight:FontWeight.w400
//
//                                               ),),
//
//                                             ],
//                                           )
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               )
//                              ],
//                            )
//
//                         ),
//                         Column(
//                           children: makeTypeList(_lunch,_lunchUnit),
//                         ),
//         Container(
//           margin: EdgeInsets.only(left:8 ,bottom: 12),
//           child:     Align(
//                           alignment: Alignment.bottomLeft,
//                           child:SizedBox(
//                             width: screenSize.width*(120/375),
//                             height: 35.0,
//                             child: RaisedButton(
//                               onPressed: () async {
//                                 // String returnVal = await Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodScreen(vade: 1,)),
//                                 //   ),
//                                 // );
//                                 //
//                                 // if (returnVal == 'yes') {
//                                 //   await _getDailyInfo(refresh:  true);
//                                 //
//                                 // }
//
//                               },
//
//                               textColor: Colors.white,
//                               disabledTextColor: Colors.white,
//                               disabledColor: MyColors.btmGray,
//
//                               shape: new RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.all(Radius.circular(10)),
//
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'افزودن ناهار',
//                                   style: TextStyle(fontSize: 11*fontvar,fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               color:Color(0xff6DC07B),
//                             ),
//                           ),
//               ) )
//
//
//
//                       ],
//                     )
//                 ),
//                 Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child:Column(
//                       children: <Widget>[
//
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: screenSize.width*(86/375), margin: EdgeInsets.only(bottom: 10),
//                             decoration: BoxDecoration(
//                               color:Color(0xffEF6844),
//                               borderRadius:  BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(10)),
//                             ),
//                             alignment: Alignment.centerRight,
//                             child:
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: screenSize.width * (62 / 375) - 6,
//                                           height: screenSize.width * (62 / 375) - 6,
//                                           child:  Image.asset('assets/images/dinner.png',width: screenSize.width*(62/375)-6,height: screenSize.width*(62/375)-6,),
//                                         ),
//                                         Padding(padding: EdgeInsets.only(right: 5),child: Text(
//                                           'شام',
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                         ),)
//                                       ],
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(left: 5),
//                                         child: Text(
//                                           _dinnerValue[0].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "") + " کالری",style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 17*fontvar,
//                                         ),
//                                         ))
//                                   ],
//                                 ),
//                                 Container(
//                                   width:MediaQuery.of(context).size.width ,
//                                   height: 1,
//                                   color:Color(0xffF2F2F2),
//                                   // thickness: 10,
//                                 ),
//                                 Expanded(
//                                   child:  Container(
//                                     alignment: Alignment.center,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(_dinnerValue[1].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم پروتئین",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(_dinnerValue[2].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم چربی",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),   Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(_dinnerValue[3].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم کربوهیدرات",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//
//                         ),
//                         Column(
//                           children: makeTypeList(_dinner,_dinnerUnit),
//                         ),
//                         Container(
//                             margin: EdgeInsets.only(left:8 ,bottom: 12),
//                             child:
//                             Align(
//                           alignment: Alignment.bottomLeft,
//                           child:SizedBox(
//                             width: screenSize.width*(120/375),
//                             height: 35.0,
//                             child: RaisedButton(
//                               onPressed: () async {
//                                 // String returnVal = await Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodScreen(vade: 2,)),
//                                 //   ),
//                                 // );
//                                 //
//                                 // if (returnVal == 'yes') {
//                                 //   await _getDailyInfo(refresh:  true);
//                                 //
//                                 // }
//
//                               },
//
//                               textColor: Colors.white,
//                               disabledTextColor: Colors.white,
//                               disabledColor: MyColors.btmGray,
//
//                               shape: new RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.all(Radius.circular(10)),
//
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'افزودن شام',
//                                   style: TextStyle(fontSize: 11*fontvar,fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               color:Color(0xff6DC07B),
//                             ),
//                           ),
//                         ))
//
//
//
//                       ],
//                     )
//                 ),
//                 Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child:Column(
//                       children: <Widget>[
//
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: screenSize.width*(86/375), margin: EdgeInsets.only(bottom: 10),
//                             decoration: BoxDecoration(
//                               color:Color(0xffEF6844),
//                               borderRadius:  BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(10)),
//                             ),
//                             alignment: Alignment.centerRight,
//                             child:
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: screenSize.width * (62 / 375) - 6,
//                                           height: screenSize.width * (62 / 375) - 6,
//                                           child:  Image.asset('assets/images/break.png',width: screenSize.width*(62/375)-6,height: screenSize.width*(62/375)-6,),
//                                         ),
//                                         Padding(padding: EdgeInsets.only(right: 5),child: Text(
//                                           'میان وعده',
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                         ),)
//                                       ],
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(left: 5),
//                                         child: Text(
//                                           _breakValue[0].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "") + " کالری",style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 17*fontvar,
//                                         ),
//                                         ))
//                                   ],
//                                 ),
//                                 Container(
//                                   width:MediaQuery.of(context).size.width ,
//                                   height: 1,
//                                   color:Color(0xffF2F2F2),
//                                   // thickness: 10,
//                                 ),
//                                 Expanded(
//                                   child:  Container(
//                                     alignment: Alignment.center,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakValue[1].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم پروتئین",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),
//                                         Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakValue[2].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم چربی",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//                                         Container(
//                                           width: 1,
//                                           height:  screenSize.width*(16/375),
//                                           color: Colors.white,
//                                         ),   Expanded(
//                                             flex: 1,
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Text( _breakValue[3].toStringAsFixed(1).replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:16*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//                                                 Text(" گرم کربوهیدرات",style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize:12*fontvar ,
//                                                     fontWeight:FontWeight.w400
//
//                                                 ),),
//
//                                               ],
//                                             )
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//
//                         ),
//                         Column(
//                           children: makeTypeList(_break,_breakUnit),
//                         ),
//         Container(
//           margin: EdgeInsets.only(left:8 ,bottom: 12),
//           child:    Align(
//                           alignment: Alignment.bottomLeft,
//                           child:SizedBox(
//                             width: screenSize.width*(120/375),
//                             height: 35.0,
//                             child: RaisedButton(
//                               onPressed: () async {
//                                 // String returnVal = await Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:foodScreen(vade: 3,)),
//                                 //   ),
//                                 // );
//                                 //
//                                 // if (returnVal == 'yes') {
//                                 //   await _getDailyInfo(refresh:  true);
//                                 //
//                                 // }
//
//                               },
//
//                               textColor: Colors.white,
//                               disabledTextColor: Colors.white,
//                               disabledColor: MyColors.btmGray,
//
//                               shape: new RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.all(Radius.circular(10)),
//
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'افزودن میان وعده',
//                                   style: TextStyle(fontSize: 11*fontvar,fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               color:Color(0xff6DC07B),
//                             ),
//                           ),
//                         ))
//
//
//
//                       ],
//                     )
//                 ),
//                 Card(
//                     margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child:Column(
//                       children: <Widget>[
//
//                         Container(
//                             margin: EdgeInsets.only(bottom: 5),
//                             width: MediaQuery.of(context).size.width,
//                             height: screenSize.width*(60/375),
//                             decoration: BoxDecoration(
//                               color:Color(0xffEF6844),
//                               borderRadius:  BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(10)),
//                             ),
//                             alignment: Alignment.centerRight,
//                             child:
//                             // Column(
//                             //   children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.only(right: 5),
//                                           width: screenSize.width * (62 / 375) - 6,
//                                           height: screenSize.width * (62 / 375) - 6,
//                                           child:  Image.network(
//                                             'assets/icons/sportD.svg',
//                                             width: screenSize.width * (62 / 375) - 6,
//                                             height: screenSize.width * (62 / 375) -
//                                                 6,),
//                                         ),
//                                         Padding(padding: EdgeInsets.only(right: 5),child: Text(
//                                           'ورزش',
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                         ),)
//                                       ],
//                                     ),
//                                     Padding(
//                                         padding: EdgeInsets.only(left: 5),
//                                         child: Text(
//                                           (_totalActshow).toStringAsFixed(0)+  " کالری",style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 17*fontvar,
//                                         ),
//                                         ))
//                                   ],
//                                 ),
//                                 // Container(
//                                 //   width:MediaQuery.of(context).size.width ,
//                                 //   height: 1,
//                                 //   color:Color(0xffF2F2F2),
//                                 //   // thickness: 10,
//                                 // ),
//                                 // Expanded(
//                                 //   child:  Container(
//                                 //     alignment: Alignment.center,
//                                 //     child: Row(
//                                 //       mainAxisAlignment: MainAxisAlignment.center,
//                                 //       crossAxisAlignment: CrossAxisAlignment.center,
//                                 //       children: [
//                                 //         Expanded(
//                                 //             flex: 1,
//                                 //             child: Row(
//                                 //               mainAxisAlignment: MainAxisAlignment.center,
//                                 //               crossAxisAlignment: CrossAxisAlignment.center,
//                                 //               children: [
//                                 //                 Text("50",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:16*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //                 Text(" گرم پروتئین",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:12*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //
//                                 //               ],
//                                 //             )
//                                 //         ),
//                                 //         Container(
//                                 //           width: 1,
//                                 //           height:  screenSize.width*(16/375),
//                                 //           color: Colors.white,
//                                 //         ),
//                                 //         Expanded(
//                                 //             flex: 1,
//                                 //             child: Row(
//                                 //               mainAxisAlignment: MainAxisAlignment.center,
//                                 //               crossAxisAlignment: CrossAxisAlignment.center,
//                                 //               children: [
//                                 //                 Text("50",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:16*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //                 Text(" گرم چربی",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:12*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //
//                                 //               ],
//                                 //             )
//                                 //         ),
//                                 //         Container(
//                                 //           width: 1,
//                                 //           height:  screenSize.width*(16/375),
//                                 //           color: Colors.white,
//                                 //         ),   Expanded(
//                                 //             flex: 1,
//                                 //             child: Row(
//                                 //               mainAxisAlignment: MainAxisAlignment.center,
//                                 //               crossAxisAlignment: CrossAxisAlignment.center,
//                                 //               children: [
//                                 //                 Text("50",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:16*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //                 Text(" گرم کربوهیدرات",style: TextStyle(
//                                 //                     color: Colors.white,
//                                 //                     fontSize:12*fontvar ,
//                                 //                     fontWeight:FontWeight.w400
//                                 //
//                                 //                 ),),
//                                 //
//                                 //               ],
//                                 //             )
//                                 //         ),
//                                 //
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // )
//                             //   ],
//                             // )
//
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment:MainAxisAlignment.start ,
//                           children: makeTypeList(_act,[]),
//                         ),
//         Container(
//           margin: EdgeInsets.only(left:8 ,bottom: 12),
//           child:  Align(
//                           alignment: Alignment.bottomLeft,
//                           child:SizedBox(
//                             width: screenSize.width*(120/375),
//                             height: 35.0,
//                             child: RaisedButton(
//                               onPressed:() async {
//
//                                 // String returnVal = await Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => Directionality(textDirection: TextDirection.rtl, child:sportscreen()),
//                                 //   ),
//                                 // );
//                                 //
//                                 // if (returnVal == 'yes') {
//                                 //   await _getDailyInfo(refresh:  true);
//                                 //
//                                 // }
//                               },
//
//                               textColor: Colors.white,
//                               disabledTextColor: Colors.white,
//                               disabledColor: MyColors.btmGray,
//
//                               shape: new RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.all(Radius.circular(10)),
//
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'افزودن ورزش',
//                                   style: TextStyle(fontSize: 11*fontvar,fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               color:Color(0xff6DC07B),
//                             ),
//                           ),
//                         ))
//
//
//                       ],
//                     )
//
//                 )
//
//
//               ]))
//         ])),
//         onWillPop: (){ Navigator.pop(context, persianDate1);}
//
//     );
//   }
//
//   Widget Progressbar(String amount, String name) {
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     double value = double.parse(amount);
//     String amountText = amount + " گرم ";
//     Color colorP;
//
//     int cal =1;
//
//     if(_user!=null&&dailyInfo!=null){
//       if(_user.calorie!=null)
//         cal=_user.calorie+double.parse(dailyInfo.total_act??"0").round();
//       else cal=_totlaCal+double.parse(dailyInfo.total_act??"0").round();
//     }
//     else cal=24000;
//
//     // Map rizMap = {"protein": 1};
//     // if (_user != null)
//       // rizMap = getRiz(int.parse(
//       //     riz(calculateAge(_user.birthdate), _user.gender, _user.birthdate)));
//     if (name == "پروتئین") {
//       value = value / double.parse(
//           double.parse((.17 * cal / 4).toString()).toStringAsFixed(1));
//       colorP = Color(0xffEF6844);
//     }
//     if (name == "چربی") {
//       value = value /
//           double.parse(
//               double.parse((.28 * cal / 9).toString()).toStringAsFixed(1));
//       colorP = Color(0xffFBD026);
//     }
//     if (name == "کربوهیدرات") {
//       value = value /
//           double.parse(
//               double.parse((.55 * cal / 4).toString()).toStringAsFixed(1));
//
//       colorP = Color(0xff44BCEF);
//     }
//
//     return Expanded(
//         child: Card(
//             elevation: 11,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             margin: EdgeInsets.only( right: 10, left: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(right: 2, left: 2, top: 7),
//                   child: Text(
//                     name,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14*fontvar,
//                         fontFamily: "iransansDN",
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 2, left: 2, bottom: 12),
//                   child: Text(
//                     amountText,
//                     textDirection: TextDirection.rtl,
//                     style: TextStyle(
//                         color: Color(0xff818181),
//                         fontSize: 12*fontvar,
//                         fontFamily: "iransansDN",
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.only(bottom: 5),
//                   child:  Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       GradientCircularProgressIndicator(
//                         gradientColors: [colorP, colorP],
//                         radius: (screenSize.width - 158) / 6,
//                         strokeWidth: (screenSize.width - 158) / 6 * (8 / 36),
//                         value: value,
//                         backgroundColor: Color(0xffDEE6EE),
//                         strokeRound: true,
//                       ),
//                       Center(
//                         child: Text(
//                           (value * 100).toStringAsFixed(1) + "%",
//                           style: TextStyle(
//                             fontSize: 14.0*fontvar,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: "iransansDN",
//                           ),
//                         ),
//                       )
//                     ],
//                   ),)
//               ],
//             )));
//   }
//
//   List<Widget> makeTypeList(List<DbDailyType> TypeList,List<String> units) {
//
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     double sizee= (screenSize.width*(62/375))*(10/31);
//
//     List<Widget> list = List<Widget>();
//     for (int i = 0; i < TypeList.length; i++) {
//       String Jsonfoodname;
//       DbFood Jsonfood;
//       DbActivities Jsonact;
//       if(TypeList[i].name.contains("name_fa")){
//         if(TypeList[i].name.contains("met")){
//           Jsonact=   DbActivities.fromJson(jsonDecode(TypeList[i].name));
//           Jsonfoodname=Jsonact.name_fa;
//
//         }
//         else{
//           Jsonfood=   DbFood.fromJson(jsonDecode(TypeList[i].name));
//           Jsonfoodname=Jsonfood.name_fa;
//           print("name_fa"+Jsonfood.name_fa);
//         }
//       }
//
//
//       list.add(
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment:MainAxisAlignment.start ,
//             children: <Widget>[
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//
//                   Expanded(
//                     child:  Padding(
//                       padding: EdgeInsets.only(top: 8,right: 8,left: 8),
//                       child:      (TypeList[i].vade=="4")
//                           ?  Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment:MainAxisAlignment.start ,
//                         children: <Widget>[
//                           Text(
//                             Jsonfoodname!=null? Jsonfoodname??'empty':TypeList[i].name??"" ,
//                             textAlign: TextAlign.right,
//                             textDirection: TextDirection.rtl,
//
//                             style: TextStyle(
//                                 color: Color(0xff5c5c5c),
//                                 fontSize: 13*fontvar,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         Text(
//                        '${TypeList[i].total_cal} کالری',
//                        textAlign: TextAlign.right,
//                        textDirection: TextDirection.rtl,
//                        style: TextStyle(
//                            color: Color(0xffA2A2A2),
//                            fontSize: 11*fontvar,
//                            fontWeight: FontWeight.w500),
//                      )])
//                          :Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment:MainAxisAlignment.start ,
//                         children: <Widget>[
//                           Text(
//                             Jsonfoodname!=null? Jsonfoodname??'empty':TypeList[i].name??"" ,
//                             textAlign: TextAlign.right,
//                             textDirection: TextDirection.rtl,
//                             style: TextStyle(
//                                 color: Color(0xff5c5c5c),
//                                 fontSize: 13*fontvar,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                          Text(
//                            units.length==0
//                                ?""
//                                : TypeList[i].amount.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")+ " "+units[i],
//
//                            textAlign: TextAlign.right,
//                            textDirection: TextDirection.rtl,
//                            style: TextStyle(
//                                color: Color(0xffA2A2A2),
//                                fontSize: 11*fontvar,
//                                fontWeight: FontWeight.w500),
//                          ),
//                          SizedBox(
//                            width: 4,
//                          ),
//                          Text(
//                            '${TypeList[i].total_cal.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} کالری',
//                            textAlign: TextAlign.right,
//                            textDirection: TextDirection.rtl,
//                            style: TextStyle(
//                                color: Color(0xffA2A2A2),
//                                fontSize: 11*fontvar,
//                                fontWeight: FontWeight.w500),
//                          )
//
//
//                         ],
//                       ),
//                     ),
//
//                   ),
//
//
//
//                   Expanded(
//                       child:Container(
//                         margin: EdgeInsets.only(top:8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//
//
//                             Padding(padding: EdgeInsets.all(2),child: GestureDetector(
//                                 onTap: () async {
//                                   await  editFood(TypeList[i]);
//                                 },
//                                 child: Container(
//                                   width: sizee+10,height: sizee+10,
//                                   child: Image.network('assets/icons/edit.svg',width:sizee,height: sizee,color: Color(0xff1B9CE4),),
//                                   decoration:BoxDecoration(
//                                     color:Color(0xff24AEFC).withOpacity(0.17),
//                                     borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                   ),
//                                   padding: EdgeInsets.all(5),
//                                 )
//                             ),
//
//                             ),
//
//                             Padding(padding: EdgeInsets.all(2),child: GestureDetector(
//                                 onTap: () async {
//                                   String returnVal = await showDialog(context: context, builder: (BuildContextcontext) {
//                                     return Padding(padding: EdgeInsets.all(0), child: Dialog(elevation: 15, shape:
//                                     RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius
//                                           .circular(
//                                           10),
//                                     ),
//                                         backgroundColor:
//                                         Colors
//                                             .transparent,
//                                         child:
//                                         deletegDialog()));
//                                   });
//                                   if (returnVal == 'yes') {
//
//                                     await deleteFood(TypeList[i]);
//
//                                   }
//                                 },
//                                 child: Container(
//                                   width: sizee+10,height: sizee+10,
//                                   child: Image.network('assets/icons/delete.svg',width: sizee,height: sizee,color: Color(0xffF15A23),),
//                                   decoration:BoxDecoration(
//                                     color:Color(0xffF15A23).withOpacity(0.17),
//                                     borderRadius:  BorderRadius.all(Radius.circular(5)),
//                                   ),
//                                   padding: EdgeInsets.all(5),
//                                 )
//                             ))
//                           ],
//                         ),
//                       ))
//
//
//                 ],
//               ),
//              (i<TypeList.length-1)? Container(
//                margin: EdgeInsets.only(top: 6,bottom: 2),
//                color: Color(0xffD2D2D2),
//                height: 1,
//               ):Container()
//
//
//             ],
//           )
//       );
//
//     }
//
//     return list;
//   }
//
//
//   _getDailyInfo({ bool refresh : false}) async {
// //print(await deleteDailyInfo());
// //
//     if(refresh=true){
//       water="0";
//       _totalCal=0;
//       _totalActCal=0;
//       _totalActshow=0;
//       _totalfoodshow=0;
//       _totalFoodCal=0;
//       _breakFast.clear();
//       _breakFastUnit.clear();
//       _breakFastValue=[0,0,0,0];
//       _lunch.clear();
//       _lunchUnit.clear();
//       _lunchValue=[0,0,0,0];
//       _dinner.clear();
//       _dinnerUnit.clear();
//       _dinnerValue=[0,0,0,0];
//       _break.clear();
//       _breakUnit.clear();
//       _breakValue=[0,0,0,0];
//       _act.clear();
//       dailyInfo=null;
//     }
//     // var db = new DailyInfoProvider();
//     // await db.open();
//     // DbDailyInfo products = await db.getByDate(gregorianDate);
// //    await db.close();
// //     if(!(products==null)){
// //       dailyInfo=products;
// //       _totalCal=double.parse(dailyInfo.total_calorie.toString());
//
//       // if(dailyInfo.total_act!=null)_totalActshow=double.parse(dailyInfo.total_act.toString());
//
//       // else _totalActshow=0;
//       // if (this.mounted) {
//       //   setState(() {
//       //     water =dailyInfo.water ?? '0';
//       //   });
//       // }
//       // print(dailyInfo.toMap());
//       // print(water);
//       // await  _getDailyType(products);
//     // }
//     // else(){};
//
//
//
//
//
//
//   }
//   _searchDailyTypeVade( List<DbDailyType> products) async {
//     double calory,pro,carb,fat;
//     if (this.mounted) {
//     setState(() {
//
//
//       products.forEach((items){
//         if(items.vade=='0') _breakFast.add(items);
//         if(items.vade=='1') _lunch.add(items);
//         if(items.vade=='2') _dinner.add(items);
//         if(items.vade=='3') _break.add(items);
//         if(items.vade=='4') _act.add(items);
//
//       });
//
//       calory=0;pro=0;carb=0;fat=0;
//       _breakFast.forEach((item)  {
//
//         // if(item.unit_id==null)
//         //   _breakFastUnit.add("گرم");
//         // else{
//         //   String str=await unitName(item.unit_id);
//         //   _breakFastUnit.add(str);
//         // }
//
//         calory=calory+double.parse(item.total_cal);
//         pro=pro+double.parse(item.total_protein);
//         fat=fat+double.parse(item.total_fat);
//         carb=carb+double.parse(item.total_carb);
//       });
//       _breakFastValue=[calory,pro,fat,carb];
//
//       calory=0;pro=0;carb=0;fat=0;
//       _lunch.forEach((item)  {
//       //   if(item.unit_id==null)
//       //     _lunchUnit.add("گرم");
//       //   else{
//       //     String str=await unitName(item.unit_id);
//       //     _lunchUnit.add(str);
//       //   }
//         calory=calory+double.parse(item.total_cal);
//         pro=pro+double.parse(item.total_protein);
//         fat=fat+double.parse(item.total_fat);
//         carb=carb+double.parse(item.total_carb);
//       });
//       _lunchValue=[calory,pro,fat,carb];
//
//       calory=0;pro=0;carb=0;fat=0;
//       _dinner.forEach((item)  {
//       //   if(item.unit_id==null)
//       //     _dinnerUnit.add("گرم");
//       //   else{
//       //     String str=await unitName(item.unit_id);
//       //     _dinnerUnit.add(str);
//       //   }
//         calory=calory+double.parse(item.total_cal);
//         pro=pro+double.parse(item.total_protein);
//         fat=fat+double.parse(item.total_fat);
//         carb=carb+double.parse(item.total_carb);
//       });
//       _dinnerValue=[calory,pro,fat,carb];
//
//       calory=0;pro=0;carb=0;fat=0;
//       _break.forEach((item)  {
//         // if(item.unit_id==null)
//         //   _breakUnit.add("گرم");
//         // else{
//         //   String str=await unitName(item.unit_id);
//         //   _breakUnit.add(str);
//         // }
//         calory=calory+double.parse(item.total_cal);
//         pro=pro+double.parse(item.total_protein);
//         fat=fat+double.parse(item.total_fat);
//         carb=carb+double.parse(item.total_carb);
//       });
//       _breakValue=[calory,pro,fat,carb];
//
//
//       competitionCalory(products);
//     });
//
//
//     List <String>bfs=[];
//     List <String>lun=[];
//     List <String>din=[];
//     List <String>brk=[];
//
//     for(int i=0;i<_breakFast.length;i++){
//
//       if(_breakFast[i].unit_id==null)
//         bfs.add("گرم");
//       else{
//         String str=await unitName(_breakFast[i].unit_id);
//         bfs.add(str);
//       }}
// ///////////////////////////////////////////////////////////////////
//     for(int i=0;i<_lunch.length;i++){
//
//       if(_lunch[i].unit_id==null)
//         lun.add("گرم");
//       else{
//         String str=await unitName(_lunch[i].unit_id);
//         lun.add(str);
//       }}
//     //////////////////////////////////////////////////////
//     for(int i=0;i<_dinner.length;i++){
//
//       if(_dinner[i].unit_id==null)
//         din.add("گرم");
//       else{
//         String str=await unitName(_dinner[i].unit_id);
//         din.add(str);
//       }}
//     //////////////////////////////
//     for(int i=0;i<_break.length;i++){
//
//       if(_break[i].unit_id==null)
//         brk.add("گرم");
//       else{
//         String str=await unitName(_break[i].unit_id);
//         brk.add(str);
//       }}
//
//     setState(() {
//       _breakFastUnit=bfs;
//       _lunchUnit=lun;
//       _dinnerUnit=din;
//       _breakUnit=brk;
//     });
//
//
//
//
//
//
//     }}
//   Future _getDailyType(DbDailyInfo product, ) async {
//
//
//     var db = new DailyTypeProvider();
//     await db.open();
//     List<DbDailyType> products = await db.searchbyInfo(product.id);
// //    await db.close();
//
//     print('productttttttfirst${products}');
//     if(products!=null)await _searchDailyTypeVade( products);
//
//   }
//   editFood(DbDailyType dailyType) async {
//
//     print(dailyType.toMap());
//     if(dailyType.food_id!=null){
//
//       DbFood food;
//       if(dailyType.name.contains("name_fa")){
//         food=   DbFood.fromJson(jsonDecode(dailyType.name));
//         print("edit name_fa"+food.name_fa);
//       }else {
//          food = await _getFood(dailyType.food_id);
//       }
//
//       List<DbUnitsPviot> Units =await _getUniits(food.id);
//       print("edit name_fa"+food.toMap().toString());
//       print(Units);
//       String returnVal=  await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Directionality(
//                 textDirection: TextDirection.rtl,
//                 child:editCalory(foods: food,units: Units,dailyType:dailyType,dailyInfo: dailyInfo,))));
// //      String returnVal= await showModalBottomSheet(
// //          context: context,
// //          isScrollControlled: true,
// //          builder: (context) {
// //            return Directionality(textDirection: TextDirection.rtl,
// //                child: editCalory(foods: food,units: Units,dailyType:dailyType,dailyInfo: dailyInfo,));
// //          });
//
//       returnVal=='yes'?await _getDailyInfo(refresh: true):(){};
//     }
//
//     else if(dailyType.myfood_id!=null){
//       DbMyFood myfood= await _getMyFood(dailyType.myfood_id);
//       print('reeeeeeed${myfood.toMap()}');
//
//       String returnVal=  await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Directionality(
//                   textDirection: TextDirection.rtl,
//                   child:editMyCalory(myFood: myfood,dailyType:dailyType,dailyInfo: dailyInfo,))));
// //      String returnVal= await   showModalBottomSheet(
// //          context: context,
// //          isScrollControlled: true,
// //          builder: (context) {
// //            return editMyCalory(myFood: myfood,dailyType:dailyType,dailyInfo: dailyInfo,);
// //          });
//
//       returnVal=='yes'?await _getDailyInfo(refresh: true):(){};
//     }
//
//     else if(dailyType.act_id!=null){
//       DbActivities dbActivities;
//       if(dailyType.name.contains("name_fa")){
//         dbActivities=   DbActivities.fromJson(jsonDecode(dailyType.name));
//         print("edit dbActivities"+dbActivities.name_fa);
//       }else {
//         dbActivities= await _getMyAct(dailyType.act_id);
//       }
//       String returnVal=  await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Directionality(
//                   textDirection: TextDirection.rtl,
//                   child:editSportCalory(activities: dbActivities,dailyType:dailyType,dailyInfo: dailyInfo,))));
//
// //      String returnVal= await   showModalBottomSheet(
// //          context: context,
// //          isScrollControlled: true,
// //          builder: (context) {
// //            return editSportCalory(activities: dbActivities,dailyType:dailyType,dailyInfo: dailyInfo,);
// //          });
//
//       returnVal=='yes'?await _getDailyInfo(refresh: true):(){};
//     }
//
//   }
//   Future _getFood(int id) async {
//     var db = new foodProvider();
//     await db.open();
//     DbFood _food = await db.getbyId(id);
// //    await db.close();
//     return _food;
//
//   }
//   Future _getMyFood(int id) async {
//     var db = new myfoodProvider();
//     await db.open();
//     DbMyFood _myfood = await db.getbyId(id);
// //    await db.close();
//     return _myfood;
//
//   }
//   Future _getMyAct(int id) async {
//     var db = new ActivityProvider();
//     await db.open();
//     DbActivities dbActivities = await db.getbyid(id);
// //    await db.close();
//     return dbActivities;
//
//   }
//   Future _getUniits(int id) async {
//     var db = new unitsProvider();
//     await db.open();
//     List<DbUnitsPviot> products = await db.search(id);
// //    print('reeeeeeed${products.toString()}');
// //    await db.close();
//     return products;
//   }
//   Future _searchUniits(int id) async {
//     var db = new unitsProvider();
//     await db.open();
//     DbUnitsPviot products = await db.searchbyid(id);
// //    print('reeeeeeed${products.toString()}');
// //    await db.close();
//     return products;
//   }
//   updatedelfood(DbUnitsPviot unit,String amount,DbFood foods) async {
//
//
//     double myFactor = double.parse(
//         ((double.parse(unit.factor) * (double.parse(amount))) / 100)
//             .toStringAsFixed(3));
//     print(
//
//         'uniiit${dailyInfo.toMap()}daily infoooobefor delete  fooolic ACID${foods.folic_acid}');
//
//
//     dailyInfo.total_calorie= double.parse((double.parse(dailyInfo.total_calorie)- (double.parse((myFactor * double.parse(foods.total_calorie)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.moisture =double.parse((double.parse(dailyInfo.moisture)-  (double.parse((myFactor * double.parse(foods.moisture)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.total_carb= double.parse((double.parse(dailyInfo.total_carb)-  (double.parse((myFactor * double.parse(foods.total_carb)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.total_fat= double.parse((double.parse(dailyInfo.total_fat)-  (double.parse((myFactor * double.parse(foods.total_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. total_protein= double.parse((double.parse(dailyInfo.total_protein)- (double.parse((myFactor * double.parse(foods.total_protein)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. saturated_fat= double.parse((double.parse(dailyInfo.saturated_fat)- (double.parse((myFactor * double.parse(foods.saturated_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. trans_fat= double.parse((double.parse(dailyInfo.trans_fat)-  (double.parse((myFactor * double.parse(foods.trans_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. cholesterol= double.parse((double.parse(dailyInfo.cholesterol)- (double.parse((myFactor * double.parse(foods.cholesterol)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. sugar= double.parse((double.parse(dailyInfo.sugar)- (double.parse((myFactor * double.parse(foods.sugar)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. fructose= double.parse((double.parse(dailyInfo.fructose)-   (double.parse((myFactor * double.parse(foods.fructose)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. fiber= double.parse((double.parse(dailyInfo.fiber)- (double.parse((myFactor * double.parse(foods.fiber)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. sodium= double.parse((double.parse(dailyInfo.sodium)- (double.parse((myFactor * double.parse(foods.sodium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. potassium= double.parse((double.parse(dailyInfo.potassium)-  (double.parse((myFactor * double.parse(foods.potassium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. phosphorus= double.parse((double.parse(dailyInfo.phosphorus)-   (double.parse((myFactor * double.parse(foods.phosphorus)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. iron= double.parse((double.parse(dailyInfo.iron)-  (double.parse((myFactor * double.parse(foods.iron)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. calcium= double.parse((double.parse(dailyInfo.calcium)-  (double.parse((myFactor * double.parse(foods.calcium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. magnesium= double.parse((double.parse(dailyInfo.magnesium)-  (double.parse((myFactor * double.parse(foods.magnesium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. copper= double.parse((double.parse(dailyInfo.copper)-  (double.parse((myFactor * double.parse(foods.copper)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. zinc= double.parse((double.parse(dailyInfo.zinc)-  (double.parse((myFactor * double.parse(foods.zinc)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. selenium= double.parse((double.parse(dailyInfo.selenium)-   (double.parse((myFactor * double.parse(foods.selenium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_c= double.parse((double.parse(dailyInfo.vitamin_c)- (double.parse((myFactor * double.parse(foods.vitamin_c)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. biotin= double.parse((double.parse(dailyInfo.biotin)-  (double.parse((myFactor * double.parse(foods.biotin)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. folic_acid= double.parse((double.parse(dailyInfo.folic_acid)-  (double.parse((myFactor * double.parse(foods.folic_acid)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. pantothenic_acid= double.parse((double.parse(dailyInfo.pantothenic_acid)-  (double.parse((myFactor * double.parse(foods.pantothenic_acid)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b1= double.parse((double.parse(dailyInfo.b1)-  (double.parse((myFactor * double.parse(foods.b1)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b2= double.parse((double.parse(dailyInfo.b2)-  (double.parse((myFactor * double.parse(foods.b2)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b3= double.parse((double.parse(dailyInfo.b3)-  (double.parse((myFactor * double.parse(foods.b3)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b6= double.parse((double.parse(dailyInfo.b6)-   (double.parse((myFactor * double.parse(foods.b6)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b12= double.parse((double.parse(dailyInfo.b12)-  (double.parse((myFactor * double.parse(foods.b12)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_a= double.parse((double.parse(dailyInfo.vitamin_a)-  (double.parse((myFactor * double.parse(foods.vitamin_a)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. beta_carotene= double.parse((double.parse(dailyInfo.beta_carotene)-  (double.parse((myFactor * double.parse(foods.beta_carotene)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_d= double.parse((double.parse(dailyInfo.vitamin_d)- (double.parse((myFactor * double.parse(foods.vitamin_d)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_e= double.parse((double.parse(dailyInfo.vitamin_e)-  (double.parse((myFactor * double.parse(foods.vitamin_e)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_k= double.parse((double.parse(dailyInfo.vitamin_k)-  (double.parse((myFactor * double.parse(foods.vitamin_k)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//
//
//     print(await _updateDailyInfo(dailyInfo));
//     print(  'uniiit${dailyInfo.toMap()}daily infooooafter delete}');
//
//
//   }
//   Future deleteDailyType(DbDailyType dailyType ) async {
//
//     try {
//       var db = new DailyTypeProvider();
//       await db.open();
//       await db.delete(dailyType);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   Future _updateDailyInfo(DbDailyInfo dailyInfo ) async {
//
//
//
//     if(double.parse(dailyInfo.total_act)<0)dailyInfo.total_act="0";
//     if(double.parse(dailyInfo.total_calorie)<0){
//       if(double.parse(dailyInfo.total_calorie).abs()!=(double.parse(dailyInfo.total_act)))
//       print("dailyInfo.total_calorie=0");
//     }
//
//     try {
//       var db = new DailyInfoProvider();
//       await db.open();
//       await db.update(dailyInfo);
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//
//
//   }
//   Future deleteDailyInfo( ) async {
//
//     try {
//       var db = new DailyInfoProvider();
//       await db.open();
//       await db.delete();
// //      await db.close();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//   void deleteFood(DbDailyType typeList) async {
//     DbUnitsPviot unit;
//     if(typeList.food_id!=null) {
//
//       if(typeList.unit_id==null){
//         Map<String, dynamic>map={
//           "name_fa":"گرم",
//           "name_ar":"",
//           "name_en":"",
//           "food_id":typeList.food_id,
//           "factor":"1",
//         };
//
//         unit=DbUnitsPviot.fromJson(map);
//
//       }
//       else{unit = await _searchUniits(typeList.unit_id);}
//
//
//       print(unit.toMap());
//       DbFood food;
//       if(typeList.name.contains("name_fa")){
//         food=   DbFood.fromJson(jsonDecode(typeList.name));
//         print("edit name_fa"+food.name_fa);
//       }else {
//         food = await _getFood(typeList.food_id);
//       }
//       print(food.toMap());
//       await updatedelfood(unit,typeList.amount, food);
//       await deleteDailyType(typeList);
//       await _getDailyInfo(refresh: true);
//     }
//     if(typeList.myfood_id!=null) {
//
//       DbMyFood myfood = await _getMyFood(typeList.myfood_id);
//       print(myfood.toMap());
//       await updatedellmyfood(typeList.amount, myfood);
//       await deleteDailyType(typeList);
//       await _getDailyInfo(refresh: true);
//
//     }
//     if(typeList.act_id!=null) {
//
//
//       DbActivities dbActivities;
//       if(typeList.name.contains("name_fa")){
//         dbActivities=   DbActivities.fromJson(jsonDecode(typeList.name));
//         print("dell dbActivities"+dbActivities.name_fa);
//       }else {
//         dbActivities= await _getMyAct(typeList.act_id);
//       }
//       print(dbActivities.toMap());
//       await updatedellmyAct(typeList.total_cal);
//       await deleteDailyType(typeList);
//       await _getDailyInfo(refresh: true);
//
//
//     }
//
//   }
//   updatedellmyfood(String amount,DbMyFood myFood) async {
//
//
//     double myFactor = double.parse(
//         ((1 * (double.parse(amount))) / 100)
//             .toStringAsFixed(3));
//     print(
//
//         'uniiit${dailyInfo.toMap()}daily infoooobefor delete  fooolic ACID${myFood.folic_acid}');
//
//
//     dailyInfo.total_calorie= double.parse((double.parse(dailyInfo.total_calorie)- (double.parse((myFactor * double.parse(myFood.total_calorie)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.moisture =double.parse((double.parse(dailyInfo.moisture)-  (double.parse((myFactor * double.parse(myFood.moisture)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.total_carb= double.parse((double.parse(dailyInfo.total_carb)- (double.parse((myFactor * double.parse(myFood.total_carb)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo.total_fat= double.parse((double.parse(dailyInfo.total_fat)- (double.parse((myFactor * double.parse(myFood.total_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. total_protein= double.parse((double.parse(dailyInfo.total_protein)- (double.parse((myFactor * double.parse(myFood.total_protein)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//
//
//     dailyInfo. saturated_fat= double.parse((double.parse(dailyInfo.saturated_fat)- (double.parse((myFactor * double.parse(myFood.saturated_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. trans_fat= double.parse((double.parse(dailyInfo.trans_fat)- (double.parse((myFactor * double.parse(myFood.trans_fat)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. cholesterol= double.parse((double.parse(dailyInfo.cholesterol)-  (double.parse((myFactor * double.parse(myFood.cholesterol)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. sugar= double.parse((double.parse(dailyInfo.sugar)- (double.parse((myFactor * double.parse(myFood.sugar)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. fructose= double.parse((double.parse(dailyInfo.fructose)- (double.parse((myFactor * double.parse(myFood.fructose)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. fiber= double.parse((double.parse(dailyInfo.fiber)- (double.parse((myFactor * double.parse(myFood.fiber)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. sodium= double.parse((double.parse(dailyInfo.sodium)- (double.parse((myFactor * double.parse(myFood.sodium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. potassium= double.parse((double.parse(dailyInfo.potassium)-(double.parse((myFactor * double.parse(myFood.potassium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. phosphorus= double.parse((double.parse(dailyInfo.phosphorus)- (double.parse((myFactor * double.parse(myFood.phosphorus)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. iron= double.parse((double.parse(dailyInfo.iron)- (double.parse((myFactor * double.parse(myFood.iron)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. calcium= double.parse((double.parse(dailyInfo.calcium)- (double.parse((myFactor * double.parse(myFood.calcium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. magnesium= double.parse((double.parse(dailyInfo.magnesium)- (double.parse((myFactor * double.parse(myFood.magnesium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. copper= double.parse((double.parse(dailyInfo.copper)- (double.parse((myFactor * double.parse(myFood.copper)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. zinc= double.parse((double.parse(dailyInfo.zinc)- (double.parse((myFactor * double.parse(myFood.zinc)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. selenium= double.parse((double.parse(dailyInfo.selenium)-  (double.parse((myFactor * double.parse(myFood.selenium)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_c= double.parse((double.parse(dailyInfo.vitamin_c)-(double.parse((myFactor * double.parse(myFood.vitamin_c)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. biotin= double.parse((double.parse(dailyInfo.biotin)-(double.parse((myFactor * double.parse(myFood.biotin)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. folic_acid= double.parse((double.parse(dailyInfo.folic_acid)- (double.parse((myFactor * double.parse(myFood.folic_acid)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. pantothenic_acid= double.parse((double.parse(dailyInfo.pantothenic_acid)- (double.parse((myFactor * double.parse(myFood.pantothenic_acid)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b1= double.parse((double.parse(dailyInfo.b1)-(double.parse((myFactor * double.parse(myFood.b1)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b2= double.parse((double.parse(dailyInfo.b2)-(double.parse((myFactor * double.parse(myFood.b2)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b3= double.parse((double.parse(dailyInfo.b3)- (double.parse((myFactor * double.parse(myFood.b3)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b6= double.parse((double.parse(dailyInfo.b6)-  (double.parse((myFactor * double.parse(myFood.b6)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. b12= double.parse((double.parse(dailyInfo.b12)- (double.parse((myFactor * double.parse(myFood.b12)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_a= double.parse((double.parse(dailyInfo.vitamin_a)-  (double.parse((myFactor * double.parse(myFood.vitamin_a)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. beta_carotene= double.parse((double.parse(dailyInfo.beta_carotene)- (double.parse((myFactor * double.parse(myFood.beta_carotene)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_d= double.parse((double.parse(dailyInfo.vitamin_d)- (double.parse((myFactor * double.parse(myFood.vitamin_d)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_e= double.parse((double.parse(dailyInfo.vitamin_e)- (double.parse((myFactor * double.parse(myFood.vitamin_e)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//     dailyInfo. vitamin_k= double.parse((double.parse(dailyInfo.vitamin_k)- (double.parse((myFactor * double.parse(myFood.vitamin_k)).toStringAsFixed(3)))).toStringAsFixed(3)).toString();
//
//     print(await _updateDailyInfo(dailyInfo));
//     print(  'uniiit${dailyInfo.toMap()}daily infooooafter delete}');
//
//
//   }
//   updatedellmyAct(String calory) async {
//
//     print(  'uniiit${dailyInfo.toMap()}daily beffooooor delete}$calory');
//     dailyInfo.total_calorie= double.parse((double.parse(dailyInfo.total_calorie)+(double.parse(calory))).toStringAsFixed(3)).toString();
//     dailyInfo.total_act= double.parse((double.parse(dailyInfo.total_act)-(double.parse(calory))).toStringAsFixed(3)).toString();
//
//     print(await _updateDailyInfo(dailyInfo));
//     print(  'uniiit${dailyInfo.toMap()}daily infooooafter delete}');
//
//
//   }
//   competitionCalory(List<DbDailyType> products){
//
//     products.forEach((item){
//       print(item.act_id!=null);
//
//       if(item.myfood_id!=null || item.food_id!=null)
//         _totalFoodCal=_totalFoodCal+double.parse(double.parse(item.total_cal).toStringAsFixed(3).toString());
//
//       else if(item.act_id!=null)
//         _totalActCal=_totalActCal+double.parse(double.parse(item.total_cal).toStringAsFixed(3).toString());
//     });
//
//
//
//
//   }
//   _getUser() async {
//
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // prefs.setString("saveDateAlarm", "getDateToday()");
//
//     var response = await getUser();
//
//     if (this.mounted){
//
//       setState(() {
//         _user = response;
//       });
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
//   addInfo(int water) async {
//
//
//     var map={
//       'date':dateCall.getDate().toString(),
//       'water':water.toString()
//
//
//     };
//     DbDailyInfo dailyInfo=DbDailyInfo.fromJson(map);
//
//     print(map);
//     print(await _addDailyInfo(dailyInfo));
//
//   }
//   Future _addDailyInfo(DbDailyInfo dailyInfo ) async {
//
//     try {
//       var db = new DailyInfoProvider();
//       await db.open();
//       DbDailyInfo AddeddailyInfo  = await db.insert(dailyInfo);
// //      await db.close();
//       return AddeddailyInfo;
//     } catch (e) {
//       return false;
//     }
//
//
//   }
//   calculateDays() {
//     int todayDay = persianDate1.jalaaliDay;
//     int dayOfWeek = DateTime.parse(gregorianDate).weekday;
//
//
//     switch (dayOfWeek) {
//       case 1:
//         {
//           arrayIndex = 2;
//           break;
//         }
//
//       case 2:
//         {
//           arrayIndex = 3;
//           break;
//         }
//
//       case 3:
//         {
//           arrayIndex = 4;
//           break;
//         }
//
//       case 4:
//         {
//           arrayIndex = 5;
//           break;
//         }
//
//       case 5:
//         {
//           arrayIndex = 6;
//           break;
//         }
//
//       case 6:
//         {
//           arrayIndex = 0;
//           break;
//         }
//
//       case 7:
//         {
//           arrayIndex = 1;
//           break;
//         }
//     }
//
//     setState(() {
//       arrayDaysEnable = [false, false, false, false, false, false, false];
//       arrayDaysEnable[arrayIndex]=true;
//
//
//       for (int i = 0; i < 7; i++) {
//         var persianDateee = PersianDateTime.fromGregorian(
//             gregorianDateTime:
//             getCustomDate2(i - arrayIndex, DateTime.parse(gregorianDate)));
//         arrayDays[i] = (persianDateee);
//
//       }
//     });
//   }
//   showDays(PersianDateTime date, int i) {
//     var dateNow = PersianDateTime.fromGregorian();
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//     bool enable=(date.isBefore(dateNow))||(date.difference(dateNow).inDays==0);
//
//
//     return Column(
//       children: <Widget>[
//         Text(
//           arrayDaysName[i],
//           style: TextStyle(
//             color: Color(0xff242424),
//             fontSize: 10*fontvar,
//             fontWeight: FontWeight.w400,
//             fontFamily: "iransansDN",
//           ),
//         ),
//         GestureDetector(
//           onTap:enable? () async {
//
//
//
//             setState(() {
//
//
//               print(arrayDaysEnable[i]);
//               arrayDaysEnable = [false, false, false, false, false, false, false];
//               arrayDaysEnable[i]=true;
//
//               persianDate1 = PersianDateTime(jalaaliDateTime: date.toString());
//               gregorianDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
// //           calculateDays();
//               print(gregorianDate + "ll" + getDateToday());
//
//               dateCall.saveDate(persianDate1);
//
//
//             });
//
//             await _getDailyInfo();
//           }:null,
//
//
//           child: Container(
//             alignment: Alignment.center,
//             margin: EdgeInsets.symmetric(horizontal: 3),
//             height: (screenSize.width - 85) / 8,
//             width: (screenSize.width - 85) / 8,
//             decoration: BoxDecoration(
//               color:enable? arrayDaysEnable[i] ? Color(0XFF62BC72) : Colors.white:Colors.black12,
//               borderRadius: BorderRadius.all(Radius.circular(6)),
//               border: Border.all(
//                   width: 1,
//                   color:arrayDaysEnable[i]
//                       ? Color(0xff62BC72)
//                       : Color(0xffE8E8E8)),
//             ),
//             child: Text(
//               date.jalaaliDay.toString(),
//               style: TextStyle(
//                 color: arrayDaysEnable[i] ? Colors.white : Color(0XFF242424),
//                 fontSize: 19*fontvar,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: "iransansDN",
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//   getmain2() async {
//     var db = new DailyInfoProvider();
//     await db.open();
//     DbDailyInfo products = await db.getByDate(gregorianDate);
// //    await db.close();
//     dailyInfo=products;
//     setState(() {
//       water=products.water;
//     });
//   }
//   void initTargets() {
//     targets.add(TargetFocus(
//       identify: "Target 1",
//       keyTarget: keyButton1,
//       contents: [
//         ContentTarget(
//             align: AlignContent.top,
//             child: Container(
//                 child:
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "این بخش بهتون میگه شما تا الان چقدر از انواع ویتامین ها و مواد معدنی مصرف کردید و مقدار استاندارد مخصوص شما رو هم تعیین می کنه و میگه در طول روز کدوم ویتامین یا مواد معدنی رو کم یا زیاد استفاده کردی.",
//                     style: TextStyle(color: Colors.white,fontSize: 14*fontvar,fontWeight: FontWeight.w500),textAlign: TextAlign.center,textDirection: TextDirection.rtl,
//                   ),
//                 )
//             ))
//       ],
//       shape: ShapeLightFocus.Circle,
//
//     ));
//
//   }
//   void showTutorial() {
//     TutorialCoachMark(context,
//         targets: targets,
//         colorShadow:MyColors.green,
//         textSkip: "بستن",
//         paddingFocus: 10,
//         opacityShadow: 0.9,
//        )
//       ..show();
//   }
//   void _afterLayout(_) {
//     Future.delayed(Duration(milliseconds: 1000), () async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       String stringCoach=prefs.getString('coach');
//       if(stringCoach!=null) {
//         List<String> arrayCoach = stringCoach.split("#");
//         if (arrayCoach[2] == "0") {
//           showTutorial();
//           arrayCoach[2] = "1";
//           String stringCoachSave = "";
//           for (int i = 0; i < arrayCoach.length; i++) {
//             if (i != 0)
//               stringCoachSave = stringCoachSave + ("#");
//             stringCoachSave = stringCoachSave + arrayCoach[i];
//           }
//           await prefs.setString('coach', stringCoachSave);
//         }
//       }
//     });
//   }
//
//   unitName(int unit_id) async {
//     print("gettUnit");
//     DbUnitsPviot unit = await _searchUniits(unit_id);
//     print(unit.toMap());
//     return unit.name_fa;
//   }
// }