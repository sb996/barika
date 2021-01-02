// import 'dart:async';
// import 'dart:convert';
// import 'package:barika/utils/MyDadaPicker.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:barika/home/logiin.dart';
// import 'package:barika/home/questionnaire.dart';
// import 'package:barika/models/user.dart';
// import 'package:barika/profile/profileScreen.dart';
// import 'package:barika/services/apiServices.dart';
// import 'package:barika/sqliteProvider/userProvider.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:persian_datepicker/persian_datepicker.dart';
// import 'package:persian_datepicker/persian_datetime.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../helper.dart';
// import '../mainScrenn.dart';
//
// class userInfo extends StatefulWidget {
//   @override
//   String regim;
//   String retutnVal;
//
//   userInfo({Key key, this.regim, retutnVal}) : super(key: key);
//
//   State<StatefulWidget> createState() => new userInfoState();
// }
//
// class userInfoState extends State<userInfo> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   PersianDatePickerWidget persianDatePicker1;
//   TextEditingController textEditingController = TextEditingController();
//   final Color backgroundColor = Colors.amber;
//   final Color orange = Color(0xffF15A23);
//   final Color gray = Color(0xffB5B6B5);
//   final Color green = Color(0xff6DC07B);
//   bool _showLoading = false;
//   User _user;
//
//   double _weightValue = 2;
//   double _heightValue = 2;
//   String gender;
//   String appetite;
//   String activity;
//   String _bdate = "";
//   bool _isLoading = true;
//   String regim;
//   int i = 0;
//   TextEditingController _heightC = new TextEditingController();
//   TextEditingController _weightC = new TextEditingController();
//
//   Widget loadingView() {
//     return new Center(
//         child: SpinKitCircle(
//           color: MyColors.vazn,
//         ));
//   }
//
//   String birthDate = "0";
//   bool _validate2 = false;
//   bool _validate = false;
//
//   startTime() {
//     var _duration = new Duration(seconds: 0);
//     return new Timer(_duration, _getAlbums);
//   }
//
//   setDatePicker1() {
//     persianDatePicker1 = PersianDatePicker(
//       controller: textEditingController,
//       farsiDigits: false,
//       onChange: (String oldText, String newText) {
//         setState(() {
//           var persianDate1 = PersianDateTime(jalaaliDateTime: newText);
//           birthDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//           print(birthDate);
//         });
//
//         Navigator.pop(context);
//       },
//       maxDatetime: PersianDateTime().toString(),
//     ).init();
//   }
//
//   @override
//   void initState() {
//
//     regim = widget.regim ?? "";
//     setDatePicker1();
//     startTime();
//
//     super.initState();
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
//     return new Scaffold(
//         key: _scaffoldKey,
//         body: Builder(
//             builder: (context) => CustomScrollView(slivers: <Widget>[
//               SliverList(
//                   delegate: SliverChildListDelegate(<Widget>[
//                     Container(
//                       height:80*(screenSize.width)/375,
//                       child: Stack(
//                         alignment: Alignment.topCenter,
//                         children: <Widget>[
//                           RotatedBox(
//                             quarterTurns: 6,
//                             child: Image.asset(
//                               'assets/images/bg_intro.png',
//                               color: MyColors.green,
//                               alignment: Alignment.topCenter,
//                               fit: BoxFit.fitWidth,
//                               width:  MediaQuery.of(context).size.width,
//                               height: 80*(screenSize.width)/375,
//                             ),
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Container(
//                                 margin: EdgeInsets.only(top: 35*(screenSize.width)/375, right: 15),
//                                 child: Text(
//                                   _user == null ? "" : _user.name ?? " ",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15*fontvar,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                         alignment: Alignment.centerRight,
//                         height:45*(screenSize.width)/375,
//                         margin:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             border:
//                             Border.all(color: MyColors.green, width: 1)),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                               contentPadding: EdgeInsets.only(bottom: 7),
//                               border: InputBorder.none,
//                               hintText: 'تاریخ تولد خود را وارد کنید.',
//                               hintStyle: TextStyle(
//                                   color: Colors.black38, fontSize: 15*fontvar),
//                               prefixIcon:Container(
//                                 height: 30*(screenSize.width)/375,
//                                 width: 30*(screenSize.width)/375,
//                                 alignment: Alignment.center,
//                                 child:  Image.network(
//                                   'assets/icons/calendar.svg',
//                                   height: 30*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                 ),
//                               )),
//                           enableInteractiveSelection: false,  cursorWidth: 0,
//                           readOnly: true,
//                           style: TextStyle(
//                             fontSize: 12.0*fontvar,
//                           ),
//                           // *** this is important to prevent user interactive selection ***
//                           onTap: () {
//                             MyDatePicker.showDatePicker(
//                               context,
//
//                               onConfirm: (int year,int month,int day){
//                                 print(year);
//                                 print(month);
//                                 print(day);
//                                 String datenew=year.toString()+"/"+month.toString()+"/"+day.toString();
//                                 var datenew2 = PersianDateTime(jalaaliDateTime:datenew);
//                                 PersianDateTime datenow = PersianDateTime();
//                                 if((datenew2.isBefore(datenow))||(datenew2.difference(datenow).inDays==0))
//                                 {
//
//
//                                   setState(() {
//                                     var persianDate1 = PersianDateTime(jalaaliDateTime: datenew);
//                                     birthDate = persianDate1.toGregorian(format: 'YYYY-MM-DD');
//                                     textEditingController.text=persianDate1.toString();
//                                     print(birthDate);
//
//                                   });
//
//                                 }
//                                 else{
//
//                                   Fluttertoast.showToast(
//                                     msg: "امکان انتخاب این تاریخ وجود ندارد.",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.CENTER,
//                                     timeInSecForIosWeb: 1,
//                                     backgroundColor: Colors.red,
//                                     textColor: Colors.white,
//
//                                     fontSize: 16.0*fontvar,
//                                   );
//                                 }
//                               },
//
//
//                               minYear: 1300,
//
//                               maxYear: 1450,
//                               confirm: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.all(Radius.circular(6)),
//                                     color: Colors.green
//                                 ),
//                                 child: Text(
//                                   'تایید',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18*fontvar,
//                                       fontFamily: "iransansDN",
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               cancel:Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.all(Radius.circular(6)),
//                                       color: Colors.red
//                                   ),
//                                   child: Text(
//                                     ' لغو ',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18*fontvar,
//                                         fontFamily: "iransansDN",
//                                         fontWeight: FontWeight.w400),
//                                   )),
//
//                             );
//                           },
//                           controller: textEditingController,
//                         )
//
// //          Row(
// //        children: <Widget>[
// //        Image.network(
// //          'assets/icons/calendar.svg',
// //        ),
// //            Padding(
// //              padding: EdgeInsets.only(right: 5, left: 5, top: 3),
// //              child: Text(
// //                'تاریخ تولد',
// //                style: TextStyle(
// //                    color: Color(0xff5C5C5C),
// //                    fontWeight: FontWeight.w400,
// //                    fontSize: 12),
// //              ),
// //            )
// //          ],
// //          ),
//
//                     ),
//                     Container(
//                         margin: EdgeInsets.only(
//                             right: 15, left: 15, top: 10, bottom: 8),
//                         child: Row(
//                           children: <Widget>[
//                             Flexible(
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Image.network(
//                                         'assets/icons/profile_weight.svg',   height: 20*(screenSize.width)/375,
//                                         width: 20*(screenSize.width)/375,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             right: 5, left: 5, top: 5),
//                                         child: Text(
//                                           'وزن(کیلوگرم)',
//                                           style: TextStyle(
//                                               color: Color(0xff5C5C5C),
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 13*fontvar),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     height: 72*(screenSize.width)/375,
//                                     padding: EdgeInsets.only(
//                                         right: 5, left: 5, top: 5),
//                                     child: new TextFormField(
//                                       controller: _weightC,
//                                       textAlign: TextAlign.right,
//                                       inputFormatters: [
//                                         DecimalTextInputFormatter(
//                                             decimalRange: 3)
//                                       ],
//                                       keyboardType:
//                                       TextInputType.numberWithOptions(
//                                           decimal: true),
//                                       style:  TextStyle(
//                                           color: Color(0xff5c5c5c),
//                                           fontSize: 14*fontvar,
//                                           fontWeight: FontWeight.w500),
//                                       onChanged: (text) {
//                                         text= changeDigit( text);
//                                         print(text);
//                                         _weightValue = double.parse(text);
//                                       },
//                                       decoration: new InputDecoration(
//                                           errorText: _validate
//                                               ? "وزن خود را وارد کنید "
//                                               : null,
//                                           border: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           enabledBorder: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           focusedBorder: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           hintText: 'وزن',
//                                           hintStyle:  TextStyle(
//                                               color: Colors.black26,
//                                               fontSize: 14*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                           contentPadding:  EdgeInsets.only(top: 10, right: 8, bottom: 10, left: 8)),
//                                     ),
//                                   ),
// //                  Padding(
// //                    padding: EdgeInsets.only(top: 2, left: 12),
// //                    child: Text(
// //                      '${_weightValue.toStringAsFixed(1)} کیلوگرم ',
// //                      textAlign: TextAlign.end,
// //                      style: TextStyle(
// //                          fontWeight: FontWeight.w400,
// //                          color: Color(0xff51565F),
// //                          fontSize: 14),
// //                    ),
// //                  ),
//                                 ],
//                               ),
//                             ),
//                             Flexible(
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Image.network(
//                                         'assets/icons/profile_height.svg',   height: 20*(screenSize.width)/375,
//                                         width: 20*(screenSize.width)/375,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             right: 2, left: 5, top: 3),
//                                         child: Text(
//                                           'قد(سانتی متر)',
//                                           style: TextStyle(
//                                               color: Color(0xff5C5C5C),
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 13*fontvar),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Container(
//                                     height: 72*(screenSize.width)/375,
//                                     padding: EdgeInsets.only(
//                                         right: 5, left: 5, top: 5),
//                                     child: new TextFormField(
//                                       controller: _heightC,
//                                       textAlign: TextAlign.right,
//                                       inputFormatters: [
//                                         DecimalTextInputFormatter(
//                                             decimalRange: 1)
//                                       ],
//                                       keyboardType:
//                                       TextInputType.numberWithOptions(
//                                           decimal: true),
//                                       style:  TextStyle(
//                                           color: Color(0xff5c5c5c),
//                                           fontSize: 14*fontvar,
//                                           fontWeight: FontWeight.w500),
//                                       onChanged: (text) { text= changeDigit( text);
//                                         print(text);
//                                         _heightValue = double.parse(text);
//                                       },
//                                       decoration: new InputDecoration(
//                                           errorText: _validate2
//                                               ? 'قد خود را وارد کنید '
//                                               : null,
//                                           border: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           enabledBorder: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           focusedBorder: new OutlineInputBorder(
//                                               borderSide: new BorderSide(
//                                                   color: MyColors.green,
//                                                   width: 1),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10))),
//                                           hintText: 'قد',
//                                           hintStyle:  TextStyle(
//                                               color: Colors.black26,
//                                               fontSize: 14*fontvar,
//                                               fontWeight: FontWeight.w500),
//                                           contentPadding:  EdgeInsets.only(top: 10, right: 8, bottom: 10, left: 8)),
//                                     ),
//                                   ),
// //                  Padding(
// //                    padding: EdgeInsets.only(top: 2, left: 12),
// //                    child: Text(
// //                      '${_weightValue.toStringAsFixed(1)} کیلوگرم ',
// //                      textAlign: TextAlign.end,
// //                      style: TextStyle(
// //                          fontWeight: FontWeight.w400,
// //                          color: Color(0xff51565F),
// //                          fontSize: 14),
// //                    ),
// //                  ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )),
//                     Text(
//                       'جنسیت',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Color(0xff51565F),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14*fontvar),
//                     ),
//                     (birthDate != "0")
//                         ? calculateAge(birthDate) <= 12
//                         ? Container(
//                       margin: EdgeInsets.symmetric(vertical: 2),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/woman.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color: gender == 'female'
//                                       ? orange
//                                       : gray,
//                                 ),
//                                 Text(
//                                   'دختر',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'female'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'female';
//                               });
//                             },
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(
//                                 right: 25, left: 25, bottom: 10),
//                             alignment: Alignment.center,
//                             height: 70*(screenSize.width)/375,
//                             width: 6*(screenSize.width)/375,
//                             decoration: BoxDecoration(
//                               color: Color(0xffC1E4AF),
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(15)),
//                             ),
//                           ),
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/man.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color: gender == 'male'
//                                       ? orange
//                                       : gray,
//                                 ),
//                                 Text(
//                                   'پسر',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'male'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'male';
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     )
//                         : Container(
//                       margin: EdgeInsets.symmetric(vertical: 2),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/woman.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color: gender == 'female'
//                                       ? orange
//                                       : gray,
//                                 ),
//                                 Text(
//                                   'زن',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'female'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'female';
//                               });
//                             },
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(
//                                 right: 25, left: 25, bottom: 10),
//                             alignment: Alignment.center,
//                             height: 70*(screenSize.width)/375,
//                             width: 6*(screenSize.width)/375,
//                             decoration: BoxDecoration(
//                               color: Color(0xffC1E4AF),
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(15)),
//                             ),
//                           ),
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/man.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color: gender == 'male'
//                                       ? orange
//                                       : gray,
//                                 ),
//                                 Text(
//                                   'مرد',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'male'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'male';
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     )
//                         : Container(
//                       margin: EdgeInsets.symmetric(vertical: 2),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/woman.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color:
//                                   gender == 'female' ? orange : gray,
//                                 ),
//                                 Text(
//                                   'زن',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'female'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'female';
//                               });
//                             },
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(
//                                 right: 25, left: 25, bottom: 10),
//                             alignment: Alignment.center,
//                             height: 70*(screenSize.width)/375,
//                             width: 6*(screenSize.width)/375,
//                             decoration: BoxDecoration(
//                               color: Color(0xffC1E4AF),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(15)),
//                             ),
//                           ),
//                           GestureDetector(
//                             child: Column(
//                               children: <Widget>[
//                                 Image.network(
//                                   'assets/icons/man.svg',    height: 80*(screenSize.width)/375,
//                                   width: 30*(screenSize.width)/375,
//                                   color: gender == 'male' ? orange : gray,
//                                 ),
//                                 Text(
//                                   'مرد',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: gender == 'male'
//                                           ? orange
//                                           : gray,
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14*fontvar),
//                                 ),
//                               ],
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 gender = 'male';
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                     (birthDate == "0")
//                         ?  Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
//                           child: Row(
//                             children: <Widget>[
//                               Text(
//                                 ' فعالیت',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Color(0xff3D3D3D),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14*fontvar),
//                               ),
//                               Expanded(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       GestureDetector(
//                                         child: Container(
//                                           color: Colors.transparent,
//                                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Image.network(
//                                                 'assets/icons/active1.svg',     height: 22*(screenSize.width)/375,
//                                                 width: 22*(screenSize.width)/375,
//                                                 color: activity == '5' ? green : gray,
//                                               ),
//                                               Text(
//                                                 'خیلی زیاد',
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     color: activity == '5'
//                                                         ? green
//                                                         : gray,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 10*fontvar),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           setState(() {
//                                             activity = '5';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 Image.network(
//                                                   'assets/icons/active2.svg', height: 22*(screenSize.width)/375,
//                                                   width: 22*(screenSize.width)/375,
//                                                   color:
//                                                   activity == '4' ? green : gray,
//                                                 ),
//                                                 Text(
//                                                   'زیاد',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: activity == '4'
//                                                           ? green
//                                                           : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             activity = '4';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 Image.network(
//                                                   'assets/icons/active3.svg', height: 22*(screenSize.width)/375,
//                                                   width: 22*(screenSize.width)/375,
//                                                   color:
//                                                   activity == '3' ? green : gray,
//                                                 ),
//                                                 Text(
//                                                   'متوسط',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: activity == '3'
//                                                           ? green
//                                                           : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             activity = '3';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 Image.network(
//                                                   'assets/icons/active4.svg', height: 22*(screenSize.width)/375,
//                                                   width: 22*(screenSize.width)/375,
//                                                   color:
//                                                   activity == '2' ? green : gray,
//                                                 ),
//                                                 Text(
//                                                   'کم',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: activity == '2'
//                                                           ? green
//                                                           : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             activity = '2';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 Image.network(
//                                                   'assets/icons/active5.svg', height: 22*(screenSize.width)/375,
//                                                   width: 22*(screenSize.width)/375,
//                                                   color:
//                                                   activity == '1' ? green : gray,
//                                                 ),
//                                                 Text(
//                                                   'بی فعالیت',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: activity == '1'
//                                                           ? green
//                                                           : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             activity = '1';
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ))
//                             ],
//                           ),
//                         ),
//                         Container(
//
//                           margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
//                           child: Row(
//                             children: <Widget>[
//                               Text(
//                                 'اشتها',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Color(0xff3D3D3D),
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14*fontvar),
//                               ),
//                               Expanded(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       GestureDetector(
//                                         child: Container(
//                                           color: Colors.transparent,
//                                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               appetite == '5' ?
//                                               Image.network(
//                                                 'assets/icons/fastfoodd.svg',
//                                                 height: 28*(screenSize.width)/375,
//                                                 width: 28*(screenSize.width)/375,
//                                               ):  Image.network(
//                                                 'assets/icons/fastfood.svg',
//                                                 height: 28*(screenSize.width)/375,
//                                                 width: 28*(screenSize.width)/375,
//                                                 color: gray,
//                                               ),
//                                               Text(
//                                                 'خیلی زیاد',
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     color: appetite == '5' ? green : gray,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 10*fontvar),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           setState(() {
//                                             appetite = '5';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 appetite == '4' ? Padding(
//                                                   padding: EdgeInsets.only(bottom: 3),
//                                                   child: Image.network(
//                                                     'assets/icons/chicken.svg',
//                                                     height: 25 * (screenSize.width) / 375,
//                                                     width: 25 * (screenSize.width) / 375,
//                                                   ),
//                                                 ): Image.network(
//                                                   'assets/icons/burger.svg',
//                                                   height: 25 * (screenSize.width) / 375,
//                                                   width: 25 * (screenSize.width) / 375,
//                                                   color: gray,
//                                                 ),
//                                                 Text(
//                                                   'زیاد',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: appetite == '4' ? green : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             appetite = '4';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 appetite == '3' ?   Image.network(
//                                                   'assets/icons/lunch2.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//                                                 ):Image.network(
//                                                   'assets/icons/fish.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//                                                   color:  gray,
//                                                 ),
//                                                 Text(
//                                                   'متوسط',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: appetite == '3' ? green : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             appetite = '3';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 appetite == '2'
//                                                     ?Image.network(
//                                                   'assets/icons/food2.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//                                                 )
//                                                     :
//                                                 Image.network(
//                                                   'assets/icons/apple.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//
//                                                 ),
//
//                                                 Text(
//                                                   'کم',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: appetite == '2' ? green : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             appetite = '2';
//                                           });
//                                         },
//                                       ),
//                                       GestureDetector(
//                                         child: Container(
//                                             color: Colors.transparent,
//                                             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                               children: <Widget>[
//                                                 appetite == '1' ? Image.network(
//                                                   'assets/icons/cupcakee.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//                                                 ):Image.network(
//                                                   'assets/icons/cupcake.svg',height: 25*(screenSize.width)/375,
//                                                   width: 25*(screenSize.width)/375,
//                                                   color:  gray,
//                                                 ),
//                                                 Text(
//                                                   'بی اشتها',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: appetite == '1' ? green : gray,
//                                                       fontWeight: FontWeight.w400,
//                                                       fontSize: 10*fontvar),
//                                                 ),
//                                               ],
//                                             )),
//                                         onTap: () {
//                                           setState(() {
//                                             appetite = '1';
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ))
//                             ],
//                           ),
//                         )
//                       ],
//
//                     ):Container(),
//                     (birthDate != "0")?
//                     (calculateAge(birthDate) >= 3)?
//                     ( calculateAge(birthDate) <= 12)
//                         ? Container(
//
//                       margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
//                       child: Row(
//                         children: <Widget>[
//                           Text(
//                             ' فعالیت',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Color(0xff3D3D3D),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14*fontvar),
//                           ),
//                           Expanded(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       padding: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Image.network(
//                                             'assets/icons/active1.svg',
//                                             height: 22*(screenSize.width)/375,
//                                             width: 22*(screenSize.width)/375,
//                                             color: activity == '5' ? green : gray,
//                                           ),
//                                           Text(
//                                             'خیلی پر جنب و جوش',
//
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: activity == '5'
//                                                     ? green
//                                                     : gray,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 9*fontvar),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '5';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active2.svg',     height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color:
//                                               activity == '4' ? green : gray,
//                                             ),
//                                             Text(
//                                               'پر جنب و جوش',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '4'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 9*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '4';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active3.svg',     height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color:
//                                               activity == '3' ? green : gray,
//                                             ),
//                                             Text(
//                                               'معمولی',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '3'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 9*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '3';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active4.svg',     height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color:
//                                               activity == '2' ? green : gray,
//                                             ),
//                                             Text(
//                                               'کم فعالیت',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '2'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 9*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '2';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active5.svg',     height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color:
//                                               activity == '1' ? green : gray,
//                                             ),
//                                             Text(
//                                               'بی فعالیت',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '1'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 9*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '1';
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )
//                         :Container(
//
//                       margin:
//                       EdgeInsets.only(right: 15, bottom: 15, top: 8),
//                       child: Row(
//                         children: <Widget>[
//                           Text(
//                             ' فعالیت',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Color(0xff3D3D3D),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14*fontvar),
//                           ),
//                           Expanded(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Image.network(
//                                             'assets/icons/active1.svg', height: 22*(screenSize.width)/375,
//                                             width: 22*(screenSize.width)/375,
//                                             color:
//                                             activity == '5' ? green : gray,
//                                           ),
//                                           Text(
//                                             'خیلی زیاد',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: activity == '5'
//                                                     ? green
//                                                     : gray,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 10*fontvar),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '5';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active2.svg', height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color: activity == '4'
//                                                   ? green
//                                                   : gray,
//                                             ),
//                                             Text(
//                                               'زیاد',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '4'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '4';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active3.svg', height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color: activity == '3'
//                                                   ? green
//                                                   : gray,
//                                             ),
//                                             Text(
//                                               'متوسط',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '3'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '3';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active4.svg', height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color: activity == '2'
//                                                   ? green
//                                                   : gray,
//                                             ),
//                                             Text(
//                                               'کم',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '2'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '2';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Image.network(
//                                               'assets/icons/active5.svg', height: 22*(screenSize.width)/375,
//                                               width: 22*(screenSize.width)/375,
//                                               color: activity == '1'
//                                                   ? green
//                                                   : gray,
//                                             ),
//                                             Text(
//                                               'بی فعالیت',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: activity == '1'
//                                                       ? green
//                                                       : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         activity = '1';
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )
//                         :Container()
//                         :Container(),
//
//
//                     ( birthDate != "0")
//                         ? (calculateAge(birthDate) >= 3)
//                         ? Container(
//
//                       margin: EdgeInsets.only(right: 15, bottom: 15, top: 8),
//                       child: Row(
//                         children: <Widget>[
//                           Text(
//                             'اشتها',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Color(0xff3D3D3D),
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14*fontvar),
//                           ),
//                           Expanded(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           appetite == '5' ?
//                                           Image.network(
//                                             'assets/icons/fastfoodd.svg',
//                                             height: 28*(screenSize.width)/375,
//                                             width: 28*(screenSize.width)/375,
//                                           ):  Image.network(
//                                             'assets/icons/fastfood.svg',
//                                             height: 28*(screenSize.width)/375,
//                                             width: 28*(screenSize.width)/375,
//                                             color: gray,
//                                           ),
//                                           Text(
//                                             'خیلی زیاد',
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: appetite == '5' ? green : gray,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 10*fontvar),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       setState(() {
//                                         appetite = '5';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             appetite == '4' ? Padding(
//                                               padding: EdgeInsets.only(bottom: 3),
//                                               child: Image.network(
//                                                 'assets/icons/chicken.svg',
//                                                 height: 25 * (screenSize.width) / 375,
//                                                 width: 25 * (screenSize.width) / 375,
//                                               ),
//                                             ): Image.network(
//                                               'assets/icons/burger.svg',
//                                               height: 25 * (screenSize.width) / 375,
//                                               width: 25 * (screenSize.width) / 375,
//                                               color: gray,
//                                             ),
//                                             Text(
//                                               'زیاد',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: appetite == '4' ? green : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         appetite = '4';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             appetite == '3' ?   Image.network(
//                                               'assets/icons/lunch2.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//                                             ):Image.network(
//                                               'assets/icons/fish.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//                                               color:  gray,
//                                             ),
//                                             Text(
//                                               'متوسط',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: appetite == '3' ? green : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         appetite = '3';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             appetite == '2'
//                                                 ?Image.network(
//                                               'assets/icons/food2.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//                                             )
//                                                 :
//                                             Image.network(
//                                               'assets/icons/apple.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//
//                                             ),
//
//                                             Text(
//                                               'کم',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: appetite == '2' ? green : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         appetite = '2';
//                                       });
//                                     },
//                                   ),
//                                   GestureDetector(
//                                     child: Container(
//                                         color: Colors.transparent,
//                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             appetite == '1' ? Image.network(
//                                               'assets/icons/cupcakee.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//                                             ):Image.network(
//                                               'assets/icons/cupcake.svg',height: 25*(screenSize.width)/375,
//                                               width: 25*(screenSize.width)/375,
//                                               color:  gray,
//                                             ),
//                                             Text(
//                                               'بی اشتها',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: appetite == '1' ? green : gray,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 10*fontvar),
//                                             ),
//                                           ],
//                                         )),
//                                     onTap: () {
//                                       setState(() {
//                                         appetite = '1';
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )
//                         :Container()
//                         :Container(),
//                     Container(
//                         margin:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: <Widget>[
//                             SizedBox(
//                               width:  MediaQuery.of(context).size.width,
//                               child: RaisedButton(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: new BorderRadius.circular(10),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 5, vertical: 8),
//                                   color: MyColors.green,
//                                   onPressed: () async {
//                                     if (birthDate == "" ||
//                                         birthDate == "0" ||
//                                         birthDate == null) {
//                                       showSnakBar('لطفا اطلاعات خود را تکمیل کنید.');
//                                     } else if (checkInput()) {
//
//                                         print(birthDate);
//                                         if (await checkConnectionInternet())
//                                           _updateSetver(context);
//
//                                         await _update(context).whenComplete(() {
// //       _getAlbums();
//                                           Navigator.pushReplacementNamed(context, '/main');
//                                         });
//                                       }
//                                      else
//                                       showSnakBar('لطفا اطلاعات خود را تکمیل کنید.');
//                                   },
//                                   child: Text(
//                                     _showLoading ? '' : ' تایید اطلاعات',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14*fontvar),
//                                   )),
//                             ),
//                              (_showLoading)?
//                               SpinKitThreeBounce(
//                                 color: Colors.white,
//                                 size: 20,
//                               ):Container(width:0,height:0),
//                           ],
//                         )),
//                     Container(
//                       height: 50*(screenSize.width)/375,
//                     ),
//                   ]))
//             ])));
//   }
//
// //
// //  static Future<Map> getProducts(BuildContext context) async {
// //    print('USER');
// //    SharedPreferences prefs = await SharedPreferences.getInstance();
// //    String apiToken = prefs.getString('user_token');
// //    final response = await Provider.of<apiServices>(context, listen: false)
// //        .getUserInfo(
// //            'Bearer apiToken');
// //    if (response.statusCode == 200) {
// //      print('${response.bodyString}SSSSSSSSSSSSSSSSSSSSSSSS');
// //      final post = json.decode(response.bodyString);
// //      User users;
// //      users = User.fromJson(post['success']);
// //
// //      return {'users': users};
// //    } else {
// //      print(response.statusCode.toString());
// //    }
// //  }
//
//   _getAlbums() async {
//     var response = await getUser();
//
//     _user = response;
//     print(_user);
//     if (this.mounted) {
//       setState(() {
//         // print(_user.toMap());
//         _heightValue = double.tryParse(_user.height ?? '0');
//         _weightValue = double.tryParse(_user.weight ?? '0');
//         gender = _user.gender ?? 'male';
//         activity = _user.activity ?? '0';
//         appetite = _user.appetite ?? '0';
//         birthDate = _user.birthdate ?? '';
// //    DateTime date = DateTime.parse(intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(_user.birthdate??'1996-09-17')));
// //    print(date);
// //    var persianDateee = PersianDateTime.fromGregorian(gregorianDateTime:_user.birthdate?? '1996-09-17');
// //    var pbirthDate= persianDateee.toJalaali(format: 'YYYY-MM-DD');
// //    textEditingController.text=pbirthDate.toString();
//
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future _update(BuildContext context) async {
//     print("up");
//     print(birthDate);
//     setState(() {
//       _showLoading = true;
//     });
//
//     if (calculateAge(birthDate)  >=3) calculateCalory();
//
//     _user.birthdate = birthDate;
//     _user.appetite = appetite;
//     _user.activity = activity;
//     _user.weight = _weightValue.toStringAsFixed(3);
//     _user.height = _heightValue.toStringAsFixed(1);
//     _user.gender = gender.toString();
//
//     await updateDb(_user);
//
//     setState(() {
//       _showLoading = false;
//     });
//   }
//
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
//
//   static Future<User> updateDb(User user) async {
//     try {
//       var db = new userProvider();
//       await db.open();
//       await db.update(user);
// //      await db.close();
//     } catch (e) {
//       print(e.toString() + "errrrrorrrrr");
//       return null;
//     }
//   }
//
//   Future _updateSetver(BuildContext context) async {
//     try{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String apiToken = prefs.getString('user_token');
//       print(birthDate);
//       final newPost = {
//         'birthday': birthDate,
//         'weight': _weightValue.toStringAsFixed(3),
//         'height': _heightValue.toStringAsFixed(1),
//         'gender': gender,
//         'activity': activity,
//         'appetite': appetite
//       };
//       final response = await Provider.of<apiServices>(context,listen: false)
//           .updateUserInfo(newPost, 'Bearer ' + apiToken);
//       if (response.statusCode == 200) {
//         final post = json.decode(response.bodyString);
//         final code = post['code'].toString();
//         print(response.bodyString + "kl");
//       } else {
//         print(response.error.toString());
//
//         showSnakBar("اتصال خود به اینترنت را بررسی کنید.");
//       }}catch(e){
//       showSnakBar("اتصال خود به اینترنت را بررسی کنید.");
//     }
//     // We cannot really add any new posts using the placeholder API,
//     // so just print the response to the console
// //      print('${response.body.toString()}   aaaa  ${nameController.text}  sss ${response.statusCode.toString()}');
//   }
//
//   void setstate(User response) {}
//
//   bool checkInput() {
//     setState(() {
//       _weightC.text.isEmpty ? _validate = true : _validate = false;
//       _heightC.text.isEmpty ? _validate2 = true : _validate2 = false;
//     });
//
//     if (birthDate == "" ||
//         birthDate == "0" ||
//         birthDate == null)  return false;
//     if (calculateAge(birthDate) >= 3) {
//       if (_weightC.text.isNotEmpty &&
//           _heightC.text.isNotEmpty &&
//           appetite != null &&
//           appetite != "0" &&
//           gender != null &&
//           gender != "0" &&
//           activity != null &&
//           activity != "0")
//         return true;
//       else
//         return false;
//     } else {
//       if (_weightC.text.isNotEmpty &&
//           _heightC.text.isNotEmpty &&
//           gender != null &&
//           gender != "0")
//         return true;
//       else
//         return false;
//     }
//   }
//
//
//   showSnakBar(String s) {
//     _scaffoldKey.currentState.showSnackBar( SnackBar(
//       duration:  Duration(seconds: 2),
//       backgroundColor: MyColors.vazn,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//
//       content: Text(
//         s,
//         style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15*fontvar,fontFamily: "iransansDN"),
//         textDirection: TextDirection.rtl,
//       ),
//     ));
//   }
//
//   calculateCalory() {
//     {
//       int activity1 = int.parse(activity);
//       int appetite1 = int.parse(appetite);
//       String weight1 = _weightValue.toStringAsFixed(3);
//       String height1 = _heightValue.toStringAsFixed(1);
//       int age1 = calculateAge(birthDate);
//       String gender1 = gender.toString();
//
//       double height_meter = double.parse(height1) / 100;
//       double BMR =
//           10 * double.parse(weight1) + 6.25 * double.parse(height1) - 5 * age1;
//       if (gender1 == 'male') {
//         BMR = BMR + 5;
//       } else {
//         BMR = BMR - 161;
//       }
//       double res = BMR;
//       if (activity1 == 1) {
//         res *= 1.2;
//       } else if (activity1 == 2) {
//         res *= 1.375;
//       } else if (activity1 == 3) {
//         res *= 1.55;
//       } else if (activity1 == 4) {
//         res *= 1.725;
//       } else if (activity1 == 5) {
//         res *= 1.9;
//       }
//
//       if (appetite1 == 1) {
//         res *= 0.95;
//       } else if (appetite1 == 2) {
//         res *= 0.975;
//       } else if (appetite1 == 3) {
//         res *= 1;
//       } else if (appetite1 == 4) {
//         res *= 1.025;
//       } else if (appetite1 == 5) {
//         res *= 1.05;
//       }
//       double ideal_weight = 22.5 * height_meter * height_meter;
//       String min_period = (20 * height_meter * height_meter).toStringAsFixed(1);
//       String max_period = (25 * height_meter * height_meter).toStringAsFixed(1);
//       double diff_weights = double.parse(weight1) - ideal_weight;
//       if (diff_weights < 0) {
//         diff_weights = diff_weights * -1;
//       }
//       double recommended_weight = ideal_weight + (0.2 * diff_weights);
//
//       if (res < 600) res = 600;
//       _user.calorie = res.floor();
//       _user.ideal_weight = ideal_weight.round();
//       _user.period_weight = "$min_period - $max_period";
//       _user.recommended_weight = recommended_weight.round();
//     }
//   }
// }
