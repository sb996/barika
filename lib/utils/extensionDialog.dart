//
//
// import 'dart:ui';
//
// import 'package:barika_web/models/DbAllDiets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'SizeConfig.dart';
//
//
//
// class extensionDialog extends StatefulWidget {
//
//   DbAllDiets allDiet;
//
//   extensionDialog({Key key, this.allDiet}) : super(key: key);
//   State<StatefulWidget> createState() => extensionDialogState();
// }
//
// class extensionDialogState extends State<extensionDialog> {
//
//   bool dontShow = false;
//   DbAllDiets _allDiet;
//   @override
//   void initState() {
//     _allDiet=widget.allDiet;
//     // TODO: implement initState
//     super.initState();
//   }
//   var fontvar=1.0;
//   @override
//   Widget build(BuildContext context) {
//
//     SizeConfig().init(context);
//     var bh=SizeConfig.safeBlockHorizontal;
//     var bv=SizeConfig.safeBlockVertical;
//     print((SizeConfig.safeBlockHorizontal/SizeConfig.safeBlockVertical).toString()+"hooorizentaalll////vvvvv");
//     fontvar=(bh)/3.75;
//     if(fontvar>2)fontvar=1.7;
//     var screenSize=MediaQuery.of(context).size;
//     return StatefulBuilder(builder: (BuildContext context, StateSetter setState
//         /*You can rename this!*/) {
//     return  Container(
//
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(10))
//
//       ),
//         width: MediaQuery.of(context).size.width,
//         alignment: Alignment.center,
//         height: 350 * (screenSize.height) / 595,
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Stack(
//                 alignment: AlignmentDirectional.topCenter,
//                 children: <Widget>[
//                   Container(
//                       width: MediaQuery.of(context).size.width,
//                       alignment: Alignment.topCenter,
//                       decoration: BoxDecoration(
//                           color: MyColors.green,
//                           borderRadius: new BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10))),
// //                  child:  IconButton(alignment: Alignment.topRight,icon: Icon(Icons.clear,color: Colors.white,size: 30,), onPressed: (){ Navigator.of(context).pop();}),
//                       child: Stack(alignment: Alignment.center, children: [
//                         Container(
//                           padding: EdgeInsets.all(5 * (screenSize.width) / 375),
//                           alignment: Alignment.centerRight,
//                           child: IconButton(
//                               icon: Icon(
//                                 Icons.clear,
//                                 color: Colors.white,
//                                 size: 30 * (screenSize.width) / 375,
//                               ),
//                               alignment: Alignment.centerLeft,
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               }),
//                         ),
//                         Center(
//                             child: Text(
//                           "پایان دوره رژیم",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16 * fontvar,
//                               fontWeight: FontWeight.w600),
//                         ))
//                       ])),
//
//
//               ],
//
//
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
//               child:
//               Text(
//                 _allDiet.name+
//                     " عزیز دوره ی "+
//                     _allDiet.day.toString()+
//                     " روزه ی رژیم "+
//                     dietNameSelector(_allDiet.type)+
//                     " شما به پایان رسیده است.لطفا جهت تغییر و ادامه رژیم اقدام کنید. ",
//                 style: TextStyle(
//
//                     color: Colors.black,
//                     fontSize: 16*fontvar,
//                     fontWeight: FontWeight.w400),
//                 textAlign: TextAlign.center,
//                 textDirection: TextDirection.rtl,
//               ),
//
//             ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   textDirection: TextDirection.rtl,
//                   children: [
//                     Checkbox(
//                     onChanged: (newValue) {
//
//                       setState(() {
//                         print(newValue);
//                         dontShow = newValue;
//                       });
//
//                        Future.delayed(const Duration(milliseconds: 500), () {
//                         if(dontShow) Navigator.pop(context,"update");
//                       });
//
//
//                   },
//                       activeColor: MyColors.green,
//                       checkColor: Colors.white,
//                       value: dontShow,
//                     ),
//                     Expanded(
//                       child: Text(
//                         'مجددا این پیغام را نمایش نده',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14*fontvar),
//                         textAlign: TextAlign.right,
//                       ),
//
//                     )
//                   ],
//                 ),
//
//
//                 // child:CheckboxListTile(
//                 //
//                 //   title: Text("title text"),
//                 //   value: dontShow,
//                 //   onChanged: (newValue) {
//                 //     setState(() {
//                 //       print(newValue);
//                 //       dontShow = newValue;
//                 //     });
//                 //   },
//                 //   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//                 // ),
//
//               ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(child: FlatButton(
//
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(
//                             color: MyColors.green,
//                             width: 1
//                         ),
//                         borderRadius: new BorderRadius.circular(15),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//
//                       onPressed: () {Navigator.pop(context,);
//                       },
//                       child: Text(
//                         'متوجه شدم',
//                         style: TextStyle(
//                             color: MyColors.green,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14*fontvar),
//                       )),),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(child: FlatButton(
//                       shape: RoundedRectangleBorder(
//
//                         borderRadius: new BorderRadius.circular(15),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//                       color: MyColors.green,
//                       onPressed: () async {
//
//                         Navigator.pop(context, 'yes');
//
//                       },
//                       child: Text(
//                         'ادامه رژیم',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14*fontvar),
//                       )),)
//
//                 ],
//
//
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 5),
//             )
//
//           ]),
//
//
//
//
//     );
//
//
//
//     }
//
//     );
//
//
//   }
//
//     }
//
