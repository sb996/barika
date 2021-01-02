//
// import 'dart:convert';
// import 'package:barika_web/models/DbDailyInfo.dart';
// import 'package:barika_web/models/subSupplement.dart';
// import 'package:barika_web/utils/SizeConfig.dart';
// import 'package:barika_web/utils/colors.dart';
// import 'package:barika_web/utils/date.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../helper.dart';
//
//
// class rizMoghazi extends StatefulWidget {
//   @override
//
//   final riz;
//   int calorie;
//   rizMoghazi({Key key,  this.riz,this.calorie}) : super(key: key);
//
//   State<StatefulWidget> createState() => rizMoghaziState();
// }
//
// class rizMoghaziState extends State<rizMoghazi>{
//
//   Color textColor=Color(0xff555555);
//   List<subSupplement> _subSupplement = [];
//   List <String>_name=[];
//   List <String>_unit=[];
//   List <double>_used=[];
//   List <double>_total=[];
//   List <double>_remaining=[];
//   List <String>_siteAddress=[];
//   bool _isLoading = true;
//   double _totlaCal;
//   String date;
//   String _cid;
//   void initState() {
//     setData();
//     date = dateCall.getDate().toString();
//     prepareData();
//     int calInte=widget.calorie;
//     calInte==null
//         ?_totlaCal=0
//         :_totlaCal=calInte.toDouble();
//     super.initState();
//   }
//   Widget loadingView() {
//     return new Center(
//         child:SpinKitCircle(
//           color: MyColors.vazn,
//         )
//     );
//   }
//   Size screenSize =Size(600,600);
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     fontvar = (bh) / 3.75;
//     if(fontvar>2)fontvar=1.7;
//
//     screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return new Scaffold(
//       appBar: AppBar
//         (
//
//         automaticallyImplyLeading: false,
//         elevation: 5,
//         title: Text(
//           'وضعیت ویتامین ها و مواد معدنی',
//           style: TextStyle(
//             fontSize: 14*fontvar,
//             fontWeight: FontWeight.w500,
//             color: Colors.white
//           ),
//
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.chevron_right,
//               size: 32,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             alignment: Alignment.topLeft,
//             color: Colors.white,
//             splashColor: Colors.amber,
//             padding: EdgeInsets.all(7),
//           ),
//         ],
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             color: MyColors.green
//           ),
//         ),
//       ),
//       body:
//       _isLoading?Container():  Container(
//             child: Column(
//               children: <Widget>[
//                 itemsTitle('ماده مغذی', 'واحد', ' مقدار مصرف شده ', 'مقدار  مورد نیاز ', 'مقدار باقيمانده','منابع مصرف'),
//                 Expanded(child:   new ListView.builder(
//                     padding: EdgeInsets.only(top: 12, bottom: 20),
//                     itemCount: 31,
//                     itemBuilder: (context, index) {
//                       return
//                        items(_name[index], _unit[index],_used[index].toString(),_name[index]=='چربی ترانس'?_total[index].toString(): _total[index]==0?"-":_total[index].toString() ,_name[index]=='چربی ترانس'?_remaining[index].toString():_remaining[index]==0?"-":_remaining[index].toString(),index);
//                     }))
//               ],
//             )),
//
//     );
//   }
//
//   itemsTitle(String name,String unit,String used,String remaining,String total,String manba ){
//
//     return Container(
//       constraints: BoxConstraints(maxHeight:(50*screenSize.width/375)),
//       margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
//       padding: EdgeInsets.only(top: 0),
//       decoration: BoxDecoration(
//           color:Color(0xFF6DC07B),
//           borderRadius:BorderRadius.all(Radius.circular(10)) ,
//           // border:Border.all(color: MyColors.border,width: 1)
//       ),
//       alignment: Alignment.center,
//       child:  Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//
//         children: <Widget>[
//           Expanded(
//             flex: 1,
//             child:   Text(
//               name,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 10*fontvar
//               ),
//               textDirection: TextDirection.ltr,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 200,
//             color: Colors.white,
//           ),
//           Expanded(
//               flex: 1,
//               child:  Text(
//                 unit,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 10*fontvar
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.ltr,
//               )),
//           Container(
//             width: 1,
//             height: 200,
//             color: Colors.white,
//           ),
//           Expanded(
//               flex: 1,
//               child: Text(
//                 remaining,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 10*fontvar
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.ltr,
//               )),
//           Container(
//             width: 1,
//             height: 200,
//             color: Colors.white,
//           ),
//           Expanded(
//               flex: 1,
//               child:  Text(
//                 used,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 10*fontvar
//                 ),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.ltr,
//               )  ),
//           Container(
//             width: 1,
//             height: 200,
//             color: Colors.white,
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               total,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 10*fontvar
//               ),
//               textAlign: TextAlign.center,
//               textDirection: TextDirection.ltr,
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 200,
//             color: Colors.white,
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               manba,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 10*fontvar
//               ),
//               textAlign: TextAlign.center,
//               textDirection: TextDirection.ltr,
//             ),
//           )
//         ],
//       ),
//
//     );
//   }
//   items(String name,String unit,String used,String remaining,String total ,int index){
//
//     return    Container(
//
//
//       decoration: BoxDecoration(
//           color: index%2!=0?Color(0xffECFDEF):Color(0xffF8F8F8),
//           borderRadius:BorderRadius.all(Radius.circular(10)) ,
//           border:Border.all(color: MyColors.border,width: 1)
//       ),
//
//       margin: EdgeInsets.symmetric(horizontal:10,vertical: 6),
//       padding: EdgeInsets.symmetric(horizontal:8,vertical: 8),
//       child:
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 flex: 1,
//                 child:   Text(
//                   name,
//                   style: TextStyle(
//                       color: Color(0xff3d3d3d),
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12*fontvar
//                   ),
//                   textAlign: TextAlign.center,
//                   textDirection: TextDirection.rtl,
//                 ),
//               ),
//               Expanded(
//                   flex: 1,
//                   child:  Text(
//                     unit,
//                     style: TextStyle(
//                         color: Color(0xff3d3d3d),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 9*fontvar
//                     ),
//                     textAlign: TextAlign.center,
//                     textDirection: TextDirection.rtl,
//                   )),
//               Expanded(
//                   flex: 1,
//                   child: Text(
//                     remaining,
//                     style: TextStyle(
//                         color: Color(0xff3d3d3d),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14*fontvar
//                     ),
//                     textAlign: TextAlign.center,
//                     textDirection: TextDirection.ltr,
//                   )),
//               Expanded(
//                   flex: 1,
//                   child:  Text(
//                     used,
//                     style: TextStyle(
//                         color: Color(0xff3d3d3d),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14*fontvar
//                     ),
//                     textAlign: TextAlign.center,
//                     textDirection: TextDirection.ltr,
//                   )  ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   total,
//                   style: TextStyle(
//                       color: Color(0xff3d3d3d),
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14*fontvar
//                   ),
//                   textAlign: TextAlign.center,
//                   textDirection: TextDirection.ltr,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container( decoration: BoxDecoration(
//               boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Color(0xff000000).withOpacity(0.20),
//       blurRadius: 5,
//       offset: Offset(0, 5),
//     ),
//     ],
//     ),
//     child: FlatButton(
//
//                   child:Text(
//                     "منابع",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12*fontvar
//                     ),
//                     textAlign: TextAlign.center,
//                     textDirection: TextDirection.ltr,
//                   ) ,
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   onPressed: () async {
//                    await openApp(_siteAddress[index]);
//                   },
//                   color:Color(0xffEF6844) ,
//                   padding: EdgeInsets.symmetric(horizontal:0,vertical: 0),
//
//                   shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5.0)),
//                 ))
//               ),
//
//             ],
//           ),
//
//
//     );
//   }
//   prepareData() async {
//
//     await _getDailyInfo();
//
//     _name=[
//       'انرژی',
//       'کربوهیدرات',
//       'چربی',
//       'پروتئین',
//       'چربی اشباع',
//       'چربی ترانس',
//       'کلسترول',
//       'شکر',
//       'فیبر',
//       'سدیم',
//       'پتاسیم',
//       'فسفر',
//       'آهن',
//       'کلسیم',
//       'منیزیم',
//       'روی',
//       'مس',
//       'سلنیوم',
//       'ویتامین C',
//       'بیوتین',
//       'فولیک اسید',
//       'پانتوتنیک',
//       'ویتامین B1',
//       'ویتامین B2',
//       'نیاسین',
//       'ویتامین B6',
//       'ویتامین B12',
//       'ویتامین A',
//       'ویتامین D',
//       'ویتامین E',
//       'ویتامین K',
//     ];
//
//     _unit=[
//       'کالری',
//       'گرم',
//       'گرم',
//       'گرم',
//       'گرم',
//       'گرم',
//       'میلی گرم',
//       'گرم',
//       'گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میکرو گرم',
//        'میلی گرم',
//       'میلی گرم',
//       'میکرو گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میلی گرم',
//       'میکرو گرم',
//       'میکرو گرم',
//       'واحد (IU)',
//       'میلی گرم',
//       'میکرو گرم',
//     ];
//
//     Map rizMap=getRiz(int.parse(widget.riz));
//     _total=[
//       _totlaCal,
//       double.parse(double.parse((.55*_totlaCal/4).toString()).toStringAsFixed(1)),
//       double.parse(double.parse((.28*_totlaCal/9).toString()).toStringAsFixed(1)),
//       double.parse(double.parse((.17*_totlaCal/4).toString()).toStringAsFixed(1)),
//       double.parse(double.parse((  .3*_totlaCal/27).toString()).toStringAsFixed(1)),
//       0,
//       300,
//       double.parse(double.parse(( .15*_totlaCal/4).toString()).toStringAsFixed(1)),
//
//     rizMap['fiber'],
//     rizMap['sodium']*1000,
//     rizMap['potassium']*1000,
//     rizMap['phosphorus'],
//     rizMap['iron'],
//     rizMap['calcium'],
//     rizMap['magnesium'],
//     rizMap['zinc'],
//     rizMap['copper'],
//     rizMap['selenium'],
//     rizMap['vitamin_c'],
//     rizMap['biotin'],
//     rizMap['folic_acid'],
//     rizMap['pantothenic_acid'],
//     rizMap['b1'],
//     rizMap['b2'],
//     rizMap['b3'],
//     rizMap['b6'],
//     rizMap['b12'],
//     rizMap['vitamin_a'],
//     rizMap['vitamin_d'],
//     rizMap['vitamin_e'],
//     rizMap['vitamin_k'],
//
//     ];
//
//     for(int i=0;i<_total.length;i++){
//
//       double remain= double.parse(double.parse((_total[i]-_used[i]).toString()).toStringAsFixed(1));
//       if(_total[i]==0)remain=0;
//       _remaining.add(remain);
//
//     }
//
//     setState(() {
//
//       _isLoading=false;
//     });
//
//
//
//
//
//   }
//   _getDailyInfo({ bool refresh : false}) async {
//
// //     var db = new DailyInfoProvider();
// //     await db.open();
// //     DbDailyInfo dailyInfo = await db.getByDate(date);
// // //    await db.close();
// //     print(dailyInfo.toString());
// //
// //     if(!(dailyInfo==null)){
// //
// //       _totlaCal=_totlaCal+double.parse(dailyInfo.total_act??"0.0");
// //
// //       _used.add(double.parse((double.parse(dailyInfo.total_calorie)+double.parse(dailyInfo.total_act)).toStringAsFixed(1)));
// //       if(dailyInfo.water==null)
// //         _used.add(0);
// //       else
// //       _used.add(double.parse(dailyInfo.total_carb));
// //       _used.add(double.parse(dailyInfo.total_fat));
// //       _used.add(double.parse(dailyInfo.total_protein));
// //       _used.add(double.parse(dailyInfo.saturated_fat));
// //       _used.add(double.parse(dailyInfo.trans_fat));
// //       _used.add(double.parse(dailyInfo.cholesterol));
// //       _used.add(double.parse(dailyInfo.sugar));
// //       _used.add(double.parse(dailyInfo.fiber));
// //       _used.add(double.parse(dailyInfo.sodium));
// //       _used.add(double.parse(dailyInfo.potassium));
// //       _used.add(double.parse(dailyInfo.phosphorus));
// //       _used.add(double.parse(dailyInfo.iron));
// //       _used.add(double.parse(dailyInfo.calcium));
// //       _used.add(double.parse(dailyInfo.magnesium));
// //       _used.add(double.parse(dailyInfo.zinc));
// //       _used.add(double.parse(dailyInfo.copper));
// //       _used.add(double.parse(dailyInfo.selenium));
// //       _used.add(double.parse(dailyInfo.vitamin_c));
// //       _used.add(double.parse(dailyInfo.biotin));
// //       _used.add(double.parse(dailyInfo.folic_acid));
// //       _used.add(double.parse(dailyInfo.pantothenic_acid));
// //       _used.add(double.parse(dailyInfo.b1));
// //       _used.add(double.parse(dailyInfo.b2));
// //       _used.add(double.parse(dailyInfo.b3));
// //       _used.add(double.parse(dailyInfo.b6));
// //       _used.add(double.parse(dailyInfo.b12));
// //       _used.add(double.parse(dailyInfo.vitamin_a));
// //       _used.add(double.parse(dailyInfo.vitamin_d));
// //       _used.add(double.parse(dailyInfo.vitamin_e));
// //       _used.add(double.parse(dailyInfo.vitamin_k));
// //     }
// //     else{
// //
// //       for(int i=0;i<32;i++) {_used.add(0);}
// //
// //     };
//   }
//
//
//
//   setData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String dbmoghazipref=prefs.getString("dbmoghazi");
//     Dbmoghazi dbmoghazi;
//     if(dbmoghazipref!=null){
//       setState(() {
//         dbmoghazi= Dbmoghazi.fromJson(jsonDecode(dbmoghazipref));
//         setList(dbmoghazi);
//
//       });
//     }
//     if(await checkConnectionInternet())
//       await getInfo();
//
//
//
//   }
//   Future<void> getInfo() async {
//     print("Dbmoghazi");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String apiToken=prefs.getString("user_token");
//
//
//     final response = await Provider.of<apiServices>(context,listen: false).nutrients('Bearer '+apiToken);
//     if (response.statusCode == 200) {
//       final  post = json.decode(response.bodyString);
//       print(post);
//       Dbmoghazi dbmoghazi;
//       dbmoghazi=(Dbmoghazi.fromJson(post));
//       prefs.setString("dbmoghazi", jsonEncode(dbmoghazi.toMap()));
//
//       if(_siteAddress.isEmpty){
//         setState(() {
//           setList(dbmoghazi);
//         });
//       }
//
//     }
//     else {
//       print(response.statusCode.toString());
//     }
//
//
//
//   }
//   openApp(String url) async {
//
//     if(url !=null && url!=""){
//       if (await canLaunch(url)) {
//         await launch(
//           url,
//           universalLinksOnly: true,
//         );
//       } else {
//         throw 'There was a problem to open the url: $url';
//       }}
//   }
//
//   void setList(Dbmoghazi dbmoghazi) {
//     _siteAddress.add(dbmoghazi.total_calorie);
//     _siteAddress.add(dbmoghazi.total_carb);
//     _siteAddress.add(dbmoghazi.total_fat);
//     _siteAddress.add(dbmoghazi.total_protein);
//     _siteAddress.add(dbmoghazi.saturated_fat);
//     _siteAddress.add(dbmoghazi.trans_fat);
//     _siteAddress.add(dbmoghazi.cholesterol);
//     _siteAddress.add(dbmoghazi.sugar);
//     _siteAddress.add(dbmoghazi.fiber);
//     _siteAddress.add(dbmoghazi.sodium);
//     _siteAddress.add(dbmoghazi.potassium);
//     _siteAddress.add(dbmoghazi.phosphorus);
//     _siteAddress.add(dbmoghazi.iron);
//     _siteAddress.add(dbmoghazi.calcium);
//     _siteAddress.add(dbmoghazi.magnesium);
//     _siteAddress.add(dbmoghazi.zinc);
//     _siteAddress.add(dbmoghazi.copper);
//     _siteAddress.add(dbmoghazi.selenium);
//     _siteAddress.add(dbmoghazi.vitamin_c);
//     _siteAddress.add(dbmoghazi.biotin);
//     _siteAddress.add(dbmoghazi.folic_acid);
//     _siteAddress.add(dbmoghazi.pantothenic_acid);
//     _siteAddress.add(dbmoghazi.b1);
//     _siteAddress.add(dbmoghazi.b2);
//     _siteAddress.add(dbmoghazi.b3);
//     _siteAddress.add(dbmoghazi.b6);
//     _siteAddress.add(dbmoghazi.b12);
//     _siteAddress.add(dbmoghazi.vitamin_a);
//     _siteAddress.add(dbmoghazi.vitamin_d);
//     _siteAddress.add(dbmoghazi.vitamin_e);
//     _siteAddress.add(dbmoghazi.vitamin_k);
//     print("_siteAddress"+_siteAddress.length.toString());
//
//   }
//
//
//
// }
