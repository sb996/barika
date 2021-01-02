// import 'dart:ffi';
//
// import 'package:barika/models/cereals.dart';
// import 'package:barika/sqliteProvider/cerealsProvider.dart';
// import 'package:barika/utils/SizeConfig.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:barika/utils/colors.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

//
//
// class unitConvert extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => unitConvertState();
// }
//
// class unitConvertState extends State<unitConvert> {
//   List<DropdownMenuItem<cereals>> _dropDownMenuItems1 = [];
//   List<DropdownMenuItem<cereals>> _dropDownMenuItems2 = [];
//   List <cereals>_cereals = [];
//   double calorie1;
//   double calorie2;
//   String result;
//   String amount;
//   bool _isLoading=true;
//
//   Color textColor = Color(0xff555555);
//
//   List<DropdownMenuItem<cereals>> getDropDownMenuItems(List<cereals> _uinits) {
//     List<DropdownMenuItem<cereals>> items =  List();
//     for (int i=0;i<_uinits.length;i++) {
//       if(i==4){
//
//         items.add( DropdownMenuItem(
//             value: _uinits[i],
//             child:Stack(
//               children: [
//             Center(
//             child:  Text(_uinits[i].name, style: TextStyle(
//                 fontSize: 12*fontvar, fontWeight: FontWeight.w400
//             ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//             )),
//
//    //               ],
//             ),
//             )
//         );}
//       else{
//
//       items.add( DropdownMenuItem(
//           value: _uinits[i],
//           child: Center(
//             child:  Text(_uinits[i].name, style: TextStyle(
//                 fontSize: 12*fontvar, fontWeight: FontWeight.w400
//             ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//             ),
//           )
//       ));
//     }}
//     return items;
//   }
//
//   cereals _currectCereal1;
//   cereals _currectCereal2;
//
//   void changedDropDownItem1(cereals selectedCity) {
//     setState(() {
//       _currectCereal1 = selectedCity;
//       calorie1 =double.parse(selectedCity.calorie);
//       print("_currectCereal1");
//       print(_currectCereal1);
//       if (amount != null && calorie1 != null && calorie2 != null)
//         result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
//       print(result);
//     });
//   }
//   void changedDropDownItem2(cereals selectedCity) {
//     setState(() {
//       _currectCereal2 = selectedCity;
//       calorie2 =double.parse(selectedCity.calorie);
//       print("_currectCereal2");
//       print(_currectCereal2);
//       if (amount != null && calorie1 != null && calorie2 != null )
//         result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
//       print(result);
//     });
//   }
//
//   @override
//   void initState() {
//     getallCereals();
//
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//
// //  void onChanged(int value) {
// //    setState(() {
// //
// //      calorie1 = ;
// //      print(value);
// //      if (amount != null && calorie1 != null && calorie2 != null && amount != "")
// //        result = (double.parse(amount) / calorie1 * calorie2).toStringAsFixed(1);
// //    });
// //    print('Value = $value');
// //  }
// //
// //  void onChanged2(int value) {
// //    setState(() {
// //
// //      calorie2 = _zarib[value];
// //      if (amount != null && calorie1 != null && calorie2 != null && amount != "")
// //        result = (double.parse(amount) / calorie1 * calorie2).toStringAsFixed(1);
// //    });
// //    print('Value = $value');
// //  }
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
//     return Scaffold(
//         appBar: new PreferredSize(
//           preferredSize: Size.fromHeight(100*(screenSize.width)/375),
//           child: new Container(
//               padding: EdgeInsets.only(top: 10*(screenSize.width)/375),
//               decoration: new BoxDecoration(
//                 color: MyColors.green
//               ),
//               child: new SafeArea(
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.only(top: 12, bottom: 8),
//                       child:Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//
//                           Text(
//                             'تبدیل واحد مواد نشاسته ای به یکدیگر',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16*fontvar,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           Text(
//                             '( انواع نان، برنج، ماكاروني و سيب زميني )',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14*fontvar,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       )
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.chevron_right,
//                         size: 32*(screenSize.width)/375,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context, 'yes');
//                       },
//                       alignment: Alignment.topLeft,
//                       color: Colors.white,
//                       splashColor: Colors.amber,
//                       padding: EdgeInsets.all(7),
//                     ),
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
// //
//
//                   ],
//                 ),
//               )),
//         ),
//
//         body:
//         _isLoading
//             ?Center(
//             child: SpinKitCircle(
//               color: MyColors.vazn,
//             ))
//             :CustomScrollView(slivers: <Widget>[
//     SliverList(
//         delegate: SliverChildListDelegate(<Widget>[
//           Container(
//           margin: EdgeInsets.only(top: 15, right: 12, left: 12),
//           child: Column(
//             children: <Widget>[
//
//
//               Padding(padding: EdgeInsets.only(
//                 top: 10,
//               ),
//                 child: Text(
//                   "غذای نشاسته ای مورد نظر را انتخاب کنید.", style: TextStyle(
//                     color: textColor,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 13*fontvar
//                 ),),),
//
//               Container(
// width:screenSize.width,
//                 padding: EdgeInsets.only(right: 5),
//                 margin: EdgeInsets.only(right: 12,left: 12, top: 15),
//                 child: DropdownButtonHideUnderline(
//
//                   child:  DropdownButton<cereals>(
//
//                     value: _currectCereal1,
//                     items: _dropDownMenuItems1,
//
//                     onChanged: changedDropDownItem1,
//                   ),),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(
//                         width: 1,
//                         color: Colors.green
//                     )
//                 ),
//               ),
//
//               Container(
//                 width: screenSize
//                     .width/2,
//                 height: 52,
//                 margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                 child: TextField(
//                   maxLines: 1,
//
//                   onChanged: (String value) {
//                     setState(() {
//                       amount = value;
//                       if (amount != null && calorie1 != null && calorie2 != null )
//                         result = (double.parse(amount)*calorie1 / calorie2).toStringAsFixed(1);
//                     });
//                   },
//
//                   textAlign: TextAlign.center,
//                   keyboardType: TextInputType.number,
//                   decoration: new InputDecoration(
//                     focusColor: Colors.white,
//                     fillColor: Colors.white,
//                     contentPadding: EdgeInsets.all(0),
//                     border: new OutlineInputBorder(
//                         borderSide:
//                         new BorderSide(color: MyColors.green, width: 1),
//                         borderRadius:
//                         BorderRadius.all(Radius.circular(10))),
//                     enabledBorder: new OutlineInputBorder(
//                         borderSide:
//                         new BorderSide(color: MyColors.green, width: 1),
//                         borderRadius:
//                         BorderRadius.all(Radius.circular(10))),
//                     focusedBorder: new OutlineInputBorder(
//                         borderSide:
//                         new BorderSide(color: MyColors.green, width: 1),
//                         borderRadius:
//                         BorderRadius.all(Radius.circular(10))),
//                     hintText: 'مقدار را وارد کنید',
//                     hintStyle: TextStyle(
//                         color: Colors.black26,
//                         fontSize: 14*fontvar,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//
//               Text("تبدیل شود به :", style: TextStyle(
//                   color: textColor,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13*fontvar
//               ),),
//
//               Container(
//
//                 width: screenSize.width,
//                 padding: EdgeInsets.only(right: 5),
//                 margin: EdgeInsets.only(right: 12,left: 12, top: 15,bottom: 15),
//                 child: DropdownButtonHideUnderline(
//
//                   child: new DropdownButton<cereals>(
//                     value: _currectCereal2,
//                     items: _dropDownMenuItems2,
//                     onChanged: changedDropDownItem2,
//                   ),),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(
//                         width: 1,
//                         color: Colors.green
//                     )
//                 ),
//               ),
//
//               Text("نتیجه :", style: TextStyle(
//                   color: textColor,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13*fontvar
//               ),),
//               Container(
//                 alignment: Alignment.center,
//                 width: screenSize
//                     .width/2,
//                 height: 45,
//                 margin: EdgeInsets.only(top: 3, left: 2),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(
//                         color: MyColors.green, width: 1
//                     )
//                 ),
//                 child: Text(
//                   result ?? "",
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 14*fontvar,
//
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         )
//
//     ]))]));
//   }
//
//   getallCereals() async {
//     try {
//       var db = new cerealsProvider();
//       await db.open();
//       var c= await db.paginate();
// //      await db.close();
//       setState(() {
//         _cereals=c;
//         if(_cereals.isEmpty){
//           print("amoooooooooo");
//           _isLoading = false;
//         }
//         else {
//           _dropDownMenuItems1 = getDropDownMenuItems(_cereals);
//           _dropDownMenuItems2 = getDropDownMenuItems(_cereals);
//           _currectCereal1 = _cereals[0];
//           _currectCereal2 = _cereals[0];
//           calorie1 = double.parse(_currectCereal1.calorie);
//           calorie2 = double.parse(_currectCereal2.calorie);
//           _isLoading = false;
//         }
//       });
//
//       return true;
//     } catch (e) {
//       print("amoooooooooo");
//       print(e.toString());
//       return false;
//     }
//   }
//   Widget _errorConnection() {
//
//     Size screenSize = MediaQuery.of(context).size;
//     if(screenSize.width>600)screenSize=Size(600, screenSize.height);
//
//     return new SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child:Container(
//           child:  Center(
//               child: new Text('خطای اتصال به اینترنت')
//           ),
//           height: screenSize.height,
//         )
//     );
//   }
// }
